using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class Destination
    {
        public Destination()
        {
            CommuteLegs = new HashSet<CommuteLeg>();
            CommuteMultiRoutes = new HashSet<CommuteMultiRoute>();
            Commutes = new HashSet<Commute>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Notes { get; set; }

        public virtual ICollection<CommuteLeg> CommuteLegs { get; set; }
        public virtual ICollection<CommuteMultiRoute> CommuteMultiRoutes { get; set; }
        public virtual ICollection<Commute> Commutes { get; set; }
    }
}
