//function roundToPrecision
package feathers.utils.math 
{
    public function roundToPrecision(arg1:Number, arg2:int=0):Number
    {
        var loc1:*=Math.pow(10, arg2);
        return Math.round(loc1 * arg1) / loc1;
    }
}


