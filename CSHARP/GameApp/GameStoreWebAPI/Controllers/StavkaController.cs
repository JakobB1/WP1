using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace GameStoreWebAPI.Controllers
{
    /// <summary>
    /// Namijenjeno za CRUD operacije na entitetom stavka u bazi
    /// </summary>
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


        /// <summary>
        /// Dohvaća sve stavke iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    GET api/v1/Stavka
        ///
        /// </remarks>
        /// <returns>Stavke u bazi</returns>
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


        /// <summary>
        /// Dodaje stavku u bazu
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    POST api/v1/Stavka
        ///    {}
        ///
        /// </remarks>
        /// <returns>Kreirana stavka u bazi s svim podacima</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="400">Zahtjev nije valjan (BadRequest)</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
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


        /// <summary>
        /// Mijenja podatke postojeće stavke u bazi
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    PUT api/v1/stavka/1
        ///
        /// {}
        ///
        /// </remarks>
        /// <param name="sifra">Šifra stavke koji se mijenja</param>  
        /// <returns>Svi poslani podaci od stavke</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="204">Nema u bazi stavke koje želimo promijeniti</response>
        /// <response code="415">Nismo poslali JSON</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
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


        /// <summary>
        /// Briše stavku iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    DELETE api/v1/stavka/1
        ///    
        /// </remarks>
        /// <param name="sifra">Šifra stavke koji se briše</param>  
        /// <returns>Odgovor da li je obrisano ili ne</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="204">Nema u bazi stavke kojeg želimo obrisati</response>
        /// <response code="415">Nismo poslali JSON</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
        [HttpDelete]
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
