using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class DelayReason
    {
        public DelayReason()
        {
            CommuteLegs = new HashSet<CommuteLeg>();
            CommuteMultiRoutes = new HashSet<CommuteMultiRoute>();
            PassConditions = new HashSet<PassCondition>();
        }

        public int Id { get; set; }
        public string Description { get; set; }

        public virtual ICollection<CommuteLeg> CommuteLegs { get; set; }
        public virtual ICollection<CommuteMultiRoute> CommuteMultiRoutes { get; set; }
        public virtual ICollection<PassCondition> PassConditions { get; set; }
    }
}
