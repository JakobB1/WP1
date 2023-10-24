using System.ComponentModel.DataAnnotations.Schema;

namespace GameStoreWebAPI.Models.DTO
{
    public class IgraDTO
    {
        public int? Sifra { get; set; }
        public string Naziv { get; set; }
        public string? Izdavac { get; set; }
        public string? Zanr { get; set; }
        public decimal Cijena { get; set; }
        public int DobnaGranica { get; set; }
        public DateTime DatumIzlaska { get; set; }
        public string? Opis { get; set; }
        public int SifraIzdavac { get; set; }
    }
}
