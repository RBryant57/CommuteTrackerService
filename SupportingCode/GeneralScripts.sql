GRANT SELECT ON OBJECT::Commute TO GeneralUser
GRANT SELECT ON OBJECT::CommuteLeg TO GeneralUser
GRANT SELECT ON OBJECT::CommuteMultiRoute TO GeneralUser
GRANT SELECT ON OBJECT::CommutesRoutes TO GeneralUser
GRANT SELECT ON OBJECT::DelayReason TO GeneralUser
GRANT SELECT ON OBJECT::Destination TO GeneralUser
GRANT SELECT ON OBJECT::FareClass TO GeneralUser
GRANT SELECT ON OBJECT::PassCondition TO GeneralUser
GRANT SELECT ON OBJECT::[Route] TO GeneralUser
GRANT SELECT ON OBJECT::RouteType TO GeneralUser

GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Commute TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::CommuteLeg TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::CommuteMultiRoute TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::CommutesRoutes TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::DelayReason TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Destination TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::FareClass TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::PassCondition TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::[Route] TO GeneralLogger
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::RouteType TO GeneralLogger

GRANT EXECUTE TO GeneralLogger