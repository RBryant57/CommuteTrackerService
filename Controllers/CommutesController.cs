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
    public class CommutesController : ControllerBase
    {
        private IData _data;

        public CommutesController(CommuteTrackerContext context)
        {
            _data = new CommuteData(context);
        }

        // GET: api/Commutes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetCommute()
        {
            var entities = await _data.Get();
            var returnEntities = new List<Commute>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((Commute)entity); });

            return returnEntities;
        }

        // GET: api/Commutes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IEntity>> GetCommute(int id)
        {
            var entity = await _data.Get(id);

            if (entity == null)
            {
                return NotFound();
            }

            return (Commute)entity;
        }

        // GET: api/GetOpenCommutes
        [HttpGet]
        [Route("[action]")]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetOpenCommutes()
        {
            var entities = await ((CommuteData)_data).GetOpenCommutes();
            var returnEntities = new List<Commute>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((Commute)entity); });

            return returnEntities;
        }

        // PUT: api/Commutes/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCommute(int id, Commute entity)
        {
            if (id != entity.Id)
            {
                return BadRequest("Commute id does not match commute to be updated.");
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

        // POST: api/Commutes
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<IEntity>> PostCommute(Commute entity)
        {
            var newEntity = await _data.Add(entity);

            return CreatedAtAction("GetCommute", new { id = newEntity.Id }, newEntity);
        }

        // DELETE: api/Commutes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IEntity>> DeleteCommute(int id)
        {
            return NotFound();

            // Deleting will be implemented later.
            var entity = await _data.Get(id);
            if (entity == null)
            {
                return NotFound();
            }

            await _data.Delete(entity.Id);

            return (Commute)entity;
        }
    }
}