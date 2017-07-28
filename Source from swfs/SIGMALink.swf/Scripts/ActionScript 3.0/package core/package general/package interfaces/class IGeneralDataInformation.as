//class IGeneralDataInformation
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


