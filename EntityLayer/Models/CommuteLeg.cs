using System;

using EntityLayer.Interfaces;

namespace EntityLayer.Models
{
    public class CommuteLeg : IEntity
    {
        public int Id { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int DestinationId { get; set; }
        public int DelayId { get; set; }
        public int DelaySeconds { get; set; }
        public int FareClassId { get; set; }
        public int RouteId { get; set; }
        public int CommuteId { get; set; }
        public string Notes { get; set; }
    }
}