
// operatori uspoređivanja -> bool

bool razlicito = 3 != 4;


bool vece = 8>6;

Console.WriteLine("{0},{1}", razlicito, vece);

// Logički operatori -> učimo kod if naredbe

bool rez = razlicito & vece;

// operator + ima dvojaku ulogu

string s = "Edunova" + " Osijek"; //nadoljepiti

int x = 6 + 2; // zbrojiti

string s1 = "Broj " + 5;

// operator modulo ostatak nakon cjelobrojnog djeljenja
// školski primjer je parni i neparni broj

// Za unesi broj ispiši True ako je parni ili False ako je neparni

Console.WriteLine("Unesi broj: ");
x = Int16.Parse(Console.ReadLine());    

Console.WriteLine(x%2==0);


// Deklarirajte varijablu tipa int naziva negativniBroj i 
// dodjelite joj vrijednost -262
int negativniBroj = -262;
Console.WriteLine(negativniBroj);
// ispišite pozitivni ekvivalent negativniBroj



// Za unesena dva cijela broj
// ispišite razultat djeljenja
// npr. ulaz 5 i 10, izlaz 0,5




