//function resetFluidChildDimensionsForMeasurement
package feathers.utils.skins 
{
    import feathers.core.*;
    import starling.display.*;
    
    public function resetFluidChildDimensionsForMeasurement(arg1:starling.display.DisplayObject, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number, arg11:Number, arg12:Number, arg13:Number):void
    {
        var loc4:*=NaN;
        var loc5:*=NaN;
        var loc6:*=NaN;
        var loc7:*=NaN;
        if (arg1 === null) 
        {
            return;
        }
        var loc1:*=!(arg2 === arg2);
        var loc2:*=!(arg3 === arg3);
        if (loc1) 
        {
            arg1.width = arg8;
        }
        else 
        {
            arg1.width = arg2;
        }
        if (loc2) 
        {
            arg1.height = arg9;
        }
        else 
        {
            arg1.height = arg3;
        }
        var loc3:*=arg1 as feathers.core.IMeasureDisplayObject;
        if (loc3 !== null) 
        {
            loc4 = arg4;
            compilerWorkaround = loc4;
            if (!(loc4 === loc4) || arg10 > loc4) 
            {
                loc4 = arg10;
            }
            loc3.minWidth = loc4;
            loc5 = arg5;
            compilerWorkaround = loc5;
            if (!(loc5 === loc5) || arg11 > loc5) 
            {
                loc5 = arg11;
            }
            loc3.minHeight = loc5;
            loc6 = arg6;
            compilerWorkaround = loc6;
            if (!(loc6 === loc6) || arg12 < loc6) 
            {
                loc6 = arg12;
            }
            loc3.maxWidth = loc6;
            loc7 = arg7;
            compilerWorkaround = loc7;
            if (!(loc7 === loc7) || arg13 < loc7) 
            {
                loc7 = arg13;
            }
            loc3.maxHeight = loc7;
        }
        return;
    }
}


var compilerWorkaround:Object;

