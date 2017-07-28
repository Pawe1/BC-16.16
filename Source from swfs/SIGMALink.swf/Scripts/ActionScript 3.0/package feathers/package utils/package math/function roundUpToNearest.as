//function roundUpToNearest
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


