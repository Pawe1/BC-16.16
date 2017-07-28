//class SpeedConverter
package utils.converter 
{
    public class SpeedConverter extends Object implements utils.converter.IConverter
    {
        public function SpeedConverter(arg1:String="kmh", arg2:String="mph")
        {
            super();
            inputFormat = arg1;
            _outputFormat = arg2;
            return;
        }

        public function get inputFormat():String
        {
            return _inputFormat;
        }

        public function set inputFormat(arg1:String):void
        {
            _inputFormat = arg1;
            return;
        }

        public function get outputFormat():String
        {
            return _outputFormat;
        }

        public function set outputFormat(arg1:String):void
        {
            _outputFormat = arg1;
            return;
        }

        public function set toInt(arg1:Boolean):void
        {
            _toInt = arg1;
            return;
        }

        public function get toInt():Boolean
        {
            return _toInt;
        }

        public function convert(arg1:Object):Number
        {
            var loc2:*=0;
            var loc1:*=0;
            if (arg1 is String) 
            {
                arg1 = (arg1 as String).replace(",", ".");
                loc1 = parseFloat(arg1.toString());
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    loc1 = 0;
                }
                else 
                {
                    loc1 = arg1 as Number;
                }
            }
            if (inputFormat == outputFormat) 
            {
                loc2 = loc1;
            }
            else if (inputFormat != "ms") 
            {
                if (inputFormat != "kmh") 
                {
                    if (inputFormat != "mph") 
                    {
                        if (inputFormat != "fps") 
                        {
                            if (inputFormat != "s/km") 
                            {
                                if (inputFormat == "s/mile") 
                                {
                                    if (outputFormat != "kmh") 
                                    {
                                        if (outputFormat != "ms") 
                                        {
                                            if (outputFormat != "mph") 
                                            {
                                                if (outputFormat != "fps") 
                                                {
                                                    if (outputFormat == "s/km") 
                                                    {
                                                        loc2 = Math.round(1000 / (1609 / loc1));
                                                    }
                                                }
                                                else 
                                                {
                                                    loc2 = 1609 / loc1 * 3.2808399;
                                                }
                                            }
                                            else 
                                            {
                                                loc2 = 1609 / loc1 * 2.23693629;
                                            }
                                        }
                                        else 
                                        {
                                            loc2 = 1609 / loc1;
                                        }
                                    }
                                    else 
                                    {
                                        loc2 = 1609 / loc1 * 3.6;
                                    }
                                }
                            }
                            else if (outputFormat != "kmh") 
                            {
                                if (outputFormat != "ms") 
                                {
                                    if (outputFormat != "mph") 
                                    {
                                        if (outputFormat != "fps") 
                                        {
                                            if (outputFormat == "s/mile") 
                                            {
                                                loc2 = Math.round(1609 / (1000 / loc1));
                                            }
                                        }
                                        else 
                                        {
                                            loc2 = 1000 / loc1 / 3.2808399;
                                        }
                                    }
                                    else 
                                    {
                                        loc2 = 1000 / loc1 / 2.23693629;
                                    }
                                }
                                else 
                                {
                                    loc2 = 1000 / loc1;
                                }
                            }
                            else 
                            {
                                loc2 = 1000 / loc1 * 3.6;
                            }
                        }
                        else if (outputFormat != "kmh") 
                        {
                            if (outputFormat != "ms") 
                            {
                                if (outputFormat != "mph") 
                                {
                                    if (outputFormat != "s/km") 
                                    {
                                        if (outputFormat == "s/mile") 
                                        {
                                            loc2 = Math.round(1609 / (loc1 / 3.2808399));
                                        }
                                    }
                                    else 
                                    {
                                        loc2 = Math.round(1000 / (loc1 / 3.2808399));
                                    }
                                }
                                else 
                                {
                                    loc2 = loc1 / 3.2808399 * 2.23693629;
                                }
                            }
                            else 
                            {
                                loc2 = loc1 / 3.2808399;
                            }
                        }
                        else 
                        {
                            loc2 = loc1 / 3.2808399 * 3.6;
                        }
                    }
                    else if (outputFormat != "kmh") 
                    {
                        if (outputFormat != "ms") 
                        {
                            if (outputFormat != "fps") 
                            {
                                if (outputFormat != "s/km") 
                                {
                                    if (outputFormat == "s/mile") 
                                    {
                                        loc2 = Math.round(1609 / (loc1 / 2.23693629));
                                    }
                                }
                                else 
                                {
                                    loc2 = Math.round(1000 / (loc1 / 2.23693629));
                                }
                            }
                            else 
                            {
                                loc2 = loc1 / 2.23693629 * 3.2808399;
                            }
                        }
                        else 
                        {
                            loc2 = loc1 / 2.23693629;
                        }
                    }
                    else 
                    {
                        loc2 = loc1 / 1.609344;
                    }
                }
                else if (outputFormat != "ms") 
                {
                    if (outputFormat != "mph") 
                    {
                        if (outputFormat != "fps") 
                        {
                            if (outputFormat != "s/km") 
                            {
                                if (outputFormat == "s/mile") 
                                {
                                    loc2 = Math.round(1609 / (loc1 / 3.6));
                                }
                            }
                            else 
                            {
                                loc2 = Math.round(1000 / (loc1 / 3.6));
                            }
                        }
                        else 
                        {
                            loc2 = loc1 / 3.6 * 3.2808399;
                        }
                    }
                    else 
                    {
                        loc2 = loc1 * 1.609344;
                    }
                }
                else 
                {
                    loc2 = loc1 / 3.6;
                }
            }
            else if (outputFormat != "kmh") 
            {
                if (outputFormat != "mph") 
                {
                    if (outputFormat != "fps") 
                    {
                        if (outputFormat != "s/km") 
                        {
                            if (outputFormat == "s/mile") 
                            {
                                loc2 = Math.round(1609 / loc1);
                            }
                        }
                        else 
                        {
                            loc2 = Math.round(1000 / loc1);
                        }
                    }
                    else 
                    {
                        loc2 = loc1 * 3.2808399;
                    }
                }
                else 
                {
                    loc2 = loc1 * 2.23693629;
                }
            }
            else 
            {
                loc2 = loc1 * 3.6;
            }
            if (!isFinite(loc2)) 
            {
                loc2 = 0;
            }
            return loc2;
        }

        internal const KMH_TO_MPH:Number=1.609344;

        internal const MS_TO_FPS:Number=3.2808399;

        internal const MS_TO_KMH:Number=3.6;

        internal const MS_TO_MPH:Number=2.23693629;

        internal var _inputFormat:String="kmh";

        internal var _outputFormat:String="mph";

        internal var _toInt:Boolean=false;
    }
}


