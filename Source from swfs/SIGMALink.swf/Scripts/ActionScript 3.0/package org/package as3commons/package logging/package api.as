//package api
//  class ILogSetup
package org.as3commons.logging.api 
{
    public interface ILogSetup
    {
        function applyTo(arg1:org.as3commons.logging.api.Logger):void;
    }
}


//  class ILogger
package org.as3commons.logging.api 
{
    public interface ILogger
    {
        function get name():String;

        function get shortName():String;

        function get person():String;

        function debug(arg1:*, arg2:Array=null):void;

        function info(arg1:*, arg2:Array=null):void;

        function warn(arg1:*, arg2:Array=null):void;

        function error(arg1:*, arg2:Array=null):void;

        function fatal(arg1:*, arg2:Array=null):void;

        function get debugEnabled():Boolean;

        function get infoEnabled():Boolean;

        function get warnEnabled():Boolean;

        function get errorEnabled():Boolean;

        function get fatalEnabled():Boolean;
    }
}


//  const LOGGER_FACTORY
package org.as3commons.logging.api 
{
    public const LOGGER_FACTORY:org.as3commons.logging.api.LoggerFactory=new org.as3commons.logging.api.LoggerFactory();
}


//  class Logger
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


//  class LoggerFactory
package org.as3commons.logging.api 
{
    public class LoggerFactory extends Object
    {
        public function LoggerFactory(arg1:org.as3commons.logging.api.ILogSetup=null)
        {
            super();
            this.setup = arg1;
            return;
        }

        public function get setup():org.as3commons.logging.api.ILogSetup
        {
            return this._setup;
        }

        public function set setup(arg1:org.as3commons.logging.api.ILogSetup):void
        {
            var loc2:*=0;
            this._setup = arg1;
            var loc1:*=this._allLoggers.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                org.as3commons.logging.api.Logger(this._allLoggers[loc2]).allTargets = null;
                ++loc2;
            }
            if (arg1) 
            {
                loc2 = 0;
                this._duringSetup = true;
                while (loc2 < loc1) 
                {
                    while (loc2 < loc1) 
                    {
                        arg1.applyTo(org.as3commons.logging.api.Logger(this._allLoggers[loc2]));
                        ++loc2;
                    }
                    loc1 = this._allLoggers.length;
                }
                this._duringSetup = false;
            }
            return;
        }

        public function getNamedLogger(arg1:String=null, arg2:String=null):org.as3commons.logging.api.ILogger
        {
            arg1 = arg1 || "";
            var loc3:*;
            this._loggers[arg1] = loc3 = this._loggers[arg1] || {};
            var loc1:*=loc3;
            var loc2:*=loc1[arg2];
            if (!loc2) 
            {
                loc2 = new org.as3commons.logging.api.Logger(arg1, arg2);
                loc1[arg2] = loc2;
                this._allLoggers[this._allLoggers.length] = loc2;
                if (this._setup && !this._duringSetup) 
                {
                    this._setup.applyTo(loc2);
                }
            }
            return loc2;
        }

        internal const _allLoggers:Array=[];

        internal const _loggers:Object={};

        internal var _setup:org.as3commons.logging.api.ILogSetup;

        internal var _duringSetup:Boolean;
    }
}


//  function getLogger
package org.as3commons.logging.api 
{
    import org.as3commons.logging.util.*;
    
    public function getLogger(arg1:*=null, arg2:String=null):org.as3commons.logging.api.ILogger
    {
        if (arg1 && !(arg1 is String)) 
        {
            arg1 = org.as3commons.logging.util.toLogName(arg1);
        }
        return org.as3commons.logging.api.LOGGER_FACTORY.getNamedLogger(arg1, arg2);
    }
}


