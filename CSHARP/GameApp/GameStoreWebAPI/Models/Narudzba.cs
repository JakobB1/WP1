using System.ComponentModel.DataAnnotations.Schema;

namespace GameStoreWebAPI.Models
{
    public class Narudzba : Entitet
    {
        public string? Placanje { get; set; }
        public DateTime DatumObracuna { get; set; }
    }
}
