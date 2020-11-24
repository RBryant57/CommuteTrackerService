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
    public class CommuteData : IData
    {
        private readonly CommuteTrackerContext _context;
        private const string ENTITY_MISSING = "Commute does not exist.";

        public CommuteData(CommuteTrackerContext context)
        {
            _context = context;
        }

        public async Task<List<IEntity>> Get()
        {
            var returnModels = new List<IEntity>();
            return await _context.Commute.Include(c => c.CommuteLegs).ToListAsync<IEntity>();
        }

        public async Task<IEntity> Get(int id)
        {
            return await _context.Commute.Include(c => c.CommuteLegs).Where(i => i.Id == id).FirstOrDefaultAsync<IEntity>();
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
                if (!_context.Commute.Any(e => e.Id == id))
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
            _context.Commute.Add((Commute)entity);
            await _context.SaveChangesAsync();

            return (Commute)entity;
        }

        public async Task<IEntity> Delete(int id)
        {
            var entity = await _context.Commute.FindAsync(id);
            if (entity == null)
            {
                throw new ArgumentException(ENTITY_MISSING);
            }

            _context.Commute.Remove(entity);
            await _context.SaveChangesAsync();

            return entity;
        }

    }
}