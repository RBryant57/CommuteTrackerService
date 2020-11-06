using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

using DataLayer.Interfaces;
using EntityLayer.Contexts;
using EntityLayer.Interfaces;
using EntityLayer.Models;

namespace DataLayer.Data
{
    public class RouteTypeData : IData
    {
        private readonly CommuteTrackerContext _context;
        private const string ENTITY_MISSING = "Route type does not exist.";

        public RouteTypeData(CommuteTrackerContext context)
        {
            _context = context;
        }

        public async Task<List<IEntity>> Get()
        {
            var returnModels = new List<IEntity>();
            return await _context.RouteType.ToListAsync<IEntity>();
        }

        public async Task<IEntity> Get(int id)
        {
            return await _context.RouteType.FindAsync(id);
        }

        public async Task<bool> Update(int id, IEntity entity)
        {
            _context.Entry(entity).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.RouteType.Any(e => e.Id == id))
                {
                    throw new ArgumentException(ENTITY_MISSING);
                }
                else
                {
                    throw;
                }
            }

            return true;
        }

        public async Task<IEntity> Add(IEntity entity)
        {
            _context.RouteType.Add((RouteType)entity);
            await _context.SaveChangesAsync();

            return (RouteType)entity;
        }

        public async Task<IEntity> Delete(int id)
        {
            var entity = await _context.RouteType.FindAsync(id);
            if (entity == null)
            {
                throw new ArgumentException(ENTITY_MISSING);
            }

            _context.RouteType.Remove(entity);
            await _context.SaveChangesAsync();

            return entity;
        }

    }
}