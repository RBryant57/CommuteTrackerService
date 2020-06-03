using Microsoft.EntityFrameworkCore;
using CommuteTrackerService.Models;

namespace CommuteTrackerService.Models
{

    public class CommuteTrackerContext : DbContext
    {

        public CommuteTrackerContext(DbContextOptions<CommuteTrackerContext> options) : base(options)
        {

        }

        public DbSet<CommuteLeg> CommuteLeg { get; set; }
        public DbSet<Commute> Commute { get; set; }
        public DbSet<Destination> Destination { get; set; }
        public DbSet<CommuteTrackerService.Models.DelayReason> DelayReason { get; set; }
        public DbSet<CommuteTrackerService.Models.FareClass> FareClass { get; set; }
        public DbSet<CommuteTrackerService.Models.PassCondition> PassCondition { get; set; }
        public DbSet<CommuteTrackerService.Models.Route> Route { get; set; }
        public DbSet<CommuteTrackerService.Models.RouteType> RouteType { get; set; }
    }
}