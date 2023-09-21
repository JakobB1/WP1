using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using GameStoreWebAPI.Models.DTO;
using Microsoft.AspNetCore.Mvc;

namespace GameStoreWebAPI.Controllers
{
    /// <summary>
    /// Namijenjeno za CRUD operacije na entitetom korisnik u bazi
    /// </summary>
    [ApiController]
    [Route("api/v1/[controller]")]
    public class KorisnikController : ControllerBase
    {

        private readonly GameContext _context;

        public KorisnikController(GameContext context)
        {
            _context = context;
        }


        /// <summary>
        /// Dohvaća sve korisnike iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    GET api/v1/Korisnik
        ///
        /// </remarks>
        /// <returns>Korisnici u bazi</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="400">Zahtjev nije valjan (BadRequest)</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
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


        /// <summary>
        /// Dodaje korisnika u bazu
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    POST api/v1/Korisnik
        ///    {}
        ///
        /// </remarks>
        /// <returns>Kreirani korisnik u bazi s svim podacima</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="400">Zahtjev nije valjan (BadRequest)</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
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


        /// <summary>
        /// Mijenja podatke postojećeg korisnika u bazi
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    PUT api/v1/korisnik/1
        ///
        /// {}
        ///
        /// </remarks>
        /// <param name="sifra">Šifra korisnika koji se mijenja</param>  
        /// <returns>Svi poslani podaci od korisnika</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="204">Nema u bazi korisnika kojeg želimo promijeniti</response>
        /// <response code="415">Nismo poslali JSON</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
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


        /// <summary>
        /// Briše korisnika iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    DELETE api/v1/korisnik/1
        ///    
        /// </remarks>
        /// <param name="sifra">Šifra korisnika koji se briše</param>  
        /// <returns>Odgovor da li je obrisano ili ne</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="204">Nema u bazi korisnika kojeg želimo obrisati</response>
        /// <response code="415">Nismo poslali JSON</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
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