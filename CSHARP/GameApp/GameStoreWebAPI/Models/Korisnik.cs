﻿namespace GameStoreWebAPI.Models
{
    public class Korisnik : Entitet
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Oib { get; set; }
        public string? Email { get; set; }
    }
}
