//class IAutoLapFavSets
package core.settings.interfaces 
{
    import core.sportprofiles.*;
    
    public dynamic interface IAutoLapFavSets
    {
        function get auto_lap_fav_set_1():String;

        function set auto_lap_fav_set_1(arg1:String):void;

        function changeAutoLapFavSet(arg1:uint, arg2:String):void;

        function getAutoLapFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList;
    }
}


