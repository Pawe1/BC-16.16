//class IFavSets
package core.settings.interfaces 
{
    import core.sportprofiles.*;
    
    public dynamic interface IFavSets
    {
        function get favSetMaxCount():uint;

        function set favSetMaxCount(arg1:uint):void;

        function get fav_set_1():String;

        function set fav_set_1(arg1:String):void;

        function get fav_set_10():String;

        function set fav_set_10(arg1:String):void;

        function get fav_set_2():String;

        function set fav_set_2(arg1:String):void;

        function get fav_set_3():String;

        function set fav_set_3(arg1:String):void;

        function get fav_set_4():String;

        function set fav_set_4(arg1:String):void;

        function get fav_set_5():String;

        function set fav_set_5(arg1:String):void;

        function get fav_set_6():String;

        function set fav_set_6(arg1:String):void;

        function get fav_set_7():String;

        function set fav_set_7(arg1:String):void;

        function get fav_set_8():String;

        function set fav_set_8(arg1:String):void;

        function get fav_set_9():String;

        function set fav_set_9(arg1:String):void;

        function changeFavFunctionList(arg1:uint, arg2:core.sportprofiles.FavFunctionList):void;

        function getFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList;
    }
}


