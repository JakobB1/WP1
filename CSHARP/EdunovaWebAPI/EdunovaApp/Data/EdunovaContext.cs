using EdunovaApp.Models;
using Microsoft.EntityFrameworkCore;

namespace EdunovaApp.Data
{
    public class EdunovaContext : DbContext
    {
        public EdunovaContext(DbContextOptions<EdunovaContext> opcije)
            : base(opcije)
        {

        }

        public DbSet<Smjer> Smjer { get; set; }
        public DbSet<Polaznik> Polaznik { get; set; }

        public DbSet<Grupa> Grupa { get; set; }

        protected override void OnModelCreating(
            ModelBuilder modelBuilder)
        {
            // implementacija veze 1:n
            modelBuilder.Entity<Grupa>().HasOne(g => g.Smjer);

            // implementacjia veze n:n
            modelBuilder.Entity<Grupa>()
                .HasMany(g => g.Polaznici)
                .WithMany(p => p.Grupe)
                .UsingEntity<Dictionary<string, object>>("clan",
                c => c.HasOne<Polaznik>().WithMany().HasForeignKey("polaznik"),
                c => c.HasOne<Grupa>().WithMany().HasForeignKey("grupa"),
                c => c.ToTable("clan")
                );
        }

    }
}
