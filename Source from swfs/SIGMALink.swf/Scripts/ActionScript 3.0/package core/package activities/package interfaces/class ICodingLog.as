//class ICodingLog
package core.activities.interfaces 
{
    import core.activities.*;
    import core.units.*;
    
    public dynamic interface ICodingLog
    {
        function decodeLog(arg1:core.activities.Activity, arg2:Array):void;

        function decodePageHeaderInformation(arg1:Array, arg2:core.units.Unit):core.activities.Activity;

        function decodeAddressOfPageHeaders(arg1:Array):void;
    }
}


