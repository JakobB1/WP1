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
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var izdavaci = _context.Izdavac.ToList();
                if(izdavaci==null || izdavaci.Count == 0)
                {
                    return new EmptyResult();
                }
                return new JsonResult(_context.Izdavac.ToList());
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }
        }


        [HttpPost]
        public IActionResult Post(Izdavac izdavac)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                _context.Izdavac.Add(izdavac);
                _context.SaveChanges();
                return StatusCode(StatusCodes.Status201Created, izdavac);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message);
            }
        }


        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, Izdavac izdavac)
        {
            if(sifra<=0 || izdavac == null)
            {
                return BadRequest();
            }

            try
            {
                var izdavacBaza = _context.Izdavac.Find(sifra);
                if (izdavacBaza == null)
                {
                    return BadRequest();
                }

                izdavacBaza.naziv = izdavac.naziv;
                izdavacBaza.drzava = izdavac.drzava;
                izdavacBaza.webStranica = izdavac.webStranica;

                _context.Izdavac.Update(izdavacBaza);
                _context.SaveChanges();

                return StatusCode(StatusCodes.Status200OK, izdavacBaza);

            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex);
            }
        }


        [HttpDelete]
        [Route("{sifra:int}")]
        public IActionResult Delete(int sifra)
        {
            if (sifra <= 0)
            {
                return BadRequest();
            }

            var izdavacBaza = _context.Izdavac.Find(sifra);
            if (izdavacBaza == null)
            {
                return BadRequest();
            }

            try
            {
                _context.Izdavac.Remove(izdavacBaza);
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
