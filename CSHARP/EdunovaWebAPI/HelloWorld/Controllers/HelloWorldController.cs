using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace HelloWorld.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HelloWorldController : ControllerBase
    {
        [HttpGet]
        public string Hello()
        {
            return "Hello world";
        }

        [HttpGet]
        [Route("pozdrav")]
        public string DrugaMetoda()
        {
            return "Pozdrav svijetu";
        }

        [HttpGet]
        [Route("pozdravParametar")]
        public string DrugaMetoda(string s)
        {
            return "Hello " + s;
        }

        [HttpGet]
        [Route("pozdravViseParametara")]
        public string DrugaMetoda(string s="",int i=0)
        {
            return "Hello " + s + " " + i;
        }

        //  Kreirajte rutu /HelloWorld/zad1
        //  koja ne prima parametre i vraća Vaše ime

        //  Kreirajte rutu /HelloWorld/zad2
        //  koja prima dva broja i vraća njihov zbroj


        // DZ

        //  Kreirajte rutu /HelloWorld/zad3
        //  koja prima parametar brojPonavljanja
        //  Ruta vraća niz znakova "Osijek" koji
        //  ima onoliko elemenata koliko smo primili u
        //  brojPonavljanja



        // Kreirati rutu /HelloWorld/ciklicna
        // koja prima dva parametra (x i y) a vraća
        // cikličnu matricu kao dvodimenzionalni niz brojeva


        [HttpGet]
        [Route("{sifra:int}")]
        public string PozdravRuta(int sifra)
        {
            return "Hello " + sifra;
        }

        [HttpGet]
        [Route("{sifra:int}/{kategorija}")]
        public string PozdravRuta2(int sifra, string kategorija)
        {
            return "Hello " + sifra + " " + kategorija;
        }

        [HttpPost]
        public string DodavanjeNovog(string ime)
        {
            return "Dodao " + ime;
        }

        [HttpPut]
        public string Promjena(int sifra, string naziv)
        {
            return "Na šifri " + sifra + " postavljam " + naziv;
        }

        [HttpDelete]
        public bool Obrisao(int sifra)
        {
            return true;
        }





        [HttpGet]
        [Route("matrica")]
        public IActionResult Matrica(int redaka, int stupaca)
        {
           // moj kod koji to napuni

            int[,] matrica = new int[redaka, stupaca];

            int b = 1;

            int n = 0;

            var nizRedaka = new string[redaka];



            while (b < stupaca * redaka)
            {

                for (int i = n + 1; i <= stupaca - n; i++)      // s desna na lijevo
                {
                    if (b <= stupaca * redaka)
                        matrica[redaka - n - 1, stupaca - i] = b++;
                    else break;
                }

                for (int i = redaka - n - 2; i >= n; i--)          // gore
                {
                    if (b <= stupaca * redaka)
                        matrica[i, n] = b++;
                    else break;
                }


                for (int i = n + 1; i <= stupaca - n - 1; i++)    // s lijeva na desno
                {
                    if (b <= stupaca * redaka)
                        matrica[n, i] = b++;
                    else break;
                }


                for (int i = n + 1; i <= redaka - n - 2; i++)       // dolje
                {
                    if (b <= stupaca * redaka)
                        matrica[i, stupaca - n - 1] = b++;
                    else break;
                }

                n++;

            }

            return new JsonResult(JsonConvert.SerializeObject(matrica));
        }

    }
}
