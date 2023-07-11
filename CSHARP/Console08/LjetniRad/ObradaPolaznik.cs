using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LjetniRad
{
    internal class ObradaPolaznik
    {
        public List<Polaznik> Polaznici { get; }   

        public ObradaPolaznik() 
        {
            Polaznici = new List<Polaznik>();
        }

        public void PrikaziIzbornik()
        {
                Console.WriteLine("Izbornik za rad s polaznicima");
                Console.WriteLine("1. Pregleda postojećih polaznika");
                Console.WriteLine("2. Unos novog polaznika");
                Console.WriteLine("3. Promjena postojećeg polaznika");
                Console.WriteLine("4. Brisanje polaznika");
                Console.WriteLine("5. Povratak na glavni izbornik");
            switch (Pomocno.ucitajBrojRaspon("Odaberite stavku izbornika smjera: ",
                "Odabir mora biti 1-5", 1, 5))
            {
                case 1:
                    PregledPolaznika();
                    PrikaziIzbornik();
                    break;
                case 2:
                    UcitajPolaznik();
                    PrikaziIzbornik();
                    break;
                case 5:
                    Console.WriteLine("Gotov rad s polaznicima");
                    break;


            }
            }

        private void PregledPolaznika()
        {
            foreach(Polaznik polaznik in Polaznici)
            {
                Console.WriteLine(polaznik);
            }
        }

        private void UcitajPolaznik()
        {
            var p = new Polaznik();
            p.Ime = Pomocno.UcitajString("Unesi ime polaznika: ", "Ime obavezno");
            p.Prezime = Pomocno.UcitajString("Unesi prezime polaznika: ", "Prezime obavezno");
            // ostala svojstva kasnije
            Polaznici.Add(p);


        }
    }
}
