using System;

using EntityLayer.Interfaces;

namespace EntityLayer.Models
{
    public class PassCondition : IEntity
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