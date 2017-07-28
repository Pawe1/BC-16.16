//class BezierPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import com.greensock.core.*;
    
    public class BezierPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function BezierPlugin()
        {
            _future = {};
            super();
            this.propName = "bezier";
            this.overwriteProps = [];
            return;
        }

        public override function killProps(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=_beziers;
            for (loc1 in loc3) 
            {
                if (!(loc1 in arg1)) 
                {
                    continue;
                }
                delete _beziers[loc1];
            }
            super.killProps(arg1);
            return;
        }

        protected function init(arg1:com.greensock.TweenLite, arg2:Array, arg3:Boolean):void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            _target = arg1.target;
            var loc1:*=arg1.vars.isTV != true ? arg1.vars : arg1.vars.exposedVars;
            if (loc1.orientToBezier != true) 
            {
                if (loc1.orientToBezier is Array) 
                {
                    _orientData = loc1.orientToBezier;
                    _orient = true;
                }
            }
            else 
            {
                _orientData = [["x", "y", "rotation", 0, 0.01]];
                _orient = true;
            }
            var loc2:*={};
            loc3 = 0;
            while (loc3 < arg2.length) 
            {
                var loc6:*=0;
                var loc7:*=arg2[loc3];
                for (loc4 in loc7) 
                {
                    if (loc2[loc4] == undefined) 
                    {
                        loc2[loc4] = [arg1.target[loc4]];
                    }
                    if (typeof arg2[loc3][loc4] == "number") 
                    {
                        loc2[loc4].push(arg2[loc3][loc4]);
                        continue;
                    }
                    loc2[loc4].push(arg1.target[loc4] + Number(arg2[loc3][loc4]));
                }
                ++loc3;
            }
            loc6 = 0;
            loc7 = loc2;
            for (loc4 in loc7) 
            {
                this.overwriteProps[this.overwriteProps.length] = loc4;
                if (loc1[loc4] == undefined) 
                {
                    continue;
                }
                if (typeof loc1[loc4] != "number") 
                {
                    loc2[loc4].push(arg1.target[loc4] + Number(loc1[loc4]));
                }
                else 
                {
                    loc2[loc4].push(loc1[loc4]);
                }
                loc5 = {};
                loc5[loc4] = true;
                arg1.killVars(loc5, false);
                delete loc1[loc4];
            }
            _beziers = parseBeziers(loc2, arg3);
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg2 is Array)) 
            {
                return false;
            }
            init(arg3, arg2 as Array, false);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=NaN;
            var loc7:*=null;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=null;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=false;
            if (arg1 != 1) 
            {
                loc14 = 0;
                loc15 = _beziers;
                for (loc2 in loc15) 
                {
                    loc5 = _beziers[loc2].length;
                    if (arg1 < 0) 
                    {
                        loc1 = 0;
                    }
                    else if (arg1 >= 1) 
                    {
                        --loc1;
                    }
                    else 
                    {
                        loc1 = int(loc5 * arg1);
                    }
                    loc4 = (arg1 - loc1 * 1 / loc5) * loc5;
                    loc3 = _beziers[loc2][loc1];
                    if (this.round) 
                    {
                        loc6 = loc3[0] + loc4 * (2 * (1 - loc4) * (loc3[1] - loc3[0]) + loc4 * (loc3[2] - loc3[0]));
                        _target[loc2] = loc6 > 0 ? int(loc6 + 0.5) : int(loc6 - 0.5);
                        continue;
                    }
                    _target[loc2] = loc3[0] + loc4 * (2 * (1 - loc4) * (loc3[1] - loc3[0]) + loc4 * (loc3[2] - loc3[0]));
                }
            }
            else 
            {
                var loc14:*=0;
                var loc15:*=_beziers;
                for (loc2 in loc15) 
                {
                    loc1 = (_beziers[loc2].length - 1);
                    _target[loc2] = _beziers[loc2][loc1][2];
                }
            }
            if (_orient) 
            {
                loc1 = _orientData.length;
                loc7 = {};
                while (loc1--) 
                {
                    loc10 = _orientData[loc1];
                    loc7[loc10[0]] = _target[loc10[0]];
                    loc7[loc10[1]] = _target[loc10[1]];
                }
                loc12 = _target;
                loc13 = this.round;
                _target = _future;
                this.round = false;
                _orient = false;
                loc1 = _orientData.length;
                while (loc1--) 
                {
                    loc10 = _orientData[loc1];
                    this.changeFactor = arg1 + (loc10[4] || 0.01);
                    loc11 = loc10[3] || 0;
                    loc8 = _future[loc10[0]] - loc7[loc10[0]];
                    loc9 = _future[loc10[1]] - loc7[loc10[1]];
                    loc12[loc10[2]] = Math.atan2(loc9, loc8) * _RAD2DEG + loc11;
                }
                _target = loc12;
                this.round = loc13;
                _orient = true;
            }
            return;
        }

        public static function parseBeziers(arg1:Object, arg2:Boolean=false):Object
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*={};
            if (arg2) 
            {
                var loc6:*=0;
                var loc7:*=arg1;
                for (loc4 in loc7) 
                {
                    loc2 = arg1[loc4];
                    var loc8:*;
                    loc3 = loc8 = [];
                    loc5[loc4] = loc8;
                    if (loc2.length > 2) 
                    {
                        loc3[loc3.length] = [loc2[0], loc2[1] - (loc2[2] - loc2[0]) / 4, loc2[1]];
                        loc1 = 1;
                        while (loc1 < (loc2.length - 1)) 
                        {
                            loc3[loc3.length] = [loc2[loc1], loc2[loc1] + (loc2[loc1] - loc3[(loc1 - 1)][1]), loc2[loc1 + 1]];
                            ++loc1;
                        }
                        continue;
                    }
                    loc3[loc3.length] = [loc2[0], (loc2[0] + loc2[1]) / 2, loc2[1]];
                }
            }
            else 
            {
                loc6 = 0;
                loc7 = arg1;
                for (loc4 in loc7) 
                {
                    loc2 = arg1[loc4];
                    loc3 = loc8 = [];
                    loc5[loc4] = loc8;
                    if (loc2.length > 3) 
                    {
                        loc3[loc3.length] = [loc2[0], loc2[1], (loc2[1] + loc2[2]) / 2];
                        loc1 = 2;
                        while (loc1 < loc2.length - 2) 
                        {
                            loc3[loc3.length] = [loc3[loc1 - 2][2], loc2[loc1], (loc2[loc1] + loc2[loc1 + 1]) / 2];
                            ++loc1;
                        }
                        loc3[loc3.length] = [loc3[(loc3.length - 1)][2], loc2[loc2.length - 2], loc2[(loc2.length - 1)]];
                        continue;
                    }
                    if (loc2.length == 3) 
                    {
                        loc3[loc3.length] = [loc2[0], loc2[1], loc2[2]];
                        continue;
                    }
                    if (loc2.length != 2) 
                    {
                        continue;
                    }
                    loc3[loc3.length] = [loc2[0], (loc2[0] + loc2[1]) / 2, loc2[1]];
                }
            }
            return loc5;
        }

        public static const API:Number=1;

        protected static const _RAD2DEG:Number=180 / Math.PI;

        protected var _future:Object;

        protected var _orient:Boolean;

        protected var _orientData:Array;

        protected var _target:Object;

        protected var _beziers:Object;
    }
}


