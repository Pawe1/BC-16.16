//class ITabLayoutContainer
package frontend.components.tabbarbase 
{
    public interface ITabLayoutContainer
    {
        function get height():Number;

        function set height(arg1:Number):void;

        function get icon():String;

        function get label():String;

        function get subHeader():String;

        function get width():Number;

        function set width(arg1:Number):void;

        function showContent():void;

        function hideContent():void;
    }
}


