using System.ComponentModel.DataAnnotations.Schema;

namespace GameStoreWebAPI.Models
{
    public class Igra : Entitet
    {
        public string? Naziv { get; set; }
        [ForeignKey("izdavac")]
        public Izdavac? Izdavac { get; set; }
        public string? Zanr { get; set; }
        public decimal? Cijena { get; set; }
        public int? DobnaGranica { get; set; }
        public DateTime DatumIzlaska { get; set; }
        public string? Opis { get; set; }
    }
}
