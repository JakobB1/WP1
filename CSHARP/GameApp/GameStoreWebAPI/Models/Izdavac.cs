using System.ComponentModel.DataAnnotations;

namespace GameStoreWebAPI.Models
{
    public class Izdavac : Entitet
    {
        [Required]
        public string? naziv { get; set; }
        public string? drzava { get; set; }
        public string? webStranica { get; set; }
    }
}
