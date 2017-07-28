//class IApplication
package feathers.core 
{
    public interface IApplication
    {
        function get theme():Class;

        function set theme(arg1:Class):void;

        function get context3DProfile():String;

        function set context3DProfile(arg1:String):void;

        function get shareContext():Boolean;

        function set shareContext(arg1:Boolean):void;

        function get skipUnchangedFrames():Boolean;

        function set skipUnchangedFrames(arg1:Boolean):void;

        function get showStats():Boolean;

        function set showStats(arg1:Boolean):void;
    }
}


