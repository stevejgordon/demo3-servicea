# Build image

FROM microsoft/aspnetcore-build:1.1 as publish

WORKDIR /publish

COPY src/DockerDotNetDevsDemo3.ServiceA/*.csproj ./src/DockerDotNetDevsDemo3.ServiceA/
RUN dotnet restore src/DockerDotNetDevsDemo3.ServiceA/DockerDotNetDevsDemo3.ServiceA.csproj

COPY . .
RUN dotnet publish src/DockerDotNetDevsDemo3.ServiceA/DockerDotNetDevsDemo3.ServiceA.csproj --output ../../out --configuration Release

# Optimised final image

FROM microsoft/aspnetcore:1.1

WORKDIR /app

COPY --from=publish /publish/out .

ENTRYPOINT ["dotnet", "DockerDotNetDevsDemo3.ServiceA.dll"]