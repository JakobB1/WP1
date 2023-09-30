using System.ComponentModel.DataAnnotations.Schema;

namespace GameStoreWebAPI.Models
{
    public class Narudzba : Entitet
    {
        [ForeignKey("korisnik_id")]
        public Korisnik? Korisnik { get; set; }
        public string? Placanje { get; set; }
        public DateTime DatumObracuna { get; set; }
    }
}
