using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameStore
{
    internal class Izdavac : Entitet
    {
        public string Naziv { get; set; }
        public string Drzava { get; set; }  
        public string WebStranica { get; set; } 
    }
}