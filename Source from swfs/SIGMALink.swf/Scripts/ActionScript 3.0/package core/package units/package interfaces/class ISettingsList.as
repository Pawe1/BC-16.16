//class ISettingsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface ISettingsList
    {
        function get settingsList():__AS3__.vec.Vector.<core.settings.Settings>;

        function set settingsList(arg1:__AS3__.vec.Vector.<core.settings.Settings>):void;
    }
}


