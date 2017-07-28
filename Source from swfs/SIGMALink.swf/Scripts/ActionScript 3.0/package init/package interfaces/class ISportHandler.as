//class ISportHandler
package init.interfaces 
{
    import core.general.*;
    import core.sport.*;
    import flash.utils.*;
    
    public dynamic interface ISportHandler
    {
        function get sportsInUseDic():flash.utils.Dictionary;

        function resolveSportById(arg1:uint=0):core.sport.Sport;

        function resolveSportByKeyName(arg1:String):core.sport.Sport;

        function resolveSportByShortName(arg1:String):core.sport.Sport;

        function resolveSportByType(arg1:core.general.UnitType):core.sport.Sport;
    }
}


