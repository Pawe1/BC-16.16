//class ILogList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface ILogList
    {
        function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>;

        function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void;
    }
}


