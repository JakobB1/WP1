using System.ComponentModel.DataAnnotations;

namespace GameStoreWebAPI.Models
{
    public class Izdavac : Entitet
    {
        [Required]
        public string? Naziv { get; set; }
        public string? Drzava { get; set; }
        public string? WebStranica { get; set; }
    }
}
