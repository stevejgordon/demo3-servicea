using Microsoft.AspNetCore.Mvc;

namespace DockerDotNetDevsDemo3.ServiceA.Controllers
{
    public class ContentController : Controller
    {
        [HttpGet, Route("title")]
        public string GetTitle()
        {
            return "Hello DDD!";
        }     
    }
}
