using EntityLayer.Models;
using CommuteTrackerService.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;

namespace CommuteTrackerServiceTests
{
    public class RouteTypesControllerTests : AbstractControllerTest
    {
        [Fact]
        public void GetRouteTypes_Succeeds()
        {
            // Arrange
            var controller = new RouteTypesController(context);

            // Act
            var response = controller.GetRouteType();
            var value = response.Result.Value;

            // Assert
            //Assert.IsType<List<RouteType>>(value);
        }
    }
}
