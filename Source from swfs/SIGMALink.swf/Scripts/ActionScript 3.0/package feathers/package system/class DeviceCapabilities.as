//class DeviceCapabilities
package feathers.system 
{
    import flash.display.*;
    import flash.system.*;
    
    public class DeviceCapabilities extends Object
    {
        public function DeviceCapabilities()
        {
            super();
            return;
        }

        public static function isTablet(arg1:flash.display.Stage):Boolean
        {
            var loc1:*=screenPixelWidth;
            if (loc1 !== loc1) 
            {
                loc1 = arg1.fullScreenWidth;
            }
            var loc2:*=screenPixelHeight;
            if (loc2 !== loc2) 
            {
                loc2 = arg1.fullScreenHeight;
            }
            if (loc1 < loc2) 
            {
                loc1 = loc2;
            }
            return loc1 / dpi >= tabletScreenMinimumInches;
        }

        public static function isPhone(arg1:flash.display.Stage):Boolean
        {
            return !isTablet(arg1);
        }

        public static function screenInchesX(arg1:flash.display.Stage):Number
        {
            var loc1:*=screenPixelWidth;
            if (loc1 !== loc1) 
            {
                loc1 = arg1.fullScreenWidth;
            }
            return loc1 / dpi;
        }

        public static function screenInchesY(arg1:flash.display.Stage):Number
        {
            var loc1:*=screenPixelHeight;
            if (loc1 !== loc1) 
            {
                loc1 = arg1.fullScreenHeight;
            }
            return loc1 / dpi;
        }

        
        {
            tabletScreenMinimumInches = 5;
            screenPixelWidth = NaN;
            screenPixelHeight = NaN;
            dpi = flash.system.Capabilities.screenDPI;
        }

        public static var tabletScreenMinimumInches:Number=5;

        public static var screenPixelWidth:Number=NaN;

        public static var screenPixelHeight:Number=NaN;

        public static var dpi:int;
    }
}


