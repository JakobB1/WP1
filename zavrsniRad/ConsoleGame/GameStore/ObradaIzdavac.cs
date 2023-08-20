using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameStore
{
    internal class ObradaIzdavac
    {
        public List<Izdavac> Izdavaci { get; }

        public ObradaIzdavac()
        {
            Izdavaci = new List<Izdavac>();
            if (Pomocno.dev)
            {
                TestniPodaci();
            }
        }

        public void PrikaziIzbornik()
        {
            Console.WriteLine("Izbornik za rad s izdavacima");
            Console.WriteLine("1. Pregled postojecih izdavaca");
            Console.WriteLine("2. Unos novog izdavaca");
            Console.WriteLine("3. Promjena postojecih izdavaca");
            Console.WriteLine("4. Brisanje izdavaca");
            Console.WriteLine("5. Povratak na glavni izbornik");
            
            switch(Pomocno.ucitajBrojRaspon("Odabreite stavku izbornika izdavaca: ",
                "Odabir mora biti 1-5", 1, 5))
            {
                case 1:
                    PrikaziIzdavace();
                    PrikaziIzbornik();
                    break;
                case 2:
                    UnosNovogIzdavaca();
                    PrikaziIzbornik();
                    break;
                case 3:
                    PromjenaIzdavaca();
                    PrikaziIzbornik();
                    break;
                case 4:
                    BrisanjeIzdavaca();
                    PrikaziIzbornik();  
                    break;
                case 5:
                    Console.WriteLine("Gotov rad s izdavacima");
                    break;
            }
        }

        public void PromjenaIzdavaca()
        {
            PrikaziIzdavace();
            int index = Pomocno.ucitajBrojRaspon("Odaberi redni broj izdavaca: ", "Nije dobar odabir", 1, Izdavaci.Count());
            var i = Izdavaci[index - 1];
            i.Sifra = Pomocno.ucitajCijeliBroj("Unesite sifru izdavaca (" + i.Sifra + "): ",
                "Unos mora biti pozitivni cijeli broj");
            i.Naziv = Pomocno.UcitajString("Unesite naziv izdavaca (" + i.Naziv + "): ",
                "Unos obavezan");
            i.Drzava = Pomocno.UcitajString("Unesite drzavu izdavaca (" + i.Naziv + "): ",
                "Unos obavezan");
            i.WebStranica = Pomocno.UcitajString("Unesite web stranicu izdavaca (" + i.Naziv + "): ",
                "Unos obavezan");
        }

        private void BrisanjeIzdavaca()
        {
            PrikaziIzdavace();
            int index = Pomocno.ucitajBrojRaspon("Odaberi redni broj izdavaca: ", "Nije dobar odabir", 1, Izdavaci.Count());
            Izdavaci.RemoveAt(index - 1);
        }


        private void UnosNovogIzdavaca()
        {
            var i = new Izdavac();
            i.Sifra = Pomocno.ucitajCijeliBroj("Unesite sifru izdavaca: ",
                "Unos mora biti pozitivni cijeli broj");
            i.Naziv = Pomocno.UcitajString("Unesite naziv izdavaca: ",
                "Unos obavezan");
            i.Drzava = Pomocno.UcitajString("Unesite drzavu izdavaca: ",
                "Unos obavezan");
            i.WebStranica = Pomocno.UcitajString("Unesite web stranicu izdavaca: ",
                "Unos obavezan");
            Izdavaci.Add(i);
        }

        public void PrikaziIzdavace()
        {
            Console.WriteLine("------------------");
            Console.WriteLine("---- Izdavaci ----");
            Console.WriteLine("------------------");
            int b = 1;
            foreach (Izdavac izdavac in Izdavaci)
            {
                Console.WriteLine("{0}. {1}", b++, izdavac.Naziv);
            }
            Console.WriteLine("------------------");
        }

        private void TestniPodaci()
        {
            Izdavaci.Add(new Izdavac
            {
                Sifra = 1,
                Naziv = "Izdavac01",
                Drzava = "Drzava01",
                WebStranica = "Web01"
            });
        }
    }
}
