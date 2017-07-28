//function matrixToRotation
package feathers.utils.geom 
{
    import flash.geom.*;
    
    public function matrixToRotation(arg1:flash.geom.Matrix):Number
    {
        var loc1:*=arg1.c;
        var loc2:*=arg1.d;
        return -Math.atan(loc1 / loc2);
    }
}


