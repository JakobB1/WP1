using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;

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