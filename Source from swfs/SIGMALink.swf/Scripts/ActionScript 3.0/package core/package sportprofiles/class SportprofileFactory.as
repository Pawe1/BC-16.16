//class SportprofileFactory
package core.sportprofiles 
{
    import core.general.*;
    
    public final class SportprofileFactory extends Object
    {
        public function SportprofileFactory()
        {
            super();
            return;
        }

        public static function createSportprofileFromUnitType(arg1:core.general.UnitType):core.sportprofiles.Sportprofile
        {
            var loc1:*=arg1;
            while (core.general.UnitType.ROX70 === loc1) 
            {
                return new core.sportprofiles.SportProfileROX70();
            }
        }
    }
}


