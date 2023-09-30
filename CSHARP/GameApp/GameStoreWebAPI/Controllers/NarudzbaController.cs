using System.Text.RegularExpressions;
using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using GameStoreWebAPI.Models.DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GameStoreWebAPI.Controllers
{
    /// <summary>
    /// Namijenjeno za CRUD operacije na entitetom narudžba u bazi
    /// </summary>
    [ApiController]
    [Route("api/v1/[controller]")]
    public class NarudzbaController : ControllerBase
    {

        private readonly GameContext _context;
        private readonly ILogger<NarudzbaController> _logger;

        public NarudzbaController(GameContext context,
            ILogger<NarudzbaController> logger)
        {
            _context = context;
            _logger = logger;
        }


        /// <summary>
        /// Dohvaća sve narudžbe iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    GET api/v1/Narudzba
        ///
        /// </remarks>
        /// <returns>Narudzbe u bazi</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="400">Zahtjev nije valjan (BadRequest)</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
        [HttpGet]
        public IActionResult Get()
        {
            _logger.LogInformation("Dohvacam narudzbe");

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var narudzbe = _context.Narudzba
                    .Include(k => k.Korisnik)
                    .ToList();

                if (narudzbe == null || narudzbe.Count == 0)
                {
                    return new EmptyResult();
                }

                List<NarudzbaDTO> vrati = new();

                narudzbe.ForEach(n =>
                {
                    vrati.Add(new NarudzbaDTO()
                    {
                        Sifra = n.Sifra,
                        Korisnik = n.Korisnik?.Ime,
                        Placanje = n.Placanje,
                        DatumObracuna = n.DatumObracuna,
                        SifraKorisnik = n.Korisnik.Sifra
                    });
                });
                return Ok(vrati);
            }
            catch (Exception ex)
            {
                return StatusCode(
                    StatusCodes.Status503ServiceUnavailable,
                    ex);
            }


        }



        /// <summary>
        /// Dodaje narudžbu u bazu
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    POST api/v1/Narudzba
        ///    {}
        ///
        /// </remarks>
        /// <returns>Kreirana narudzba u bazi s svim podacima</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="400">Zahtjev nije valjan (BadRequest)</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
        [HttpPost]
        public IActionResult Post(NarudzbaDTO narudzbaDTO)
        {

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (narudzbaDTO.SifraKorisnik <= 0)
            {
                return BadRequest(ModelState);
            }

            try
            {

                var korisnik = _context.Korisnik.Find(narudzbaDTO.SifraKorisnik);

                if (korisnik == null)
                {
                    return BadRequest(ModelState);
                }

                Narudzba n = new()
                {
                    Sifra = narudzbaDTO.Sifra,
                    Korisnik = korisnik,
                    Placanje = narudzbaDTO.Placanje,
                    DatumObracuna = narudzbaDTO.DatumObracuna
                };

                _context.Narudzba.Add(n);
                _context.SaveChanges();

                narudzbaDTO.Sifra = n.Sifra;
                narudzbaDTO.Korisnik = korisnik.Ime;

                return Ok(narudzbaDTO);


            }
            catch (Exception ex)
            {
                return StatusCode(
                   StatusCodes.Status503ServiceUnavailable,
                   ex);
            }

        }



        /// <summary>
        /// Mijenja podatke postojeće narudžbe u bazi
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    PUT api/v1/narudzba/1
        ///
        /// {}
        ///
        /// </remarks>
        /// <param name="sifra">Šifra narudžbe koji se mijenja</param>  
        /// <returns>Svi poslani podaci od narudžbe</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="204">Nema u bazi narudžbe koje želimo promijeniti</response>
        /// <response code="415">Nismo poslali JSON</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, NarudzbaDTO narudzbaDTO)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            if (sifra <= 0 || narudzbaDTO == null)
            {
                return BadRequest();
            }

            try
            {
                var korisnik = _context.Korisnik.Find(narudzbaDTO.SifraKorisnik);

                if (korisnik == null)
                {
                    return BadRequest();
                }

                var narudzba = _context.Narudzba.Find(sifra);

                if (narudzba == null)
                {
                    return BadRequest();
                }

                narudzba.Korisnik = korisnik;
                narudzba.Placanje = narudzbaDTO.Placanje;
                narudzba.DatumObracuna = narudzbaDTO.DatumObracuna;

                _context.Narudzba.Update(narudzba);
                _context.SaveChanges();

                narudzbaDTO.Sifra = sifra;
                narudzbaDTO.Korisnik = korisnik.Ime;

                return Ok(narudzbaDTO);
            }
            catch (Exception ex)
            {
                return StatusCode(
                    StatusCodes.Status503ServiceUnavailable,
                    ex.Message);
            }


        }


        /// <summary>
        /// Briše narudžbe iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    DELETE api/v1/narudzba/1
        ///    
        /// </remarks>
        /// <param name="sifra">Šifra narudžbe koji se briše</param>  
        /// <returns>Odgovor da li je obrisano ili ne</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="204">Nema u bazi narudžbe kojeg želimo obrisati</response>
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