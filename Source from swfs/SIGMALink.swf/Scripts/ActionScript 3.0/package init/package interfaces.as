//package interfaces
//  class IBackendInitializer
package init.interfaces 
{
    import core.user.interfaces.*;
    import utils.interfaces.*;
    
    public dynamic interface IBackendInitializer
    {
        function createDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter;

        function createAltitudeFormatter():utils.interfaces.ICustomFormatter;

        function createCaloriesFormatter():utils.interfaces.ICustomFormatterBase;

        function createDateFormatterMx():utils.interfaces.ICustomFormatter;

        function createDistanceFormatter():utils.interfaces.ICustomFormatter;

        function createHeartrateFormatter():utils.interfaces.ICustomFormatterBase;

        function createPowerFormatter():utils.interfaces.ICustomFormatterBase;

        function createSpeedFormatter():utils.interfaces.ICustomFormatter;

        function createSpeedTimeFormatter():utils.interfaces.ICustomTimeFormatter;

        function createTimeFormatterHHMM():utils.interfaces.ICustomTimeFormatter;

        function createTimeFormatter():utils.interfaces.ICustomTimeFormatter;

        function createCadenceFormatter():utils.interfaces.ICustomFormatterBase;

        function createInclineFormatter():utils.interfaces.ICustomFormatterBase;

        function createGhostDistanceDecoderFormatter():utils.interfaces.ICustomFormatterBase;

        function createVectorList(arg1:*=null):init.interfaces.IVectorList;

        function getSportHandler():init.interfaces.ISportHandler;

        function getUserhandler():core.user.interfaces.IUserHandler;
    }
}


//  class ISportHandler
package init.interfaces 
{
    import core.general.*;
    import core.sport.*;
    import flash.utils.*;
    
    public dynamic interface ISportHandler
    {
        function get sportsInUseDic():flash.utils.Dictionary;

        function resolveSportById(arg1:uint=0):core.sport.Sport;

        function resolveSportByKeyName(arg1:String):core.sport.Sport;

        function resolveSportByShortName(arg1:String):core.sport.Sport;

        function resolveSportByType(arg1:core.general.UnitType):core.sport.Sport;
    }
}


//  class IVectorList
package init.interfaces 
{
    import flash.events.*;
    
    public dynamic interface IVectorList extends flash.events.IEventDispatcher
    {
        function get length():int;

        function get source():*;

        function toArray():Array;

        function addItem(arg1:Object):void;

        function contains(arg1:Object):Boolean;

        function getItemAt(arg1:int, arg2:int=0):Object;

        function createVectorList(arg1:*=null):init.interfaces.IVectorList;
    }
}


