//class ISportProfiles
package core.units.interfaces 
{
    import __AS3__.vec.*;
    import core.sportprofiles.*;
    import init.interfaces.*;
    
    public dynamic interface ISportProfiles
    {
        function get currentSportProfileIndex():uint;

        function set currentSportProfileIndex(arg1:uint):void;

        function get loadedSportProfiles():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        function set loadedSportProfiles(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void;

        function get sportprofilesList():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        function set sportprofilesList(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void;

        function get sportprofilesVectorlist():init.interfaces.IVectorList;

        function set sportprofilesVectorlist(arg1:init.interfaces.IVectorList):void;

        function addSportProfile(arg1:core.sportprofiles.Sportprofile):void;
    }
}


