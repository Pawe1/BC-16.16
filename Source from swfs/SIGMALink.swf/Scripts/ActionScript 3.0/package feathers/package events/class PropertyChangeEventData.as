//class PropertyChangeEventData
package feathers.events 
{
    import __AS3__.vec.*;
    
    public class PropertyChangeEventData extends Object
    {
        public function PropertyChangeEventData(arg1:String="update", arg2:Object=null, arg3:Object=null, arg4:Object=null, arg5:Object=null)
        {
            super();
            this.reset(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function reset(arg1:String, arg2:Object, arg3:Object, arg4:Object, arg5:Object):feathers.events.PropertyChangeEventData
        {
            this.kind = arg1;
            this.property = arg2;
            this.newValue = arg3;
            this.oldValue = arg4;
            this.source = arg5;
            return this;
        }

        public static function fromPool(arg1:String, arg2:Object, arg3:Object, arg4:Object, arg5:Object):feathers.events.PropertyChangeEventData
        {
            if (POOL.length > 0) 
            {
                return POOL.pop().reset(arg1, arg2, arg3, arg4, arg5);
            }
            return new PropertyChangeEventData(arg1, arg2, arg3, arg4, arg5);
        }

        public static function toPool(arg1:feathers.events.PropertyChangeEventData):void
        {
            arg1.newValue = null;
            arg1.oldValue = null;
            arg1.source = null;
            arg1.kind = null;
            arg1.property = null;
            POOL[POOL.length] = arg1;
            return;
        }

        public static const KIND_UPDATE:String="update";

        public static const KIND_DELETE:String="delete";

        internal static const POOL:__AS3__.vec.Vector.<feathers.events.PropertyChangeEventData>=new Vector.<>(0);

        public var kind:String;

        public var property:Object;

        public var newValue:Object;

        public var oldValue:Object;

        public var source:Object;
    }
}


