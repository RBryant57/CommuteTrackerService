USE [General]
/****** Object:  UserDefinedFunction [dbo].[GetSecondsPastMidnight]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSecondsPastMidnight]
(
	-- Add the parameters for the function here
	@Date		datetime
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE		@Secs	int

	-- Add the T-SQL statements to compute the return value here
	SET @Secs = (DATEPART("hh", @Date) * 3600) + (DATEPART("mi", @Date) * 60) + (DATEPART("s", @Date))

	-- Return the result of the function
	RETURN @Secs

END
GO
/****** Object:  Table [dbo].[Commute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Commute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Destination] [int] NOT NULL,
	[DelaySeconds] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_Commute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommuteLeg]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommuteLeg](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Destination] [int] NOT NULL,
	[Delay] [int] NOT NULL,
	[DelaySeconds] [int] NOT NULL,
	[FareClass] [int] NOT NULL,
	[Route] [int] NOT NULL,
	[Commute] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_CommuteLeg] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommuteMultiRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommuteMultiRoute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Destination] [int] NOT NULL,
	[Delay] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_CommuteMulitRoute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommutesRoutes]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommutesRoutes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CommuteId] [int] NOT NULL,
	[RouteId] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_CommutesRoutes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DelayReason]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DelayReason](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_DelayReason] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__DelayReason_Description] UNIQUE NONCLUSTERED 
(
	[Description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Destination]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destination](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_DestinationType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Destination_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FareClass]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FareClass](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_FareClass] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__FareClass_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PassCondition]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PassCondition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Minutes] [int] NOT NULL,
	[UsualMinutes] [int] NOT NULL,
	[RouteId] [int] NOT NULL,
	[DelayReasonId] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_PassConditions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Route]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Route](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Type] [int] NOT NULL,
	[Number] [nvarchar](5) NOT NULL,
	[Miles] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_Route] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Route_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RouteType]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RouteType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_RouteType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__RouteType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[AverageCommute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AverageCommute]
AS
SELECT     dbo.Route.Name AS Route, dbo.Route.Miles AS Length, dbo.RouteType.Name AS [Route Type], AVG(ABS(DATEDIFF(second, dbo.Commute.EndTime, 
                      dbo.Commute.StartTime))) AS [Average Seconds]
FROM         dbo.Commute INNER JOIN
                      dbo.CommutesRoutes ON dbo.Commute.Id = dbo.CommutesRoutes.CommuteId INNER JOIN
                      dbo.Route ON dbo.CommutesRoutes.RouteId = dbo.Route.Id INNER JOIN
                      dbo.RouteType ON dbo.Route.Type = dbo.RouteType.Id
GROUP BY dbo.Route.Id, dbo.Route.Name, dbo.RouteType.Name, dbo.Route.Miles
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unique_Name]    Script Date: 9/11/2024 8:20:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Unique_Name] ON [dbo].[Route]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CommuteLeg] ADD  CONSTRAINT [DF_CommuteLeg_DelaySecondsTest]  DEFAULT ((0)) FOR [DelaySeconds]
GO
ALTER TABLE [dbo].[Commute]  WITH CHECK ADD  CONSTRAINT [FK_Commute_Destination] FOREIGN KEY([Destination])
REFERENCES [dbo].[Destination] ([Id])
GO
ALTER TABLE [dbo].[Commute] CHECK CONSTRAINT [FK_Commute_Destination]
GO
ALTER TABLE [dbo].[CommuteLeg]  WITH CHECK ADD  CONSTRAINT [FK_CommuteLeg_Commute] FOREIGN KEY([Commute])
REFERENCES [dbo].[Commute] ([Id])
GO
ALTER TABLE [dbo].[CommuteLeg] CHECK CONSTRAINT [FK_CommuteLeg_Commute]
GO
ALTER TABLE [dbo].[CommuteLeg]  WITH CHECK ADD  CONSTRAINT [FK_CommuteLeg_Delay] FOREIGN KEY([Delay])
REFERENCES [dbo].[DelayReason] ([Id])
GO
ALTER TABLE [dbo].[CommuteLeg] CHECK CONSTRAINT [FK_CommuteLeg_Delay]
GO
ALTER TABLE [dbo].[CommuteLeg]  WITH CHECK ADD  CONSTRAINT [FK_CommuteLeg_Destination] FOREIGN KEY([Destination])
REFERENCES [dbo].[Destination] ([Id])
GO
ALTER TABLE [dbo].[CommuteLeg] CHECK CONSTRAINT [FK_CommuteLeg_Destination]
GO
ALTER TABLE [dbo].[CommuteLeg]  WITH CHECK ADD  CONSTRAINT [FK_CommuteLeg_FareClass] FOREIGN KEY([FareClass])
REFERENCES [dbo].[FareClass] ([Id])
GO
ALTER TABLE [dbo].[CommuteLeg] CHECK CONSTRAINT [FK_CommuteLeg_FareClass]
GO
ALTER TABLE [dbo].[CommuteLeg]  WITH CHECK ADD  CONSTRAINT [FK_CommuteLeg_Route] FOREIGN KEY([Route])
REFERENCES [dbo].[Route] ([Id])
GO
ALTER TABLE [dbo].[CommuteLeg] CHECK CONSTRAINT [FK_CommuteLeg_Route]
GO
ALTER TABLE [dbo].[CommuteMultiRoute]  WITH CHECK ADD  CONSTRAINT [FK_CommuteMultiRoute_DelayReason] FOREIGN KEY([Delay])
REFERENCES [dbo].[DelayReason] ([Id])
GO
ALTER TABLE [dbo].[CommuteMultiRoute] CHECK CONSTRAINT [FK_CommuteMultiRoute_DelayReason]
GO
ALTER TABLE [dbo].[CommuteMultiRoute]  WITH CHECK ADD  CONSTRAINT [FK_CommuteMultiRoute_DestinationType] FOREIGN KEY([Destination])
REFERENCES [dbo].[Destination] ([Id])
GO
ALTER TABLE [dbo].[CommuteMultiRoute] CHECK CONSTRAINT [FK_CommuteMultiRoute_DestinationType]
GO
ALTER TABLE [dbo].[CommutesRoutes]  WITH CHECK ADD  CONSTRAINT [FK_CommutesRoutes_Commute] FOREIGN KEY([CommuteId])
REFERENCES [dbo].[CommuteMultiRoute] ([Id])
GO
ALTER TABLE [dbo].[CommutesRoutes] CHECK CONSTRAINT [FK_CommutesRoutes_Commute]
GO
ALTER TABLE [dbo].[CommutesRoutes]  WITH CHECK ADD  CONSTRAINT [FK_CommutesRoutes_Route] FOREIGN KEY([RouteId])
REFERENCES [dbo].[Route] ([Id])
GO
ALTER TABLE [dbo].[CommutesRoutes] CHECK CONSTRAINT [FK_CommutesRoutes_Route]
GO
ALTER TABLE [dbo].[PassCondition]  WITH CHECK ADD  CONSTRAINT [FK_PassConditions_DelayReason] FOREIGN KEY([DelayReasonId])
REFERENCES [dbo].[DelayReason] ([Id])
GO
ALTER TABLE [dbo].[PassCondition] CHECK CONSTRAINT [FK_PassConditions_DelayReason]
GO
ALTER TABLE [dbo].[PassCondition]  WITH CHECK ADD  CONSTRAINT [FK_PassConditions_Route] FOREIGN KEY([RouteId])
REFERENCES [dbo].[Route] ([Id])
GO
ALTER TABLE [dbo].[PassCondition] CHECK CONSTRAINT [FK_PassConditions_Route]
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD  CONSTRAINT [FK_Route_RouteType] FOREIGN KEY([Type])
REFERENCES [dbo].[RouteType] ([Id])
GO
ALTER TABLE [dbo].[Route] CHECK CONSTRAINT [FK_Route_RouteType]
GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommuteByRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/13/08
-- Description:	Gets the average commute time by route.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommuteByRoute]
 
	@RouteId				int
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT AVG(ABS(DATEDIFF(second, EndTime, StartTime))), COUNT(*) FROM Commute INNER JOIN
		CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
        [Route] ON CommutesRoutes.RouteId = Route.Id
			WHERE Route.Id = @RouteID



END


GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutes]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/13/09
-- Description:	Gets the average commute time 
--				grouped by route.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutes]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id, Route.Name, Route.Miles, RouteType.Name, 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0), COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id
	GROUP BY Route.Id, Route.Name, RouteType.Name, Route.Miles



END




GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDay]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/13/08
-- Description:	Gets the average commute time 
--				grouped by route and day.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDay]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id, Route.Name, DATEPART(weekday, Commute.StartTime), Route.Miles, RouteType.Name, 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0), COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id
	GROUP BY Route.Id, DATEPART(weekday, Commute.StartTime), Route.Name, RouteType.Name, Route.Miles



END






GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDayByDestination]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route, day and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDayByDestination]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id, Route.Name, DATEPART(weekday, Commute.StartTime), Destination.Name, Route.Miles, RouteType.Name, 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0), COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id INNER JOIN
			 Destination ON Commute.Destination = Destination.Id
	GROUP BY Route.Id, DATEPART(weekday, Commute.StartTime), Destination.Name, Route.Name, RouteType.Name, Route.Miles



END







GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDayByDestinationByRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				by route grouped by day and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDayByDestinationByRoute]
	
	@RouteId				int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DATEPART(weekday, Commute.StartTime), Destination.Name,
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0),
			Route.Miles, COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id INNER JOIN
			 Destination ON Commute.Destination = Destination.Id
		WHERE Route.Id = @RouteId
	GROUP BY DATEPART(weekday, Commute.StartTime), Destination.Name, Route.Miles



END







GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDayByDestinationForRouteXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route, day and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDayByDestinationForRouteXML]
	
	@RouteId				int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
	(
		SELECT Destination.Name AS '@Name', 
		(
			SELECT DATEPART(weekday, Commute.StartTime) AS '@WeekDay', 
				COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
				COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
				COALESCE(COUNT(*), 0) AS 'Commutes'
			FROM Commute INNER JOIN
				CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
				[Route] AS DayRoute ON CommuteLeg.Route = DayRoute.Id INNER JOIN
				Destination AS DayDestination ON Commute.Destination = DayDestination.Id
			WHERE DayDestination.Name = Destination.Name AND DayRoute.Id = Route.Id

			GROUP BY DATEPART(weekday, Commute.StartTime)

			FOR XML PATH('Day'), type
		)
		FROM Commute INNER JOIN
			CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
			[Route] AS DestinationRoute ON CommuteLeg.Route = DestinationRoute.Id INNER JOIN
			Destination ON Commute.Destination = Destination.Id
		WHERE DestinationRoute.Id = Route.Id

		GROUP BY Destination.Name
		
		FOR XML PATH('Destination'), type
	)
		FROM [Route] INNER JOIN
			RouteType ON Route.Type = RouteType.Id
		WHERE Route.Id = @RouteId

		FOR XML PATH('Route')



END















GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDayByDestinationXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route, day and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDayByDestinationXML]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
	(
		SELECT Destination.Name AS '@Name', 
		(
			SELECT DATEPART(weekday, Commute.StartTime) AS '@WeekDay', 
				COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
				COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
				COALESCE(COUNT(*), 0) AS 'Commutes'
			FROM Commute INNER JOIN
				CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
				[Route] AS DayRoute ON CommutesRoutes.RouteId = DayRoute.Id INNER JOIN
				Destination AS DayDestination ON Commute.Destination = DayDestination.Id
			WHERE DayDestination.Name = Destination.Name AND DayRoute.Id = Route.Id

			GROUP BY DATEPART(weekday, Commute.StartTime)

			FOR XML PATH('Day'), type
		)
		FROM Commute INNER JOIN
			CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
			[Route] AS DestinationRoute ON CommutesRoutes.RouteId = DestinationRoute.Id INNER JOIN
			Destination ON Commute.Destination = Destination.Id
		WHERE DestinationRoute.Id = Route.Id

		GROUP BY Destination.Name
				
		FOR XML PATH('Destination'), type
	)
		FROM [Route] INNER JOIN
			RouteType ON Route.Type = RouteType.Id

		FOR XML PATH('Route'), ROOT('Routes')



END












GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDayByRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/13/08
-- Description:	Gets the average commute time 
--				by route grouped by day.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDayByRoute]
	
	@RouteId				int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DATEPART(weekday, Commute.StartTime), 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0),
			Route.Miles, COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id
		WHERE Route.Id = @RouteId
	GROUP BY DATEPART(weekday, Commute.StartTime), Route.Miles



END






GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDayForRouteXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/13/08
-- Description:	Gets the average commute time 
--				by route grouped by day.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDayForRouteXML]
	
	@RouteId				int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@Type', 
	(
		SELECT DATEPART(weekday, Commute.StartTime) AS '@WeekDay', 
				COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
				COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
				COALESCE(COUNT(*), 0) AS 'Commutes'
			FROM Commute INNER JOIN
				 CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
				[Route] ON CommuteLeg.Route = Route.Id
			WHERE Route.Id = @RouteId

		GROUP BY DATEPART(weekday, Commute.StartTime)
		
		FOR XML PATH('Day'), type
	)
		FROM [Route] INNER JOIN
			RouteType ON RouteType.Id = Route.Type
		WHERE Route.Id = @RouteId

	FOR XML PATH('Route')


END














GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDayXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/13/08
-- Description:	Gets the average commute time 
--				grouped by route and day.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDayXML]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
	(
		SELECT DATEPART(weekday, Commute.StartTime) AS '@WeekDay', 
				COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
				COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
				COALESCE(COUNT(*), 0) AS 'Commutes'
			FROM Commute INNER JOIN
				 CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
				 [Route] AS DayRoute ON CommutesRoutes.RouteId = DayRoute.Id 
			WHERE DayRoute.Id = Route.Id

		GROUP BY DATEPART(weekday, Commute.StartTime)
		
		FOR XML PATH('Day'), type
	)
		FROM [Route] INNER JOIN
			 RouteType ON Route.Type = RouteType.Id

	FOR XML PATH('Route'), ROOT('Routes')



END










GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDestination]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDestination]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id, Route.Name, Destination.Name, Route.Miles, RouteType.Name, 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0), COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id	INNER JOIN
			 Destination ON Commute.Destination = Destination.Id
	GROUP BY Route.Id, Destination.Name, Route.Name, RouteType.Name, Route.Miles



END








GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDestinationByRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				by route grouped by destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDestinationByRoute]
	
	@RouteId				int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Destination.Name, 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0),
			Route.Miles, COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id INNER JOIN
			 Destination ON Commute.Destination = Destination.Id
		WHERE Route.Id = @RouteId
	GROUP BY Destination.Name, Route.Miles



END







GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDestinationForRouteXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route, day and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDestinationForRouteXML]
	
	@RouteId				int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
	(
		SELECT Destination.Name AS '@Name', 
			COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
			COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
			COALESCE(COUNT(*), 0) AS 'Commutes'
		FROM Commute INNER JOIN
			CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
			[Route] AS DayRoute ON CommuteLeg.Route = DayRoute.Id INNER JOIN
			Destination ON Commute.Destination = Destination.Id
		WHERE DayRoute.Id = Route.Id

		GROUP BY Destination.Name
		
		FOR XML PATH('Destination'), type
	)
		FROM [Route] INNER JOIN
			RouteType ON Route.Type = RouteType.Id
		WHERE Route.Id = @RouteId

		FOR XML PATH('Route')



END















GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByDestinationXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route, day and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByDestinationXML]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
	(
		SELECT Destination.Name AS '@Name', 
			COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
			COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
			COALESCE(COUNT(*), 0) AS 'Commutes'
		FROM Commute INNER JOIN
			CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
			[Route] AS DayRoute ON CommuteLeg.Route = DayRoute.Id INNER JOIN
			Destination ON Commute.Destination = Destination.Id
		WHERE DayRoute.Id = Route.Id

		GROUP BY Destination.Name
		
		FOR XML PATH('Destination'), type
	)
		FROM [Route] INNER JOIN
			RouteType ON Route.Type = RouteType.Id

		FOR XML PATH('Route'), ROOT('Routes')



END













GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByMonth]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/14/09
-- Description:	Gets the average commute time 
--				grouped by route and month.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByMonth]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id, Route.Name, MONTH(Commute.StartTime), Route.Miles, RouteType.Name, 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0), COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id
	GROUP BY Route.Id, MONTH(Commute.StartTime), Route.Name, RouteType.Name, Route.Miles



END




GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByMonthByDestination]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route, month and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByMonthByDestination]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id, Route.Name, MONTH(Commute.StartTime), Destination.Name, Route.Miles, RouteType.Name, 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0), COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id INNER JOIN
			 Destination ON Commute.Destination = Destination.Id
	GROUP BY Route.Id, MONTH(Commute.StartTime), Destination.Name, Route.Name, RouteType.Name, Route.Miles



END





GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByMonthByDestinationByRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				by route grouped by month and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByMonthByDestinationByRoute]
	
	@RouteId				int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT MONTH(Commute.StartTime), Destination.Name,
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0), 
			Route.Miles, COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id INNER JOIN
			 Destination ON Commute.Destination = Destination.Id
	WHERE Route.Id = @RouteId
	GROUP BY MONTH(Commute.StartTime), Destination.Name, Route.Miles


END







GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByMonthByDestinationForRouteXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route, day and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByMonthByDestinationForRouteXML]
	
	@RouteId				int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
	(
		SELECT Destination.Name AS '@Name', 
		(
			SELECT DATEPART(month, Commute.StartTime) AS '@Month', 
				COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
				COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
				COALESCE(COUNT(*), 0) AS 'Commutes'
			FROM Commute INNER JOIN
				CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
				[Route] AS MonthRoute ON CommuteLeg.Route = MonthRoute.Id INNER JOIN
				Destination AS MonthDestination ON Commute.Destination = MonthDestination.Id
			WHERE MonthDestination.Name = Destination.Name AND MonthRoute.Id = Route.Id

			GROUP BY DATEPART(month, Commute.StartTime)

			FOR XML PATH('Month'), type
		)
		FROM Commute INNER JOIN
			CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
			[Route] AS DestinationRoute ON CommuteLeg.Route = DestinationRoute.Id INNER JOIN
			Destination ON Commute.Destination = Destination.Id
		WHERE DestinationRoute.Id = Route.Id

		GROUP BY Destination.Name
		
		FOR XML PATH('Destination'), type
	)
		FROM [Route] INNER JOIN
			RouteType ON Route.Type = RouteType.Id
		WHERE Route.Id = @RouteId

		FOR XML PATH('Route')



END















GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByMonthByDestinationXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/30/09
-- Description:	Gets the average commute time 
--				grouped by route, day and destination.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByMonthByDestinationXML]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
	(
		SELECT Destination.Name AS '@Name', 
		(
			SELECT DATEPART(month, Commute.StartTime) AS '@Month', 
				COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
				COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
				COALESCE(COUNT(*), 0) AS 'Commutes'
			FROM Commute INNER JOIN
				CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
				[Route] AS MonthRoute ON CommuteLeg.Route = MonthRoute.Id INNER JOIN
				Destination AS MonthDestination ON Commute.Destination = MonthDestination.Id
			WHERE MonthDestination.Name = Destination.Name AND MonthRoute.Id = Route.Id

			GROUP BY DATEPART(month, Commute.StartTime)

			FOR XML PATH('Month'), type
		)
		FROM Commute INNER JOIN
			CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
			[Route] AS DestinationRoute ON CommuteLeg.Route = DestinationRoute.Id INNER JOIN
			Destination ON Commute.Destination = Destination.Id
		WHERE DestinationRoute.Id = Route.Id

		GROUP BY Destination.Name
				
		FOR XML PATH('Destination'), type
	)
		FROM [Route] INNER JOIN
			RouteType ON Route.Type = RouteType.Id

		FOR XML PATH('Route'), ROOT('Routes')



END



GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByMonthByRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/14/09
-- Description:	Gets the average commute time 
--				by route grouped by month.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByMonthByRoute]
	
	@RouteId				int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT MONTH(Commute.StartTime), 
			AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0), 
			Route.Miles, COUNT(*)
		FROM Commute INNER JOIN
             CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
             [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id
	WHERE Route.Id = @RouteId
	GROUP BY MONTH(Commute.StartTime), Route.Miles


END






GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByMonthForRouteXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/13/08
-- Description:	Gets the average commute time 
--				by route grouped by month.
--				Returns XML.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByMonthForRouteXML]
	
	@RouteId				int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Name AS '@Name', Route.Id AS '@Id', Route.Miles AS '@RouteMiles', RouteType.Name AS '@Type', 
	(
		SELECT DATEPART(month, Commute.StartTime) AS '@Month', 
				COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
				COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
				COALESCE(COUNT(*), 0) AS 'Commutes'
			FROM Commute INNER JOIN
				 CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
				[Route] ON CommuteLeg.Route = Route.Id
			WHERE Route.Id = @RouteId
		GROUP BY DATEPART(month, Commute.StartTime)
		
		FOR XML PATH('Month'), type
	)
		FROM [Route] INNER JOIN
			RouteType ON RouteType.Id = Route.Type
		WHERE Route.Id = @RouteId

	FOR XML PATH('Route')


END

GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesByMonthXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/13/08
-- Description:	Gets the average commute time 
--				grouped by route and day.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesByMonthXML]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
	(
		SELECT DATEPART(month, Commute.StartTime) AS '@Month', 
			COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
			COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
			COALESCE(COUNT(*), 0) AS 'Commutes'
		FROM Commute INNER JOIN
			CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
			[Route] AS MonthRoute ON CommuteLeg.Route = MonthRoute.Id 
		WHERE MonthRoute.Id = Route.Id

		GROUP BY DATEPART(month, Commute.StartTime)
		
		FOR XML PATH('Month'), type
	)
		FROM [Route] INNER JOIN
			 RouteType ON Route.Type = RouteType.Id


	FOR XML PATH('Route'), ROOT('Routes')



END
GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesForRouteXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/13/09
-- Description:	Gets the average commute time 
--				grouped by route.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesForRouteXML]
	
	
	@RouteId			int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
			COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
			COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation', 
			COALESCE(COUNT(*), 0) AS 'Commutes'
		FROM Commute INNER JOIN
             CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
             [Route] ON CommuteLeg.Route = Route.Id INNER JOIN
             RouteType ON Route.Type = RouteType.Id
		WHERE Route.Id = @RouteId

	GROUP BY Route.Id, Route.Name, RouteType.Name, Route.Miles

	FOR XML PATH('Route')
END
GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesXML]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/13/09
-- Description:	Gets the average commute time 
--				grouped by route.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesXML]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
			COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
			COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'StandardDeviation', 
			COALESCE(COUNT(*), 0) AS 'Commutes',
	(
		SELECT Destination.Name AS '@Name', 
			COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
			COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
			COALESCE(AVG(dbo.GetSecondsPastMidnight(Commute.StartTime)), 0) AS 'AverageStartTime',
			COALESCE(AVG(dbo.GetSecondsPastMidnight(Commute.EndTime)), 0) AS 'AverageEndTime',
			COALESCE(COUNT(*), 0) AS 'Commutes'
		FROM Commute INNER JOIN
			CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
			[Route] AS DayRoute ON CommuteLeg.Route = DayRoute.Id INNER JOIN
			Destination ON Commute.Destination = Destination.Id
		WHERE DayRoute.Id = Route.Id

		GROUP BY Destination.Name
		
		FOR XML PATH('Destination'), type
	) AS 'Destinations'
		FROM Commute INNER JOIN
			CommuteLeg ON Commute.Id = CommuteLeg.Commute INNER JOIN
            [Route] ON CommuteLeg.Route = Route.Id INNER JOIN
            RouteType ON Route.Type = RouteType.Id

		GROUP BY Route.Id, Route.Name, RouteType.Name, Route.Miles

	FOR XML PATH('Route'), ROOT('Routes')

END






GO
/****** Object:  StoredProcedure [dbo].[GetAverageCommutesXMLTest]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 5/13/09
-- Description:	Gets the average commute time 
--				grouped by route.
-- =============================================
CREATE PROCEDURE [dbo].[GetAverageCommutesXMLTest]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Route.Id AS '@Id', Route.Name AS '@Name', Route.Miles AS '@RouteMiles', RouteType.Name AS '@RouteType', 
			COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
			COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'StandardDeviation', 
			COALESCE(COUNT(*), 0) AS 'Commutes',
	(
		SELECT Destination.Name AS '@Name', 
			COALESCE(AVG(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0) AS 'AverageSeconds', 
			COALESCE(STDEV(ABS(DATEDIFF(second, Commute.EndTime, Commute.StartTime))), 0.0) AS 'StandardDeviation',
			COALESCE(COUNT(*), 0) AS 'Commutes'
		FROM Commute INNER JOIN
			CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
			[Route] AS DayRoute ON CommutesRoutes.RouteId = DayRoute.Id INNER JOIN
			Destination ON Commute.Destination = Destination.Id
		WHERE DayRoute.Id = Route.Id

		GROUP BY Destination.Name
		
		FOR XML PATH('Destination'), type
	) AS 'Destinations'
		FROM Commute INNER JOIN
			CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
            [Route] ON CommutesRoutes.RouteId = Route.Id INNER JOIN
            RouteType ON Route.Type = RouteType.Id

		GROUP BY Route.Id, Route.Name, RouteType.Name, Route.Miles

	FOR XML PATH('Route'), ROOT('Routes')

END




GO
/****** Object:  StoredProcedure [dbo].[GetCommutesByCommuteId]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 10/29/11
-- Description:	Gets the commute legs for the given
--				commute Id.
-- =============================================
CREATE PROCEDURE [dbo].[GetCommutesByCommuteId]
 
	@CommuteId		int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT CommuteLeg.Id, CommuteLeg.StartTime, CommuteLeg.EndTime, Destination.Name, Route.Name, CommuteLeg.DelaySeconds, DelayReason.Description, 
           FareClass.Name AS FareClassName, CommuteLeg.Notes
	FROM CommuteLeg INNER JOIN
           DelayReason ON CommuteLeg.Delay = DelayReason.Id INNER JOIN
           Destination ON CommuteLeg.Destination = Destination.Id INNER JOIN
           FareClass ON CommuteLeg.FareClass = FareClass.Id INNER JOIN
           [Route] ON CommuteLeg.Route = Route.Id INNER JOIN
           RouteType ON Route.Type = RouteType.Id
    WHERE CommuteLeg.Commute = @CommuteId



END






GO
/****** Object:  StoredProcedure [dbo].[GetEmptyFareClass]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 10/22/11
-- Description:	Gets the not applicable Id.
-- =============================================
CREATE PROCEDURE [dbo].[GetEmptyFareClass]
 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Id FROM FareClass
		WHERE [Name] LIKE 'NA'



END


GO
/****** Object:  StoredProcedure [dbo].[GetNoDelay]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/08/08
-- Description:	Gets the no delay Id.
-- =============================================
CREATE PROCEDURE [dbo].[GetNoDelay]
 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Id FROM DelayReason
		WHERE [Description] LIKE 'None'



END
GO
/****** Object:  StoredProcedure [dbo].[GetPassConditionByDateByRouteId]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 1/24/15
-- Description:	Gets the pass condition for the given
--				date and Route id.
-- =============================================
CREATE PROCEDURE [dbo].[GetPassConditionByDateByRouteId]
 
	@Date				datetime,
	@RouteId			int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT PassCondition.Id, PassCondition.Date, PassCondition.Minutes, PassCondition.UsualMinutes, Route.Name, DelayReason.Description, 
           PassCondition.Notes
	FROM PassCondition INNER JOIN
           DelayReason ON PassCondition.DelayReasonId = DelayReason.Id INNER JOIN
           [Route] ON PassCondition.RouteId = Route.Id INNER JOIN
           RouteType ON Route.Type = RouteType.Id
    WHERE PassCondition.RouteId = @RouteId AND PassCondition.Date = @Date



END









GO
/****** Object:  StoredProcedure [dbo].[GetPassConditionByPassConditionId]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 1/17/15
-- Description:	Gets the pass condition for the given
--				pass condition Id.
-- =============================================
CREATE PROCEDURE [dbo].[GetPassConditionByPassConditionId]
 
	@PassConditionId		int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT PassCondition.Id, PassCondition.Date, PassCondition.Minutes, PassCondition.UsualMinutes, Route.Name, DelayReason.Description, 
           PassCondition.Notes
	FROM PassCondition INNER JOIN
           DelayReason ON PassCondition.DelayReasonId = DelayReason.Id INNER JOIN
           [Route] ON PassCondition.RouteId = Route.Id INNER JOIN
           RouteType ON Route.Type = RouteType.Id
    WHERE PassCondition.Id = @PassConditionId



END









GO
/****** Object:  StoredProcedure [dbo].[GetSDCommuteByRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/13/08
-- Description:	Gets the standard deviation of commute time by route.
-- =============================================
CREATE PROCEDURE [dbo].[GetSDCommuteByRoute]
 
	@RouteId				int
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT STDEV(ABS(DATEDIFF(second, EndTime, StartTime))) FROM Commute INNER JOIN
		CommutesRoutes ON Commute.Id = CommutesRoutes.CommuteId INNER JOIN
        [Route] ON CommutesRoutes.RouteId = Route.Id
			WHERE Route.Id = @RouteID



END
GO
/****** Object:  StoredProcedure [dbo].[InsertCommute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 10/29/11
-- Description:	Inserts commute data.
-- =============================================
CREATE PROCEDURE [dbo].[InsertCommute]
 
	@StartTime			datetime,
	@EndTime			datetime,
	@Destination		int,
	@DelaySeconds		int,
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO Commute
		VALUES(@StartTime, @EndTime, @Destination, @DelaySeconds, @Notes)


SELECT @@IDENTITY

END





GO
/****** Object:  StoredProcedure [dbo].[InsertCommuteData]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/07/08
-- Description:	Inserts commute data.
-- =============================================
CREATE PROCEDURE [dbo].[InsertCommuteData]
 
	@StartTime			datetime,
	@EndTime			datetime,
	@Destination		int,
	@Delay				int,
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO Commute
		VALUES(@StartTime, @EndTime, @Destination, @Delay, @Notes)


SELECT @@IDENTITY

END
GO
/****** Object:  StoredProcedure [dbo].[InsertCommuteLeg]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 10/29/11
-- Description:	Inserts commute leg data.
-- =============================================
CREATE PROCEDURE [dbo].[InsertCommuteLeg]
 
	@StartTime			datetime,
	@EndTime			datetime,
	@Destination		int,
	@Delay				int,
	@DelaySeconds		int,
	@FareClass			int,
	@Route				int,
	@Commute			int,
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO CommuteLeg
		VALUES(@StartTime, @EndTime, @Destination, @Delay, @DelaySeconds, @FareClass, @Route, @Commute, @Notes)


SELECT @@IDENTITY

END





GO
/****** Object:  StoredProcedure [dbo].[InsertCommutesRoutes]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/07/08
-- Description:	Inserts commute route data.
-- =============================================
CREATE PROCEDURE [dbo].[InsertCommutesRoutes]
 
	@CommuteId			int,
	@RouteId			int,
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO CommutesRoutes
		VALUES(@CommuteId, @RouteId, @Notes)

END
GO
/****** Object:  StoredProcedure [dbo].[InsertDelayReason]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/21/08
-- Description:	Inserts a delay reason.
-- =============================================
CREATE PROCEDURE [dbo].[InsertDelayReason]
 
	@Description				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO DelayReason
		VALUES(@Description)


SELECT @@IDENTITY

END

GO
/****** Object:  StoredProcedure [dbo].[InsertDestination]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 12/12/08
-- Description:	Inserts a destination.
-- =============================================
CREATE PROCEDURE [dbo].[InsertDestination]
 
	@Name				nvarchar(50),
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO Destination
		VALUES(@Name, @Notes)


SELECT @@IDENTITY

END

GO
/****** Object:  StoredProcedure [dbo].[InsertFareClass]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 10/21/11
-- Description:	Inserts a fare class.
-- =============================================
CREATE PROCEDURE [dbo].[InsertFareClass]
 
	@Name				nvarchar(50),
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO FareClass
		VALUES(@Name, @Notes)


SELECT @@IDENTITY

END



GO
/****** Object:  StoredProcedure [dbo].[InsertPassCondition]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 12/20/14
-- Description:	Inserts pass condition data.
-- =============================================
CREATE PROCEDURE [dbo].[InsertPassCondition]
 
	@Date				datetime,
	@Minutes			int,
	@UsualMinutes		int,
	@RouteId			int,
	@DelayReasonId		int,
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO PassCondition
		VALUES(@Date, @Minutes, @UsualMinutes, @RouteId, @DelayReasonId, @Notes)


SELECT @@IDENTITY

END







GO
/****** Object:  StoredProcedure [dbo].[InsertRoute]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/08/08
-- Description:	Inserts a route.
-- =============================================
CREATE PROCEDURE [dbo].[InsertRoute]
 
	@Name				nvarchar(50),
	@Type				int,
	@Number				nvarchar(5),
	@Miles				int,
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [Route]
		VALUES(@Name, @Type, @Number, @Miles, @Notes)


SELECT @@IDENTITY

END

GO
/****** Object:  StoredProcedure [dbo].[InsertRouteType]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 12/12/08
-- Description:	Inserts a route type.
-- =============================================
CREATE PROCEDURE [dbo].[InsertRouteType]
 
	@Name				nvarchar(50),
	@Notes				nvarchar(MAX) = ''

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO RouteType
		VALUES(@Name, @Notes)


SELECT @@IDENTITY

END

GO
/****** Object:  StoredProcedure [dbo].[SelectAllDelayReasons]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/11/08
-- Description:	Gets all the delay reasons.
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllDelayReasons]
 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Id, [Description] FROM DelayReason



END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllDestinations]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/15/08
-- Description:	Gets all the destinations.
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllDestinations]
 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Id, [Name], COALESCE(Notes, '') FROM Destination



END

GO
/****** Object:  StoredProcedure [dbo].[SelectAllFareClasses]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/11/08
-- Description:	Gets all the fare classes.
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllFareClasses]
 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Id, [Name] FROM FareClass
	ORDER BY Id


END


GO
/****** Object:  StoredProcedure [dbo].[SelectAllRoutes]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/11/08
-- Description:	Gets all the Routes.
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllRoutes]
 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Id, [Name], [Type], Number, Miles, COALESCE(Notes, '') FROM [Route]



END

GO
/****** Object:  StoredProcedure [dbo].[SelectAllRouteTypes]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 11/19/08
-- Description:	Gets all the Route Types.
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllRouteTypes]
 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Id, [Name], COALESCE(Notes, '') FROM RouteType



END


GO
/****** Object:  StoredProcedure [dbo].[SelectAllWeather]    Script Date: 9/11/2024 8:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YellowCaddis Development
-- Create date: 8/19/09
-- Description:	Gets all the weather types.
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllWeather]
 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Id, [Name], COALESCE(Notes, '') FROM Weather



END




GO
