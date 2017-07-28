//class DeviceSportprofileSettingsView
package frontend.screen.mydevices.sportprofiles 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import core.sportprofiles.*;
    import debug.*;
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.component.*;
    import utils.*;
    import utils.converter.*;
    import utils.format.*;
    
    public class DeviceSportprofileSettingsView extends frontend.screen.mydevices.sportprofiles.SportprofilesScreen
    {
        public function DeviceSportprofileSettingsView()
        {
            super();
            this.mxmlContent = [this._DeviceSportprofileSettingsView_Footer1_i()];
            return;
        }

        protected override function validateProperties():void
        {
            var distanceConverterAutoLap:utils.converter.DistanceConverter;
            var autoLapSpinner:frontend.components.menuList.MenuListItem;
            var basedOnDistanceItem:frontend.components.menuList.MenuListItem;
            var basedOnTimeItem:frontend.components.menuList.MenuListItem;
            var basedOnCaloriesItem:frontend.components.menuList.MenuListItem;
            var autoLapAllowed:Array;

            var loc1:*;
            autoLapSpinner = null;
            basedOnDistanceItem = null;
            basedOnTimeItem = null;
            basedOnCaloriesItem = null;
            autoLapAllowed = null;
            dataProvider.removeAll();
            distanceConverterAutoLap = new utils.converter.DistanceConverter(utils.format.DistanceFormat.MILLIMETER, core.MeasurementConfig.distanceFormat);
            title = sportprofile.profileName;
            if (sportprofile is core.settings.interfaces.IAutoPause) 
            {
                addListItem("DEVICE_SPORTPROFILES.AUTO_PAUSE", core.sportprofiles.SportprofileMapper.col_autoPause, (sportprofile as core.settings.interfaces.IAutoPause).autoPause, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (sportprofile is core.settings.interfaces.IAutoLap) 
            {
                autoLapAllowed = new Array();
                autoLapAllowed.push(core.general.AutoLap.OFF);
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnDistance) 
                {
                    autoLapAllowed.push(core.general.AutoLap.DISTANCE);
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnTime) 
                {
                    autoLapAllowed.push(core.general.AutoLap.TIME);
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnCalories) 
                {
                    autoLapAllowed.push(core.general.AutoLap.CALORIES);
                }
                autoLapSpinner = addListItem("SETTINGS_AUTOLAP_ACTIVE", core.sportprofiles.SportprofileMapper.col_autoLap, (sportprofile as core.settings.interfaces.IAutoLap).autoLap, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.AutoLapDataProvider.filter(autoLapAllowed));
                autoLapSpinner.saveCompleteCallback = function (arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
                {
                    debug.Debug.debug(arg2.value + " (" + arg2.rawValue + ") selected");
                    if (sportprofile is core.settings.interfaces.IAutoLapBasedOnDistance) 
                    {
                        basedOnDistanceItem.editable = arg2.rawValue == core.general.AutoLap.DISTANCE;
                    }
                    if (sportprofile is core.settings.interfaces.IAutoLapBasedOnTime) 
                    {
                        basedOnTimeItem.editable = arg2.rawValue == core.general.AutoLap.TIME;
                    }
                    if (sportprofile is core.settings.interfaces.IAutoLapBasedOnCalories) 
                    {
                        basedOnCaloriesItem.editable = arg2.rawValue == core.general.AutoLap.CALORIES;
                    }
                    apply(arg1, arg2);
                    return;
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnDistance) 
                {
                    basedOnDistanceItem = addListItemNumberInput("SETTINGS_AUTOLAP_BASEDON_DISTANCE", core.sportprofiles.SportprofileMapper.col_autoLapDistance, (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance, (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistanceMin, (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistanceMax, backend.utils.DataUtils.distanceFormatter, distanceConverterAutoLap, backend.utils.DataUtils.unitStringDistance);
                    basedOnDistanceItem.editable = (sportprofile as core.settings.interfaces.IAutoLap).autoLap == core.general.AutoLap.DISTANCE;
                    basedOnDistanceItem.minimum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistanceMin;
                    basedOnDistanceItem.maximum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistanceMax;
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnTime) 
                {
                    basedOnTimeItem = addListItem("SETTINGS_AUTOLAP_BASEDON_TIME", core.sportprofiles.SportprofileMapper.col_autoLapTime, (sportprofile as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME, null, backend.utils.DataUtils.autoLapTimeFormatter, false, utils.LanguageManager.getString("UNIT_HOUR"));
                    basedOnTimeItem.editable = (sportprofile as core.settings.interfaces.IAutoLap).autoLap == core.general.AutoLap.TIME;
                    basedOnTimeItem.minimum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTimeMin;
                    basedOnTimeItem.maximum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTimeMax;
                }
                if (sportprofile is core.settings.interfaces.IAutoLapBasedOnCalories) 
                {
                    basedOnCaloriesItem = addListItem("SETTINGS_AUTOLAP_BASEDON_CALORIES", core.sportprofiles.SportprofileMapper.col_autoLapCalories, (sportprofile as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER, null, backend.utils.DataUtils.caloriesFormatter, false, backend.utils.DataUtils.unitStringCalories);
                    basedOnCaloriesItem.editable = (sportprofile as core.settings.interfaces.IAutoLap).autoLap == core.general.AutoLap.CALORIES;
                    basedOnCaloriesItem.minimum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCaloriesMin;
                    basedOnCaloriesItem.maximum = (sportprofile as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCaloriesMax;
                }
            }
            return;
        }

        internal function _DeviceSportprofileSettingsView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", footer);
            return loc1;
        }
    }
}


