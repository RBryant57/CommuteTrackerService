using EntityLayer.Interfaces;

namespace EntityLayer.Models
{
    public class Destination : IEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Notes { get; set; }
    }
}