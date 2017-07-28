//package plugins
//  class AutoAlphaPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class AutoAlphaPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function AutoAlphaPlugin()
        {
            super();
            this.propName = "autoAlpha";
            this.overwriteProps = ["alpha", "visible"];
            return;
        }

        public override function killProps(arg1:Object):void
        {
            super.killProps(arg1);
            _ignoreVisible = Boolean("visible" in arg1);
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            addTween(arg1, "alpha", arg1.alpha, arg2, "alpha");
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            updateTweens(arg1);
            if (!_ignoreVisible) 
            {
                _target.visible = Boolean(!(_target.alpha == 0));
            }
            return;
        }

        public static const API:Number=1;

        protected var _target:Object;

        protected var _ignoreVisible:Boolean;
    }
}


//  class BevelFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class BevelFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function BevelFilterPlugin()
        {
            super();
            this.propName = "bevelFilter";
            this.overwriteProps = ["bevelFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.BevelFilter;
            initFilter(arg2, new flash.filters.BevelFilter(0, 0, 16777215, 0.5, 0, 0.5, 2, 2, 0, arg2.quality || 2), _propNames);
            return true;
        }

        
        {
            _propNames = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


//  class BezierPlugin
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


//  class BezierThroughPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    
    public class BezierThroughPlugin extends com.greensock.plugins.BezierPlugin
    {
        public function BezierThroughPlugin()
        {
            super();
            this.propName = "bezierThrough";
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg2 is Array)) 
            {
                return false;
            }
            init(arg3, arg2 as Array, true);
            return true;
        }

        public static const API:Number=1;
    }
}


//  class BlurFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class BlurFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function BlurFilterPlugin()
        {
            super();
            this.propName = "blurFilter";
            this.overwriteProps = ["blurFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.BlurFilter;
            initFilter(arg2, new flash.filters.BlurFilter(0, 0, arg2.quality || 2), _propNames);
            return true;
        }

        
        {
            _propNames = ["blurX", "blurY", "quality"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


//  class ColorMatrixFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class ColorMatrixFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function ColorMatrixFilterPlugin()
        {
            super();
            this.propName = "colorMatrixFilter";
            this.overwriteProps = ["colorMatrixFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.ColorMatrixFilter;
            var loc1:*=arg2;
            initFilter({"remove":arg2.remove, "index":arg2.index, "addFilter":arg2.addFilter}, new flash.filters.ColorMatrixFilter(_idMatrix.slice()), _propNames);
            _matrix = flash.filters.ColorMatrixFilter(_filter).matrix;
            var loc2:*=[];
            if (!(loc1.matrix == null) && loc1.matrix is Array) 
            {
                loc2 = loc1.matrix;
            }
            else 
            {
                if (loc1.relative != true) 
                {
                    loc2 = _idMatrix.slice();
                }
                else 
                {
                    loc2 = _matrix.slice();
                }
                loc2 = setBrightness(loc2, loc1.brightness);
                loc2 = setContrast(loc2, loc1.contrast);
                loc2 = setHue(loc2, loc1.hue);
                loc2 = setSaturation(loc2, loc1.saturation);
                loc2 = setThreshold(loc2, loc1.threshold);
                if (!isNaN(loc1.colorize)) 
                {
                    loc2 = colorize(loc2, loc1.colorize, loc1.amount);
                }
            }
            _matrixTween = new com.greensock.plugins.EndArrayPlugin();
            _matrixTween.init(_matrix, loc2);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            _matrixTween.changeFactor = arg1;
            flash.filters.ColorMatrixFilter(_filter).matrix = _matrix;
            super.changeFactor = arg1;
            return;
        }

        public static function setSaturation(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            var loc1:*=1 - arg2;
            var loc2:*=loc1 * _lumR;
            var loc3:*=loc1 * _lumG;
            var loc4:*=loc1 * _lumB;
            var loc5:*=[loc2 + arg2, loc3, loc4, 0, 0, loc2, loc3 + arg2, loc4, 0, 0, loc2, loc3, loc4 + arg2, 0, 0, 0, 0, 0, 1, 0];
            return applyMatrix(loc5, arg1);
        }

        public static function setHue(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            arg2 = arg2 * Math.PI / 180;
            var loc1:*=Math.cos(arg2);
            var loc2:*=Math.sin(arg2);
            var loc3:*=[_lumR + loc1 * (1 - _lumR) + loc2 * (-_lumR), _lumG + loc1 * (-_lumG) + loc2 * (-_lumG), _lumB + loc1 * (-_lumB) + loc2 * (1 - _lumB), 0, 0, _lumR + loc1 * (-_lumR) + loc2 * 0.143, _lumG + loc1 * (1 - _lumG) + loc2 * 0.14, _lumB + loc1 * (-_lumB) + loc2 * -0.283, 0, 0, _lumR + loc1 * (-_lumR) + loc2 * (-(1 - _lumR)), _lumG + loc1 * (-_lumG) + loc2 * _lumG, _lumB + loc1 * (1 - _lumB) + loc2 * _lumB, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            return applyMatrix(loc3, arg1);
        }

        public static function setContrast(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            arg2 = arg2 + 0.01;
            var loc1:*=[arg2, 0, 0, 0, 128 * (1 - arg2), 0, arg2, 0, 0, 128 * (1 - arg2), 0, 0, arg2, 0, 128 * (1 - arg2), 0, 0, 0, 1, 0];
            return applyMatrix(loc1, arg1);
        }

        public static function applyMatrix(arg1:Array, arg2:Array):Array
        {
            var loc4:*=0;
            var loc5:*=0;
            if (!(arg1 is Array) || !(arg2 is Array)) 
            {
                return arg2;
            }
            var loc1:*=[];
            var loc2:*=0;
            var loc3:*=0;
            loc4 = 0;
            while (loc4 < 4) 
            {
                loc5 = 0;
                while (loc5 < 5) 
                {
                    if (loc5 != 4) 
                    {
                        loc3 = 0;
                    }
                    else 
                    {
                        loc3 = arg1[loc2 + 4];
                    }
                    loc1[loc2 + loc5] = arg1[loc2] * arg2[loc5] + arg1[loc2 + 1] * arg2[loc5 + 5] + arg1[loc2 + 2] * arg2[loc5 + 10] + arg1[loc2 + 3] * arg2[loc5 + 15] + loc3;
                    ++loc5;
                }
                loc2 = loc2 + 5;
                ++loc4;
            }
            return loc1;
        }

        public static function setThreshold(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            var loc1:*=[_lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * arg2, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * arg2, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * arg2, 0, 0, 0, 1, 0];
            return applyMatrix(loc1, arg1);
        }

        public static function colorize(arg1:Array, arg2:Number, arg3:Number=1):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            if (isNaN(arg3)) 
            {
                arg3 = 1;
            }
            var loc1:*=(arg2 >> 16 & 255) / 255;
            var loc2:*=(arg2 >> 8 & 255) / 255;
            var loc3:*=(arg2 & 255) / 255;
            var loc4:*=1 - arg3;
            var loc5:*=[loc4 + arg3 * loc1 * _lumR, arg3 * loc1 * _lumG, arg3 * loc1 * _lumB, 0, 0, arg3 * loc2 * _lumR, loc4 + arg3 * loc2 * _lumG, arg3 * loc2 * _lumB, 0, 0, arg3 * loc3 * _lumR, arg3 * loc3 * _lumG, loc4 + arg3 * loc3 * _lumB, 0, 0, 0, 0, 0, 1, 0];
            return applyMatrix(loc5, arg1);
        }

        public static function setBrightness(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            arg2 = arg2 * 100 - 100;
            return applyMatrix([1, 0, 0, 0, arg2, 0, 1, 0, 0, arg2, 0, 0, 1, 0, arg2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], arg1);
        }

        
        {
            _propNames = [];
            _idMatrix = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
            _lumR = 0.212671;
            _lumG = 0.71516;
            _lumB = 0.072169;
        }

        public static const API:Number=1;

        protected var _matrix:Array;

        protected var _matrixTween:com.greensock.plugins.EndArrayPlugin;

        internal static var _propNames:Array;

        protected static var _lumG:Number=0.71516;

        protected static var _lumR:Number=0.212671;

        protected static var _idMatrix:Array;

        protected static var _lumB:Number=0.072169;
    }
}


//  class ColorTransformPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;
    
    public class ColorTransformPlugin extends com.greensock.plugins.TintPlugin
    {
        public function ColorTransformPlugin()
        {
            super();
            this.propName = "colorTransform";
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc2:*=null;
            var loc3:*=NaN;
            if (!(arg1 is flash.display.DisplayObject)) 
            {
                return false;
            }
            var loc1:*=arg1.transform.colorTransform;
            var loc4:*=0;
            var loc5:*=arg2;
            for (loc2 in loc5) 
            {
                if (loc2 == "tint" || loc2 == "color") 
                {
                    if (arg2[loc2] != null) 
                    {
                        loc1.color = int(arg2[loc2]);
                    }
                    continue;
                }
                if (loc2 == "tintAmount" || loc2 == "exposure" || loc2 == "brightness") 
                {
                    continue;
                }
                loc1[loc2] = arg2[loc2];
            }
            if (isNaN(arg2.tintAmount)) 
            {
                if (isNaN(arg2.exposure)) 
                {
                    if (!isNaN(arg2.brightness)) 
                    {
                        loc1.blueOffset = loc4 = Math.max(0, (arg2.brightness - 1) * 255);
                        loc1.greenOffset = loc4 = loc4;
                        loc1.redOffset = loc4;
                        loc1.blueMultiplier = loc4 = 1 - Math.abs((arg2.brightness - 1));
                        loc1.greenMultiplier = loc4 = loc4;
                        loc1.redMultiplier = loc4;
                    }
                }
                else 
                {
                    loc1.blueOffset = loc4 = 255 * (arg2.exposure - 1);
                    loc1.greenOffset = loc4 = loc4;
                    loc1.redOffset = loc4;
                    loc1.blueMultiplier = loc4 = 1;
                    loc1.greenMultiplier = loc4 = loc4;
                    loc1.redMultiplier = loc4;
                }
            }
            else 
            {
                loc3 = arg2.tintAmount / (1 - (loc1.redMultiplier + loc1.greenMultiplier + loc1.blueMultiplier) / 3);
                loc1.redOffset = loc1.redOffset * loc3;
                loc1.greenOffset = loc1.greenOffset * loc3;
                loc1.blueOffset = loc1.blueOffset * loc3;
                loc1.blueMultiplier = loc4 = 1 - arg2.tintAmount;
                loc1.greenMultiplier = loc4 = loc4;
                loc1.redMultiplier = loc4;
            }
            _ignoreAlpha = Boolean(!(arg3.vars.alpha == undefined) && arg2.alphaMultiplier == undefined);
            init(arg1 as flash.display.DisplayObject, loc1);
            return true;
        }

        public static const API:Number=1;
    }
}


//  class DropShadowFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class DropShadowFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function DropShadowFilterPlugin()
        {
            super();
            this.propName = "dropShadowFilter";
            this.overwriteProps = ["dropShadowFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.DropShadowFilter;
            initFilter(arg2, new flash.filters.DropShadowFilter(0, 45, 0, 0, 0, 0, 1, arg2.quality || 2, arg2.inner, arg2.knockout, arg2.hideObject), _propNames);
            return true;
        }

        
        {
            _propNames = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


//  class EndArrayPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class EndArrayPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function EndArrayPlugin()
        {
            _info = [];
            super();
            this.propName = "endArray";
            this.overwriteProps = ["endArray"];
            return;
        }

        public function init(arg1:Array, arg2:Array):void
        {
            _a = arg1;
            var loc1:*=arg2.length;
            while (loc1--) 
            {
                if (!(!(arg1[loc1] == arg2[loc1]) && !(arg1[loc1] == null))) 
                {
                    continue;
                }
                _info[_info.length] = new ArrayTweenInfo(loc1, _a[loc1], arg2[loc1] - _a[loc1]);
            }
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg1 is Array) || !(arg2 is Array)) 
            {
                return false;
            }
            init(arg1 as Array, arg2);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc1:*=_info.length;
            if (this.round) 
            {
                while (loc1--) 
                {
                    loc2 = _info[loc1];
                    loc3 = loc2.start + loc2.change * arg1;
                    _a[loc2.index] = loc3 > 0 ? int(loc3 + 0.5) : int(loc3 - 0.5);
                }
            }
            else 
            {
                while (loc1--) 
                {
                    loc2 = _info[loc1];
                    _a[loc2.index] = loc2.start + loc2.change * arg1;
                }
            }
            return;
        }

        public static const API:Number=1;

        protected var _a:Array;

        protected var _info:Array;
    }
}


class ArrayTweenInfo extends Object
{
    public function ArrayTweenInfo(arg1:uint, arg2:Number, arg3:Number)
    {
        super();
        this.index = arg1;
        this.start = arg2;
        this.change = arg3;
        return;
    }

    public var change:Number;

    public var start:Number;

    public var index:uint;
}

//  class FilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import com.greensock.core.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class FilterPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function FilterPlugin()
        {
            super();
            return;
        }

        public function onCompleteTween():void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (_remove) 
            {
                loc1 = _target.filters;
                if (loc1[_index] is _type) 
                {
                    loc1.splice(_index, 1);
                }
                else 
                {
                    loc2 = loc1.length;
                    while (loc2--) 
                    {
                        if (!(loc1[loc2] is _type)) 
                        {
                            continue;
                        }
                        loc1.splice(loc2, 1);
                        break;
                    }
                }
                _target.filters = loc1;
            }
            return;
        }

        protected function initFilter(arg1:Object, arg2:flash.filters.BitmapFilter, arg3:Array):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=_target.filters;
            var loc5:*=arg1 is flash.filters.BitmapFilter ? {} : arg1;
            _index = -1;
            if (loc5.index == null) 
            {
                loc3 = loc1.length;
                while (loc3--) 
                {
                    if (!(loc1[loc3] is _type)) 
                    {
                        continue;
                    }
                    _index = loc3;
                }
            }
            else 
            {
                _index = loc5.index;
            }
            if (_index == -1 || loc1[_index] == null || loc5.addFilter == true) 
            {
                _index = loc5.index == null ? loc1.length : loc5.index;
                loc1[_index] = arg2;
                _target.filters = loc1;
            }
            _filter = loc1[_index];
            if (loc5.remove == true) 
            {
                _remove = true;
                this.onComplete = onCompleteTween;
            }
            loc3 = arg3.length;
            while (loc3--) 
            {
                loc2 = arg3[loc3];
                if (!(loc2 in arg1 && !(_filter[loc2] == arg1[loc2]))) 
                {
                    continue;
                }
                if (loc2 == "color" || loc2 == "highlightColor" || loc2 == "shadowColor") 
                {
                    loc4 = new com.greensock.plugins.HexColorsPlugin();
                    loc4.initColor(_filter, loc2, _filter[loc2], arg1[loc2]);
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(loc4, "changeFactor", 0, 1, loc2, false);
                    continue;
                }
                if (loc2 == "quality" || loc2 == "inner" || loc2 == "knockout" || loc2 == "hideObject") 
                {
                    _filter[loc2] = arg1[loc2];
                    continue;
                }
                addTween(_filter, loc2, _filter[loc2], arg1[loc2], loc2);
            }
            return;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc2:*=null;
            var loc1:*=_tweens.length;
            var loc3:*=_target.filters;
            while (loc1--) 
            {
                loc2 = _tweens[loc1];
                loc2.target[loc2.property] = loc2.start + loc2.change * arg1;
            }
            if (!(loc3[_index] is _type)) 
            {
                var loc4:*;
                _index = loc4 = loc3.length;
                loc1 = loc4;
                while (loc1--) 
                {
                    if (!(loc3[loc1] is _type)) 
                    {
                        continue;
                    }
                    _index = loc1;
                }
            }
            loc3[_index] = _filter;
            _target.filters = loc3;
            return;
        }

        public static const VERSION:Number=2.03;

        public static const API:Number=1;

        protected var _remove:Boolean;

        protected var _target:Object;

        protected var _index:int;

        protected var _filter:flash.filters.BitmapFilter;

        protected var _type:Class;
    }
}


//  class FrameLabelPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class FrameLabelPlugin extends com.greensock.plugins.FramePlugin
    {
        public function FrameLabelPlugin()
        {
            super();
            this.propName = "frameLabel";
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!arg3.target is flash.display.MovieClip) 
            {
                return false;
            }
            _target = arg1 as flash.display.MovieClip;
            this.frame = _target.currentFrame;
            var loc1:*=_target.currentLabels;
            var loc2:*=arg2;
            var loc3:*=_target.currentFrame;
            var loc4:*=loc1.length;
            while (loc4--) 
            {
                if (loc1[loc4].name != loc2) 
                {
                    continue;
                }
                loc3 = loc1[loc4].frame;
                break;
            }
            if (this.frame != loc3) 
            {
                addTween(this, "frame", this.frame, loc3, "frame");
            }
            return true;
        }

        public static const API:Number=1;
    }
}


//  class FramePlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class FramePlugin extends com.greensock.plugins.TweenPlugin
    {
        public function FramePlugin()
        {
            super();
            this.propName = "frame";
            this.overwriteProps = ["frame", "frameLabel"];
            this.round = true;
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg1 is flash.display.MovieClip) || isNaN(arg2)) 
            {
                return false;
            }
            _target = arg1 as flash.display.MovieClip;
            this.frame = _target.currentFrame;
            addTween(this, "frame", this.frame, arg2, "frame");
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            updateTweens(arg1);
            _target.gotoAndStop(this.frame);
            return;
        }

        public static const API:Number=1;

        protected var _target:flash.display.MovieClip;

        public var frame:int;
    }
}


//  class GlowFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class GlowFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function GlowFilterPlugin()
        {
            super();
            this.propName = "glowFilter";
            this.overwriteProps = ["glowFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.GlowFilter;
            initFilter(arg2, new flash.filters.GlowFilter(16777215, 0, 0, 0, arg2.strength || 1, arg2.quality || 2, arg2.inner, arg2.knockout), _propNames);
            return true;
        }

        
        {
            _propNames = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


//  class HexColorsPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class HexColorsPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function HexColorsPlugin()
        {
            super();
            this.propName = "hexColors";
            this.overwriteProps = [];
            _colors = [];
            return;
        }

        public override function killProps(arg1:Object):void
        {
            var loc1:*=(_colors.length - 1);
            while (loc1 > -1) 
            {
                if (arg1[_colors[loc1][1]] != undefined) 
                {
                    _colors.splice(loc1, 1);
                }
                --loc1;
            }
            super.killProps(arg1);
            return;
        }

        public function initColor(arg1:Object, arg2:String, arg3:uint, arg4:uint):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (arg3 != arg4) 
            {
                loc1 = arg3 >> 16;
                loc2 = arg3 >> 8 & 255;
                loc3 = arg3 & 255;
                _colors[_colors.length] = [arg1, arg2, loc1, (arg4 >> 16) - loc1, loc2, (arg4 >> 8 & 255) - loc2, loc3, (arg4 & 255) - loc3];
                this.overwriteProps[this.overwriteProps.length] = arg2;
            }
            return;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=null;
            loc1 = (_colors.length - 1);
            while (loc1 > -1) 
            {
                loc2 = _colors[loc1];
                loc2[0][loc2[1]] = loc2[2] + arg1 * loc2[3] << 16 | loc2[4] + arg1 * loc2[5] << 8 | loc2[6] + arg1 * loc2[7];
                --loc1;
            }
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg2;
            for (loc1 in loc3) 
            {
                initColor(arg1, loc1, uint(arg1[loc1]), uint(arg2[loc1]));
            }
            return true;
        }

        public static const API:Number=1;

        protected var _colors:Array;
    }
}


//  class RemoveTintPlugin
package com.greensock.plugins 
{
    public class RemoveTintPlugin extends com.greensock.plugins.TintPlugin
    {
        public function RemoveTintPlugin()
        {
            super();
            this.propName = "removeTint";
            return;
        }

        public static const API:Number=1;
    }
}


//  class RoundPropsPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class RoundPropsPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function RoundPropsPlugin()
        {
            super();
            this.propName = "roundProps";
            this.overwriteProps = [];
            this.round = true;
            return;
        }

        public function add(arg1:Object, arg2:String, arg3:Number, arg4:Number):void
        {
            addTween(arg1, arg2, arg3, arg3 + arg4, arg2);
            this.overwriteProps[this.overwriteProps.length] = arg2;
            return;
        }

        public static const API:Number=1;
    }
}


//  class ShortRotationPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class ShortRotationPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function ShortRotationPlugin()
        {
            super();
            this.propName = "shortRotation";
            this.overwriteProps = [];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc1:*=null;
            if (typeof arg2 == "number") 
            {
                return false;
            }
            var loc2:*=0;
            var loc3:*=arg2;
            for (loc1 in loc3) 
            {
                initRotation(arg1, loc1, arg1[loc1], typeof arg2[loc1] != "number" ? arg1[loc1] + Number(arg2[loc1]) : Number(arg2[loc1]));
            }
            return true;
        }

        public function initRotation(arg1:Object, arg2:String, arg3:Number, arg4:Number):void
        {
            var loc1:*=(arg4 - arg3) % 360;
            if (loc1 != loc1 % 180) 
            {
                loc1 = loc1 < 0 ? loc1 + 360 : loc1 - 360;
            }
            addTween(arg1, arg2, arg3, arg3 + loc1, arg2);
            this.overwriteProps[this.overwriteProps.length] = arg2;
            return;
        }

        public static const API:Number=1;
    }
}


//  class TintPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import com.greensock.core.*;
    import flash.display.*;
    import flash.geom.*;
    
    public class TintPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function TintPlugin()
        {
            super();
            this.propName = "tint";
            this.overwriteProps = ["tint"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg1 is flash.display.DisplayObject)) 
            {
                return false;
            }
            var loc1:*=new flash.geom.ColorTransform();
            if (!(arg2 == null) && !(arg3.vars.removeTint == true)) 
            {
                loc1.color = uint(arg2);
            }
            _ignoreAlpha = true;
            init(arg1 as flash.display.DisplayObject, loc1);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc1:*=null;
            updateTweens(arg1);
            if (_ignoreAlpha) 
            {
                loc1 = _transform.colorTransform;
                _ct.alphaMultiplier = loc1.alphaMultiplier;
                _ct.alphaOffset = loc1.alphaOffset;
            }
            _transform.colorTransform = _ct;
            return;
        }

        public function init(arg1:flash.display.DisplayObject, arg2:flash.geom.ColorTransform):void
        {
            var loc2:*=null;
            _transform = arg1.transform;
            _ct = _transform.colorTransform;
            var loc1:*=_props.length;
            while (loc1--) 
            {
                loc2 = _props[loc1];
                if (_ct[loc2] == arg2[loc2]) 
                {
                    continue;
                }
                _tweens[_tweens.length] = new com.greensock.core.PropTween(_ct, loc2, _ct[loc2], arg2[loc2] - _ct[loc2], "tint", false);
            }
            return;
        }

        
        {
            _props = ["redMultiplier", "greenMultiplier", "blueMultiplier", "alphaMultiplier", "redOffset", "greenOffset", "blueOffset", "alphaOffset"];
        }

        public static const API:Number=1;

        protected var _ct:flash.geom.ColorTransform;

        protected var _transform:flash.geom.Transform;

        protected var _ignoreAlpha:Boolean;

        protected static var _props:Array;
    }
}


//  class TweenPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import com.greensock.core.*;
    
    public class TweenPlugin extends Object
    {
        public function TweenPlugin()
        {
            _tweens = [];
            super();
            return;
        }

        protected function updateTweens(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc1:*=_tweens.length;
            if (this.round) 
            {
                while (loc1--) 
                {
                    loc2 = _tweens[loc1];
                    loc3 = loc2.start + loc2.change * arg1;
                    loc2.target[loc2.property] = loc3 > 0 ? int(loc3 + 0.5) : int(loc3 - 0.5);
                }
            }
            else 
            {
                while (loc1--) 
                {
                    loc2 = _tweens[loc1];
                    loc2.target[loc2.property] = loc2.start + loc2.change * arg1;
                }
            }
            return;
        }

        protected function addTween(arg1:Object, arg2:String, arg3:Number, arg4:*, arg5:String=null):void
        {
            var loc1:*=NaN;
            if (arg4 != null) 
            {
                loc1 = typeof arg4 != "number" ? Number(arg4) : Number(arg4) - arg3;
                if (loc1 != 0) 
                {
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(arg1, arg2, arg3, loc1, arg5 || arg2, false);
                }
            }
            return;
        }

        public function get changeFactor():Number
        {
            return _changeFactor;
        }

        public function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            addTween(arg1, this.propName, arg1[this.propName], arg2, this.propName);
            return true;
        }

        public function killProps(arg1:Object):void
        {
            var loc1:*=this.overwriteProps.length;
            while (loc1--) 
            {
                if (!(this.overwriteProps[loc1] in arg1)) 
                {
                    continue;
                }
                this.overwriteProps.splice(loc1, 1);
            }
            loc1 = _tweens.length;
            while (loc1--) 
            {
                if (!(com.greensock.core.PropTween(_tweens[loc1]).name in arg1)) 
                {
                    continue;
                }
                _tweens.splice(loc1, 1);
            }
            return;
        }

        public function set changeFactor(arg1:Number):void
        {
            updateTweens(arg1);
            _changeFactor = arg1;
            return;
        }

        public static function activate(arg1:Array):Boolean
        {
            var loc2:*=null;
            com.greensock.TweenLite.onPluginEvent = com.greensock.plugins.TweenPlugin.onTweenEvent;
            var loc1:*=arg1.length;
            while (loc1--) 
            {
                if (!arg1[loc1].hasOwnProperty("API")) 
                {
                    continue;
                }
                loc2 = new (arg1[loc1] as Class)();
                com.greensock.TweenLite.plugins[loc2.propName] = arg1[loc1];
            }
            return true;
        }

        internal static function onTweenEvent(arg1:String, arg2:com.greensock.TweenLite):Boolean
        {
            var loc2:*=false;
            var loc3:*=null;
            var loc4:*=0;
            var loc1:*=arg2.cachedPT1;
            if (arg1 != "onInit") 
            {
                while (loc1) 
                {
                    if (loc1.isPlugin && loc1.target[arg1]) 
                    {
                        if (loc1.target.activeDisable) 
                        {
                            loc2 = true;
                        }
                        var loc5:*;
                        (loc5 = loc1.target)[arg1]();
                    }
                    loc1 = loc1.nextNode;
                }
            }
            else 
            {
                loc3 = [];
                while (loc1) 
                {
                    loc3[loc3.length] = loc1;
                    loc1 = loc1.nextNode;
                }
                loc3.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
                loc4 = loc3.length;
                while (loc4--) 
                {
                    com.greensock.core.PropTween(loc3[loc4]).nextNode = loc3[loc4 + 1];
                    com.greensock.core.PropTween(loc3[loc4]).prevNode = loc3[(loc4 - 1)];
                }
                arg2.cachedPT1 = loc3[0];
            }
            return loc2;
        }

        public static const VERSION:Number=1.31;

        public static const API:Number=1;

        public var activeDisable:Boolean;

        protected var _changeFactor:Number=0;

        protected var _tweens:Array;

        public var onDisable:Function;

        public var propName:String;

        public var round:Boolean;

        public var onEnable:Function;

        public var priority:int=0;

        public var overwriteProps:Array;

        public var onComplete:Function;
    }
}


//  class VisiblePlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class VisiblePlugin extends com.greensock.plugins.TweenPlugin
    {
        public function VisiblePlugin()
        {
            super();
            this.propName = "visible";
            this.overwriteProps = ["visible"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _tween = arg3;
            _initVal = _target.visible;
            _visible = Boolean(arg2);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            if (arg1 == 1 && (_tween.cachedDuration == _tween.cachedTime || _tween.cachedTime == 0)) 
            {
                _target.visible = _visible;
            }
            else 
            {
                _target.visible = _initVal;
            }
            return;
        }

        public static const API:Number=1;

        protected var _target:Object;

        protected var _initVal:Boolean;

        protected var _visible:Boolean;

        protected var _tween:com.greensock.TweenLite;
    }
}


//  class VolumePlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.media.*;
    
    public class VolumePlugin extends com.greensock.plugins.TweenPlugin
    {
        public function VolumePlugin()
        {
            super();
            this.propName = "volume";
            this.overwriteProps = ["volume"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (isNaN(arg2) || !arg1.hasOwnProperty("soundTransform")) 
            {
                return false;
            }
            _target = arg1;
            _st = _target.soundTransform;
            addTween(_st, "volume", _st.volume, arg2, "volume");
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            updateTweens(arg1);
            _target.soundTransform = _st;
            return;
        }

        public static const API:Number=1;

        protected var _target:Object;

        protected var _st:flash.media.SoundTransform;
    }
}


