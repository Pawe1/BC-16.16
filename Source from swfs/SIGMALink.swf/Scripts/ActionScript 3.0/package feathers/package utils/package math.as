//package math
//  function clamp
package feathers.utils.math 
{
    public function clamp(arg1:Number, arg2:Number, arg3:Number):Number
    {
        if (arg2 > arg3) 
        {
            throw new ArgumentError("minimum should be smaller than maximum.");
        }
        if (arg1 < arg2) 
        {
            arg1 = arg2;
        }
        else if (arg1 > arg3) 
        {
            arg1 = arg3;
        }
        return arg1;
    }
}


//  function roundDownToNearest
package feathers.utils.math 
{
    public function roundDownToNearest(arg1:Number, arg2:Number=1):Number
    {
        if (arg2 == 0) 
        {
            return arg1;
        }
        return Math.floor(feathers.utils.math.roundToPrecision(arg1 / arg2, 10)) * arg2;
    }
}


//  function roundToNearest
package feathers.utils.math 
{
    public function roundToNearest(arg1:Number, arg2:Number=1):Number
    {
        if (arg2 == 0) 
        {
            return arg1;
        }
        var loc1:*=Math.round(feathers.utils.math.roundToPrecision(arg1 / arg2, 10)) * arg2;
        return feathers.utils.math.roundToPrecision(loc1, 10);
    }
}


//  function roundToPrecision
package feathers.utils.math 
{
    public function roundToPrecision(arg1:Number, arg2:int=0):Number
    {
        var loc1:*=Math.pow(10, arg2);
        return Math.round(loc1 * arg1) / loc1;
    }
}


//  function roundUpToNearest
package feathers.utils.math 
{
    public function roundUpToNearest(arg1:Number, arg2:Number=1):Number
    {
        if (arg2 == 0) 
        {
            return arg1;
        }
        return Math.ceil(feathers.utils.math.roundToPrecision(arg1 / arg2, 10)) * arg2;
    }
}


