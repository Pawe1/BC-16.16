//package interfaces
//  class IDatabase
package core.general.interfaces 
{
    public dynamic interface IDatabase
    {
        function generateDBInsert():Array;

        function generateDBSelect():Array;

        function generateDBDelete():Array;
    }
}


//  class IDate
package core.general.interfaces 
{
    public dynamic interface IDate
    {
        function get date():Date;

        function set date(arg1:Date):void;
    }
}


//  class IGeneralDataInformation
package core.general.interfaces 
{
    import __AS3__.vec.*;
    import core.units.*;
    
    public dynamic interface IGeneralDataInformation
    {
        function get dateCode():String;

        function set dateCode(arg1:String):void;

        function get description():String;

        function set description(arg1:String):void;

        function get externalLink():String;

        function set externalLink(arg1:String):void;

        function get linkedRouteId():uint;

        function set linkedRouteId(arg1:uint):void;

        function get name():String;

        function set name(arg1:String):void;

        function get participant():__AS3__.vec.Vector.<core.participant.Person>;

        function set participant(arg1:__AS3__.vec.Vector.<core.participant.Person>):void;

        function get rating():uint;

        function set rating(arg1:uint):void;

        function get serialNumber():String;

        function set serialNumber(arg1:String):void;

        function get startDate():Date;

        function set startDate(arg1:Date):void;

        function get trackProfile():uint;

        function set trackProfile(arg1:uint):void;

        function get trainingType():String;

        function set trainingType(arg1:String):void;

        function get unit():core.units.Unit;

        function set unit(arg1:core.units.Unit):void;

        function get weather():uint;

        function set weather(arg1:uint):void;

        function get wind():uint;

        function set wind(arg1:uint):void;
    }
}


//  class IImportFromDevice
package core.general.interfaces 
{
    public dynamic interface IImportFromDevice
    {
        function get alreadySaved():Boolean;

        function set alreadySaved(arg1:Boolean):void;

        function get importFromDevice():Boolean;

        function set importFromDevice(arg1:Boolean):void;

        function get isNew():Boolean;

        function set isNew(arg1:Boolean):void;

        function get isUpdate():Boolean;

        function set isUpdate(arg1:Boolean):void;
    }
}


//  class ISynchronisable
package core.general.interfaces 
{
    public dynamic interface ISynchronisable
    {
        function get GUID():String;

        function set GUID(arg1:String):void;

        function get isDeleted():Boolean;

        function set isDeleted(arg1:Boolean):void;

        function get modificationDate():Number;

        function set modificationDate(arg1:Number):void;
    }
}


