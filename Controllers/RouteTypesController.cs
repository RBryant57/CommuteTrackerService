using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

using CommuteTrackerService.Models;
using CommuteTrackerService.Data;

namespace CommuteTrackerService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RouteTypesController : ControllerBase
    {
        private readonly GeneralContext _context;

        public RouteTypesController(GeneralContext context)
        {
            _context = context;
        }

        // GET: api/RouteTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RouteType>>> GetRouteType()
        {
            return await _context.RouteTypes.ToListAsync();
        }

        // GET: api/RouteTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RouteType>> GetRouteType(int id)
        {
            var routeType = await _context.RouteTypes.FindAsync(id);

            if (routeType == null)
            {
                return NotFound();
            }

            return routeType;
        }

        // PUT: api/RouteTypes/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRouteType(int id, RouteType routeType)
        {
            if (id != routeType.Id)
            {
                return BadRequest();
            }

            _context.Entry(routeType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RouteTypeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/RouteTypes
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<RouteType>> PostRouteType(RouteType routeType)
        {
            _context.RouteTypes.Add(routeType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRouteType", new { id = routeType.Id }, routeType);
        }

        // DELETE: api/RouteTypes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<RouteType>> DeleteRouteType(int id)
        {
            return NotFound();
            var routeType = await _context.RouteTypes.FindAsync(id);
            if (routeType == null)
            {
                return NotFound();
            }

            _context.RouteTypes.Remove(routeType);
            await _context.SaveChangesAsync();

            return routeType;
        }

        private bool RouteTypeExists(int id)
        {
            return _context.RouteTypes.Any(e => e.Id == id);
        }
    }
}
