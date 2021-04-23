using EntityLayer.Contexts;
using EntityLayer.Interfaces;
using EntityLayer.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;

namespace CommuteTrackerServiceTests
{
    public abstract class AbstractControllerTest
    {
        protected readonly CommuteTrackerContext context;
        public AbstractControllerTest()
        {
            // var options = new DbContextOptionsBuilder<CommuteTrackerContext>()
            //     .UseInMemoryDatabase("CommuteTrackerContext", new InMemoryDatabaseRoot())
            //     .Options;

            //context = new CommuteTrackerContext(options);
        }
    }
}
