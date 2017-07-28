//class Binding
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


