using GameStoreWebAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace GameStoreWebAPI.Data
{
    public class GameContext : DbContext
    {
        public GameContext(DbContextOptions<GameContext> opcije)
            : base(opcije) {

        }

        public DbSet<Izdavac> Izdavac { get; set; }
        public DbSet<Korisnik> Korisnik { get; set; }
    }
}
