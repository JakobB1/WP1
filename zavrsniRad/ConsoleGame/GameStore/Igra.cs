using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameStore
{
    internal class Igra : Entitet
    {
        public string Naziv { get; set; }
        public string Zanr { get; set; }
        public string Opis { get; set; }
        public List<Izdavac> Izdavaci { get; set; }
        public decimal Cijena { get; set; }
        public int DobnaGranica { get; set; }
        public DateTime DatumIzlaska { get; set; }
    }
}