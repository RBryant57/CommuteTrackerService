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
    public class DelayReasonsController : ControllerBase
    {
        private readonly CommuteTrackerContext _context;

        public DelayReasonsController(CommuteTrackerContext context)
        {
            _context = context;
        }

        // GET: api/DelayReasons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DelayReason>>> GetDelayReason()
        {
            return await _context.DelayReason.ToListAsync();
        }

        // GET: api/DelayReasons/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DelayReason>> GetDelayReason(int id)
        {
            var delayReason = await _context.DelayReason.FindAsync(id);

            if (delayReason == null)
            {
                return NotFound();
            }

            return delayReason;
        }

        // PUT: api/DelayReasons/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDelayReason(int id, DelayReason delayReason)
        {
            if (id != delayReason.Id)
            {
                return BadRequest();
            }

            _context.Entry(delayReason).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DelayReasonExists(id))
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

        // POST: api/DelayReasons
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<DelayReason>> PostDelayReason(DelayReason delayReason)
        {
            _context.DelayReason.Add(delayReason);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDelayReason", new { id = delayReason.Id }, delayReason);
        }

        // DELETE: api/DelayReasons/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<DelayReason>> DeleteDelayReason(int id)
        {
            return NotFound();
            var delayReason = await _context.DelayReason.FindAsync(id);
            if (delayReason == null)
            {
                return NotFound();
            }

            _context.DelayReason.Remove(delayReason);
            await _context.SaveChangesAsync();

            return delayReason;
        }

        private bool DelayReasonExists(int id)
        {
            return _context.DelayReason.Any(e => e.Id == id);
        }
    }
}
