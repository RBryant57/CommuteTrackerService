using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class CommutesRoute
    {
        public int Id { get; set; }
        public int CommuteId { get; set; }
        public int RouteId { get; set; }
        public string Notes { get; set; }

        public virtual CommuteMultiRoute Commute { get; set; }
        public virtual Route Route { get; set; }
    }
}
