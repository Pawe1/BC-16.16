//class ICodingTotals
package core.units.interfaces 
{
    import core.totals.*;
    import core.units.*;
    
    public dynamic interface ICodingTotals
    {
        function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals;

        function encodeTotals(arg1:core.totals.Totals):Array;
    }
}


