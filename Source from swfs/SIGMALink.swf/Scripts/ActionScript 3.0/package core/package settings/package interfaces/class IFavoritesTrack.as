//class IFavoritesTrack
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesTrack
    {
        function get favoritesTrack():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        function set favoritesTrack(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void;
    }
}


