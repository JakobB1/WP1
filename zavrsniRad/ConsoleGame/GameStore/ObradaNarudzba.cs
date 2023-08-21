using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace GameStore
{
    internal class ObradaNarudzba
    {
        public List<Narudzba> Narudzbe { get; }

        private Izbornik Izbornik;

        public ObradaNarudzba(Izbornik izbornik) : this()
        {
            this.Izbornik = izbornik;
        }

        public ObradaNarudzba()
        {
            Narudzbe = new List<Narudzba>();   
        }


        public void PrikaziIzbornik()
        {
            Console.WriteLine("Izbornik za rad s narudzbama");
            Console.WriteLine("1. Pregled postojećih narudzbi");
            Console.WriteLine("2. Unos nove narudzbe");
            Console.WriteLine("3. Promjena postojece narudzbe");
            Console.WriteLine("4. Brisanje narudzbe");
            Console.WriteLine("5. Povratak na glavni izbornik");

            switch (Pomocno.ucitajBrojRaspon("Odaberite stavku izbornika grupa: ",
                "Odabir mora biti 1-5", 1, 5))
            {
                case 1:
                    PrikaziNarudzbe();
                    PrikaziIzbornik();
                    break;
                case 2:
                    UnosNoveNarudzbe();
                    PrikaziIzbornik();
                    break;
                case 3:
                    PrikaziIzbornik();
                    break;
                case 4:
                    BrisanjeNardzbe();
                    PrikaziIzbornik();
                    break;
                case 5:
                    Console.WriteLine("Gotov rad s grupama");
                    break;
            }
        }


        private void PrikaziNarudzbe()
        {
            Console.WriteLine("------------------");
            Console.WriteLine("---- Narudzbe ----");
            Console.WriteLine("------------------");
            int b = 1;
            foreach (Narudzba narudzba in Narudzbe)
            {
                Console.WriteLine("{0}. {1}", b++, narudzba.BrojNarudzbe);
            }
            Console.WriteLine("------------------");
        }


        private void UnosNoveNarudzbe()
        {
            var n = new Narudzba();
            n.Sifra = Pomocno.ucitajCijeliBroj("Unesite sifru narudzbe: ",
                "Unos mora biti pozitivni cijeli broj");
            n.BrojNarudzbe = Pomocno.ucitajCijeliBroj("Unesite broj narudzbe: ",
                "Unos mora biti pozitivni cijeli broj");
            n.Korisnici = PostaviKorisnike();
            n.Placanje = Pomocno.UcitajString("Unesite nacina placanja: ",
                "Unos obavezan");
            n.DatumNarudzbe = Pomocno.ucitajDatum("Unesi datum narudzbe u formatu dd.MM.yyyy.", "Greška");
            Narudzbe.Add(n);
        }


        private List<Korisnik> PostaviKorisnike()
        {
            List<Korisnik> korisnici = new List<Korisnik>();
            while (Pomocno.ucitajBool("Želite li dodati korisnike? (da ili bilo što drugo za ne): "))
            {
                korisnici.Add(PostaviKorisnika());
            }

            return korisnici;
        }


        private Korisnik PostaviKorisnika()
        {
            Izbornik.ObradaKorisnik.PregledKorisnika();
            int index = Pomocno.ucitajBrojRaspon("Odaberi redni broj korisnika: ", "Nije dobar odabir", 1, Izbornik.ObradaKorisnik.Korisnici.Count());
            return Izbornik.ObradaKorisnik.Korisnici[index - 1];
        }


        private void BrisanjeNardzbe()
        {
            PrikaziNarudzbe();
            int index = Pomocno.ucitajBrojRaspon("Odaberi redni broj narudzbe: ", "Nije dobar odabir", 1, Narudzbe.Count());
            Narudzbe.RemoveAt(index - 1);
        }
    }
}
