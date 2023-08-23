using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _02Delegati
{
    internal class PrimjerKoristenje2
    {
        public PrimjerKoristenje2()
        {
            ObradaSmjer os = new();
            os.IspisSmjer(nijeBitno);
        }

        private void nijeBitno(Smjer s)
        {
            Console.WriteLine("Drugi nacin: " + s.Naziv);
        }

    }
}
