//class TrainingReference
package core.training 
{
    import __AS3__.vec.*;
    import core.marker.*;
    
    public class TrainingReference extends Object
    {
        public function TrainingReference()
        {
            super();
            plannedPhases = new __AS3__.vec.Vector.<core.marker.Marker>();
            logPhases = new __AS3__.vec.Vector.<core.marker.Marker>();
            return;
        }

        public var count:int;

        public var index:int;

        public var logPhases:__AS3__.vec.Vector.<core.marker.Marker>;

        public var modificationDate:Number;

        public var name:String="";

        public var plannedPhases:__AS3__.vec.Vector.<core.marker.Marker>;

        public var programId:int=0;

        public var startPoint:uint;

        public var totalPhases:int=0;

        public var trainingGUID:String="";

        public var workoutId:int=0;
    }
}


