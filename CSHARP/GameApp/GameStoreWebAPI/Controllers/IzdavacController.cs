using System.Linq.Expressions;
using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace GameStoreWebAPI.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    public class IzdavacController : ControllerBase
    {

        private readonly GameContext _context;

        public IzdavacController(GameContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Get()
        {
            return new JsonResult(_context.Izdavac.ToList());   
        }

        [HttpPost]
        public IActionResult Post(Izdavac izdavac)
        {
            return Created("/api/v1/Izdavac", izdavac);
        }

        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, Izdavac izdavac)
        {
            return StatusCode(StatusCodes.Status200OK, izdavac);
        }

        [HttpDelete]
        [Route("{sifra:int}")]
        public IActionResult Delete(int sifra) 
        {
            return StatusCode(StatusCodes.Status200OK, "{\"obrisano\":true}");
        }
    }
}
