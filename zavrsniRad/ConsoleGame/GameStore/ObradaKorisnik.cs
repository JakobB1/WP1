using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameStore
{
    internal class ObradaKorisnik
    {
        public List<Korisnik> Korisnici { get; }

        public ObradaKorisnik()
        {
            Korisnici = new List<Korisnik>();
            if (Pomocno.dev)
            {
                TestniPodaci();
            }
        }


        public void PrikaziIzbornik()
        {
            Console.WriteLine("Izbornik za rad s korisnicima");
            Console.WriteLine("1. Pregled postojecih korisnika");
            Console.WriteLine("2. Unos novog korisnika");
            Console.WriteLine("3. Promjena postojeceg korisnika");
            Console.WriteLine("4. Brisanje korisnika");
            Console.WriteLine("5. Povratak na glavni izbornik");

            switch (Pomocno.ucitajBrojRaspon("Odaberite stavku izbornika korisnika: ",
                "Odabir mora biti 1-5", 1, 5))
            {
                case 1:
                    PregledKorisnika();
                    PrikaziIzbornik();
                    break;
                case 2:
                    UcitajKorisnika();
                    PrikaziIzbornik();
                    break;
                case 3:
                    PrikaziIzbornik();
                    break;
                case 4:
                    BrisanjeKorisnika();
                    PrikaziIzbornik();
                    break;
                case 5:
                    Console.WriteLine("Gotov rad s korisnicima");
                    break;
            }
        }

        public void PregledKorisnika()
        {
            Console.WriteLine("-------------------");
            Console.WriteLine("---- Korisnici ----");
            Console.WriteLine("-------------------");
            int b = 1;
            foreach (Korisnik korisnik in Korisnici)
            {
                Console.WriteLine("{0}. {1}", b++, korisnik);
            }
            Console.WriteLine("------------------");
        }


        private void UcitajKorisnika()
        {
            var k = new Korisnik();
            k.Sifra = Pomocno.ucitajCijeliBroj("Unesite sifru korisnika: ",
                "Unos mora biti pozitivni cijeli broj");
            k.Ime = Pomocno.UcitajString("Unesi ime korisnika: ", "Ime obavezno");
            k.Prezime = Pomocno.UcitajString("Unesi Prezime korisnika: ", "Prezime obavezno");
            k.Email = Pomocno.UcitajString("Unesi Email korisnika: ", "Email obavezno");
            k.Oib = Pomocno.UcitajString("Unesi OIB korisnika: ", "OIB obavezno");
            Korisnici.Add(k);
        }


        private void BrisanjeKorisnika()
        {
            PregledKorisnika();
            int index = Pomocno.ucitajBrojRaspon("Odaberi redni broj korisnika: ", "Nije dobar odabir", 1, Korisnici.Count());
            Korisnici.RemoveAt(index - 1);
        }


        private void TestniPodaci()
        {
            Korisnici.Add(new Korisnik
            {
                Sifra = 1,
                Ime = "Pero",
                Prezime = "Peric",
                Email = "pero@gmail.com",
                Oib = "12345678911"
            });
        }
    }
}
