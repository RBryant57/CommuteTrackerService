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
    public class FareClassesController : ControllerBase
    {
        private readonly CommuteTrackerContext _context;

        public FareClassesController(CommuteTrackerContext context)
        {
            _context = context;
        }

        // GET: api/FareClasses
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FareClass>>> GetFareClass()
        {
            return await _context.FareClass.ToListAsync();
        }

        // GET: api/FareClasses/5
        [HttpGet("{id}")]
        public async Task<ActionResult<FareClass>> GetFareClass(int id)
        {
            var fareClass = await _context.FareClass.FindAsync(id);

            if (fareClass == null)
            {
                return NotFound();
            }

            return fareClass;
        }

        // PUT: api/FareClasses/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFareClass(int id, FareClass fareClass)
        {
            if (id != fareClass.Id)
            {
                return BadRequest();
            }

            _context.Entry(fareClass).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FareClassExists(id))
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

        // POST: api/FareClasses
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<FareClass>> PostFareClass(FareClass fareClass)
        {
            _context.FareClass.Add(fareClass);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetFareClass", new { id = fareClass.Id }, fareClass);
        }

        // DELETE: api/FareClasses/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<FareClass>> DeleteFareClass(int id)
        {
            var fareClass = await _context.FareClass.FindAsync(id);
            if (fareClass == null)
            {
                return NotFound();
            }

            _context.FareClass.Remove(fareClass);
            await _context.SaveChangesAsync();

            return fareClass;
        }

        private bool FareClassExists(int id)
        {
            return _context.FareClass.Any(e => e.Id == id);
        }
    }
}
