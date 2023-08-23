using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _01Lambda
{
    internal class Smjer
    {

        public int Sifra { get; set; }
        // ? oznacava kako Naziv moze biti null
        public String? Naziv { get; set; }

        public override string ToString()
        {
            // return Naziv==null ? "" : Naziv;
            return Naziv ?? ""; // ova linija je ekvivalent gornjoj
        }
    }
}
