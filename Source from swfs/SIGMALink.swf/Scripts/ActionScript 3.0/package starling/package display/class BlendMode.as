//class BlendMode
package starling.display 
{
    import flash.display3D.*;
    import starling.core.*;
    
    public class BlendMode extends Object
    {
        public function BlendMode(arg1:String, arg2:String, arg3:String)
        {
            super();
            this._name = arg1;
            this._sourceFactor = arg2;
            this._destinationFactor = arg3;
            return;
        }

        public function activate():void
        {
            starling.core.Starling.context.setBlendFactors(this._sourceFactor, this._destinationFactor);
            return;
        }

        public function toString():String
        {
            return this._name;
        }

        public function get sourceFactor():String
        {
            return this._sourceFactor;
        }

        public function get destinationFactor():String
        {
            return this._destinationFactor;
        }

        public function get name():String
        {
            return this._name;
        }

        public static function get(arg1:String):starling.display.BlendMode
        {
            if (sBlendModes == null) 
            {
                registerDefaults();
            }
            if (arg1 in sBlendModes) 
            {
                return sBlendModes[arg1];
            }
            throw new ArgumentError("Blend mode not found: " + arg1);
        }

        public static function register(arg1:String, arg2:String, arg3:String):starling.display.BlendMode
        {
            if (sBlendModes == null) 
            {
                registerDefaults();
            }
            var loc1:*=new BlendMode(arg1, arg2, arg3);
            sBlendModes[arg1] = loc1;
            return loc1;
        }

        internal static function registerDefaults():void
        {
            if (sBlendModes) 
            {
                return;
            }
            sBlendModes = {};
            register("none", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ZERO);
            register("normal", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("add", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE);
            register("multiply", flash.display3D.Context3DBlendFactor.DESTINATION_COLOR, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("screen", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
            register("erase", flash.display3D.Context3DBlendFactor.ZERO, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("mask", flash.display3D.Context3DBlendFactor.ZERO, flash.display3D.Context3DBlendFactor.SOURCE_ALPHA);
            register("below", flash.display3D.Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA, flash.display3D.Context3DBlendFactor.DESTINATION_ALPHA);
            return;
        }

        public static const AUTO:String="auto";

        public static const NONE:String="none";

        public static const NORMAL:String="normal";

        public static const ADD:String="add";

        public static const MULTIPLY:String="multiply";

        public static const SCREEN:String="screen";

        public static const ERASE:String="erase";

        public static const MASK:String="mask";

        public static const BELOW:String="below";

        internal var _name:String;

        internal var _sourceFactor:String;

        internal var _destinationFactor:String;

        internal static var sBlendModes:Object;
    }
}


