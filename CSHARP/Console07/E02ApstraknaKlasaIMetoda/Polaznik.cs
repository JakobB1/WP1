using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E02ApstraknaKlasaIMetoda
{
    internal class Polaznik : Osoba
    {
        public string BrojUgovora { get; set; }

        public string Spol { get; set; }

        public override void Pozdravi()
        {
            Console.WriteLine(Spol.Equals("Ženski") ? "Dobar dan gospođo" : "Dobar dan gospodine");
        }
    }
}
