using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace GameStoreWebAPI.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    public class NarudzbaController : ControllerBase
    {

        private readonly GameContext _context;

        public NarudzbaController(GameContext context)
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
                var narudzbe = _context.Narudzba.ToList();
                if (narudzbe == null || narudzbe.Count == 0)
                {
                    return new EmptyResult();
                }
                return new JsonResult(_context.Narudzba.ToList());
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }
        }


        [HttpPost]
        public IActionResult Post(Narudzba narudzba)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                _context.Narudzba.Add(narudzba);
                _context.SaveChanges();
                return StatusCode(StatusCodes.Status201Created, narudzba);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }
        }


        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, Narudzba narudzba)
        {
            if (sifra <= 0 || narudzba == null)
            {
                return BadRequest();
            }

            try
            {
                var narudzbaBaza = _context.Narudzba.Find(sifra);
                if (narudzbaBaza == null)
                {
                    return BadRequest();
                }

                narudzbaBaza.Placanje = narudzbaBaza.Placanje;
                narudzbaBaza.DatumObracuna = narudzbaBaza.DatumObracuna;


                _context.Narudzba.Update(narudzbaBaza);
                _context.SaveChanges();

                return StatusCode(StatusCodes.Status200OK, narudzbaBaza);

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

            var narudzbaBaza = _context.Narudzba.Find(sifra);
            if (narudzbaBaza == null)
            {
                return BadRequest();
            }

            try
            {
                _context.Narudzba.Remove(narudzbaBaza);
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