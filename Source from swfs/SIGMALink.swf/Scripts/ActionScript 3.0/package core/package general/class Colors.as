//class Colors
package core.general 
{
    public class Colors extends Object
    {
        public function Colors()
        {
            super();
            return;
        }

        public static function brightness(arg1:Number):Number
        {
            var loc1:*=0;
            var loc2:*=hexToRgb(arg1);
            if (loc2.r > loc1) 
            {
                loc1 = loc2.r;
            }
            if (loc2.g > loc1) 
            {
                loc1 = loc2.g;
            }
            if (loc2.b > loc1) 
            {
                loc1 = loc2.b;
            }
            loc1 = loc1 / 255;
            return loc1;
        }

        public static function calculateColorWithAlpha(arg1:int, arg2:Number):int
        {
            var loc3:*=0;
            var loc1:*=null;
            var loc2:*=0;
            if (arg2 >= 0 && arg2 <= 1) 
            {
                loc1 = (arg2 * 255).toString(16);
                loc3 = (loc2 = "0x" + loc1 + "000000") + arg1;
            }
            else 
            {
                loc3 = arg1;
            }
            return loc3;
        }

        public static function brightenColor(arg1:Number, arg2:Number):Number
        {
            if (isNaN(arg2)) 
            {
                arg2 = 0;
            }
            if (arg2 > 100) 
            {
                arg2 = 100;
            }
            if (arg2 < 0) 
            {
                arg2 = 0;
            }
            var loc1:*=arg2 / 100;
            var loc2:*;
            loc2.r = (loc2 = hexToRgb(arg1)).r + (255 - loc2.r) * loc1;
            loc2.b = loc2.b + (255 - loc2.b) * loc1;
            loc2.g = loc2.g + (255 - loc2.g) * loc1;
            return rgbToHex(Math.round(loc2.r), Math.round(loc2.g), Math.round(loc2.b));
        }

        public static function darkenColor(arg1:Number, arg2:Number):Number
        {
            if (isNaN(arg2)) 
            {
                arg2 = 0;
            }
            if (arg2 > 100) 
            {
                arg2 = 100;
            }
            if (arg2 < 0) 
            {
                arg2 = 0;
            }
            var loc1:*=1 - arg2 / 100;
            var loc2:*;
            loc2.r = (loc2 = hexToRgb(arg1)).r * loc1;
            loc2.b = loc2.b * loc1;
            loc2.g = loc2.g * loc1;
            return rgbToHex(Math.round(loc2.r), Math.round(loc2.g), Math.round(loc2.b));
        }

        public static function rgbToHex(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return arg1 << 16 | arg2 << 8 | arg3;
        }

        public static function hexToRgb(arg1:Number):Object
        {
            return {"r":(arg1 & 16711680) >> 16, "g":(arg1 & 65280) >> 8, "b":arg1 & 255};
        }

        public static const AVERAGE_INCLINE:int=INCLINE;

        public static const AVERAGE_POWER:int=POWER;

        public static const AVERAGE_RISERATE:int=RISERATE;

        public static const AVERAGE_SPEED:int=SPEED;

        public static const AVERAGE_TEMPERATURE:int=TEMPERATURE;

        public static const BALANCE:int=46795;

        public static const BALANCE_DARK:int=32655;

        public static const BEST_20MIN_POWER_COLOR:int=10066329;

        public static const BEST_5K_TIME_COLOR:int=16752653;

        public static const BLACK:int=0;

        public static const BLUE:int=1542837;

        public static const BLUE_DARK:int=1014176;

        public static const BLUE_GPSIES:int=24063;

        public static const BREAK_COLOR:int=24063;

        public static const BRONZE:int=14132588;

        public static const BUTTON_BLUE:uint=3045570;

        public static const CADENCE:int=4539975;

        public static const CALORIES:int=16750910;

        public static const CHART_OUTSIDE:int=10066329;

        public static const CHART_OUTSIDE_DARK:int=7434867;

        public static const CHART_ZONE1:int=48716;

        public static const CHART_ZONE1_DARK:int=3050304;

        public static const CHART_ZONE2:int=16568846;

        public static const CHART_ZONE2_DARK:int=13544728;

        public static const CHART_ZONE3:int=13046322;

        public static const CHART_ZONE3_DARK:int=10031655;

        public static const CHART_ZONE_IN:int=48716;

        public static const CHART_ZONE_IN_DARK:int=3050304;

        public static const CHART_ZONE_OVER:int=6908265;

        public static const CHART_ZONE_OVER_DARK:int=4539975;

        public static const CHART_ZONE_UNDER:int=10066329;

        public static const CHART_ZONE_UNDER_DARK:int=7434867;

        public static const DARKESTGREY:uint=3684408;

        public static const DARKFONT:uint=3028545;

        public static const DARKGREY:uint=6710886;

        public static const DARK_BLUE:int=19931;

        public static const DARK_BLUE_DARK:int=2506104;

        public static const DEEPPINK:int=16711884;

        public static const DEEPPINT_DARK:int=10828408;

        public static const DIMGREY:int=6908265;

        public static const DIMGREY_DARK:int=4539975;

        public static const DISTANCE:int=11388486;

        public static const GOLD:int=16698419;

        public static const GREEN:int=48716;

        public static const GREEN_DARK:int=3050304;

        public static const GREEN_TRACKS:int=39168;

        public static const GREY:int=10066329;

        public static const GREY_DARK:int=7434867;

        public static const HEATRATE:int=10031655;

        public static const INCLINE:int=7747541;

        public static const INTENSITY_ZONE:int=13046322;

        public static const INTENSITY_ZONE_1:int=1542837;

        public static const INTENSITY_ZONE_1_DARK:int=1014176;

        public static const INTENSITY_ZONE_2:int=48716;

        public static const INTENSITY_ZONE_2_DARK:int=3050304;

        public static const INTENSITY_ZONE_3:int=16568846;

        public static const INTENSITY_ZONE_3_DARK:int=13544728;

        public static const INTENSITY_ZONE_4:int=13046322;

        public static const INTENSITY_ZONE_4_DARK:int=10031655;

        public static const INTENSITY_ZONE_OVER:int=6908265;

        public static const INTENSITY_ZONE_OVER_DARK:int=4539975;

        public static const INTENSITY_ZONE_UNDER:int=10066329;

        public static const INTENSITY_ZONE_UNDER_DARK:int=7434867;

        public static const INTERVAL_COLOR:int=13046322;

        public static const LAP_COLOR:int=41728;

        public static const LIGHTGREY:uint=15396337;

        public static const MAGENTA:int=11085908;

        public static const MAGENTA_DARK:int=2377349;

        public static const MIDGREY:uint=9737364;

        public static const OK_GREEN:uint=3781962;

        public static const ORANGE:int=16752653;

        public static const ORANGE_DARK:int=14123548;

        public static const PHASE_COLOR:int=8588321;

        public static const POWER:int=16755200;

        public static const POWER_NP:int=14192640;

        public static const POWER_ZONE_1:int=7747541;

        public static const POWER_ZONE_1_DARK:int=5257595;

        public static const POWER_ZONE_2:int=1542837;

        public static const POWER_ZONE_2_DARK:int=1014176;

        public static const POWER_ZONE_3:int=48716;

        public static const POWER_ZONE_3_DARK:int=3050304;

        public static const POWER_ZONE_4:int=16568846;

        public static const POWER_ZONE_4_DARK:int=13544728;

        public static const POWER_ZONE_5:int=16752653;

        public static const POWER_ZONE_5_DARK:int=14123548;

        public static const POWER_ZONE_6:int=13046322;

        public static const POWER_ZONE_6_DARK:int=10031655;

        public static const POWER_ZONE_7:int=11085908;

        public static const ALTITUDE:int=19931;

        public static const RECOVERY_COLOR:int=0;

        public static const RED:int=13046322;

        public static const RED_DARK:int=10031655;

        public static const RISERATE:int=16711884;

        public static const SILVER:int=11581372;

        public static const SLEEP_BLUE:uint=39321;

        public static const SLEEP_GREEN:uint=10079283;

        public static const SLEEP_RED:uint=16737894;

        public static const SPEED:int=3050304;

        public static const STEPS:int=2201544;

        public static const TEMPERATURE:int=11085908;

        public static const VIOLET:int=7747541;

        public static const VIOLET_DARK:int=5257595;

        public static const WHITE:int=16777215;

        public static const POWER_ZONE_7_DARK:int=2377349;

        public static const YELLOW_DARK:int=13544728;

        public static const YELLOW_GREEN:int=11067173;

        public static const YELLOW_GREEN_DARK:int=8954666;

        public static const YELLOW_ORANGE:int=16755200;

        public static const YELLOW_ORANGE_DARK:int=14192640;

        public static const ZONE:int=48716;

        public static const ZONE1:int=48716;

        public static const ZONE2:int=16568846;

        public static const ZONE3:int=13046322;

        public static const AUTO_LAP_COLOR:uint=1535255;

        public static const AVERAGE_ALTITUDE:int=19931;

        public static const AVERAGE_BALANCE:int=46795;

        public static const AVERAGE_CADENCE:int=CADENCE;

        public static const AVERAGE_HEATRATE:int=HEATRATE;

        public static const YELLOW:int=16568846;
    }
}


