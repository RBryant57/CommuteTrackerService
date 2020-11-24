using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

using DataLayer.Data;
using DataLayer.Interfaces;
using EntityLayer.Contexts;
using EntityLayer.Interfaces;
using EntityLayer.Models;

namespace CommuteTrackerService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DelayReasonsController : ControllerBase
    {
        private IData _data;

        public DelayReasonsController(CommuteTrackerContext context)
        {
            _data = new DelayReasonData(context);
        }

        // GET: api/DelayReasons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetDelayReason()
        {
            var entities = await _data.Get();
            var returnEntities = new List<DelayReason>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((DelayReason)entity); });

            return returnEntities;
        }

        // GET: api/DelayReasons/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IEntity>> GetDelayReason(int id)
        {
            var entity = await _data.Get(id);

            if (entity == null)
            {
                return NotFound();
            }

            return (DelayReason)entity;
        }

        // PUT: api/DelayReasons/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDelayReason(int id, DelayReason entity)
        {
            if (id != entity.Id)
            {
                return BadRequest("Delay reason id does not match delay reason to be updated.");
            }

            try
            {
                await _data.Update(id, entity);
            }
            catch (ArgumentException)
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/DelayReasons
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<IEntity>> PostDelayReason(DelayReason entity)
        {
            var newEntity = await _data.Add(entity);

            return CreatedAtAction("GetDelayReason", new { id = newEntity.Id }, newEntity);
        }

        // DELETE: api/DelayReasons/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IEntity>> DeleteDelayReason(int id)
        {
            return NotFound();

            // Deleting will be implemented later.
            var entity = await _data.Get(id);
            if (entity == null)
            {
                return NotFound();
            }

            await _data.Delete(entity.Id);

            return (DelayReason)entity;
        }
    }
}