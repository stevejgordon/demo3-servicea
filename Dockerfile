# Build image
FROM microsoft/aspnetcore-build:2.0.6-2.1.101 as publish

WORKDIR /publish

COPY ./DockerDotNetDevsDemo3.sln ./
COPY src/DockerDotNetDevsDemo3.ServiceA/*.csproj ./src/DockerDotNetDevsDemo3.ServiceA/
COPY test/DockerDotNetDevsDemo3.ServiceA.Tests/*.csproj ./test/DockerDotNetDevsDemo3.ServiceA.Tests/

RUN dotnet restore --verbosity quiet

COPY ./test ./test
COPY ./src ./src

RUN dotnet build -c Release
RUN dotnet test test/DockerDotNetDevsDemo3.ServiceA.Tests/DockerDotNetDevsDemo3.ServiceA.Tests.csproj -c Release --no-build --verbosity minimal
RUN dotnet publish src/DockerDotNetDevsDemo3.ServiceA/DockerDotNetDevsDemo3.ServiceA.csproj --output ../../out -c Release --verbosity quiet

# Optimised final image
FROM microsoft/aspnetcore:2.0.6

EXPOSE 80

ENTRYPOINT ["dotnet", "DockerDotNetDevsDemo3.ServiceA.dll"]

WORKDIR /app

COPY --from=publish /publish/out .