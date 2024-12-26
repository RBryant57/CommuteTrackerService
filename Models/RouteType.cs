using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CommuteTrackerService.Models
{
    public partial class RouteType
    {
        public RouteType()
        {
            Routes = new HashSet<Route>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Notes { get; set; }

        [JsonIgnore]
        public virtual ICollection<Route> Routes { get; set; }
    }
}