//class ILatLon
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


