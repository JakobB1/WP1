using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E02ApstraknaKlasaIMetoda
{
    internal abstract class Osoba
    {
        public abstract void Pozdravi();

        public int Sifra { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }


    }
}
