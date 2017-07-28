//class ICodingSettings
package core.units.interfaces 
{
    import core.settings.*;
    import core.units.*;
    
    public dynamic interface ICodingSettings
    {
        function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings;

        function encodeSettings(arg1:core.units.Unit):Array;
    }
}


