using System.ComponentModel.DataAnnotations.Schema;

namespace GameStoreWebAPI.Models
{
    public class Stavka : Entitet
    {
        [ForeignKey("igra_id")]
        public Igra? Igra { get; set; }
        [ForeignKey("narudzba_id")]
        public Narudzba? Narudzba { get; set; }
        public int? Kolicina { get; set; }
    }
}
