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
    public class CommutesController : ControllerBase
    {
        private readonly GeneralContext _context;

        public CommutesController(GeneralContext context)
        {
            _context = context;
        }

        // GET: api/Commutes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Commute>>> GetCommute()
        {
            return await _context.Commutes.Include(c => c.CommuteLegs).ToListAsync();
        }

        // GET: api/Commutes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Commute>> GetCommute(int id)
        {
            var commute = await _context.Commutes.Include(c => c.CommuteLegs).Where(c => c.Id == id).FirstAsync();

            if (commute == null)
            {
                return NotFound();
            }

            return commute;
        }

        // PUT: api/Commutes/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCommute(int id, Commute commute)
        {
            if (id != commute.Id)
            {
                return BadRequest();
            }

            _context.Entry(commute).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CommuteExists(id))
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

        // POST: api/Commutes
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<Commute>> PostCommute(Commute commute)
        {
            _context.Commutes.Add(commute);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCommute", new { id = commute.Id }, commute);
        }

        // DELETE: api/Commutes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Commute>> DeleteCommute(int id)
        {
            return NotFound();
            var commute = await _context.Commutes.FindAsync(id);
            if (commute == null)
            {
                return NotFound();
            }

            _context.Commutes.Remove(commute);
            await _context.SaveChangesAsync();

            return commute;
        }

        private bool CommuteExists(int id)
        {
            return _context.Commutes.Any(e => e.Id == id);
        }
    }
}
