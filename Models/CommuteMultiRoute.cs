using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class CommuteMultiRoute
    {
        public CommuteMultiRoute()
        {
            CommutesRoutes = new HashSet<CommutesRoute>();
        }

        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int Destination { get; set; }
        public int Delay { get; set; }
        public string Notes { get; set; }

        public virtual DelayReason DelayNavigation { get; set; }
        public virtual Destination DestinationNavigation { get; set; }
        public virtual ICollection<CommutesRoute> CommutesRoutes { get; set; }
    }
}
