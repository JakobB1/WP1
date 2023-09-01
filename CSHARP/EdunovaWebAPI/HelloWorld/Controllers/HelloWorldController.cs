using Microsoft.AspNetCore.Mvc;

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





    }
}
