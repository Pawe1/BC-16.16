//package binding
//  package utils
//    const BINDING_EVENT_PRIORITY
package feathers.binding.utils 
{
    public const BINDING_EVENT_PRIORITY:int=100;
}


//    class DescribeTypeCache
package feathers.binding.utils 
{
    import feathers.binding.*;
    import flash.utils.*;
    
    public class DescribeTypeCache extends Object
    {
        public function DescribeTypeCache()
        {
            super();
            return;
        }

        public static function describeType(arg1:*):feathers.binding.utils.DescribeTypeCacheRecord
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1 is String) 
            {
                var loc5:*;
                loc1 = loc5 = arg1;
                loc2 = loc5;
            }
            else 
            {
                loc1 = loc5 = flash.utils.getQualifiedClassName(arg1);
                loc2 = loc5;
            }
            if (arg1 is Class) 
            {
                loc2 = loc2 + "$";
            }
            if (loc2 in typeCache) 
            {
                return typeCache[loc2];
            }
            if (arg1 is String) 
            {
                try 
                {
                    arg1 = flash.utils.getDefinitionByName(arg1);
                }
                catch (error:ReferenceError)
                {
                };
            }
            loc3 = flash.utils.describeType(arg1);
            loc4 = new feathers.binding.utils.DescribeTypeCacheRecord();
            loc4.typeDescription = loc3;
            loc4.typeName = loc1;
            typeCache[loc2] = loc4;
            return loc4;
        }

        public static function registerCacheHandler(arg1:String, arg2:Function):void
        {
            cacheHandlers[arg1] = arg2;
            return;
        }

        static function extractValue(arg1:String, arg2:feathers.binding.utils.DescribeTypeCacheRecord):*
        {
            if (arg1 in cacheHandlers) 
            {
                var loc1:*;
                return (loc1 = cacheHandlers)[arg1](arg2);
            }
            return undefined;
        }

        internal static function bindabilityInfoHandler(arg1:feathers.binding.utils.DescribeTypeCacheRecord):*
        {
            return new feathers.binding.BindabilityInfo(arg1.typeDescription);
        }

        
        {
            typeCache = {};
            cacheHandlers = {};
            registerCacheHandler("bindabilityInfo", bindabilityInfoHandler);
        }

        internal static var typeCache:Object;

        internal static var cacheHandlers:Object;
    }
}


//    class DescribeTypeCacheRecord
package feathers.binding.utils 
{
    import flash.utils.*;
    
    use namespace flash_proxy;
    
    public dynamic class DescribeTypeCacheRecord extends flash.utils.Proxy
    {
        public function DescribeTypeCacheRecord()
        {
            this.cache = {};
            super();
            return;
        }

        flash_proxy override function getProperty(arg1:*):*
        {
            var loc1:*=this.cache[arg1];
            if (loc1 === undefined) 
            {
                loc1 = feathers.binding.utils.DescribeTypeCache.extractValue(arg1, this);
                this.cache[arg1] = loc1;
            }
            return loc1;
        }

        flash_proxy override function hasProperty(arg1:*):Boolean
        {
            if (arg1 in this.cache) 
            {
                return true;
            }
            var loc1:*=feathers.binding.utils.DescribeTypeCache.extractValue(arg1, this);
            if (loc1 === undefined) 
            {
                return false;
            }
            this.cache[arg1] = loc1;
            return true;
        }

        internal var cache:Object;

        public var typeDescription:XML;

        public var typeName:String;
    }
}


//  class BindabilityInfo
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


//  class Binding
package feathers.binding 
{
    import flash.utils.*;
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class Binding extends Object
    {
        public function Binding(arg1:Object, arg2:Function, arg3:Function, arg4:String, arg5:String=null)
        {
            super();
            this.mx_internal::document = arg1;
            this.mx_internal::srcFunc = arg2;
            this.mx_internal::destFunc = arg3;
            this.mx_internal::destString = arg4;
            this.mx_internal::srcString = arg5;
            this.mx_internal::destFuncFailed = false;
            if (this.mx_internal::srcFunc == null) 
            {
                this.mx_internal::srcFunc = this.defaultSrcFunc;
            }
            if (this.mx_internal::destFunc == null) 
            {
                this.mx_internal::destFunc = this.defaultDestFunc;
            }
            this.mx_internal::_isEnabled = true;
            this.mx_internal::isExecuting = false;
            this.mx_internal::isHandlingEvent = false;
            this.hasHadValue = false;
            this.uiComponentWatcher = -1;
            feathers.binding.BindingManager.addBinding(arg1, arg4, this);
            return;
        }

        mx_internal function get isEnabled():Boolean
        {
            return this.mx_internal::_isEnabled;
        }

        mx_internal function set isEnabled(arg1:Boolean):void
        {
            this.mx_internal::_isEnabled = arg1;
            if (arg1) 
            {
                this.processDisabledRequests();
            }
            return;
        }

        internal function defaultDestFunc(arg1:Object):void
        {
            var loc1:*=this.mx_internal::destString.split(".");
            var loc2:*=this.mx_internal::document;
            var loc3:*=0;
            if (loc1[0] == "this") 
            {
                ++loc3;
            }
            while (loc3 < (loc1.length - 1)) 
            {
                loc2 = loc2[loc1[loc3++]];
                if (loc2 != null) 
                {
                    continue;
                }
                this.mx_internal::destFuncFailed = true;
                if (feathers.binding.BindingManager.debugDestinationStrings[this.mx_internal::destString]) 
                {
                    trace("Binding: destString = " + this.mx_internal::destString + ", error = 1009");
                }
                return;
            }
            loc2[loc1[loc3]] = arg1;
            return;
        }

        internal function defaultSrcFunc():Object
        {
            return this.mx_internal::document[this.mx_internal::srcString];
        }

        public function execute(arg1:Object=null):void
        {
            var o:Object=null;

            var loc1:*;
            o = arg1;
            if (!this.mx_internal::isEnabled) 
            {
                if (o != null) 
                {
                    this.registerDisabledExecute(o);
                }
                return;
            }
            if (this.twoWayCounterpart && !this.twoWayCounterpart.hasHadValue && this.twoWayCounterpart.isTwoWayPrimary) 
            {
                this.twoWayCounterpart.execute();
                this.hasHadValue = true;
                return;
            }
            if (this.mx_internal::isExecuting || this.twoWayCounterpart && this.twoWayCounterpart.mx_internal::isExecuting) 
            {
                this.hasHadValue = true;
                return;
            }
            try 
            {
                this.mx_internal::isExecuting = true;
                this.wrapFunctionCall(this, this.innerExecute, o);
            }
            catch (error:Error)
            {
                if (mx_internal::allowedErrors[error.errorID] == null) 
                {
                    throw error;
                }
            }
            finally
            {
                this.mx_internal::isExecuting = false;
            }
            return;
        }

        internal function registerDisabledExecute(arg1:Object):void
        {
            if (arg1 != null) 
            {
                this.mx_internal::disabledRequests = this.mx_internal::disabledRequests == null ? new flash.utils.Dictionary(true) : this.mx_internal::disabledRequests;
                this.mx_internal::disabledRequests[arg1] = true;
            }
            return;
        }

        internal function processDisabledRequests():void
        {
            var loc1:*=null;
            if (this.mx_internal::disabledRequests != null) 
            {
                var loc2:*=0;
                var loc3:*=this.mx_internal::disabledRequests;
                for (loc1 in loc3) 
                {
                    this.execute(loc1);
                }
                this.mx_internal::disabledRequests = null;
            }
            return;
        }

        protected function wrapFunctionCall(arg1:Object, arg2:Function, arg3:Object=null, ... rest):Object
        {
            var thisArg:Object;
            var wrappedFunction:Function;
            var object:Object=null;
            var args:Array;
            var result:Object;

            var loc1:*;
            result = null;
            thisArg = arg1;
            wrappedFunction = arg2;
            object = arg3;
            args = rest;
            this.wrappedFunctionSuccessful = false;
            try 
            {
                result = wrappedFunction.apply(thisArg, args);
                if (this.mx_internal::destFuncFailed == true) 
                {
                    this.mx_internal::destFuncFailed = false;
                    return null;
                }
                this.wrappedFunctionSuccessful = true;
                return result;
            }
            catch (error:Error)
            {
                if (error is RangeError) 
                {
                    if (feathers.binding.BindingManager.debugDestinationStrings[mx_internal::destString]) 
                    {
                        trace("Binding: destString = " + mx_internal::destString + ", error = " + error);
                    }
                }
                else 
                {
                    if (!(error.errorID == 1006) && !(error.errorID == 1009) && !(error.errorID == 1010) && !(error.errorID == 1055) && !(error.errorID == 1069)) 
                    {
                        throw error;
                    }
                    if (feathers.binding.BindingManager.debugDestinationStrings[mx_internal::destString]) 
                    {
                        trace("Binding: destString = " + mx_internal::destString + ", error = " + error);
                    }
                }
            }
            return null;
        }

        internal function nodeSeqEqual(arg1:XMLList, arg2:XMLList):Boolean
        {
            var loc2:*=0;
            var loc1:*=arg1.length();
            if (loc1 == arg2.length()) 
            {
                loc2 = 0;
                while (loc2 < loc1 && arg1[loc2] === arg2[loc2]) 
                {
                    ++loc2;
                }
                return loc2 == loc1;
            }
            return false;
        }

        internal function innerExecute():void
        {
            this.mx_internal::destFuncFailed = false;
            var loc1:*=this.wrapFunctionCall(this.mx_internal::document, this.mx_internal::srcFunc);
            if (feathers.binding.BindingManager.debugDestinationStrings[this.mx_internal::destString]) 
            {
                trace("Binding: destString = " + this.mx_internal::destString + ", srcFunc result = " + loc1);
            }
            if (this.hasHadValue || this.wrappedFunctionSuccessful) 
            {
                if (!(this.lastValue is XML && this.lastValue.hasComplexContent() && this.lastValue === loc1) && !(this.lastValue is XMLList && this.lastValue.hasComplexContent() && loc1 is XMLList && this.nodeSeqEqual(this.lastValue as XMLList, loc1 as XMLList))) 
                {
                    this.mx_internal::destFunc.call(this.mx_internal::document, loc1);
                    if (this.mx_internal::destFuncFailed == false) 
                    {
                        this.lastValue = loc1;
                        this.hasHadValue = true;
                    }
                }
            }
            return;
        }

        public function watcherFired(arg1:Boolean, arg2:int):void
        {
            var commitEvent:Boolean;
            var cloneIndex:int;

            var loc1:*;
            commitEvent = arg1;
            cloneIndex = arg2;
            if (this.mx_internal::isHandlingEvent) 
            {
                return;
            }
            try 
            {
                this.mx_internal::isHandlingEvent = true;
                this.execute(cloneIndex);
            }
            finally
            {
                this.mx_internal::isHandlingEvent = false;
            }
            return;
        }

        mx_internal static function generateAllowedErrors():Object
        {
            var loc1:*={};
            loc1[1507] = 1;
            loc1[2005] = 1;
            return loc1;
        }

        
        {
            mx_internal::allowedErrors = mx_internal::generateAllowedErrors();
        }

        mx_internal var _isEnabled:Boolean;

        mx_internal var isExecuting:Boolean;

        mx_internal var isHandlingEvent:Boolean;

        mx_internal var disabledRequests:flash.utils.Dictionary;

        internal var hasHadValue:Boolean;

        public var uiComponentWatcher:int;

        public var twoWayCounterpart:feathers.binding.Binding;

        public var isTwoWayPrimary:Boolean;

        internal var wrappedFunctionSuccessful:Boolean;

        mx_internal var document:Object;

        mx_internal var srcFunc:Function;

        mx_internal var destFunc:Function;

        mx_internal var destFuncFailed:Boolean;

        mx_internal var destString:String;

        mx_internal var srcString:String;

        internal var lastValue:Object;

        mx_internal static var allowedErrors:Object;
    }
}


//  class BindingManager
package feathers.binding 
{
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class BindingManager extends Object
    {
        public function BindingManager()
        {
            super();
            return;
        }

        public static function addBinding(arg1:Object, arg2:String, arg3:feathers.binding.Binding):void
        {
            if (!arg1._bindingsByDestination) 
            {
                arg1._bindingsByDestination = {};
                arg1._bindingsBeginWithWord = {};
            }
            arg1._bindingsByDestination[arg2] = arg3;
            arg1._bindingsBeginWithWord[getFirstWord(arg2)] = true;
            return;
        }

        public static function setEnabled(arg1:Object, arg2:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            if (arg1 is feathers.binding.IBindingClient && arg1._bindings) 
            {
                loc1 = arg1._bindings as Array;
                loc2 = 0;
                while (loc2 < loc1.length) 
                {
                    loc3 = loc1[loc2];
                    loc3.mx_internal::isEnabled = arg2;
                    ++loc2;
                }
            }
            return;
        }

        public static function executeBindings(arg1:Object, arg2:String, arg3:Object):void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (!arg2 || arg2 == "") 
            {
                return;
            }
            if (arg1 && (arg1 is feathers.binding.IBindingClient || arg1.hasOwnProperty("_bindingsByDestination")) && arg1._bindingsByDestination && arg1._bindingsBeginWithWord[getFirstWord(arg2)]) 
            {
                var loc3:*=0;
                var loc4:*=arg1._bindingsByDestination;
                for (loc1 in loc4) 
                {
                    if (loc1.charAt(0) != arg2.charAt(0)) 
                    {
                        continue;
                    }
                    loc2 = arg2.length;
                    if (!(loc2 < loc1.length && loc1.indexOf(arg2) == 0 && (loc1.charAt(loc2) == "." || loc1.charAt(loc2) == "[") || loc1 == arg2)) 
                    {
                        continue;
                    }
                    arg1._bindingsByDestination[loc1].execute(arg3);
                }
            }
            return;
        }

        public static function enableBindings(arg1:Object, arg2:String, arg3:Boolean=true):void
        {
            var loc1:*=null;
            if (!arg2 || arg2 == "") 
            {
                return;
            }
            if (arg1 && (arg1 is feathers.binding.IBindingClient || arg1.hasOwnProperty("_bindingsByDestination")) && arg1._bindingsByDestination && arg1._bindingsBeginWithWord[getFirstWord(arg2)]) 
            {
                var loc2:*=0;
                var loc3:*=arg1._bindingsByDestination;
                for (loc1 in loc3) 
                {
                    if (loc1.charAt(0) != arg2.charAt(0)) 
                    {
                        continue;
                    }
                    if (!(loc1.indexOf(arg2 + ".") == 0 || loc1.indexOf(arg2 + "[") == 0 || loc1 == arg2)) 
                    {
                        continue;
                    }
                    arg1._bindingsByDestination[loc1].isEnabled = arg3;
                }
            }
            return;
        }

        internal static function getFirstWord(arg1:String):String
        {
            var loc1:*=arg1.indexOf(".");
            var loc2:*=arg1.indexOf("[");
            if (loc1 == loc2) 
            {
                return arg1;
            }
            var loc3:*=Math.min(loc1, loc2);
            if (loc3 == -1) 
            {
                loc3 = Math.max(loc1, loc2);
            }
            return arg1.substr(0, loc3);
        }

        public static function debugBinding(arg1:String):void
        {
            debugDestinationStrings[arg1] = true;
            return;
        }

        
        {
            debugDestinationStrings = {};
        }

        static var debugDestinationStrings:Object;
    }
}


//  class FunctionReturnWatcher
package feathers.binding 
{
    import feathers.binding.utils.*;
    import flash.events.*;
    import mx.core.*;
    import starling.events.*;
    
    use namespace mx_internal;
    
    public class FunctionReturnWatcher extends feathers.binding.Watcher
    {
        public function FunctionReturnWatcher(arg1:String, arg2:Object, arg3:Function, arg4:Object, arg5:Array, arg6:Function=null)
        {
            super(arg5);
            this.functionName = arg1;
            this.document = arg2;
            this.parameterFunction = arg3;
            this.events = arg4;
            this.functionGetter = arg6;
            return;
        }

        public override function updateParent(arg1:Object):void
        {
            if (arg1 is feathers.binding.Watcher) 
            {
                if (arg1 == this.parentWatcher) 
                {
                    this.setupParentObj(this.parentWatcher.value);
                }
            }
            else 
            {
                this.setupParentObj(arg1);
            }
            this.updateFunctionReturn();
            return;
        }

        protected override function shallowClone():feathers.binding.Watcher
        {
            var loc1:*=new feathers.binding.FunctionReturnWatcher(this.functionName, this.document, this.parameterFunction, this.events, listeners, this.functionGetter);
            return loc1;
        }

        public function updateFunctionReturn():void
        {
            var loc1:*;
            wrapUpdate(function ():void
            {
                if (functionGetter == null) 
                {
                    value = parentObj[functionName].apply(parentObj, parameterFunction.apply(document));
                }
                else 
                {
                    value = functionGetter(functionName).apply(parentObj, parameterFunction.apply(document));
                }
                updateChildren();
                return;
            })
            return;
        }

        internal function setupParentObj(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this.parentObj != null) 
            {
                if (this.events != null) 
                {
                    var loc4:*=0;
                    var loc5:*=this.events;
                    for (loc1 in loc5) 
                    {
                        if (loc1 == "__NoChangeEvent__") 
                        {
                            continue;
                        }
                        if (this.parentObj is starling.events.EventDispatcher) 
                        {
                            loc2 = starling.events.EventDispatcher(this.parentObj);
                            loc2.removeEventListener(loc1, this.eventHandler);
                            continue;
                        }
                        if (!(this.parentObj is flash.events.IEventDispatcher)) 
                        {
                            continue;
                        }
                        loc3 = flash.events.IEventDispatcher(this.parentObj);
                        loc3.removeEventListener(loc1, this.eventHandler);
                    }
                }
            }
            this.parentObj = arg1;
            if (this.parentObj != null) 
            {
                if (this.events != null) 
                {
                    loc4 = 0;
                    loc5 = this.events;
                    for (loc1 in loc5) 
                    {
                        if (loc1 == "__NoChangeEvent__") 
                        {
                            continue;
                        }
                        if (this.parentObj is starling.events.EventDispatcher) 
                        {
                            loc2 = starling.events.EventDispatcher(this.parentObj);
                            loc2.addEventListener(loc1, this.eventHandler);
                            continue;
                        }
                        if (!(this.parentObj is flash.events.IEventDispatcher)) 
                        {
                            continue;
                        }
                        loc3 = flash.events.IEventDispatcher(this.parentObj);
                        loc3.addEventListener(loc1, this.eventHandler, false, feathers.binding.utils.BINDING_EVENT_PRIORITY, true);
                    }
                }
            }
            return;
        }

        public function eventHandler(arg1:Object):void
        {
            var loc1:*=null;
            this.updateFunctionReturn();
            if (this.events != null) 
            {
                loc1 = arg1.type as String;
                notifyListeners(this.events[loc1]);
            }
            return;
        }

        internal var functionName:String;

        internal var document:Object;

        internal var parameterFunction:Function;

        internal var events:Object;

        internal var parentObj:Object;

        public var parentWatcher:feathers.binding.Watcher;

        internal var functionGetter:Function;
    }
}


//  class IBindingClient
package feathers.binding 
{
    public interface IBindingClient
    {
    }
}


//  class IWatcherSetupUtil
package feathers.binding 
{
    public interface IWatcherSetupUtil
    {
        function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void;
    }
}


//  class PropertyWatcher
package feathers.binding 
{
    import feathers.binding.utils.*;
    import feathers.events.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.events.*;
    import starling.events.*;
    
    public class PropertyWatcher extends feathers.binding.Watcher
    {
        public function PropertyWatcher(arg1:String, arg2:Object, arg3:Array, arg4:Function=null)
        {
            super(arg3);
            this._propertyName = arg1;
            this.events = arg2;
            this.propertyGetter = arg4;
            this.useRTTI = !arg2;
            return;
        }

        public function get propertyName():String
        {
            return this._propertyName;
        }

        public override function updateParent(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (this.parentObj) 
            {
                if (this.parentObj is starling.events.EventDispatcher) 
                {
                    loc1 = starling.events.EventDispatcher(this.parentObj);
                    var loc5:*=0;
                    var loc6:*=this.events;
                    for (loc2 in loc6) 
                    {
                        loc1.removeEventListener(loc2, this.eventHandler);
                    }
                }
                else if (this.parentObj is flash.events.IEventDispatcher) 
                {
                    loc3 = flash.events.IEventDispatcher(this.parentObj);
                    loc5 = 0;
                    loc6 = this.events;
                    for (loc2 in loc6) 
                    {
                        loc3.removeEventListener(loc2, this.eventHandler);
                    }
                }
            }
            if (arg1 is feathers.binding.Watcher) 
            {
                this.parentObj = arg1.value;
            }
            else 
            {
                this.parentObj = arg1;
            }
            if (this.parentObj) 
            {
                if (this.useRTTI) 
                {
                    this.events = {};
                    if (this.parentObj is starling.events.EventDispatcher || this.parentObj is flash.events.IEventDispatcher) 
                    {
                        loc4 = feathers.binding.utils.DescribeTypeCache.describeType(this.parentObj).bindabilityInfo;
                        this.events = loc4.getChangeEvents(this._propertyName);
                        if (this.objectIsEmpty(this.events)) 
                        {
                            trace("warning: unable to bind to property \'" + this._propertyName + "\' on class \'" + flash.utils.getQualifiedClassName(this.parentObj) + "\'");
                        }
                        else if (this.parentObj is starling.events.EventDispatcher) 
                        {
                            this.addParentStarlingEventListeners();
                        }
                        else if (this.parentObj is flash.events.IEventDispatcher) 
                        {
                            this.addParentNativeEventListeners();
                        }
                    }
                    else 
                    {
                        trace("warning: unable to bind to property \'" + this._propertyName + "\' on class \'" + flash.utils.getQualifiedClassName(this.parentObj) + "\' (class is not an IEventDispatcher)");
                    }
                }
                else if (this.parentObj is starling.events.EventDispatcher) 
                {
                    this.addParentStarlingEventListeners();
                }
                else if (this.parentObj is flash.events.IEventDispatcher) 
                {
                    this.addParentNativeEventListeners();
                }
            }
            wrapUpdate(this.updateProperty);
            return;
        }

        protected override function shallowClone():feathers.binding.Watcher
        {
            var loc1:*=new feathers.binding.PropertyWatcher(this._propertyName, this.events, listeners, this.propertyGetter);
            return loc1;
        }

        internal function addParentStarlingEventListeners():void
        {
            var loc2:*=null;
            var loc1:*=starling.events.EventDispatcher(this.parentObj);
            var loc3:*=0;
            var loc4:*=this.events;
            for (loc2 in loc4) 
            {
                if (loc2 == "__NoChangeEvent__") 
                {
                    continue;
                }
                loc1.addEventListener(loc2, this.eventHandler);
            }
            return;
        }

        internal function addParentNativeEventListeners():void
        {
            var loc2:*=null;
            var loc1:*=flash.events.IEventDispatcher(this.parentObj);
            var loc3:*=0;
            var loc4:*=this.events;
            for (loc2 in loc4) 
            {
                if (loc2 == "__NoChangeEvent__") 
                {
                    continue;
                }
                loc1.addEventListener(loc2, this.eventHandler, false, feathers.binding.utils.BINDING_EVENT_PRIORITY, true);
            }
            return;
        }

        internal function traceInfo():String
        {
            return "Watcher(" + flash.utils.getQualifiedClassName(this.parentObj) + "." + this._propertyName + "): events = [" + this.eventNamesToString() + (this.useRTTI ? "] (RTTI)" : "]");
        }

        internal function eventNamesToString():String
        {
            var loc2:*=null;
            var loc1:*=" ";
            var loc3:*=0;
            var loc4:*=this.events;
            for (loc2 in loc4) 
            {
                loc1 = loc1 + (loc2 + " ");
            }
            return loc1;
        }

        internal function objectIsEmpty(arg1:Object):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3) 
            {
                return false;
            }
            return true;
        }

        internal function updateProperty():void
        {
            if (this.parentObj) 
            {
                if (this._propertyName != "this") 
                {
                    if (this.propertyGetter == null) 
                    {
                        value = this.parentObj[this._propertyName];
                    }
                    else 
                    {
                        value = this.propertyGetter.apply(this.parentObj, [this._propertyName]);
                    }
                }
                else 
                {
                    value = this.parentObj;
                }
            }
            else 
            {
                value = null;
            }
            updateChildren();
            return;
        }

        public function eventHandler(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 is starling.events.Event && arg1.data is feathers.events.PropertyChangeEventData) 
            {
                loc2 = starling.events.Event(arg1);
                loc3 = feathers.events.PropertyChangeEventData(loc2.data).property;
                if (loc3 != this._propertyName) 
                {
                    return;
                }
            }
            else if (arg1 is mx.events.PropertyChangeEvent) 
            {
                loc3 = mx.events.PropertyChangeEvent(arg1).property;
                if (loc3 != this._propertyName) 
                {
                    return;
                }
            }
            wrapUpdate(this.updateProperty);
            var loc1:*=arg1.type as String;
            notifyListeners(this.events[loc1]);
            return;
        }

        internal var parentObj:Object;

        protected var events:Object;

        protected var propertyGetter:Function;

        internal var _propertyName:String;

        internal var useRTTI:Boolean;
    }
}


//  class StaticPropertyWatcher
package feathers.binding 
{
    import feathers.binding.utils.*;
    import feathers.events.*;
    import flash.events.*;
    import mx.events.*;
    import starling.events.*;
    
    public class StaticPropertyWatcher extends feathers.binding.Watcher
    {
        public function StaticPropertyWatcher(arg1:String, arg2:Object, arg3:Array, arg4:Function=null)
        {
            super(arg3);
            this._propertyName = arg1;
            this.events = arg2;
            this.propertyGetter = arg4;
            return;
        }

        public function get propertyName():String
        {
            return this._propertyName;
        }

        public override function updateParent(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.parentObj = Class(arg1);
            var loc1:*=this.parentObj["staticEventDispatcher"];
            if (loc1 != null) 
            {
                var loc5:*=0;
                var loc6:*=this.events;
                for (loc2 in loc6) 
                {
                    if (loc2 == "__NoChangeEvent__") 
                    {
                        continue;
                    }
                    if (loc1 is starling.events.EventDispatcher) 
                    {
                        loc3 = starling.events.EventDispatcher(this.parentObj["staticEventDispatcher"]);
                        loc3.addEventListener(loc2, this.eventHandler);
                        continue;
                    }
                    if (!(loc1 is flash.events.IEventDispatcher)) 
                    {
                        continue;
                    }
                    loc4 = flash.events.IEventDispatcher(this.parentObj["staticEventDispatcher"]);
                    loc4.addEventListener(loc2, this.eventHandler, false, feathers.binding.utils.BINDING_EVENT_PRIORITY, true);
                }
            }
            wrapUpdate(this.updateProperty);
            return;
        }

        protected override function shallowClone():feathers.binding.Watcher
        {
            var loc1:*=new feathers.binding.StaticPropertyWatcher(this._propertyName, this.events, listeners, this.propertyGetter);
            return loc1;
        }

        internal function traceInfo():String
        {
            return "StaticPropertyWatcher(" + this.parentObj + "." + this._propertyName + "): events = [" + this.eventNamesToString() + "]";
        }

        internal function eventNamesToString():String
        {
            var loc2:*=null;
            var loc1:*=" ";
            var loc3:*=0;
            var loc4:*=this.events;
            for (loc2 in loc4) 
            {
                loc1 = loc1 + (loc2 + " ");
            }
            return loc1;
        }

        internal function updateProperty():void
        {
            if (this.parentObj) 
            {
                if (this.propertyGetter == null) 
                {
                    value = this.parentObj[this._propertyName];
                }
                else 
                {
                    value = this.propertyGetter.apply(this.parentObj, [this._propertyName]);
                }
            }
            else 
            {
                value = null;
            }
            updateChildren();
            return;
        }

        public function eventHandler(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 is starling.events.Event && arg1.data is feathers.events.PropertyChangeEventData) 
            {
                loc2 = starling.events.Event(arg1);
                loc3 = feathers.events.PropertyChangeEventData(loc2.data).property;
                if (loc3 != this._propertyName) 
                {
                    return;
                }
            }
            else if (arg1 is mx.events.PropertyChangeEvent) 
            {
                loc3 = mx.events.PropertyChangeEvent(arg1).property;
                if (loc3 != this._propertyName) 
                {
                    return;
                }
            }
            wrapUpdate(this.updateProperty);
            var loc1:*=arg1.type as String;
            notifyListeners(this.events[loc1]);
            return;
        }

        internal var parentObj:Class;

        protected var events:Object;

        internal var propertyGetter:Function;

        internal var _propertyName:String;
    }
}


//  class Watcher
package feathers.binding 
{
    public class Watcher extends Object
    {
        public function Watcher(arg1:Array=null)
        {
            super();
            this.listeners = arg1;
            return;
        }

        public function updateParent(arg1:Object):void
        {
            return;
        }

        public function addChild(arg1:feathers.binding.Watcher):void
        {
            if (this.children) 
            {
                this.children.push(arg1);
            }
            else 
            {
                this.children = [arg1];
            }
            arg1.updateParent(this);
            return;
        }

        public function removeChildren(arg1:int):void
        {
            this.children.splice(arg1);
            return;
        }

        public function updateChildren():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this.children) 
            {
                loc1 = this.children.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    this.children[loc2].updateParent(this);
                    ++loc2;
                }
            }
            return;
        }

        internal function valueChanged(arg1:Object):Boolean
        {
            if (arg1 == null && this.value == null) 
            {
                return false;
            }
            var loc1:*=typeof this.value;
            if (loc1 == "string") 
            {
                if (arg1 == null && this.value == "") 
                {
                    return false;
                }
                return !(arg1 == this.value);
            }
            if (loc1 == "number") 
            {
                if (arg1 == null && this.value == 0) 
                {
                    return false;
                }
                return !(arg1 == this.value);
            }
            if (loc1 == "boolean") 
            {
                if (arg1 == null && this.value == false) 
                {
                    return false;
                }
                return !(arg1 == this.value);
            }
            return true;
        }

        protected function wrapUpdate(arg1:Function):void
        {
            var wrappedFunction:Function;

            var loc1:*;
            wrappedFunction = arg1;
            try 
            {
                wrappedFunction.apply(this);
            }
            catch (error:Error)
            {
                if (error is RangeError) 
                {
                    value = null;
                }
                else if (!(error.errorID == 1006) && !(error.errorID == 1009) && !(error.errorID == 1010) && !(error.errorID == 1055) && !(error.errorID == 1069) && !(error.errorID == 1507)) 
                {
                    throw error;
                }
            }
            return;
        }

        protected function deepClone(arg1:int):feathers.binding.Watcher
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=this.shallowClone();
            loc1.cloneIndex = arg1;
            if (this.listeners) 
            {
                loc1.listeners = this.listeners.concat();
            }
            if (this.children) 
            {
                loc2 = this.children.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc4 = this.children[loc3].deepClone(arg1);
                    loc1.addChild(loc4);
                    ++loc3;
                }
            }
            return loc1;
        }

        protected function shallowClone():feathers.binding.Watcher
        {
            return new feathers.binding.Watcher();
        }

        public function notifyListeners(arg1:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this.listeners) 
            {
                loc1 = this.listeners.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    this.listeners[loc2].watcherFired(arg1, this.cloneIndex);
                    ++loc2;
                }
            }
            return;
        }

        protected var listeners:Array;

        protected var children:Array;

        public var value:Object;

        protected var cloneIndex:int;
    }
}


