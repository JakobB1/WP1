using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _02Delegati
{
    internal class PrimjerKoristenje3
    {

        public PrimjerKoristenje3()
        {
            var os = new ObradaSmjer();
            Action<Smjer> a = new(MetodaOvdje);
            os.IspisSmjerAction(a);

        }

        void MetodaOvdje(Smjer s)
        {
            Console.WriteLine("\"" + s.Naziv + "\"");
        }

    }
}
