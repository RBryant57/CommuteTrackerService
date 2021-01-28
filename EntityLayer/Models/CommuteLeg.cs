using System;
using System.ComponentModel.DataAnnotations.Schema;

using EntityLayer.Interfaces;

namespace EntityLayer.Models
{
    public class CommuteLeg : IEntity
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int DestinationId { get; set; }
        public int DelayReasonId { get; set; }
        public int DelaySeconds { get; set; }
        public int FareClassId { get; set; }
        public int RouteId { get; set; }
        public int CommuteId { get; set; }
        public string Notes { get; set; }
        [ForeignKey("DestinationId")]
        public Destination Destination { get; set; }
        [ForeignKey("DelayReasonId")]
        public DelayReason DelayReason { get; set; }
        [ForeignKey("FareClassId")]
        public FareClass FareClass { get; set; }
        [ForeignKey("RouteId")]
        public Route Route { get; set; }
        [ForeignKey("CommuteId")]
        public Commute Commute { get; set; }
    }
}