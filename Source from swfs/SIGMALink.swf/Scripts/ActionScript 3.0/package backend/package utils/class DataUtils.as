//class DataUtils
package backend.utils 
{
    import __AS3__.vec.*;
    import backend.utils.dataprovider.*;
    import configCache.*;
    import core.*;
    import core.general.*;
    import feathers.events.*;
    import frontend.formatter.*;
    import starling.events.*;
    import utils.*;
    import utils.converter.*;
    import utils.format.*;
    import utils.formatter.*;
    import utils.interfaces.*;
    
    public class DataUtils extends starling.events.EventDispatcher
    {
        public function DataUtils()
        {
            super();
            return;
        }

        
        {
            speedTimeConverter = new utils.converter.SpeedTimeConverter();
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static function set unitStringFuelEconomy(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._277633613unitStringFuelEconomy;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._277633613unitStringFuelEconomy = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringFuelEconomy", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function init():void
        {
            backend.utils.dataprovider.DataProviderUtil.initDataProviders();
            updateMeasurementConfig();
            unitStringPercent = utils.LanguageManager.getString("UNIT_PERCENT");
            unitStringTimeHours = utils.LanguageManager.getString("UNIT_HOUR");
            unitStringDistance = utils.LanguageManager.getString("UNIT_KM");
            unitStringSpeed = utils.LanguageManager.getString("UNIT_KMH");
            distanceFormatter = new frontend.formatter.DistanceFormatter();
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                if (core.MeasurementConfig.distanceFormat == utils.format.DistanceFormat.MILE) 
                {
                    unitStringDistance = utils.LanguageManager.getString("UNIT_MI");
                    distanceFormatter.formatString = "K.MM";
                }
            }
            else 
            {
                unitStringDistance = utils.LanguageManager.getString("UNIT_KM");
                distanceFormatter.formatString = "K,MM";
            }
            altitudeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_ALTITUDE");
            altitudeFormatter = new frontend.formatter.AltitudeFormatter();
            if (core.MeasurementConfig.altitudeFormat != utils.format.AltitudeFormat.METER) 
            {
                if (core.MeasurementConfig.altitudeFormat == utils.format.AltitudeFormat.FEET) 
                {
                    unitStringAltitude = utils.LanguageManager.getString("UNIT_FT");
                    altitudeFormatter.formatString = "M";
                    (altitudeFormatter as frontend.formatter.AltitudeFormatter).outputFeed = true;
                    unitStringRiseRate = utils.LanguageManager.getString("UNIT_FT_MIN");
                }
            }
            else 
            {
                unitStringAltitude = utils.LanguageManager.getString("UNIT_M");
                altitudeFormatter.formatString = "M";
                (altitudeFormatter as frontend.formatter.AltitudeFormatter).outputFeed = false;
                unitStringRiseRate = utils.LanguageManager.getString("UNIT_M_MIN");
            }
            fuelEconomyFormatter = new frontend.formatter.FuelEconomyFormatter();
            fuelEconomyConverter = new utils.converter.FuelEconomyConverter();
            fuelEconomyConverter.inputFormat = utils.format.FuelEconomyFormat.LITER;
            fuelEconomyConverter.outputFormat = core.MeasurementConfig.fuelEconomyFormat;
            if (core.MeasurementConfig.fuelEconomyFormat != utils.format.FuelEconomyFormat.LITER) 
            {
                fuelEconomyFormatter.decimalSeparator = ".";
                unitStringFuelEconomy = utils.LanguageManager.getString("UNIT_GALLON");
            }
            else 
            {
                fuelEconomyFormatter.decimalSeparator = ",";
                unitStringFuelEconomy = utils.LanguageManager.getString("UNIT_LITER");
            }
            fuelEconomyLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_FUEL_ECONOMY");
            altitudeConverter = new utils.converter.AltitudeConverter();
            altitudeConverter.inputFormat = utils.format.AltitudeFormat.MILLIMETER;
            altitudeConverter.outputFormat = core.MeasurementConfig.altitudeFormat;
            caloriesLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_CALORIES");
            caloriesFormatter = new frontend.formatter.CaloriesFormatter();
            unitStringCalories = utils.LanguageManager.getString("UNIT_CALORIE");
            cadenceLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_CADENCE");
            cadenceFormatter = new frontend.formatter.CadenceFormatter();
            unitStringCadence = utils.LanguageManager.getString("UNIT_RPM");
            distanceLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE");
            distanceConverter = new utils.converter.DistanceConverter();
            distanceConverter.inputFormat = utils.format.DistanceFormat.METER;
            distanceConverter.outputFormat = core.MeasurementConfig.distanceFormat;
            distancePlusMinusLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE_UP_DOWN");
            expansionLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_EXPANSION");
            expansionFormatter = new frontend.formatter.ExpansionFormatter();
            if (core.MeasurementConfig.altitudeFormat != utils.format.AltitudeFormat.METER) 
            {
                unitStringExpansion = utils.LanguageManager.getString("UNIT_FTR");
                expansionFormatter.decimalSeparator = ".";
            }
            else 
            {
                unitStringExpansion = utils.LanguageManager.getString("UNIT_MR");
                expansionFormatter.decimalSeparator = ",";
            }
            heartrateLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_HEARTRATE");
            heartrateFormatter = new frontend.formatter.HeartrateFormatter();
            inclineLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_INCLINE");
            unitStringIncline = unitStringPercent;
            inclineFormatter = new frontend.formatter.InclineFormatter();
            powerLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_POWER");
            powerFormatter = new frontend.formatter.PowerFormatter();
            unitStringPower = utils.LanguageManager.getString("UNIT_WATT");
            powerPerKGLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_WATT_PER_KG");
            powerPerKGFormatter = new frontend.formatter.PowerPerKGFormatter();
            if (core.MeasurementConfig.weightFormat != core.general.WeightUnit.KG) 
            {
                unitStringPowerPerKg = utils.LanguageManager.getString("UNIT_WATT_PER_LB");
                powerPerKGFormatter.decimalSeparator = ".";
            }
            else 
            {
                unitStringPowerPerKg = utils.LanguageManager.getString("UNIT_WATT_PER_KG");
                powerPerKGFormatter.decimalSeparator = ",";
            }
            powerPerKGConverter = new utils.converter.PowerPerWeightConverter();
            powerPerKGConverter.inputFormat = core.general.WeightUnit.KG;
            powerPerKGConverter.outputFormat = core.MeasurementConfig.weightFormat;
            unitStringKj = utils.LanguageManager.getString("UNIT_KJ");
            riseRateLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_RISERATE");
            speedLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_SPEED");
            speedFormatter = new frontend.formatter.SpeedFormatter();
            speedConverter = new utils.converter.SpeedConverter();
            speedConverter.inputFormat = utils.format.SpeedFormat.METER_PER_SECOND;
            speedConverter.outputFormat = core.MeasurementConfig.speedFormat;
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                if (core.MeasurementConfig.distanceFormat == utils.format.DistanceFormat.MILE) 
                {
                    unitStringSpeed = utils.LanguageManager.getString("UNIT_MPH");
                    unitStringSpeedTime = utils.LanguageManager.getString("UNIT_MIN_PER_MILE");
                    speedFormatter.decimalSeparator = ".";
                }
            }
            else 
            {
                unitStringSpeed = utils.LanguageManager.getString("UNIT_KMH");
                unitStringSpeedTime = utils.LanguageManager.getString("UNIT_MIN_PER_KM");
                speedFormatter.decimalSeparator = ",";
            }
            temperatureLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TEMPERATURE");
            temperatureFormatter = new frontend.formatter.TemperatureFormatter();
            if (core.MeasurementConfig.temperatureFormat != utils.format.TemperatureFormat.CELSIUS) 
            {
                if (core.MeasurementConfig.temperatureFormat == utils.format.TemperatureFormat.FAHRENHEIT) 
                {
                    unitStringTemperature = utils.LanguageManager.getString("UNIT_FAHRENHEIT");
                    temperatureFormatter.formatString = "B.A";
                    temperatureFormatter.fractionalDigits = 0;
                }
            }
            else 
            {
                unitStringTemperature = utils.LanguageManager.getString("UNIT_CELSIUS");
                temperatureFormatter.formatString = "B,A";
                temperatureFormatter.fractionalDigits = 1;
            }
            timeFormatter = new frontend.formatter.TimeFormatter();
            timeFormatterHHMM = new frontend.formatter.TimeFormatter();
            timeFormatterHHMM.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatterHHMM.formatString = "HH:MM";
            timeFormatterHHMMSST = new frontend.formatter.TimeFormatter();
            timeFormatterHHMMSST.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatterHHMMSST.formatString = "HH:MM:SS.t";
            unitStringHeartrate = utils.LanguageManager.getString("UNIT_BPM");
            dateFormatter = new utils.formatter.DateFormatterMx();
            if (core.MeasurementConfig.dateFormat != utils.format.DateFormat.EUROPEAN) 
            {
                dateFormatter.formatString = utils.formatter.DateFormatterMx.US_FORMAT;
            }
            else 
            {
                dateFormatter.formatString = utils.formatter.DateFormatterMx.EU_FORMAT;
            }
            dateTimeFormatter = new utils.formatter.DateFormatterMx();
            if (core.MeasurementConfig.clockFormat != utils.format.ClockFormat.CLOCK_12H) 
            {
                dateTimeFormatter.formatString = utils.formatter.DateFormatterMx.CLOCK_24;
                clockFormat = utils.formatter.DateFormatterMx.CLOCK_24;
            }
            else 
            {
                dateTimeFormatter.formatString = utils.formatter.DateFormatterMx.CLOCK_12;
                clockFormat = utils.formatter.DateFormatterMx.CLOCK_12;
            }
            countdownFormatter = new frontend.formatter.TimeFormatter();
            countdownFormatter.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            countdownFormatter.formatString = "H:MM:SS.t";
            autoLapTimeFormatter = new frontend.formatter.TimeFormatter();
            autoLapTimeFormatter.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            autoLapTimeFormatter.formatString = "H:MM:SS";
            timeFormatter_MM_SS = new frontend.formatter.TimeFormatter();
            timeFormatter_MM_SS.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatter_MM_SS.formatString = "MM:SS";
            wheelSizeFormatter = new frontend.formatter.WheelSizeFormatter();
            weightConverter = new utils.converter.WeightConverter();
            weightConverter.inputFormat = core.general.WeightUnit.G;
            weightConverter.outputFormat = core.MeasurementConfig.weightFormat;
            weightFormatter = new frontend.formatter.NumberFormatter();
            weightFormatter.decimalSeparator = weightConverter.outputFormat != core.general.WeightUnit.KG ? "." : ",";
            weightFormatter.fractionalDigits = 1;
            if (weightConverter.outputFormat != core.general.WeightUnit.KG) 
            {
                weightFormatter.decimalSeparator = ".";
                unitStringWeight = utils.LanguageManager.getString("UNIT_LB");
            }
            else 
            {
                weightFormatter.decimalSeparator = ",";
                unitStringWeight = utils.LanguageManager.getString("UNIT_KG");
            }
            seaLevelFormatter = new frontend.formatter.SeaLevelFormatter();
            seaLevelFormatter.decimalSeparator = altitudeConverter.outputFormat != utils.format.AltitudeFormat.METER ? "." : ",";
            unitStringSeaLevel = utils.LanguageManager.getString("UNIT_HPA");
            bodySizeConverter = new utils.converter.SizeConverter();
            bodySizeConverter.inputFormat = utils.format.BodySizeFormat.CENTIMETER;
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                bodySizeConverter.outputFormat = utils.format.BodySizeFormat.INCH;
                unitStringBodySize = utils.LanguageManager.getString("UNIT_INCH");
            }
            else 
            {
                bodySizeConverter.outputFormat = utils.format.BodySizeFormat.CENTIMETER;
                unitStringBodySize = utils.LanguageManager.getString("UNIT_CM");
            }
            bodySizeFormatter = new frontend.formatter.NumberFormatter();
            bodySizeFormatter.fractionalDigits = 0;
            validateMonthLabels();
            intensityZonePercentageFormatter = new frontend.formatter.NumberFormatter();
            intensityZonePercentageFormatter.fractionalDigits = 0;
            intensityFactorFormatter = new frontend.formatter.IntensityFactorFormatter();
            intensityFactorFormatter.decimalSeparator = ",";
            tssFormatter = new frontend.formatter.NumberFormatter();
            tssFormatter.decimalSeparator = ",";
            tssFormatter.fractionalDigits = 1;
            percentFormatter = new frontend.formatter.NumberFormatter();
            percentFormatter.fractionalDigits = 0;
            latLonFormatter = new frontend.formatter.NumberFormatter();
            latLonFormatter.decimalSeparator = ".";
            latLonFormatter.fractionalDigits = 6;
            latLonDegreesFormatter = new frontend.formatter.NumberFormatter();
            latLonDegreesFormatter.fractionalDigits = 0;
            latLonMinutesFormatter = new frontend.formatter.NumberFormatter();
            latLonMinutesFormatter.fractionalDigits = 0;
            latLonSecondsFormatter = new frontend.formatter.NumberFormatter();
            latLonSecondsFormatter.decimalSeparator = ".";
            latLonSecondsFormatter.fractionalDigits = 2;
            return;
        }

        internal static function updateMeasurementConfig():void
        {
            core.MeasurementConfig.language = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.LANGUAGE, core.general.LanguageSoftware.DE_DE);
            core.MeasurementConfig.dateFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.DATE_FORMAT, utils.format.DateFormat.EUROPEAN);
            core.MeasurementConfig.clockFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.CLOCK_FORMAT, utils.format.ClockFormat.CLOCK_24H);
            core.MeasurementConfig.distanceFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.DISTANCE_FORMAT, utils.format.DistanceFormat.KILOMETER);
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheAttributeNames.SPEED_FORMAT, core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER ? utils.format.SpeedFormat.MILES_PER_HOUR : utils.format.SpeedFormat.KILOMETER_PER_HOUR);
            core.MeasurementConfig.speedFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.SPEED_FORMAT, utils.format.SpeedFormat.KILOMETER_PER_HOUR);
            core.MeasurementConfig.altitudeFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.ALTITUDE_FORMAT, utils.format.AltitudeFormat.METER);
            core.MeasurementConfig.weightFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.WEIGHT_FORMAT, core.general.WeightUnit.KG);
            core.MeasurementConfig.temperatureFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.TEMPERATURE_FORMAT, utils.format.TemperatureFormat.CELSIUS);
            return;
        }

        internal static function validateMonthLabels():void
        {
            monthLabelsLong = new Vector.<String>();
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JANUARY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_FEBRUARY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_MARCH_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_APRIL_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_MAY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JUNE_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JULY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_AUGUST_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_SEPTEMBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_OCTOBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_NOVEMBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_DECEMBER_LONG"));
            monthLabelsShort = new Vector.<String>();
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JANUARY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_FEBRUARY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_MARCH"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_APRIL"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_MAY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JUNE"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JULY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_AUGUST"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_SEPTEMBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_OCTOBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_NOVEMBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_DECEMBER"));
            return;
        }

        public static function get dateFormatter():utils.interfaces.ICustomFormatter
        {
            return backend.utils.DataUtils._779770692dateFormatter;
        }

        public static function set dateFormatter(arg1:utils.interfaces.ICustomFormatter):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._779770692dateFormatter;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._779770692dateFormatter = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dateFormatter", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get dateTimeFormatter():utils.interfaces.ICustomFormatter
        {
            return backend.utils.DataUtils._483524753dateTimeFormatter;
        }

        public static function set dateTimeFormatter(arg1:utils.interfaces.ICustomFormatter):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._483524753dateTimeFormatter;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._483524753dateTimeFormatter = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dateTimeFormatter", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringAltitude():String
        {
            return backend.utils.DataUtils._1519444873unitStringAltitude;
        }

        public static function set unitStringAltitude(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1519444873unitStringAltitude;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1519444873unitStringAltitude = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringAltitude", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringDistance():String
        {
            return backend.utils.DataUtils._1027431882unitStringDistance;
        }

        public static function set unitStringDistance(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1027431882unitStringDistance;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1027431882unitStringDistance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringDistance", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringFuelEconomy():String
        {
            return backend.utils.DataUtils._277633613unitStringFuelEconomy;
        }

        public static function get unitStringHeartrate():String
        {
            return backend.utils.DataUtils._1634669297unitStringHeartrate;
        }

        public static function set unitStringHeartrate(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1634669297unitStringHeartrate;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1634669297unitStringHeartrate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringHeartrate", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringRiseRate():String
        {
            return backend.utils.DataUtils._357338850unitStringRiseRate;
        }

        public static function set unitStringRiseRate(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._357338850unitStringRiseRate;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._357338850unitStringRiseRate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringRiseRate", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringSpeed():String
        {
            return backend.utils.DataUtils._2005501586unitStringSpeed;
        }

        public static function set unitStringSpeed(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._2005501586unitStringSpeed;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._2005501586unitStringSpeed = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringSpeed", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringSpeedTime():String
        {
            return backend.utils.DataUtils._209210241unitStringSpeedTime;
        }

        public static function set unitStringSpeedTime(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._209210241unitStringSpeedTime;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._209210241unitStringSpeedTime = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringSpeedTime", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringTimeHours():String
        {
            return backend.utils.DataUtils._1448584461unitStringTimeHours;
        }

        public static function set unitStringTimeHours(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1448584461unitStringTimeHours;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1448584461unitStringTimeHours = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringTimeHours", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        public static var inclineFormatter:frontend.formatter.InclineFormatter;

        public static var inclineLabel:String;

        public static var intensityFactorFormatter:frontend.formatter.IntensityFactorFormatter;

        public static var intensityZonePercentageFormatter:frontend.formatter.NumberFormatter;

        public static var latLonDegreesFormatter:frontend.formatter.NumberFormatter;

        public static var latLonFormatter:frontend.formatter.NumberFormatter;

        public static var latLonMinutesFormatter:frontend.formatter.NumberFormatter;

        public static var latLonSecondsFormatter:frontend.formatter.NumberFormatter;

        public static var monthLabelsLong:__AS3__.vec.Vector.<String>;

        public static var monthLabelsShort:__AS3__.vec.Vector.<String>;

        public static var percentFormatter:frontend.formatter.NumberFormatter;

        public static var powerFormatter:frontend.formatter.PowerFormatter;

        public static var powerLabel:String;

        public static var powerPerKGConverter:utils.converter.PowerPerWeightConverter;

        public static var powerPerKGFormatter:frontend.formatter.PowerPerKGFormatter;

        public static var powerPerKGLabel:String;

        public static var riseRateLabel:String;

        public static var seaLevelFormatter:frontend.formatter.SeaLevelFormatter;

        public static var speedConverter:utils.converter.SpeedConverter;

        public static var speedFormatter:frontend.formatter.SpeedFormatter;

        public static var speedLabel:String;

        public static var speedTimeConverter:utils.converter.SpeedTimeConverter;

        public static var temperatureConverter:utils.converter.TemperatureConverter;

        public static var temperatureFormatter:frontend.formatter.TemperatureFormatter;

        public static var temperatureLabel:String;

        public static var timeFormatter:utils.interfaces.ICustomFormatter;

        internal static var _779770692dateFormatter:utils.interfaces.ICustomFormatter;

        public static var timeFormatterHHMMSST:utils.interfaces.ICustomTimeFormatter;

        public static var timeFormatter_MM_SS:frontend.formatter.TimeFormatter;

        public static var tssFormatter:frontend.formatter.NumberFormatter;

        internal static var _1519444873unitStringAltitude:String;

        public static var unitStringBodySize:String;

        public static var unitStringCadence:String;

        public static var unitStringCalories:String;

        internal static var _1027431882unitStringDistance:String;

        public static var unitStringExpansion:String;

        internal static var _277633613unitStringFuelEconomy:String;

        internal static var _1634669297unitStringHeartrate:String;

        public static var unitStringIncline:String;

        public static var unitStringKj:String;

        public static var unitStringPercent:String;

        public static var unitStringPower:String;

        public static var unitStringPowerPerKg:String;

        internal static var _357338850unitStringRiseRate:String;

        public static var unitStringSeaLevel:String;

        internal static var _2005501586unitStringSpeed:String;

        internal static var _209210241unitStringSpeedTime:String;

        public static var unitStringTemperature:String;

        internal static var _1448584461unitStringTimeHours:String;

        public static var unitStringWeight:String;

        public static var weightConverter:utils.converter.WeightConverter;

        public static var weightFormatter:frontend.formatter.NumberFormatter;

        public static var altitudeConverter:utils.converter.IConverter;

        public static var altitudeFormatter:utils.interfaces.ICustomFormatter;

        public static var altitudeLabel:String;

        public static var autoLapTimeFormatter:frontend.formatter.TimeFormatter;

        public static var bodySizeConverter:utils.converter.SizeConverter;

        public static var bodySizeFormatter:frontend.formatter.NumberFormatter;

        public static var cadenceFormatter:frontend.formatter.CadenceFormatter;

        public static var cadenceLabel:String;

        public static var caloriesFormatter:frontend.formatter.CaloriesFormatter;

        public static var caloriesLabel:String;

        public static var clockFormat:String;

        public static var countdownFormatter:frontend.formatter.TimeFormatter;

        internal static var _483524753dateTimeFormatter:utils.interfaces.ICustomFormatter;

        public static var timeFormatterHHMM:utils.interfaces.ICustomTimeFormatter;

        public static var distanceConverter:utils.converter.DistanceConverter;

        public static var distanceFormatter:utils.interfaces.ICustomFormatter;

        public static var distanceLabel:String;

        public static var distancePlusMinusLabel:String;

        public static var expansionFormatter:frontend.formatter.ExpansionFormatter;

        public static var expansionLabel:String;

        public static var fuelEconomyConverter:utils.converter.FuelEconomyConverter;

        public static var fuelEconomyFormatter:frontend.formatter.FuelEconomyFormatter;

        public static var fuelEconomyLabel:String;

        public static var heartrateFormatter:frontend.formatter.HeartrateFormatter;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        public static var heartrateLabel:String;

        public static var wheelSizeFormatter:frontend.formatter.WheelSizeFormatter;
    }
}


