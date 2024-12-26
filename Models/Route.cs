using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CommuteTrackerService.Models
{
    public partial class Route
    {
        public Route()
        {
            CommuteLegs = new HashSet<CommuteLeg>();
            CommutesRoutes = new HashSet<CommutesRoute>();
            PassConditions = new HashSet<PassCondition>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public int Type { get; set; }
        public string Number { get; set; }
        public int Miles { get; set; }
        public string Notes { get; set; }

        public virtual RouteType RouteType { get; set; }
        [JsonIgnore]
        public virtual ICollection<CommuteLeg> CommuteLegs { get; set; }
        [JsonIgnore]
        public virtual ICollection<CommutesRoute> CommutesRoutes { get; set; }
        [JsonIgnore]
        public virtual ICollection<PassCondition> PassConditions { get; set; }
    }
}
