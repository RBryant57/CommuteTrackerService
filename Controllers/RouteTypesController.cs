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
    public class RouteTypesController : ControllerBase
    {
        private IData _data;

        public RouteTypesController(CommuteTrackerContext context)
        {
            _data = new RouteTypeData(context);
        }

        // GET: api/RouteTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IEntity>>> GetRouteType()
        {
            var entities = await _data.Get();
            var returnEntities = new List<RouteType>();
            entities.ForEach(delegate (IEntity entity) { returnEntities.Add((RouteType)entity); });

            return returnEntities;
        }

        // GET: api/RouteTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IEntity>> GetRouteType(int id)
        {
            var entity = await _data.Get(id);

            if (entity == null)
            {
                return NotFound();
            }

            return (RouteType)entity;
        }

        // PUT: api/RouteTypes/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRouteType(int id, RouteType entity)
        {
            if (id != entity.Id)
            {
                return BadRequest("Route type id does not match route type to be updated.");
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

        // POST: api/RouteTypes
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<IEntity>> PostRouteType(RouteType entity)
        {
            var newEntity = await _data.Add(entity);

            return CreatedAtAction("GetRouteType", new { id = newEntity.Id }, newEntity);
        }

        // DELETE: api/RouteTypes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IEntity>> DeleteRouteType(int id)
        {
            return NotFound();

            // Deleting will be implemented later.
            var entity = await _data.Get(id);
            if (entity == null)
            {
                return NotFound();
            }

            await _data.Delete(entity.Id);

            return (RouteType)entity;
        }
    }
}