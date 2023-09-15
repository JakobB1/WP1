using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace GameStoreWebAPI.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    public class KorisnikController : ControllerBase
    {

        private readonly GameContext _context;

        public KorisnikController(GameContext context)
        {
            _context = context;
        }


        [HttpGet]
        public IActionResult Get()
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var korisnici = _context.Korisnik.ToList();
                if (korisnici == null || korisnici.Count == 0)
                {
                    return new EmptyResult();
                }
                return new JsonResult(_context.Korisnik.ToList());
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }
        }

    }
}
