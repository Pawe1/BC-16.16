//class ITotalsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    import core.totals.*;
    
    public dynamic interface ITotalsList
    {
        function get currentTotals():core.totals.Totals;

        function set currentTotals(arg1:core.totals.Totals):void;

        function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>;

        function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void;
    }
}


