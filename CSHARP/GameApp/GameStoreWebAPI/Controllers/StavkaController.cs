using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace GameStoreWebAPI.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    public class StavkaController : ControllerBase
    {
        private readonly GameContext _context;
        private readonly ILogger<StavkaController> _logger;

        public StavkaController(GameContext context,
            ILogger<StavkaController> logger)
        {
            _context = context;
            _logger = logger;
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
                var stavke = _context.Stavka.ToList();
                if (stavke == null || stavke.Count == 0)
                {
                    return new EmptyResult();
                }
                return new JsonResult(_context.Stavka.ToList());
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }

        }


        [HttpPost]
        public IActionResult Post(Stavka stavka)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                _context.Stavka.Add(stavka);
                _context.SaveChanges();
                return StatusCode(StatusCodes.Status201Created, stavka);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }
        }


        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, Stavka stavka)
        {
            if (sifra <= 0 || stavka == null)
            {
                return BadRequest();
            }

            try
            {
                var stavkaBaza = _context.Stavka.Find(sifra);
                if (stavkaBaza == null)
                {
                    return BadRequest();
                }


                stavkaBaza.Kolicina = stavkaBaza.Kolicina;


                _context.Stavka.Update(stavkaBaza);
                _context.SaveChanges();

                return StatusCode(StatusCodes.Status200OK, stavkaBaza);

            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex);
            }
        }


        [HttpDelete]
        [Route("{sifra:int}")]
        [Produces("application/json")]
        public IActionResult Delete(int sifra)
        {
            if (sifra <= 0)
            {
                return BadRequest();
            }

            var stavkaBaza = _context.Stavka.Find(sifra);
            if (stavkaBaza == null)
            {
                return BadRequest();
            }

            try
            {
                _context.Stavka.Remove(stavkaBaza);
                _context.SaveChanges();

                return new JsonResult("{\"poruka\":\"Obrisano\"}");

            }
            catch (Exception ex)
            {

                return new JsonResult("{\"poruka\":\"Ne može se obrisati\"}");

            }
        }

    }
}
