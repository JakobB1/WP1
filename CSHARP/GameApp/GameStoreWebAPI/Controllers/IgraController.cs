﻿using System.Linq.Expressions;
using System.Text.RegularExpressions;
using GameStoreWebAPI.Data;
using GameStoreWebAPI.Models;
using GameStoreWebAPI.Models.DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace GameStoreWebAPI.Controllers
{

    [ApiController]
    [Route("api/v1/[controller]")]
    public class IgraController : ControllerBase
    {

        private readonly GameContext _context;
        private readonly ILogger<IgraController> _logger;

        public IgraController(GameContext context,
            ILogger<IgraController> logger)
        {
            _context = context;
            _logger = logger;
        }


        /// <summary>
        /// Dohvaca sve igre iz baze
        /// </summary>
        /// <remarks>
        /// Primjer upita:
        ///
        ///    GET api/v1/Igra
        ///
        /// </remarks>
        /// <returns>Igre u bazi</returns>
        /// <response code="200">Sve je u redu</response>
        /// <response code="400">Zahtjev nije valjan (BadRequest)</response> 
        /// <response code="503">Na azure treba dodati IP u firewall</response> 
        [HttpGet]
        public IActionResult Get()
        {
            _logger.LogInformation("Dohvacam igre");

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var igre = _context.Igra
                    .Include(i => i.Izdavac)
                    .ToList();

                if (igre == null || igre.Count == 0)
                {
                    return new EmptyResult();
                }

                List<IgraDTO> vrati = new();

                igre.ForEach(i =>
                {
                    vrati.Add(new IgraDTO()
                    {
                        Sifra = i.Sifra,
                        Naziv = i.Naziv,
                        Izdavac = i.Izdavac?.Naziv,
                        SifraIzdavac = i.Izdavac.Sifra,
                        Zanr = i.Zanr,
                        Cijena = i.Cijena,
                        DobnaGranica = i.DobnaGranica,
                        DatumIzlaska = i.DatumIzlaska,
                        Opis = i.Opis

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


        [HttpPost]
        public IActionResult Post(IgraDTO igraDTO)
        {

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (igraDTO.SifraIzdavac <= 0)
            {
                return BadRequest(ModelState);
            }

            try
            {

                var izdavac = _context.Izdavac.Find(igraDTO.SifraIzdavac);

                if (izdavac == null)
                {
                    return BadRequest(ModelState);
                }

                Igra i = new()
                {
                    Naziv = igraDTO.Naziv,
                    Izdavac = izdavac,
                    Zanr = igraDTO.Zanr,
                    Cijena = igraDTO.Cijena,
                    DobnaGranica = igraDTO.DobnaGranica,
                    DatumIzlaska = igraDTO.DatumIzlaska,
                    Opis = igraDTO.Opis

                };

                _context.Igra.Add(i);
                _context.SaveChanges();

                igraDTO.Sifra = i.Sifra;
                igraDTO.Izdavac = izdavac.Naziv;

                return Ok(igraDTO);


            }
            catch (Exception ex)
            {
                return StatusCode(
                   StatusCodes.Status503ServiceUnavailable,
                   ex);
            }

        }


        [HttpPut]
        [Route("{sifra:int}")]
        public IActionResult Put(int sifra, IgraDTO igraDTO)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            if (sifra <= 0 || igraDTO == null)
            {
                return BadRequest();
            }

            try
            {
                var izdavac = _context.Izdavac.Find(igraDTO.SifraIzdavac);

                if (izdavac == null)
                {
                    return BadRequest();
                }

                var igra = _context.Igra.Find(sifra);

                if (igra == null)
                {
                    return BadRequest();
                }

                igra.Naziv = igra.Naziv;
                igra.Izdavac = izdavac;
                igra.Zanr = igra.Zanr;
                igra.Cijena = igra.Cijena;
                igra.DobnaGranica = igra.DobnaGranica;
                igra.DatumIzlaska = igra.DatumIzlaska;
                igra.Opis = igra.Opis;

                _context.Igra.Update(igra);
                _context.SaveChanges();

                igraDTO.Sifra = sifra;
                igraDTO.Izdavac = izdavac.Naziv;

                return Ok(igraDTO);
            }
            catch (Exception ex)
            {
                return StatusCode(
                    StatusCodes.Status503ServiceUnavailable,
                    ex.Message);
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
