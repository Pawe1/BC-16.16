//class UserEvent
package core.user 
{
    import flash.events.*;
    
    public class UserEvent extends flash.events.Event
    {
        public function UserEvent(arg1:String, arg2:core.user.User=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            user = arg2;
            return;
        }

        public var user:core.user.User;
    }
}


