﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CommuteTrackerService.Models
{
    public class Route
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int RouteTypeId { get; set; }
        public string Number { get; set; }
        public int Miles { get; set; }
        public string Notes { get; set; }
    }
}