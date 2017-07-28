//function roundToNearest
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


