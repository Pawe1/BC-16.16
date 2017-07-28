//package target
//  class IFormattingLogTarget
package org.as3commons.logging.setup.target 
{
    import org.as3commons.logging.setup.*;
    
    public interface IFormattingLogTarget extends org.as3commons.logging.setup.ILogTarget
    {
        function set format(arg1:String):void;
    }
}


//  class TraceTarget
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


