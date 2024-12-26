using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class Commute
    {
        public Commute()
        {
            CommuteLegs = new HashSet<CommuteLeg>();
        }

        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int Destination { get; set; }
        public int DelaySeconds { get; set; }
        public string Notes { get; set; }

        public virtual Destination DestinationNavigation { get; set; }
        public virtual ICollection<CommuteLeg> CommuteLegs { get; set; }
    }
}
