using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class FareClass
    {
        public FareClass()
        {
            CommuteLegs = new HashSet<CommuteLeg>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Notes { get; set; }

        public virtual ICollection<CommuteLeg> CommuteLegs { get; set; }
    }
}
