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
    public class FareClassesController : ControllerBase
    {
        private IData _data;

        public FareClassesController(CommuteTrackerContext context)
        {
            _data = new FareClassData(context);
        }

        // GET: api/FareClasses
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetFareClass()
        {
            var entities = await _data.Get();
            var returnEntities = new List<FareClass>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((FareClass)entity); });

            return returnEntities;
        }

        // GET: api/FareClasses/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IEntity>> GetFareClass(int id)
        {
            var entity = await _data.Get(id);

            if (entity == null)
            {
                return NotFound();
            }

            return (FareClass)entity;
        }

        // PUT: api/FareClasses/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFareClass(int id, FareClass entity)
        {
            if (id != entity.Id)
            {
                return BadRequest("Fare class id does not match fare class to be updated.");
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

        // POST: api/FareClasses
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<IEntity>> PostFareClass(FareClass entity)
        {
            var newEntity = await _data.Add(entity);

            return CreatedAtAction("GetFareClass", new { id = newEntity.Id }, newEntity);
        }

        // DELETE: api/FareClasses/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IEntity>> DeleteFareClass(int id)
        {
            return NotFound();

            // Deleting will be implemented later.
            var entity = await _data.Get(id);
            if (entity == null)
            {
                return NotFound();
            }

            await _data.Delete(entity.Id);

            return (FareClass)entity;
        }
    }
}