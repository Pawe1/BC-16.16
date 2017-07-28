//function matrixToScaleX
package feathers.utils.geom 
{
    import flash.geom.*;
    
    public function matrixToScaleX(arg1:flash.geom.Matrix):Number
    {
        var loc1:*=arg1.a;
        var loc2:*=arg1.b;
        return Math.sqrt(loc1 * loc1 + loc2 * loc2);
    }
}


