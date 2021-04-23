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
    public class CommuteLegsController : ControllerBase
    {
        private IData _data;

        public CommuteLegsController(CommuteTrackerContext context)
        {
            _data = new CommuteLegData(context);
        }

        // GET: api/CommuteLegs
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetCommuteLeg()
        {
            var entities = await _data.Get();
            var returnEntities = new List<CommuteLeg>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((CommuteLeg)entity); });

            return returnEntities;
        }

        // GET: api/CommuteLegs/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IEntity>> GetCommuteLeg(int id)
        {
            var entity = await _data.Get(id);

            if (entity == null)
            {
                return NotFound();
            }

            return (CommuteLeg)entity;
        }

        // GET: api/GetTotalDelay
        [HttpGet]
        [Route("[action]/{id}")]
        public async Task<ActionResult<int>> GetTotalDelay(int id)
        {
            return await ((CommuteLegData)_data).GetTotalDelay(id);
        }

        // PUT: api/CommuteLegs/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCommuteLeg(int id, CommuteLeg entity)
        {
            if (id != entity.Id)
            {
                return BadRequest("Commute leg id does not match commute leg to be updated.");
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

        // POST: api/CommuteLegs
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<IEntity>> PostCommuteLeg(CommuteLeg entity)
        {
            var newEntity = await _data.Add(entity);

            return CreatedAtAction("GetCommuteLeg", new { id = newEntity.Id }, newEntity);
        }

        // DELETE: api/CommuteLegs/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IEntity>> DeleteCommuteLeg(int id)
        {
            return NotFound();

            // Deleting will be implemented later.
            var entity = await _data.Get(id);
            if (entity == null)
            {
                return NotFound();
            }

            await _data.Delete(entity.Id);

            return (CommuteLeg)entity;
        }
    }
}