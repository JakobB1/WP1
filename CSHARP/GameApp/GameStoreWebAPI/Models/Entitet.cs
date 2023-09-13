using System.ComponentModel.DataAnnotations;

namespace GameStoreWebAPI.Models
{
    public abstract class Entitet
    {
        [Key]
        public int sifra { get; set; }
    }
}
