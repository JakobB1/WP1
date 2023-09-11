using EdunovaApp.Data;
using EdunovaApp.Models;
using EdunovaApp.Models.DTO;
using Microsoft.AspNetCore.Mvc;

namespace EdunovaApp.Controllers
{
    [ApiController]
    [Route("ap1/v1/[controller]")]
    public class PolaznikController : ControllerBase
    {

        private readonly EdunovaContext _context;

        public PolaznikController(EdunovaContext context)
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

            var polaznici = _context.Polaznik.ToList();
            if (polaznici == null || polaznici.Count == 0)
            {
                return new EmptyResult();
            }

            List<PolaznikDTO> vrati = new();

            polaznici.ForEach(p =>
            {
                // ovo je rucno presipavanje, kasnije upogonimo automapper
                var pdto = new PolaznikDTO()
                {
                    Sifra = p.Sifra,
                    Ime = p.Ime,
                    Prezime = p.Prezime,
                    Oib = p.Oib,
                    Email = p.Email
                };

                vrati.Add(pdto);


            });


            return Ok(vrati);

        }

        [HttpPost]
        public IActionResult Post(PolaznikDTO dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                Polaznik p = new Polaznik()
                {
                    Ime = dto.Ime,
                    Prezime = dto.Prezime,
                    Oib = dto.Oib,
                    Email = dto.Email
                };

                _context.Polaznik.Add(p);
                _context.SaveChanges();
                dto.Sifra = p.Sifra;
                return Ok(p);

            }
            catch (Exception ex)
            {
                return StatusCode(
                    StatusCodes.Status503ServiceUnavailable, ex.Message);
            }
        }


        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, PolaznikDTO pdto)
        {

            if (sifra <= 0 || pdto == null)
            {
                return BadRequest();
            }

            try
            {
                var polaznikBaza = _context.Polaznik.Find(sifra);
                if (polaznikBaza == null)
                {
                    return BadRequest();
                }
                // inace se rade Mapper-i
                // mi cemo za sada rucno
                polaznikBaza.Ime = pdto.Ime;
                polaznikBaza.Prezime = pdto.Prezime;
                polaznikBaza.Oib = pdto.Oib;
                polaznikBaza.Email = pdto.Email;

                _context.Polaznik.Update(polaznikBaza);
                _context.SaveChanges();
                pdto.Sifra = polaznikBaza.Sifra;
                return StatusCode(StatusCodes.Status200OK, pdto);

            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable,
                                    ex.Message); // 
                //nije dobro vracati cijeli ex ali za dev je OK
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

            try
            {
                var polaznikBaza = _context.Polaznik.Find(sifra);
                if (polaznikBaza == null)
                {
                    return BadRequest();
                }

                _context.Polaznik.Remove(polaznikBaza);
                _context.SaveChanges();

                return new JsonResult("{\"poruka\":\"Obrisano\"}");

            }
            catch (Exception ex)
            {
                return new JsonResult("{\"poruka\":\"Ne moze se obrisati\"}");
            }

        }
    }
}
