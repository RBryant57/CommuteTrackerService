using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class AverageCommute
    {
        public string Route { get; set; }
        public int Length { get; set; }
        public string RouteType { get; set; }
        public int? AverageSeconds { get; set; }
    }
}
