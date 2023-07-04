using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E01KlasaObjekt
{
    // Ovo morate znati nakon svatova u 4 ujutro
    // Klasa je opisnik objekta
    internal class Osoba
    {
        // ovako se ne smiju deklarirati svojstva u klasi
        // zato što nije zadovoljen OOP princip učahurivanja
        /*
        public string ime;
        internal string prezime;
        int godine;
        */

        // zadnja vrsta metoda: konstruktor
        // poziva se u trenutku instanciranja novog objekta (ključna riječ new)
        // ona nije obavezna. Ako nije definirana poziva se konstruktor iz nadklase (nasljeđivanje)
        // Naziv konstruktora mora biti identičan nazivu klase
        public Osoba() 
        {
            Console.WriteLine("Konstruktor klase Osoba");
        }

        public Osoba(string ime)
        {
            Console.WriteLine(ime);
        }
    }
}
