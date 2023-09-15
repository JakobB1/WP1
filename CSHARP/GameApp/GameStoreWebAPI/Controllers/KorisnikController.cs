using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using GameStoreWebAPI.Models.DTO;
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

            var korisnici = _context.Korisnik.ToList();
            if (korisnici == null || korisnici.Count == 0)
            {
                return new EmptyResult();
            }

            List<KorisnikDTO> vrati = new();

            korisnici.ForEach(k =>
            {
                // ovo je ručno presipavanje, kasnije upogonimo automapper
                var kdto = new KorisnikDTO()
                {
                    Sifra = k.Sifra,
                    Ime = k.Ime,
                    Prezime = k.Prezime,
                    Oib = k.Oib,
                    Email = k.Email
                };

                vrati.Add(kdto);


            });


            return Ok(vrati);

        }


        [HttpPost]
        public IActionResult Post(KorisnikDTO kto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                Korisnik k = new Korisnik()
                {
                    Ime = kto.Ime,
                    Prezime = kto.Prezime,
                    Oib = kto.Oib,
                    Email = kto.Email
                };

                _context.Korisnik.Add(k);
                _context.SaveChanges();
                kto.Sifra = k.Sifra;
                return Ok(kto);

            }
            catch (Exception ex)
            {
                return StatusCode(
                    StatusCodes.Status503ServiceUnavailable, ex.Message);
            }
        }


        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, KorisnikDTO kdto)
        {

            if (sifra <= 0 || kdto == null)
            {
                return BadRequest();
            }

            try
            {
                var korisnikBaza = _context.Korisnik.Find(sifra);
                if (korisnikBaza == null)
                {
                    return BadRequest();
                }
                // inače se rade Mapper-i
                // mi ćemo za sada ručno
                korisnikBaza.Ime = kdto.Ime;
                korisnikBaza.Prezime = kdto.Prezime;
                korisnikBaza.Oib = kdto.Oib;
                korisnikBaza.Email = kdto.Email;

                _context.Korisnik.Update(korisnikBaza);
                _context.SaveChanges();
                kdto.Sifra = korisnikBaza.Sifra;
                return StatusCode(StatusCodes.Status200OK, kdto);

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

            var korisnikBaza = _context.Korisnik.Find(sifra);
            if (korisnikBaza == null)
            {
                return BadRequest();
            }

            try
            {
                _context.Korisnik.Remove(korisnikBaza);
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