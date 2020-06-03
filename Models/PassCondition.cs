using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommuteTrackerService.Models
{
    public class PassCondition
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public int Minutes { get; set; }
        public int UsualMinutes { get; set; }
        public int RouteId { get; set; }
        public int DelayReasonId { get; set; }
        public string Notes { get; set; }
    }
}