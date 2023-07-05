using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E01Nasljedivanje
{
    internal class Polaznik :Osoba
    {
        public string BrojUgovora { get; set; }

        public override string ToString()
        {
            // vidimo iz nadklase protected, interbal i private načine pristupa
            //base.uvjet = true;
            return base.ToString() + " " + BrojUgovora;
        }
    }
}
