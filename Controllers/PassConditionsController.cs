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
    public class PassConditionsController : ControllerBase
    {
        private readonly GeneralContext _context;

        public PassConditionsController(GeneralContext context)
        {
            _context = context;
        }

        // GET: api/PassConditions
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PassCondition>>> GetPassCondition()
        {
            return await _context.PassConditions.ToListAsync();
        }

        // GET: api/PassConditions/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PassCondition>> GetPassCondition(int id)
        {
            var passCondition = await _context.PassConditions.FindAsync(id);

            if (passCondition == null)
            {
                return NotFound();
            }

            return passCondition;
        }

        // PUT: api/PassConditions/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPassCondition(int id, PassCondition passCondition)
        {
            if (id != passCondition.Id)
            {
                return BadRequest();
            }

            _context.Entry(passCondition).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PassConditionExists(id))
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

        // POST: api/PassConditions
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<PassCondition>> PostPassCondition(PassCondition passCondition)
        {
            _context.PassConditions.Add(passCondition);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPassCondition", new { id = passCondition.Id }, passCondition);
        }

        // DELETE: api/PassConditions/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<PassCondition>> DeletePassCondition(int id)
        {
            return NotFound();
            var passCondition = await _context.PassConditions.FindAsync(id);
            if (passCondition == null)
            {
                return NotFound();
            }

            _context.PassConditions.Remove(passCondition);
            await _context.SaveChangesAsync();

            return passCondition;
        }

        private bool PassConditionExists(int id)
        {
            return _context.PassConditions.Any(e => e.Id == id);
        }
    }
}
