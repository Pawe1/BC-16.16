//package util
//  const GMT
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

//  const LEVEL_NAMES
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

//  class LogMessageFormatter
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

//  const START_TIME
package org.as3commons.logging.util 
{
    public const START_TIME:Number=new Date().getTime() - flash.utils.getTimer();
}


//  var SWF_SHORT_URL
package org.as3commons.logging.util 
{
    public var SWF_SHORT_URL:String;
}



{
    org.as3commons.logging.util.SWF_SHORT_URL = org.as3commons.logging.util.URL_ERROR;
}

//  var SWF_URL
package org.as3commons.logging.util 
{
    public var SWF_URL:String;
}



{
    org.as3commons.logging.util.SWF_URL = org.as3commons.logging.util.URL_ERROR;
}

//  const URL_ERROR
package org.as3commons.logging.util 
{
    public const URL_ERROR:String="[SWF url not initialized. Please call SWFInfo.init(stage).]";
}


//  function toLogName
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


