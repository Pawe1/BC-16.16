//class IFavoritesCustom
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesCustom
    {
        function get favoritesCustom():__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>;

        function set favoritesCustom(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>):void;

        function get favoritesCustomPageCount():__AS3__.vec.Vector.<int>;

        function set favoritesCustomPageCount(arg1:__AS3__.vec.Vector.<int>):void;
    }
}


