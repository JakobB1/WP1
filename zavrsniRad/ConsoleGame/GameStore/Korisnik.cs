using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameStore
{
    internal class Korisnik : Entitet
    {
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Email { get; set; }
        public string Oib { get; set; }

        public override string ToString()
        {
            return Ime + " " + Prezime;
        }
    }
}