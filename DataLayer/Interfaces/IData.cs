using System.Collections.Generic;
using System.Threading.Tasks;

using EntityLayer.Interfaces;

namespace DataLayer.Interfaces
{
    public interface IData
    {
        Task<List<IEntity>> Get();
        Task<IEntity> Get(int id);
        Task<bool> Update(int id, IEntity entity);
        Task<IEntity> Add(IEntity entity);
        Task<IEntity> Delete(int id);
    }
}