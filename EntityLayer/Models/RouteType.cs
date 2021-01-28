using System.Collections.Generic;
using EntityLayer.Interfaces;

namespace EntityLayer.Models
{
    public class RouteType : IEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Notes { get; set; }
    }
}