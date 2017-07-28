//class ColorMatrixFilterPlugin
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


