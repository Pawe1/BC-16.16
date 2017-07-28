//class OverwriteManager
package com.greensock 
{
    import com.greensock.core.*;
    import flash.errors.*;
    import flash.utils.*;
    
    public class OverwriteManager extends Object
    {
        public function OverwriteManager()
        {
            super();
            return;
        }

        public static function getGlobalPaused(arg1:com.greensock.core.TweenCore):Boolean
        {
            while (arg1) 
            {
                if (arg1.cachedPaused) 
                {
                    return true;
                }
                arg1 = arg1.timeline;
            }
            return false;
        }

        public static function init(arg1:int=2):int
        {
            if (com.greensock.TweenLite.version < 11.1) 
            {
                throw new Error("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
            }
            com.greensock.TweenLite.overwriteManager = com.greensock.OverwriteManager;
            mode = arg1;
            enabled = true;
            return mode;
        }

        public static function manageOverwrites(arg1:com.greensock.TweenLite, arg2:Object, arg3:Array, arg4:uint):Boolean
        {
            var loc1:*=0;
            var loc2:*=false;
            var loc3:*=null;
            var loc9:*=0;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=NaN;
            var loc14:*=null;
            if (arg4 >= 4) 
            {
                loc9 = arg3.length;
                loc1 = 0;
                while (loc1 < loc9) 
                {
                    loc3 = arg3[loc1];
                    if (loc3 == arg1) 
                    {
                        if (arg4 == 5) 
                        {
                            break;
                        }
                    }
                    else if (loc3.setEnabled(false, false)) 
                    {
                        loc2 = true;
                    }
                    ++loc1;
                }
                return loc2;
            }
            var loc4:*=arg1.cachedStartTime + 1e-010;
            var loc5:*=[];
            var loc6:*=[];
            var loc7:*=0;
            var loc8:*=0;
            loc1 = arg3.length;
            while (--loc1 > -1) 
            {
                loc3 = arg3[loc1];
                if (loc3 == arg1 || loc3.gc) 
                {
                    continue;
                }
                if (loc3.timeline != arg1.timeline) 
                {
                    if (!getGlobalPaused(loc3)) 
                    {
                        var loc15:*;
                        loc6[loc15 = loc7++] = loc3;
                    }
                    continue;
                }
                if (!(loc3.cachedStartTime <= loc4 && loc3.cachedStartTime + loc3.totalDuration + 1e-010 > loc4 && !getGlobalPaused(loc3))) 
                {
                    continue;
                }
                loc5[loc15 = loc8++] = loc3;
            }
            if (loc7 != 0) 
            {
                loc10 = arg1.cachedTimeScale;
                loc11 = loc4;
                loc14 = arg1.timeline;
                while (loc14) 
                {
                    loc10 = loc10 * loc14.cachedTimeScale;
                    loc11 = loc11 + loc14.cachedStartTime;
                    loc14 = loc14.timeline;
                }
                loc4 = loc10 * loc11;
                loc1 = loc7;
                while (--loc1 > -1) 
                {
                    loc12 = loc6[loc1];
                    loc10 = loc12.cachedTimeScale;
                    loc11 = loc12.cachedStartTime;
                    loc14 = loc12.timeline;
                    while (loc14) 
                    {
                        loc10 = loc10 * loc14.cachedTimeScale;
                        loc11 = loc11 + loc14.cachedStartTime;
                        loc14 = loc14.timeline;
                    }
                    loc13 = loc10 * loc11;
                    if (!(loc13 <= loc4 && (loc13 + loc12.totalDuration * loc10 + 1e-010 > loc4 || loc12.cachedDuration == 0))) 
                    {
                        continue;
                    }
                    loc5[loc15 = loc8++] = loc12;
                }
            }
            if (loc8 == 0) 
            {
                return loc2;
            }
            loc1 = loc8;
            if (arg4 != 2) 
            {
                while (--loc1 > -1) 
                {
                    if (!com.greensock.TweenLite(loc5[loc1]).setEnabled(false, false)) 
                    {
                        continue;
                    }
                    loc2 = true;
                }
            }
            else 
            {
                while (--loc1 > -1) 
                {
                    loc3 = loc5[loc1];
                    if (loc3.killVars(arg2)) 
                    {
                        loc2 = true;
                    }
                    if (!(loc3.cachedPT1 == null && loc3.initted)) 
                    {
                        continue;
                    }
                    loc3.setEnabled(false, false);
                }
            }
            return loc2;
        }

        public static const ALL_ONSTART:int=4;

        public static const CONCURRENT:int=3;

        public static const ALL_IMMEDIATE:int=1;

        public static const PREEXISTING:int=5;

        public static const AUTO:int=2;

        public static const version:Number=6.02;

        public static const NONE:int=0;

        public static var enabled:Boolean;

        public static var mode:int;
    }
}


