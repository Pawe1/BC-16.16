//function calculateSnapshotTextureDimensions
package feathers.utils.textures 
{
    import flash.geom.*;
    import starling.utils.*;
    
    public function calculateSnapshotTextureDimensions(arg1:Number, arg2:Number, arg3:Number, arg4:Boolean, arg5:flash.geom.Point=null):flash.geom.Point
    {
        var loc1:*=arg1;
        var loc2:*=arg2;
        if (arg4) 
        {
            if (loc1 > arg3) 
            {
                loc1 = int(loc1 / arg3) * arg3 + loc1 % arg3;
            }
        }
        else if (loc1 > arg3) 
        {
            loc1 = int(loc1 / arg3) * arg3 + starling.utils.MathUtil.getNextPowerOfTwo(loc1 % arg3);
        }
        else 
        {
            loc1 = starling.utils.MathUtil.getNextPowerOfTwo(loc1);
        }
        if (arg4) 
        {
            if (loc2 > arg3) 
            {
                loc2 = int(loc2 / arg3) * arg3 + loc2 % arg3;
            }
        }
        else if (loc2 > arg3) 
        {
            loc2 = int(loc2 / arg3) * arg3 + starling.utils.MathUtil.getNextPowerOfTwo(loc2 % arg3);
        }
        else 
        {
            loc2 = starling.utils.MathUtil.getNextPowerOfTwo(loc2);
        }
        if (arg5 !== null) 
        {
            arg5.setTo(loc1, loc2);
        }
        else 
        {
            arg5 = new flash.geom.Point(loc1, loc2);
        }
        return arg5;
    }
}


