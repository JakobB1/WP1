using System.ComponentModel.DataAnnotations.Schema;

namespace GameStoreWebAPI.Models
{
    public class Narudzba : Entitet
    {
        [ForeignKey("korisnik")]
        public Korisnik? Korisnik { get; set; }
        public string? Placanje { get; set; }
        public DateTime DatumIzlaska { get; set; }
    }
}
