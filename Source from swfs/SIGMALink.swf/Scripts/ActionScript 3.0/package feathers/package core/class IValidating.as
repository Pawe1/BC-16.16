//class IValidating
package feathers.core 
{
    public interface IValidating extends feathers.core.IFeathersDisplayObject
    {
        function get depth():int;

        function validate():void;
    }
}


