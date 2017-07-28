//class IRange
package feathers.controls 
{
    import feathers.core.*;
    
    public interface IRange extends feathers.core.IFeathersControl
    {
        function get minimum():Number;

        function set minimum(arg1:Number):void;

        function get maximum():Number;

        function set maximum(arg1:Number):void;

        function get value():Number;

        function set value(arg1:Number):void;

        function get step():Number;

        function set step(arg1:Number):void;
    }
}


