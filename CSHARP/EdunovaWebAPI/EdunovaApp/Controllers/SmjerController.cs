using EdunovaApp.Models;
using Microsoft.AspNetCore.Mvc;

namespace EdunovaApp.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    public class SmjerController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            var lista = new List<Smjer>()
            {
                new (){Naziv="Prvi"},
                new (){Naziv="Drugi"},
            }; 
            return new JsonResult(lista); 
        }

        [HttpPost]
        public IActionResult Post(Smjer smjer)
        {
            // dodavanje u bazu
            return Created("/api/v1/Smjer", smjer);
        }

        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, Smjer smjer)
        {
            //promjena u bazi
            return StatusCode(StatusCodes.Status200OK, smjer);
        }

        [HttpDelete]
        [Route("{sifra:int}")]
        public IActionResult Deleet(int sifra)
        {
            //brisanje u bazi
            return StatusCode(StatusCodes.Status200OK, "{\"obrisano\":true}");
        }
    }
}
