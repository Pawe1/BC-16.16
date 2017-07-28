//class EnterFrameEvent
package starling.events 
{
    public class EnterFrameEvent extends starling.events.Event
    {
        public function EnterFrameEvent(arg1:String, arg2:Number, arg3:Boolean=false)
        {
            super(arg1, arg3, arg2);
            return;
        }

        public function get passedTime():Number
        {
            return data as Number;
        }

        public static const ENTER_FRAME:String="enterFrame";
    }
}


