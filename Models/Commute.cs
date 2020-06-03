using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public class Commute
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int Destination { get; set; }
        public int DelaySeconds { get; set; }
        public List<CommuteLeg> CommuteLegs { get; set; }
        public string Notes { get; set; }

        public Commute()
        {
            CommuteLegs = new List<CommuteLeg>();
        }
    }
}