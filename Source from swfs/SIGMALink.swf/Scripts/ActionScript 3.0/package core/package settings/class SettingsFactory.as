//class SettingsFactory
package core.settings 
{
    import core.general.*;
    
    public class SettingsFactory extends Object
    {
        public function SettingsFactory()
        {
            super();
            return;
        }

        public static function createSettingsFromSSF(arg1:XML):core.settings.Settings
        {
            var loc2:*=null;
            var loc1:*=core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            try 
            {
                loc2 = unitSwitch(loc1);
            }
            catch (e:Error)
            {
                var loc4:*=null;
                return loc4;
            }
            if (loc2 != null) 
            {
                core.settings.SettingsMapper.fromXML(arg1, loc2);
            }
            return loc2;
        }

        public static function createSettingsFromUnitType(arg1:core.general.UnitType):core.settings.Settings
        {
            return unitSwitch(arg1);
        }

        public static function createSettingsFromDB(arg1:Object, arg2:core.general.UnitType):core.settings.Settings
        {
            var loc1:*=unitSwitch(arg2);
            core.settings.SettingsMapper.fromDB(loc1, arg1);
            return loc1;
        }

        internal static function unitSwitch(arg1:core.general.UnitType):core.settings.Settings
        {
            var loc1:*=null;
            var loc2:*=arg1.toString();
            while (core.general.UnitType.BC509.toString() === loc2) 
            {
                loc1 = new core.settings.SettingsBC509();
            }
        }
    }
}


