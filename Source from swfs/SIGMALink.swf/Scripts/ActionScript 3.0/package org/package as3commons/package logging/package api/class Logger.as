//class Logger
package org.as3commons.logging.api 
{
    import flash.utils.*;
    import org.as3commons.logging.setup.*;
    
    public final class Logger extends Object implements org.as3commons.logging.api.ILogger
    {
        public function Logger(arg1:String, arg2:String=null)
        {
            super();
            this._name = arg1;
            var loc1:*;
            this._shortName = loc1 = this._name.substr(this._name.lastIndexOf(".") + 1);
            this._shortName = loc1;
            this._person = arg2;
            return;
        }

        public function debug(arg1:*, arg2:Array=null):void
        {
            if (this.debugTarget) 
            {
                this.debugTarget.log(this._name, this._shortName, 32, flash.utils.getTimer(), arg1, arg2, this._person);
            }
            return;
        }

        public function info(arg1:*, arg2:Array=null):void
        {
            if (this.infoTarget) 
            {
                this.infoTarget.log(this._name, this._shortName, 16, flash.utils.getTimer(), arg1, arg2, this._person);
            }
            return;
        }

        public function warn(arg1:*, arg2:Array=null):void
        {
            if (this.warnTarget) 
            {
                this.warnTarget.log(this._name, this._shortName, 8, flash.utils.getTimer(), arg1, arg2, this._person);
            }
            return;
        }

        public function error(arg1:*, arg2:Array=null):void
        {
            if (this.errorTarget) 
            {
                this.errorTarget.log(this._name, this._shortName, 4, flash.utils.getTimer(), arg1, arg2, this._person);
            }
            return;
        }

        public function fatal(arg1:*, arg2:Array=null):void
        {
            if (this.fatalTarget) 
            {
                this.fatalTarget.log(this._name, this._shortName, 2, flash.utils.getTimer(), arg1, arg2, this._person);
            }
            return;
        }

        public function get debugEnabled():Boolean
        {
            return !(this.debugTarget == null);
        }

        public function get infoEnabled():Boolean
        {
            return !(this.infoTarget == null);
        }

        public function get warnEnabled():Boolean
        {
            return !(this.warnTarget == null);
        }

        public function get errorEnabled():Boolean
        {
            return !(this.errorTarget == null);
        }

        public function get fatalEnabled():Boolean
        {
            return !(this.fatalTarget == null);
        }

        public function get name():String
        {
            return this._name;
        }

        public function get shortName():String
        {
            return this._shortName;
        }

        public function get person():String
        {
            return this._person;
        }

        public function set allTargets(arg1:org.as3commons.logging.setup.ILogTarget):void
        {
            var loc1:*;
            this.fatalTarget = loc1 = arg1;
            this.errorTarget = loc1 = loc1;
            this.warnTarget = loc1 = loc1;
            this.infoTarget = loc1 = loc1;
            this.debugTarget = loc1;
            return;
        }

        public function toString():String
        {
            return "[Logger name=\'" + this._name + (this._person ? "@" + this._person : "") + "\']";
        }

        public var debugTarget:org.as3commons.logging.setup.ILogTarget;

        public var infoTarget:org.as3commons.logging.setup.ILogTarget;

        public var warnTarget:org.as3commons.logging.setup.ILogTarget;

        public var errorTarget:org.as3commons.logging.setup.ILogTarget;

        public var fatalTarget:org.as3commons.logging.setup.ILogTarget;

        internal var _name:String;

        internal var _shortName:String;

        internal var _person:String;
    }
}


