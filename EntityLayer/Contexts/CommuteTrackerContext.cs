using Microsoft.EntityFrameworkCore;

using EntityLayer.Models;

namespace EntityLayer.Contexts
{

    public class CommuteTrackerContext : DbContext
    {

        public CommuteTrackerContext(DbContextOptions<CommuteTrackerContext> options) : base(options)
        {

        }

        public DbSet<CommuteLeg> CommuteLeg { get; set; }
        public DbSet<Commute> Commute { get; set; }
        public DbSet<Destination> Destination { get; set; }
        public DbSet<DelayReason> DelayReason { get; set; }
        public DbSet<FareClass> FareClass { get; set; }
        public DbSet<Models.PassCondition> PassCondition { get; set; }
        public DbSet<Route> Route { get; set; }
        public DbSet<RouteType> RouteType { get; set; }
    }
}