using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

using EntityLayer.Interfaces;

namespace EntityLayer.Models
{
    public class Commute : IEntity
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public int DestinationId { get; set; }
        public int DelaySeconds { get; set; }
        public List<CommuteLeg> CommuteLegs { get; set; }
        public string Notes { get; set; }
        [ForeignKey("DestinationId")]
        public Destination Destination { get; set; }

        public Commute()
        {
            CommuteLegs = new List<CommuteLeg>();
        }
    }
}