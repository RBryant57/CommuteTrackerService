using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommuteTrackerService.Models
{
    public class CommuteLeg
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int Destination { get; set; }
        public int Delay { get; set; }
        public int DelaySeconds { get; set; }
        public int FareClass { get; set; }
        public int Route { get; set; }
        public int CommuteId { get; set; }
        public string Notes { get; set; }
    }
}