using System.Linq.Expressions;
using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace GameStoreWebAPI.Controllers
{
    /// <summary>
    /// Namijenjeno za CRUD operacije na entitetom izdavac u bazi
    /// </summary>
    [ApiController]
    [Route("api/v1/[controller]")]
    public class IzdavacController : ControllerBase
    {

        private readonly GameContext _context;

        public IzdavacController(GameContext context)
        {
            _context = context;
        }


        /// <summary>
        /// Dohvaća sve izdavače iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    GET api/v1/Izdavac
        ///
        /// </remarks>
        /// <returns>Izdavči u bazi</returns>
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


        [HttpGet]
        [Route("{sifra:int}")]
        public IActionResult GetBySifra(int sifra) {

            if (sifra <= 0)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var i = _context.Izdavac.Find(sifra);

                if(i == null)
                {
                    return StatusCode(StatusCodes.Status204NoContent, i);
                }

                return new JsonResult(i);
            } 
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status503ServiceUnavailable, ex.Message);
            }
        
        }


        /// <summary>
        /// Dodaje izdavača u bazu
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    POST api/v1/Izdavac
        ///    {}
        ///
        /// </remarks>
        /// <returns>Kreirani izdavač u bazi s svim podacima</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="400">Zahtjev nije valjan (BadRequest)</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
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


        /// <summary>
        /// Mijenja podatke postojećeg izdavača u bazi
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    PUT api/v1/izdavac/1
        ///
        /// {}
        ///
        /// </remarks>
        /// <param name="sifra">Šifra izdavača koji se mijenja</param>  
        /// <returns>Svi poslani podaci od izdavača</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="204">Nema u bazi izdavača kojeg želimo promijeniti</response>
        /// <response code="415">Nismo poslali JSON</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
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

                izdavacBaza.Naziv = izdavac.Naziv;
                izdavacBaza.Drzava = izdavac.Drzava;
                izdavacBaza.WebStranica = izdavac.WebStranica;

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


        /// <summary>
        /// Briše izdavača iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    DELETE api/v1/izdavac/1
        ///    
        /// </remarks>
        /// <param name="sifra">Šifra izdavača koji se briše</param>  
        /// <returns>Odgovor da li je obrisano ili ne</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="204">Nema u bazi izdavača kojeg želimo obrisati</response>
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

                return new JsonResult("{\"poruka\":\"Ne može se obrisati izdavač jer ima sebi igru\"}");

            }
        }
    }
}
