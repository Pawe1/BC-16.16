//class ISynchronisable
package core.general.interfaces 
{
    public dynamic interface ISynchronisable
    {
        function get GUID():String;

        function set GUID(arg1:String):void;

        function get isDeleted():Boolean;

        function set isDeleted(arg1:Boolean):void;

        function get modificationDate():Number;

        function set modificationDate(arg1:Number):void;
    }
}


