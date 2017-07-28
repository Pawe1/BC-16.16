//class IPersistenceManager
package configCache 
{
    public dynamic interface IPersistenceManager
    {
        function clear():void;

        function save():Boolean;

        function load():Boolean;

        function getProperty(arg1:String):Object;

        function setProperty(arg1:String, arg2:Object):void;
    }
}


