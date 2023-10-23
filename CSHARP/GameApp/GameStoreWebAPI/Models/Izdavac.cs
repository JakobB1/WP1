using System.ComponentModel.DataAnnotations;
using GameStoreWebAPI.Validations;

namespace GameStoreWebAPI.Models
{
    public class Izdavac : Entitet
    {
        [Required]
        [NazivNeMozeBitiBroj]
        public string? Naziv { get; set; }
        public string? Drzava { get; set; }
        public string? WebStranica { get; set; }
    }
}
