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
    public class RoutesController : ControllerBase
    {
        private IData _data;

        public RoutesController(CommuteTrackerContext context)
        {
            _data = new RouteData(context);
        }

        // GET: api/Routes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetRoute()
        {
            var entities = await _data.Get();
            var returnEntities = new List<Route>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((Route)entity); });

            return returnEntities;
        }

        // GET: api/Routes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IEntity>> GetRoute(int id)
        {
            var entity = await _data.Get(id);

            if (entity == null)
            {
                return NotFound();
            }

            return (Route)entity;
        }

        // PUT: api/Routes/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRoute(int id, Route entity)
        {
            if (id != entity.Id)
            {
                return BadRequest("Route id does not match route to be updated.");
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

        // POST: api/Routes
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<IEntity>> PostRoute(Route entity)
        {
            var newEntity = await _data.Add(entity);

            return CreatedAtAction("GetRoute", new { id = newEntity.Id }, newEntity);
        }

        // DELETE: api/Routes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IEntity>> DeleteRoute(int id)
        {
            return NotFound();

            // Deleting will be implemented later.
            var entity = await _data.Get(id);
            if (entity == null)
            {
                return NotFound();
            }

            await _data.Delete(entity.Id);

            return (Route)entity;
        }
    }
}