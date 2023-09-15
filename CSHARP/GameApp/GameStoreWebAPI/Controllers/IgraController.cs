using System.Linq.Expressions;
using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace GameStoreWebAPI.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    public class IgraController : ControllerBase
    {

        private readonly GameContext _context;

        public IgraController(GameContext context)
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
                var igre = _context.Igra.ToList();
                if (igre == null || igre.Count == 0)
                {
                    return new EmptyResult();
                }
                return new JsonResult(_context.Igra.ToList());
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }
        }


        [HttpPost]
        public IActionResult Post(Igra igra)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                _context.Igra.Add(igra);
                _context.SaveChanges();
                return StatusCode(StatusCodes.Status201Created, igra);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }
        }


        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, Igra igra)
        {
            if (sifra <= 0 || igra == null)
            {
                return BadRequest();
            }

            try
            {
                var igraBaza = _context.Igra.Find(sifra);
                if (igraBaza == null)
                {
                    return BadRequest();
                }

                igraBaza.Naziv = igra.Naziv;
                igraBaza.Zanr = igra.Zanr;
                igraBaza.Cijena = igra.Cijena;
                igraBaza.DobnaGranica = igra.DobnaGranica;
                igraBaza.DatumIzlaska = igra.DatumIzlaska;
                igraBaza.Opis = igra.Opis;


                _context.Igra.Update(igraBaza);
                _context.SaveChanges();

                return StatusCode(StatusCodes.Status200OK, igraBaza);

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

            var igraBaza = _context.Igra.Find(sifra);
            if (igraBaza == null)
            {
                return BadRequest();
            }

            try
            {
                _context.Igra.Remove(igraBaza);
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
