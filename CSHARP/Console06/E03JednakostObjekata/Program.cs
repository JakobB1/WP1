

using E03JednakostObjekata;

var s = "Osijek";

var n = "Osijek";

Console.WriteLine(s==n);
Console.WriteLine(s.Equals(n));


Grad g1 = new Grad
{
    Naziv = "Osijek"
};

Grad g2 = new Grad
{
    Naziv = "Osijek"
};

Console.WriteLine(g1==g2);
Console.WriteLine(g1.Equals(g2));

Console.WriteLine(g1.GetHashCode());
Console.WriteLine(g2.GetHashCode()); // kasnije u nasljeđivanju
