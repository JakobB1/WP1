using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E01Nasljedivanje
{
    
    internal class Osoba : Object // svaka klasa nasljeđuje Object htjela ona to ili ne i to se ne mora pisati
    {

        int brojac;
        protected bool uvjet;
        private string naziv;
        internal DateTime datum;

        public int Sifra { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }

        public Osoba() { }

        // metoda toString postoji na klasi Object i mi ovdje redefiniramo (prepišemo/override) njezino ponašanje
        public override string ToString()
        {
            return Ime + " " + Prezime;
        }

        public override bool Equals(object? obj)
        {
            var o = obj as Osoba;
            return Sifra.Equals(o.Sifra);
        }

    }
}
