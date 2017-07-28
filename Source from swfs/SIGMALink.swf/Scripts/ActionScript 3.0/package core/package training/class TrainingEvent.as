//class TrainingEvent
package core.training 
{
    import flash.events.*;
    
    public class TrainingEvent extends flash.events.Event
    {
        public function TrainingEvent(arg1:String, arg2:core.training.Training=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            training = arg2;
            return;
        }

        public static const SELECT_PHASE:String="selectPhaseEvent";

        public static const TRAININGS_CHANGED:String="trainingsChanged";

        public var phase:core.training.TrainingPhase;

        public var training:core.training.Training;
    }
}


