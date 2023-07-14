using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameStore
{
    internal class NaruzbaIgra : Entitet
    {
        public List<Igra> Igre { get; set; }
        public List<Narudzba> Narudzbe { get; set; }
        public int Kolicina { get; set; }   
    }
}