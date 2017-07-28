//class ITrainingsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    import init.interfaces.*;
    
    public dynamic interface ITrainingsList
    {
        function get supportMultipleTrainings():Boolean;

        function get trainingsList():__AS3__.vec.Vector.<core.training.Training>;

        function set trainingsList(arg1:__AS3__.vec.Vector.<core.training.Training>):void;

        function get trainingsOnDeviceList():__AS3__.vec.Vector.<core.training.Training>;

        function set trainingsOnDeviceList(arg1:__AS3__.vec.Vector.<core.training.Training>):void;

        function get trainingsToDelete():__AS3__.vec.Vector.<core.training.Training>;

        function set trainingsToDelete(arg1:__AS3__.vec.Vector.<core.training.Training>):void;

        function get trainingsVectorList():init.interfaces.IVectorList;
    }
}


