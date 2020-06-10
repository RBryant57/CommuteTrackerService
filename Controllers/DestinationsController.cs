using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using CommuteTrackerService.Models;

namespace CommuteTrackerService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DestinationsController : ControllerBase
    {
        private readonly CommuteTrackerContext _context;

        public DestinationsController(CommuteTrackerContext context)
        {
            _context = context;
        }

        // GET: api/Destinations
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Destination>>> GetDestination()
        {
            return await _context.Destination.ToListAsync();
        }

        // GET: api/Destinations/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Destination>> GetDestination(int id)
        {
            var destination = await _context.Destination.FindAsync(id);

            if (destination == null)
            {
                return NotFound();
            }

            return destination;
        }

        // PUT: api/Destinations/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDestination(int id, Destination destination)
        {
            if (id != destination.Id)
            {
                return BadRequest();
            }

            _context.Entry(destination).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DestinationExists(id))
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

        // POST: api/Destinations
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<Destination>> PostDestination(Destination destination)
        {
            _context.Destination.Add(destination);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDestination", new { id = destination.Id }, destination);
        }

        // DELETE: api/Destinations/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Destination>> DeleteDestination(int id)
        {
            return NotFound();
            var destination = await _context.Destination.FindAsync(id);
            if (destination == null)
            {
                return NotFound();
            }

            _context.Destination.Remove(destination);
            await _context.SaveChangesAsync();

            return destination;
        }

        private bool DestinationExists(int id)
        {
            return _context.Destination.Any(e => e.Id == id);
        }
    }
}
