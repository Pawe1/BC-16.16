//class IAutoOffTime
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface IAutoOffTime
    {
        function get autoOffTime():core.general.AutoOffTimeUnit;

        function set autoOffTime(arg1:core.general.AutoOffTimeUnit):void;
    }
}


