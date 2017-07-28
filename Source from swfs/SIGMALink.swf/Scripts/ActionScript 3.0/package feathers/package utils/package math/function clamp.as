//function clamp
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


