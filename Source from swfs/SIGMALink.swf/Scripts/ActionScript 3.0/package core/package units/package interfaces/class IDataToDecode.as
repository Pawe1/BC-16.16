//class IDataToDecode
package core.units.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IDataToDecode
    {
        function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>;

        function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void;

        function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>;

        function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void;
    }
}


