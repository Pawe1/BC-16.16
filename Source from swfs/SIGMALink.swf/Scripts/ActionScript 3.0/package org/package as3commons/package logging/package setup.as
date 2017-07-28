//package setup
//  package target
//    class IFormattingLogTarget
package org.as3commons.logging.setup.target 
{
    import org.as3commons.logging.setup.*;
    
    public interface IFormattingLogTarget extends org.as3commons.logging.setup.ILogTarget
    {
        function set format(arg1:String):void;
    }
}


//    class TraceTarget
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


//  class ILogTarget
package org.as3commons.logging.setup 
{
    public interface ILogTarget
    {
        function log(arg1:String, arg2:String, arg3:int, arg4:Number, arg5:*, arg6:Array, arg7:String):void;
    }
}


//  class LevelTargetSetup
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


//  class LogSetupLevel
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


