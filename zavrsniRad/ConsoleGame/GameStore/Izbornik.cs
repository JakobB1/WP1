using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameStore
{
    internal class Izbornik
    {
        public ObradaIzdavac ObradaIzdavac { get;}
        public ObradaIgra ObradaIgra { get;}

        public Izbornik() 
        {
            ObradaIzdavac = new ObradaIzdavac();
            ObradaIgra = new ObradaIgra();
            PozdravnaPoruka();
            PrikaziIzbornik();  
        }

        private void PozdravnaPoruka()
        {
            Console.WriteLine("***************************************");
            Console.WriteLine("***** GameStore Console APP v 1.0 *****");
            Console.WriteLine("***************************************");
        }

        private void PrikaziIzbornik()
        {
            Console.WriteLine("Glavni izbornik");
            Console.WriteLine("1. Izdavac");
            Console.WriteLine("2. Igra");
            Console.WriteLine("3. Korisnik");
            Console.WriteLine("4. Narudzba");
            Console.WriteLine("5. Izlaz iz programa");

            switch(Pomocno.ucitajBrojRaspon("Odaberite stavku izbornika: ",
                "Odabir mora biti 1-5", 1, 5))
            {
                case 1:
                    ObradaIzdavac.PrikaziIzbornik();
                    PrikaziIzbornik();
                    break;
                case 2:
                    ObradaIgra.PrikaziIzbornik();
                    PrikaziIzbornik();
                    break;
                case 3:
                    PrikaziIzbornik();
                    break;
                case 4:
                    PrikaziIzbornik();
                    break;
                case 5:
                    Console.WriteLine("Hvala na koristenju, dovidenja");
                    break;  
            }
        }
    }
}