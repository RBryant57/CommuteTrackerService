using System;
using System.Collections.Generic;

namespace CommuteTrackerService.Models
{
    public partial class PassCondition
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public int Minutes { get; set; }
        public int UsualMinutes { get; set; }
        public int RouteId { get; set; }
        public int DelayReasonId { get; set; }
        public string Notes { get; set; }

        public virtual DelayReason DelayReason { get; set; }
        public virtual Route Route { get; set; }
    }
}
