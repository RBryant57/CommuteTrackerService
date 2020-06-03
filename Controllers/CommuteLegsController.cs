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
    public class CommuteLegsController : ControllerBase
    {
        private readonly CommuteTrackerContext _context;

        public CommuteLegsController(CommuteTrackerContext context)
        {
            _context = context;
        }

        // GET: api/CommuteLegs
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CommuteLeg>>> GetCommuteLeg()
        {
            return await _context.CommuteLeg.ToListAsync();
        }

        // GET: api/CommuteLegs/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CommuteLeg>> GetCommuteLeg(int id)
        {
            var commuteLeg = await _context.CommuteLeg.FindAsync(id);

            if (commuteLeg == null)
            {
                return NotFound();
            }

            return commuteLeg;
        }

        // PUT: api/CommuteLegs/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCommuteLeg(int id, CommuteLeg commuteLeg)
        {
            if (id != commuteLeg.Id)
            {
                return BadRequest();
            }

            _context.Entry(commuteLeg).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CommuteLegExists(id))
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

        // POST: api/CommuteLegs
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<CommuteLeg>> PostCommuteLeg(CommuteLeg commuteLeg)
        {
            _context.CommuteLeg.Add(commuteLeg);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCommuteLeg", new { id = commuteLeg.Id }, commuteLeg);
        }

        // DELETE: api/CommuteLegs/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<CommuteLeg>> DeleteCommuteLeg(int id)
        {
            var commuteLeg = await _context.CommuteLeg.FindAsync(id);
            if (commuteLeg == null)
            {
                return NotFound();
            }

            _context.CommuteLeg.Remove(commuteLeg);
            await _context.SaveChangesAsync();

            return commuteLeg;
        }

        private bool CommuteLegExists(int id)
        {
            return _context.CommuteLeg.Any(e => e.Id == id);
        }
    }
}
