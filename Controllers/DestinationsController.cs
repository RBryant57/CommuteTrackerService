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
    public class DestinationsController : ControllerBase
    {
        private IData _data;

        public DestinationsController(CommuteTrackerContext context)
        {
            _data = new DestinationData(context);
        }

        // GET: api/Destinations
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetDestination()
        {
            var entities = await _data.Get();
            var returnEntities = new List<Destination>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((Destination)entity); });

            return returnEntities;
        }

        // GET: api/Destinations/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IEntity>> GetDestination(int id)
        {
            var entity = await _data.Get(id);

            if (entity == null)
            {
                return NotFound();
            }

            return (Destination)entity;
        }

        // PUT: api/Destinations/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDestination(int id, Destination entity)
        {
            if (id != entity.Id)
            {
                return BadRequest("Destination id does not match destination to be updated.");
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

        // POST: api/Destinations
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<IEntity>> PostDestination(Destination entity)
        {
            var newEntity = await _data.Add(entity);

            return CreatedAtAction("GetDestination", new { id = newEntity.Id }, newEntity);
        }

        // DELETE: api/Destinations/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IEntity>> DeleteDestination(int id)
        {
            return NotFound();

            // Deleting will be implemented later.
            var entity = await _data.Get(id);
            if (entity == null)
            {
                return NotFound();
            }

            await _data.Delete(entity.Id);

            return (Destination)entity;
        }
    }
}