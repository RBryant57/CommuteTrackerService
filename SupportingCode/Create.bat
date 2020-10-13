dotnet new webapi -o CommuteTracker
dotnet add package Microsoft.EntityFrameworkCore.SqlServer

dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet tool install --global dotnet-aspnet-codegenerator

dotnet ef dbcontext scaffold "Server=.\Development;Database=CommuteTracker;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer -o Models
dotnet aspnet-codegenerator controller -name CommutesController -async -api -m Commute -dc CommuteTrackerContext -outDir Controllers
dotnet aspnet-codegenerator controller -name CommuteLegsController -async -api -m CommuteLeg -dc CommuteTrackerContext -outDir Controllers
dotnet aspnet-codegenerator controller -name DelayReasonsController -async -api -m DelayReason -dc CommuteTrackerContext -outDir Controllers
dotnet aspnet-codegenerator controller -name DestinationsController -async -api -m Destination -dc CommuteTrackerContext -outDir Controllers
dotnet aspnet-codegenerator controller -name FareClassesController -async -api -m FareClass -dc CommuteTrackerContext -outDir Controllers
dotnet aspnet-codegenerator controller -name PassConditionsController -async -api -m PassCondition -dc CommuteTrackerContext -outDir Controllers
dotnet aspnet-codegenerator controller -name RoutesController -async -api -m Route -dc CommuteTrackerContext -outDir Controllers
dotnet aspnet-codegenerator controller -name RouteTypesController -async -api -m RouteType -dc CommuteTrackerContext -outDir Controllers

dotnet publish -o D:\Webs\YCDServices\CommuteTrackerService