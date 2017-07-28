//package interfaces
//  class IAltitude
package core.route.interfaces 
{
    public dynamic interface IAltitude
    {
        function get altitude():Number;

        function set altitude(arg1:Number):void;
    }
}


//  class IAltitudeDifferencesDownhill
package core.route.interfaces 
{
    public dynamic interface IAltitudeDifferencesDownhill
    {
        function get altitudeDifferencesDownhill():int;

        function set altitudeDifferencesDownhill(arg1:int):void;
    }
}


//  class IAltitudeDifferencesUphill
package core.route.interfaces 
{
    public dynamic interface IAltitudeDifferencesUphill
    {
        function get altitudeDifferencesUphill():int;

        function set altitudeDifferencesUphill(arg1:int):void;
    }
}


//  class IDistance
package core.route.interfaces 
{
    public dynamic interface IDistance
    {
        function get distance():Number;

        function set distance(arg1:Number):void;
    }
}


//  class IDownloadFrom
package core.route.interfaces 
{
    public dynamic interface IDownloadFrom
    {
        function get downloadId():String;

        function set downloadId(arg1:String):void;

        function get webPortalId():String;

        function set webPortalId(arg1:String):void;
    }
}


//  class IGeneralRouteInformation
package core.route.interfaces 
{
    public dynamic interface IGeneralRouteInformation
    {
        function get autor():String;

        function set autor(arg1:String):void;

        function get description():String;

        function set description(arg1:String):void;

        function get name():String;

        function set name(arg1:String):void;

        function get rating():int;

        function set rating(arg1:int):void;
    }
}


//  class IGhostRace
package core.route.interfaces 
{
    public dynamic interface IGhostRace
    {
        function get ghostData():Array;

        function set ghostData(arg1:Array):void;

        function get ghostName():String;

        function set ghostName(arg1:String):void;
    }
}


//  class ILatLon
package core.route.interfaces 
{
    public dynamic interface ILatLon
    {
        function get latitude():Number;

        function set latitude(arg1:Number):void;

        function get longitude():Number;

        function set longitude(arg1:Number):void;

        function equalsRoutePoint(arg1:core.route.interfaces.ILatLon):Boolean;
    }
}


//  class ILatLonEnd
package core.route.interfaces 
{
    public dynamic interface ILatLonEnd
    {
        function get latitudeEnd():Number;

        function set latitudeEnd(arg1:Number):void;

        function get longitudeEnd():Number;

        function set longitudeEnd(arg1:Number):void;
    }
}


//  class ILatLonStart
package core.route.interfaces 
{
    public dynamic interface ILatLonStart
    {
        function get latitudeStart():Number;

        function set latitudeStart(arg1:Number):void;

        function get longitudeStart():Number;

        function set longitudeStart(arg1:Number):void;
    }
}


//  class IPointInstruction
package core.route.interfaces 
{
    public dynamic interface IPointInstruction
    {
        function get comment():String;

        function set comment(arg1:String):void;

        function get commentNumber():int;

        function set commentNumber(arg1:int):void;

        function get distance():Number;

        function set distance(arg1:Number):void;
    }
}


//  class IRoutePointType
package core.route.interfaces 
{
    public dynamic interface IRoutePointType
    {
        function get routePointType():String;

        function set routePointType(arg1:String):void;
    }
}


//  class IUserPoint
package core.route.interfaces 
{
    public dynamic interface IUserPoint
    {
        function get userPoint():Boolean;

        function set userPoint(arg1:Boolean):void;
    }
}


