//class ILapFavSets
package core.settings.interfaces 
{
    import core.sportprofiles.*;
    
    public dynamic interface ILapFavSets
    {
        function get lap_fav_set_1():String;

        function set lap_fav_set_1(arg1:String):void;

        function changeLapFavSet(arg1:uint, arg2:String):void;

        function getLapFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList;
    }
}


