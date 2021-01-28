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
    public class CommuteLegData : IData
    {
        private readonly CommuteTrackerContext _context;
        private const string ENTITY_MISSING = "Commute leg does not exist.";

        public CommuteLegData(CommuteTrackerContext context)
        {
            _context = context;
        }

        public async Task<List<IEntity>> Get()
        {
            return await _context.CommuteLeg.Include(d => d.Destination).Include(dr => dr.DelayReason).Include(f => f.FareClass).Include(r => r.Route).Include(c => c.Commute).ToListAsync<IEntity>();
        }

        public async Task<IEntity> Get(int id)
        {
            return await _context.CommuteLeg.Include(d => d.Destination).Include(dr => dr.DelayReason).Include(f => f.FareClass).Include(r => r.Route).Include(c => c.Commute).Where(cl => cl.Id == id).FirstOrDefaultAsync<IEntity>();
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
                if (!_context.CommuteLeg.Any(e => e.Id == id))
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
            _context.CommuteLeg.Add((CommuteLeg)entity);
            await _context.SaveChangesAsync();

            return (CommuteLeg)entity;
        }

        public async Task<IEntity> Delete(int id)
        {
            var entity = await _context.CommuteLeg.FindAsync(id);
            if (entity == null)
            {
                throw new ArgumentException(ENTITY_MISSING);
            }

            _context.CommuteLeg.Remove(entity);
            await _context.SaveChangesAsync();

            return entity;
        }

    }
}