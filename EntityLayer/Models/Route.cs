using System.ComponentModel.DataAnnotations.Schema;
using EntityLayer.Interfaces;

namespace EntityLayer.Models
{
    public class Route : IEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int RouteTypeId { get; set; }
        public string Number { get; set; }
        public int Miles { get; set; }
        public string Notes { get; set; }
        [ForeignKey("RouteTypeId")]
        public RouteType RouteType { get; set; }
    }
}