//package events
//  class PropertyChangeEvent
package mx.events 
{
    import flash.events.*;
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class PropertyChangeEvent extends flash.events.Event
    {
        public function PropertyChangeEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:String=null, arg5:Object=null, arg6:Object=null, arg7:Object=null, arg8:Object=null)
        {
            super(arg1, arg2, arg3);
            this.kind = arg4;
            this.property = arg5;
            this.oldValue = arg6;
            this.newValue = arg7;
            this.source = arg8;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new mx.events.PropertyChangeEvent(type, bubbles, cancelable, this.kind, this.property, this.oldValue, this.newValue, this.source);
        }

        public static function createUpdateEvent(arg1:Object, arg2:Object, arg3:Object, arg4:Object):mx.events.PropertyChangeEvent
        {
            var loc1:*=new PropertyChangeEvent(PROPERTY_CHANGE);
            loc1.kind = mx.events.PropertyChangeEventKind.UPDATE;
            loc1.oldValue = arg3;
            loc1.newValue = arg4;
            loc1.source = arg1;
            loc1.property = arg2;
            return loc1;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";

        public static const PROPERTY_CHANGE:String="propertyChange";

        public var kind:String;

        public var newValue:Object;

        public var oldValue:Object;

        public var property:Object;

        public var source:Object;
    }
}


//  class PropertyChangeEventKind
package mx.events 
{
    import mx.core.*;
    
    use namespace mx_internal;
    
    public final class PropertyChangeEventKind extends Object
    {
        public function PropertyChangeEventKind()
        {
            super();
            return;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";

        public static const UPDATE:String="update";

        public static const DELETE:String="delete";
    }
}


