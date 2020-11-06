using EntityLayer.Interfaces;

namespace EntityLayer.Models
{
    public class DelayReason : IEntity
    {
        public int Id { get; set; }
        public string Description { get; set; }
        
    }
}