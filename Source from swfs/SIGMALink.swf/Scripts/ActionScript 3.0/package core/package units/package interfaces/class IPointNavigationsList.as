//class IPointNavigationsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    import core.gps.*;
    
    public dynamic interface IPointNavigationsList
    {
        function get currentPointNavigation():core.gps.PointNavigation;

        function set currentPointNavigation(arg1:core.gps.PointNavigation):void;

        function get pointNavigationsVector():__AS3__.vec.Vector.<core.gps.PointNavigation>;

        function set pointNavigationsVector(arg1:__AS3__.vec.Vector.<core.gps.PointNavigation>):void;
    }
}


