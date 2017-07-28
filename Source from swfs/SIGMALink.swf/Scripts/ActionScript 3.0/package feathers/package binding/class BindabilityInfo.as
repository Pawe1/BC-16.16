//class BindabilityInfo
package feathers.binding 
{
    import mx.events.*;
    
    public class BindabilityInfo extends Object
    {
        public function BindabilityInfo(arg1:XML)
        {
            this.childChangeEvents = {};
            super();
            this.typeDescription = arg1;
            return;
        }

        public function getChangeEvents(arg1:String):Object
        {
            var childName:String;
            var changeEvents:Object;
            var childDesc:XMLList;
            var numChildren:int;

            var loc1:*;
            childDesc = null;
            numChildren = 0;
            childName = arg1;
            changeEvents = this.childChangeEvents[childName];
            if (!changeEvents) 
            {
                changeEvents = this.copyProps(this.getClassChangeEvents(), {});
                var loc3:*=0;
                var loc4:*=this.typeDescription.accessor;
                var loc2:*=new XMLList("");
                for each (var loc5:* in loc4) 
                {
                    var loc6:*;
                    with (loc6 = loc5) 
                    {
                        if (@name == childName) 
                        {
                            loc2[loc3] = loc5;
                        }
                    }
                }
                loc3 = 0;
                loc4 = this.typeDescription.method;
                loc2 = new XMLList("");
                for each (loc5 in loc4) 
                {
                    with (loc6 = loc5) 
                    {
                        if (@name == childName) 
                        {
                            loc2[loc3] = loc5;
                        }
                    }
                }
                childDesc = loc2 + loc2;
                numChildren = childDesc.length();
                if (numChildren != 0) 
                {
                    if (numChildren > 1) 
                    {
                        trace("warning: multiple describeType entries for \'" + childName + "\' on type \'" + this.typeDescription.@name + "\':\n" + childDesc);
                    }
                    this.addBindabilityEvents(childDesc.metadata, changeEvents);
                }
                else if (!this.typeDescription.@dynamic) 
                {
                    trace("warning: no describeType entry for \'" + childName + "\' on non-dynamic type \'" + this.typeDescription.@name + "\'");
                }
                this.childChangeEvents[childName] = changeEvents;
            }
            return changeEvents;
        }

        internal function getClassChangeEvents():Object
        {
            var loc1:*;
            if (!this.classChangeEvents) 
            {
                this.classChangeEvents = {};
                this.addBindabilityEvents(this.typeDescription.metadata, this.classChangeEvents);
                var loc3:*=0;
                var loc4:*=this.typeDescription.metadata;
                var loc2:*=new XMLList("");
                for each (var loc5:* in loc4) 
                {
                    var loc6:*;
                    with (loc6 = loc5) 
                    {
                        if (@name == MANAGED) 
                        {
                            loc2[loc3] = loc5;
                        }
                    }
                }
                if (loc2.length() > 0) 
                {
                    this.classChangeEvents[mx.events.PropertyChangeEvent.PROPERTY_CHANGE] = true;
                }
            }
            return this.classChangeEvents;
        }

        internal function addBindabilityEvents(arg1:XMLList, arg2:Object):void
        {
            var metadata:XMLList;
            var eventListObj:Object;

            var loc1:*;
            metadata = arg1;
            eventListObj = arg2;
            var loc3:*=0;
            var loc4:*=metadata;
            var loc2:*=new XMLList("");
            for each (var loc5:* in loc4) 
            {
                var loc6:*;
                with (loc6 = loc5) 
                {
                    if (@name == BINDABLE) 
                    {
                        loc2[loc3] = loc5;
                    }
                }
            }
            this.addChangeEvents(loc2, eventListObj, true);
            loc3 = 0;
            loc4 = metadata;
            loc2 = new XMLList("");
            for each (loc5 in loc4) 
            {
                with (loc6 = loc5) 
                {
                    if (@name == CHANGE_EVENT) 
                    {
                        loc2[loc3] = loc5;
                    }
                }
            }
            this.addChangeEvents(loc2, eventListObj, true);
            loc3 = 0;
            loc4 = metadata;
            loc2 = new XMLList("");
            for each (loc5 in loc4) 
            {
                with (loc6 = loc5) 
                {
                    if (@name == NON_COMMITTING_CHANGE_EVENT) 
                    {
                        loc2[loc3] = loc5;
                    }
                }
            }
            this.addChangeEvents(loc2, eventListObj, false);
            return;
        }

        internal function addChangeEvents(arg1:XMLList, arg2:Object, arg3:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=arg1;
            for each (loc1 in loc5) 
            {
                loc2 = loc1.arg;
                if (loc2.length() > 0) 
                {
                    loc3 = loc2[0].@value;
                    arg2[loc3] = arg3;
                    continue;
                }
                trace("warning: unconverted Bindable metadata in class \'" + this.typeDescription.@name + "\'");
            }
            return;
        }

        internal function copyProps(arg1:Object, arg2:Object):Object
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3) 
            {
                arg2[loc1] = arg1[loc1];
            }
            return arg2;
        }

        public static const BINDABLE:String="Bindable";

        public static const MANAGED:String="Managed";

        public static const CHANGE_EVENT:String="ChangeEvent";

        public static const NON_COMMITTING_CHANGE_EVENT:String="NonCommittingChangeEvent";

        public static const ACCESSOR:String="accessor";

        public static const METHOD:String="method";

        internal var typeDescription:XML;

        internal var classChangeEvents:Object;

        internal var childChangeEvents:Object;
    }
}


