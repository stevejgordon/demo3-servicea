using Xunit;

namespace DockerDotNetDevsDemo3.ServiceA.Tests
{
    public class DemoTests
    {
        [Fact]
        public void OneShouldBeEqualToOne()
        {
            // Not testing anything useful here! 
            // Just an example so the build can run tests
            Assert.Equal(1, 1);
        }
    }
}
