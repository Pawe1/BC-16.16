//package as3commons
//  package logging
//    package api
//      class ILogSetup
package org.as3commons.logging.api 
{
    public interface ILogSetup
    {
        function applyTo(arg1:org.as3commons.logging.api.Logger):void;
    }
}


//      class ILogger
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


//      const LOGGER_FACTORY
package org.as3commons.logging.api 
{
    public const LOGGER_FACTORY:org.as3commons.logging.api.LoggerFactory=new org.as3commons.logging.api.LoggerFactory();
}


//      class Logger
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


//      class LoggerFactory
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


//      function getLogger
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


//    package level
//      const DEBUG
package org.as3commons.logging.level 
{
    public const DEBUG:int=32;
}


//      const ERROR
package org.as3commons.logging.level 
{
    public const ERROR:int=4;
}


//      const FATAL
package org.as3commons.logging.level 
{
    public const FATAL:int=2;
}


//      const INFO
package org.as3commons.logging.level 
{
    public const INFO:int=16;
}


//      const WARN
package org.as3commons.logging.level 
{
    public const WARN:int=8;
}


//    package setup
//      package target
//        class IFormattingLogTarget
package org.as3commons.logging.setup.target 
{
    import org.as3commons.logging.setup.*;
    
    public interface IFormattingLogTarget extends org.as3commons.logging.setup.ILogTarget
    {
        function set format(arg1:String):void;
    }
}


//        class TraceTarget
package org.as3commons.logging.setup.target 
{
    import org.as3commons.logging.util.*;
    
    public final class TraceTarget extends Object implements org.as3commons.logging.setup.target.IFormattingLogTarget
    {
        public function TraceTarget(arg1:String=null)
        {
            super();
            this.format = arg1;
            return;
        }

        public function set format(arg1:String):void
        {
            this._formatter = new org.as3commons.logging.util.LogMessageFormatter(arg1 || DEFAULT_FORMAT);
            return;
        }

        public function log(arg1:String, arg2:String, arg3:int, arg4:Number, arg5:*, arg6:Array, arg7:String):void
        {
            trace(this._formatter.format(arg1, arg2, arg3, arg4, arg5, arg6, arg7));
            return;
        }

        public static const DEFAULT_FORMAT:String="{time} {logLevel} - {shortName}{atPerson} - {message}";

        internal var _formatter:org.as3commons.logging.util.LogMessageFormatter;
    }
}


//      class ILogTarget
package org.as3commons.logging.setup 
{
    public interface ILogTarget
    {
        function log(arg1:String, arg2:String, arg3:int, arg4:Number, arg5:*, arg6:Array, arg7:String):void;
    }
}


//      class LevelTargetSetup
package org.as3commons.logging.setup 
{
    import org.as3commons.logging.api.*;
    
    public class LevelTargetSetup extends Object implements org.as3commons.logging.api.ILogSetup
    {
        public function LevelTargetSetup(arg1:org.as3commons.logging.setup.ILogTarget, arg2:org.as3commons.logging.setup.LogSetupLevel)
        {
            super();
            this._target = arg1;
            this._level = arg2;
            return;
        }

        public function applyTo(arg1:org.as3commons.logging.api.Logger):void
        {
            this._level.applyTo(arg1, this._target);
            return;
        }

        internal var _level:org.as3commons.logging.setup.LogSetupLevel;

        internal var _target:org.as3commons.logging.setup.ILogTarget;
    }
}


//      class LogSetupLevel
package org.as3commons.logging.setup 
{
    import org.as3commons.logging.api.*;
    
    public final class LogSetupLevel extends Object
    {
        public function LogSetupLevel(arg1:int)
        {
            super();
            if (_levels[arg1]) 
            {
                throw Error("LogTargetLevel exists already!");
            }
            _levels[arg1] = this;
            this._value = arg1;
            return;
        }

        public function applyTo(arg1:org.as3commons.logging.api.Logger, arg2:org.as3commons.logging.setup.ILogTarget):void
        {
            if (this._value & DEBUG_ONLY._value) 
            {
                arg1.debugTarget = arg2;
            }
            if (this._value & INFO_ONLY._value) 
            {
                arg1.infoTarget = arg2;
            }
            if (this._value & WARN_ONLY._value) 
            {
                arg1.warnTarget = arg2;
            }
            if (this._value & ERROR_ONLY._value) 
            {
                arg1.errorTarget = arg2;
            }
            if (this._value & FATAL_ONLY._value) 
            {
                arg1.fatalTarget = arg2;
            }
            return;
        }

        public function or(arg1:org.as3commons.logging.setup.LogSetupLevel):org.as3commons.logging.setup.LogSetupLevel
        {
            return getLevelByValue(this._value | arg1._value);
        }

        public function valueOf():int
        {
            return this._value;
        }

        public static function getLevelByValue(arg1:int):org.as3commons.logging.setup.LogSetupLevel
        {
            if (!_levels[arg1]) 
            {
                _levels[arg1];
                var loc1:*;
                _levels[arg1] = loc1 = new LogSetupLevel(arg1);
            }
            return _levels[arg1];
        }

        internal static const _levels:Array=[];

        public static const NONE:org.as3commons.logging.setup.LogSetupLevel=getLevelByValue(1);

        public static const FATAL_ONLY:org.as3commons.logging.setup.LogSetupLevel=getLevelByValue(2);

        public static const FATAL:org.as3commons.logging.setup.LogSetupLevel=NONE.or(FATAL_ONLY);

        public static const ERROR_ONLY:org.as3commons.logging.setup.LogSetupLevel=getLevelByValue(4);

        public static const ERROR:org.as3commons.logging.setup.LogSetupLevel=FATAL.or(ERROR_ONLY);

        public static const WARN_ONLY:org.as3commons.logging.setup.LogSetupLevel=getLevelByValue(8);

        public static const WARN:org.as3commons.logging.setup.LogSetupLevel=ERROR.or(WARN_ONLY);

        public static const INFO_ONLY:org.as3commons.logging.setup.LogSetupLevel=getLevelByValue(16);

        public static const INFO:org.as3commons.logging.setup.LogSetupLevel=WARN.or(INFO_ONLY);

        public static const DEBUG_ONLY:org.as3commons.logging.setup.LogSetupLevel=getLevelByValue(32);

        public static const DEBUG:org.as3commons.logging.setup.LogSetupLevel=INFO.or(DEBUG_ONLY);

        public static const ALL:org.as3commons.logging.setup.LogSetupLevel=DEBUG;

        internal var _value:int;
    }
}


//    package util
//      const GMT
package org.as3commons.logging.util 
{
    public const GMT:String=calculateGMT();
}


const calculateGMT:Function=function ():String
{
    var loc4:*=null;
    var loc1:*=new Date();
    var loc2:*=loc1.timezoneOffset;
    var loc3:*=loc2 / 60;
    if (loc2 <= 0) 
    {
        var loc5:*;
        loc4 = loc5 = "+";
        loc5;
        loc2 = loc5 = loc2 * -1;
        loc5;
        loc3 = loc5 = loc3 * -1;
        loc5;
    }
    else 
    {
        loc4 = loc5 = "-";
        loc5;
    }
    loc3 = loc5 = Math.floor(loc3);
    loc5;
    loc2 = loc5 = loc2 - loc3 * 60;
    loc5;
    return "GMT" + loc4 + (loc3 < 10 ? "0" + loc3 : loc3) + (loc2 < 10 ? "0" + loc2 : loc2);
}

//      const LEVEL_NAMES
package org.as3commons.logging.util 
{
    public const LEVEL_NAMES:Object={};
}

import org.as3commons.logging.level.*;



{
    org.as3commons.logging.util.LEVEL_NAMES[org.as3commons.logging.level.DEBUG] = "DEBUG";
    org.as3commons.logging.util.LEVEL_NAMES[org.as3commons.logging.level.FATAL] = "FATAL";
    org.as3commons.logging.util.LEVEL_NAMES[org.as3commons.logging.level.ERROR] = "ERROR";
    org.as3commons.logging.util.LEVEL_NAMES[org.as3commons.logging.level.INFO] = "INFO";
    var loc2:*;
    org.as3commons.logging.util.LEVEL_NAMES[org.as3commons.logging.level.WARN] = loc2 = "WARN";
    var loc1:*=loc2;
    loc1;
}

//      class LogMessageFormatter
package org.as3commons.logging.util 
{
    public final class LogMessageFormatter extends Object
    {
        public function LogMessageFormatter(arg1:String)
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=null;
            super();
            var loc1:*=0;
            for (;;) 
            {
                loc2 = loc8 = this._braceRegexp.exec(arg1);
                if (!loc8) 
                {
                    break;
                }
                var loc8:*;
                loc6 = loc8 = this.TYPES[loc2["field"]];
                if (!loc8) 
                {
                    continue;
                }
                if (loc1 != loc2["index"]) 
                {
                    loc5 = arg1.substring(loc1, loc2["index"]);
                    loc4 = new FormatNode();
                    loc4.type = this.STATIC_TYPE;
                    loc4.content = loc5;
                    if (loc3) 
                    {
                        loc3.next = loc4;
                    }
                    else 
                    {
                        this._firstNode = loc4;
                    }
                    loc3 = loc4;
                }
                loc7 = new FormatNode();
                loc7.type = loc6;
                if (loc6 == this.MESSAGE_TYPE || loc6 == this.MESSAGE_DQT_TYPE) 
                {
                    this._hasMessageNode = true;
                }
                else if (loc6 == this.TIME_TYPE || loc6 == this.TIME_UTC_TYPE || loc6 == this.DATE_TYPE || loc6 == this.DATE_UTC_TYPE || loc6 == this.LOG_TIME_TYPE) 
                {
                    this._hasTimeNode = true;
                }
                loc1 = loc2["index"] + loc2[0]["length"];
                if (loc3) 
                {
                    loc3.next = loc7;
                }
                else 
                {
                    this._firstNode = loc7;
                }
                loc3 = loc7;
            }
            if (loc1 != arg1.length) 
            {
                loc5 = arg1.substring(loc1);
                loc4 = new FormatNode();
                loc4.type = this.STATIC_TYPE;
                loc4.content = loc5;
                if (loc3) 
                {
                    loc3.next = loc4;
                }
                else 
                {
                    this._firstNode = loc4;
                }
            }
            return;
        }

        public function format(arg1:String, arg2:String, arg3:int, arg4:Number, arg5:String, arg6:Array, arg7:String):String
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=undefined;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc1:*="";
            var loc2:*=this._firstNode;
            if (this._hasMessageNode && arg5 && arg6) 
            {
                loc3 = arg6.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc5 = arg6[loc4];
                    arg5 = arg5.split("{" + loc4 + "}").join(loc5);
                    ++loc4;
                }
            }
            if (this._hasTimeNode) 
            {
                this._now.time = isNaN(arg4) ? 0 : org.as3commons.logging.util.START_TIME + arg4;
            }
            while (loc2) 
            {
                loc6 = loc2.type;
                if (loc6 < 7) 
                {
                    if (loc6 < 4) 
                    {
                        if (loc6 != this.STATIC_TYPE) 
                        {
                            if (loc6 != this.MESSAGE_TYPE) 
                            {
                                if (arg5) 
                                {
                                    loc1 = loc1 + arg5.split("\"").join("\\\"").split("\n").join("\\n");
                                }
                                else 
                                {
                                    loc1 = loc1 + arg5;
                                }
                            }
                            else 
                            {
                                loc1 = loc1 + arg5;
                            }
                        }
                        else 
                        {
                            loc1 = loc1 + loc2.content;
                        }
                    }
                    else if (loc6 != this.TIME_TYPE) 
                    {
                        if (loc6 != this.TIME_UTC_TYPE) 
                        {
                            loc7 = this._now.hoursUTC.toString();
                            if (loc7.length == 1) 
                            {
                                loc7 = "0" + loc7;
                            }
                            loc8 = this._now.minutesUTC.toString();
                            if (loc8.length == 1) 
                            {
                                loc8 = "0" + loc8;
                            }
                            loc9 = this._now.secondsUTC.toString();
                            if (loc9.length == 1) 
                            {
                                loc9 = "0" + loc9;
                            }
                            loc10 = this._now.millisecondsUTC.toString();
                            if (loc10.length != 1) 
                            {
                                if (loc10.length == 2) 
                                {
                                    loc10 = "0" + loc10;
                                }
                            }
                            else 
                            {
                                loc10 = "00" + loc10;
                            }
                            loc1 = loc1 + (loc7 + ":" + loc8 + ":" + loc9 + "." + loc10);
                        }
                        else 
                        {
                            loc1 = loc1 + (this._now.hoursUTC + ":" + this._now.minutesUTC + ":" + this._now.secondsUTC + "." + this._now.millisecondsUTC);
                        }
                    }
                    else 
                    {
                        loc1 = loc1 + (this._now.hours + ":" + this._now.minutes + ":" + this._now.seconds + "." + this._now.milliseconds);
                    }
                }
                else if (loc6 < 13) 
                {
                    if (loc6 < 10) 
                    {
                        if (loc6 != this.DATE_TYPE) 
                        {
                            if (loc6 != this.DATE_UTC_TYPE) 
                            {
                                if (arg3) 
                                {
                                    loc1 = loc1 + (org.as3commons.logging.util.LEVEL_NAMES[arg3] || "FATAL");
                                }
                            }
                            else 
                            {
                                loc1 = loc1 + (this._now.fullYearUTC + "/" + (this._now.monthUTC + 1) + "/" + this._now.dateUTC);
                            }
                        }
                        else 
                        {
                            loc1 = loc1 + (this._now.fullYear + "/" + (this._now.month + 1) + "/" + this._now.date);
                        }
                    }
                    else if (loc6 != this.SWF_TYPE) 
                    {
                        if (loc6 != this.SHORT_SWF_TYPE) 
                        {
                            loc1 = loc1 + arg1;
                        }
                        else 
                        {
                            loc1 = loc1 + org.as3commons.logging.util.SWF_SHORT_URL;
                        }
                    }
                    else 
                    {
                        loc1 = loc1 + org.as3commons.logging.util.SWF_URL;
                    }
                }
                else if (loc6 != this.SHORT_NAME_TYPE) 
                {
                    if (loc6 != this.GMT_OFFSET_TYPE) 
                    {
                        if (loc6 != this.PERSON_TYPE) 
                        {
                            if (arg7) 
                            {
                                loc1 = loc1 + ("@" + arg7);
                            }
                        }
                        else if (arg7) 
                        {
                            loc1 = loc1 + arg7;
                        }
                    }
                    else 
                    {
                        loc1 = loc1 + org.as3commons.logging.util.GMT;
                    }
                }
                else 
                {
                    loc1 = loc1 + arg2;
                }
                loc2 = loc2.next;
            }
            return loc1;
        }

        internal const STATIC_TYPE:int=1;

        internal const MESSAGE_TYPE:int=2;

        internal const MESSAGE_DQT_TYPE:int=3;

        internal const TIME_TYPE:int=4;

        internal const TIME_UTC_TYPE:int=5;

        internal const LOG_TIME_TYPE:int=6;

        internal const DATE_TYPE:int=7;

        internal const DATE_UTC_TYPE:int=8;

        internal const LOG_LEVEL_TYPE:int=9;

        internal const SWF_TYPE:int=10;

        internal const SHORT_SWF_TYPE:int=11;

        internal const NAME_TYPE:int=12;

        internal const SHORT_NAME_TYPE:int=13;

        internal const GMT_OFFSET_TYPE:int=14;

        internal const PERSON_TYPE:int=15;

        internal const AT_PERSON_TYPE:int=16;

        internal const TYPES:Object={"message":this.MESSAGE_TYPE, "message_dqt":this.MESSAGE_DQT_TYPE, "time":this.TIME_TYPE, "timeUTC":this.TIME_UTC_TYPE, "logTime":this.LOG_TIME_TYPE, "date":this.DATE_TYPE, "dateUTC":this.DATE_UTC_TYPE, "logLevel":this.LOG_LEVEL_TYPE, "swf":this.SWF_TYPE, "shortSWF":this.SHORT_SWF_TYPE, "name":this.NAME_TYPE, "shortName":this.SHORT_NAME_TYPE, "gmt":this.GMT_OFFSET_TYPE, "person":this.PERSON_TYPE, "atPerson":this.AT_PERSON_TYPE};

        internal const _now:Date=new Date();

        internal const _braceRegexp:RegExp=new RegExp("{(?P<field>[a-zA-Z_]+)}", "g");

        internal var _firstNode:FormatNode;

        internal var _hasMessageNode:Boolean=false;

        internal var _hasTimeNode:Boolean=false;
    }
}


final class FormatNode extends Object
{
    public function FormatNode()
    {
        super();
        return;
    }

    public var next:FormatNode;

    public var content:String;

    public var param:int;

    public var type:int;
}

//      const START_TIME
package org.as3commons.logging.util 
{
    public const START_TIME:Number=new Date().getTime() - flash.utils.getTimer();
}


//      var SWF_SHORT_URL
package org.as3commons.logging.util 
{
    public var SWF_SHORT_URL:String;
}



{
    org.as3commons.logging.util.SWF_SHORT_URL = org.as3commons.logging.util.URL_ERROR;
}

//      var SWF_URL
package org.as3commons.logging.util 
{
    public var SWF_URL:String;
}



{
    org.as3commons.logging.util.SWF_URL = org.as3commons.logging.util.URL_ERROR;
}

//      const URL_ERROR
package org.as3commons.logging.util 
{
    public const URL_ERROR:String="[SWF url not initialized. Please call SWFInfo.init(stage).]";
}


//      function toLogName
package org.as3commons.logging.util 
{
    import flash.utils.*;
    
    public function toLogName(arg1:*=null):String
    {
        if (arg1 == null) 
        {
            return arg1;
        }
        return flash.utils.getQualifiedClassName(arg1).replace("::", ".");
    }
}


