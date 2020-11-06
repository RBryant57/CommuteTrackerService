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
    public class PassConditionsController : ControllerBase
    {
        private IData _data;

        public PassConditionsController(CommuteTrackerContext context)
        {
            _data = new PassConditionData(context);
        }

        // GET: api/PassConditions
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetPassCondition()
        {
            var entities = await _data.Get();
            var returnEntities = new List<PassCondition>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((PassCondition)entity); });

            return returnEntities;
        }

        // GET: api/PassConditions/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IEntity>> GetPassCondition(int id)
        {
            var entity = await _data.Get(id);

            if (entity == null)
            {
                return NotFound();
            }

            return (PassCondition)entity;
        }

        // PUT: api/PassConditions/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPassCondition(int id, PassCondition entity)
        {
            if (id != entity.Id)
            {
                return BadRequest("Pass condition id does not match pass condition to be updated.");
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

        // POST: api/PassConditions
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<IEntity>> PostPassCondition(PassCondition entity)
        {
            var newEntity = await _data.Add(entity);

            return CreatedAtAction("GetPassCondition", new { id = newEntity.Id }, newEntity);
        }

        // DELETE: api/RouteTypes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IEntity>> DeletePassCondition(int id)
        {
            return NotFound();

            // Deleting will be implemented later.
            var entity = await _data.Get(id);
            if (entity == null)
            {
                return NotFound();
            }

            await _data.Delete(entity.Id);

            return (PassCondition)entity;
        }
    }
}