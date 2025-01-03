﻿using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class CommuteLeg
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int Destination { get; set; }
        public int Delay { get; set; }
        public int DelaySeconds { get; set; }
        public int FareClass { get; set; }
        public int Route { get; set; }
        public int Commute { get; set; }
        public string Notes { get; set; }

        public virtual Commute CommuteNavigation { get; set; }
        public virtual DelayReason DelayNavigation { get; set; }
        public virtual Destination DestinationNavigation { get; set; }
        public virtual FareClass FareClassNavigation { get; set; }
        public virtual Route RouteNavigation { get; set; }
    }
}
