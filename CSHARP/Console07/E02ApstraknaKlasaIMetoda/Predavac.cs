using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E02ApstraknaKlasaIMetoda
{
    internal class Predavac : Osoba
    {
        public int Godine { get; set; }

        public override void Pozdravi()
        {
            Console.WriteLine(Godine>24 ? "Dobar dan gospođo/ine" : "Dobar dan mladiću");
        }
    }
}
