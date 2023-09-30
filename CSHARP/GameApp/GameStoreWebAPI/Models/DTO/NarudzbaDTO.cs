namespace GameStoreWebAPI.Models.DTO
{
    public class NarudzbaDTO
    {
        public int Sifra { get; set; }
        public string? Korisnik { get; set; }
        public string? Placanje { get; set; }
        public DateTime DatumObracuna { get; set; }
        public int SifraKorisnik { get; set; }
    }
}
