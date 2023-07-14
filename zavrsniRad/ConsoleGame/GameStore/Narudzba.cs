using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameStore
{
    internal class Narudzba : Entitet
    {
        public List<Korisnik> Korisnici { get; set; }   
        public string Placanje { get; set; }    
        public DateTime DatumNarudzbe { get; set; } 
    }
}