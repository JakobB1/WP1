using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace GameStore
{
    internal class ObradaIgra
    {
        public List<Igra> Igre { get; }

        private Izbornik Izbornik;

        public ObradaIgra(Izbornik izbornik) : this()
        {
            this.Izbornik = izbornik;
        }

        public ObradaIgra()
        {
            Igre = new List<Igra>();
        }

        public void PrikaziIzbornik()
        {
            Console.WriteLine("Izbornik za rad s igrama");
            Console.WriteLine("1. Pregled postojecih igara");
            Console.WriteLine("2. Unos novih igara");
            Console.WriteLine("3. Promjena postojecih igara");
            Console.WriteLine("4. Brisanje igara");
            Console.WriteLine("5. Povratak na glavni izbornik");

            switch (Pomocno.ucitajBrojRaspon("Odaberite stavku izbornika igra: ",
                "Odabir mora biti 1-5", 1, 5))
            {
                case 1:
                    PrikaziIgre();
                    PrikaziIzbornik();
                    break;
                case 2:
                    UnosNoveIgre();
                    PrikaziIzbornik();
                    break;
                case 3:
                    PrikaziIzbornik();
                    break;
                case 4:
                    BrisanjeIgre();
                    PrikaziIzbornik();
                    break;
                case 5:
                    Console.WriteLine("Gotov rad s grupama");
                    break;
            }
        }

        private void UnosNoveIgre()
        {
            var i = new Igra();
            i.Sifra = Pomocno.ucitajCijeliBroj("Unesite sifru igre: ",
                "Unos mora biti pozitivni cijeli broj");
            i.Naziv = Pomocno.UcitajString("Unesite naziv igre: ",
                "Unos obavezan");
            i.Zanr = Pomocno.UcitajString("Unesite zanr igre: ",
                "Unos obavezan");
            i.Opis = Pomocno.UcitajString("Unesite opis igre: ",
                "Unos obavezan");
            i.Izdavaci = PostaviIzdavace();
            i.Cijena = Pomocno.ucitajDecimalniBroj("Unesite cijenu (. za decimalni dio): ", 
                "Unos mora biti pozitivan broj");
            i.DobnaGranica = Pomocno.ucitajCijeliBroj("Unesite dobrnu granicu igre: ",
                "Unos mora biti pozitivni cijeli broj");
            i.DatumIzlaska = Pomocno.ucitajDatum("Unesi datum grupe u formatu dd.MM.yyyy.", "Greška");
            Igre.Add(i);
        }

        private void BrisanjeIgre()
        {
            PrikaziIgre();
            int index = Pomocno.ucitajBrojRaspon("Odaberi redni broj igre: ", "Nije dobar odabir", 1, Igre.Count());
            Igre.RemoveAt(index - 1);
        }

        private List<Izdavac> PostaviIzdavace()
        {
            List<Izdavac> izdavaci = new List<Izdavac>();
            while (Pomocno.ucitajBool("Želite li dodati izdavace? (da ili bilo što drugo za ne): "))
            {
                izdavaci.Add(PostaviIzdavaca());
            }
            return izdavaci;
        }

        private Izdavac PostaviIzdavaca()
        {
            Izbornik.ObradaIzdavac.PrikaziIzdavace();
            int index = Pomocno.ucitajBrojRaspon("Odaberi redni broj izdavaca: ", "Nije dobar odabir", 1, Izbornik.ObradaIzdavac.Izdavaci.Count());
            return Izbornik.ObradaIzdavac.Izdavaci[index - 1];
        }

        public void PrikaziIgre()
        {
            Console.WriteLine("------------------");
            Console.WriteLine("---- Igre---- ----");
            Console.WriteLine("------------------");
            int b = 1;
            foreach (Igra igra in Igre)
            {
                Console.WriteLine("{0}. {1}", b++, igra.Naziv);
            }
            Console.WriteLine("------------------");
        }

    }
}
