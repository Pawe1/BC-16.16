//class IImportFromDevice
package core.general.interfaces 
{
    public dynamic interface IImportFromDevice
    {
        function get alreadySaved():Boolean;

        function set alreadySaved(arg1:Boolean):void;

        function get importFromDevice():Boolean;

        function set importFromDevice(arg1:Boolean):void;

        function get isNew():Boolean;

        function set isNew(arg1:Boolean):void;

        function get isUpdate():Boolean;

        function set isUpdate(arg1:Boolean):void;
    }
}


