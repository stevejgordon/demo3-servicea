using Microsoft.AspNetCore.Mvc;

namespace DockerDotNetDevsDemo3.ServiceA.Controllers
{
    [Route("api/[controller]")]
    public class ContentController : Controller
    {
        [HttpGet, Route("title")]
        public string GetTitle()
        {
            return "Hello .NET South East!";
        }     
    }
}