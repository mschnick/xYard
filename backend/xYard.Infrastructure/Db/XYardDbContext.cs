using Microsoft.EntityFrameworkCore;
using xYard.Domain.Entities;

namespace xYard.Infrastructure.Db;

public class XYardDbContext : DbContext
{
    public XYardDbContext(DbContextOptions<XYardDbContext> options)
        : base(options)
    {
    }

    public DbSet<Point> Points => Set<Point>();
    public DbSet<Route> Routes => Set<Route>();
    // später: Boards, Users, etc.
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Route>()
            .HasOne(r => r.FromPoint)
            .WithMany(p => p.RoutesFromHere)
            .HasForeignKey(r => r.FromPointId)
            .OnDelete(DeleteBehavior.Restrict); // Verhindert Kaskadenlöschung

        modelBuilder.Entity<Route>()
            .HasOne(r => r.ToPoint)
            .WithMany()
            .HasForeignKey(r => r.ToPointId)
            .OnDelete(DeleteBehavior.Restrict);
    }

}