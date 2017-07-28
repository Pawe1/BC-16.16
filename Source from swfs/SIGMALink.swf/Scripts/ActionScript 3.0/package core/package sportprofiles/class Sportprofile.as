//class Sportprofile
package core.sportprofiles 
{
    import core.*;
    import core.general.interfaces.*;
    import core.sport.*;
    import core.units.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import helper.*;
    import init.*;
    import utils.*;
    import utils.interfaces.*;
    
    public class Sportprofile extends flash.events.EventDispatcher implements core.general.interfaces.ISynchronisable
    {
        public function Sportprofile(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            return;
        }

        internal function changeFavSet(arg1:uint, arg2:String):void
        {
            if (this.hasOwnProperty("fav_set_" + arg1)) 
            {
                this["fav_set_" + arg1] = arg2;
            }
            return;
        }

        public function get GUID():String
        {
            return _GUID;
        }

        public function set GUID(arg1:String):void
        {
            _GUID = arg1;
            return;
        }

        public function changeFavFunctionList(arg1:uint, arg2:core.sportprofiles.FavFunctionList):void
        {
            if (arg1 == 1) 
            {
                arg2.active = true;
            }
            changeFavSet(arg1, arg2.toJson());
            return;
        }

        public function set isDeleted(arg1:Boolean):void
        {
            _isDeleted = arg1;
            return;
        }

        public function get dateOutputString():String
        {
            if (initFormatter) 
            {
                dateFormatter = initDateTimeFormatter();
                _dateOutputString = dateFormatter.format(modificationDate);
            }
            return _dateOutputString;
        }

        public function set dateOutputString(arg1:String):void
        {
            _dateOutputString = arg1;
            return;
        }

        public function changeLapFavSet(arg1:uint, arg2:String):void
        {
            if (this.hasOwnProperty("lap_fav_set_" + arg1)) 
            {
                this["lap_fav_set_" + arg1] = arg2;
            }
            return;
        }

        public function get isDeleted():Boolean
        {
            return _isDeleted;
        }

        public function changeAutoLapFavSet(arg1:uint, arg2:String):void
        {
            if (this.hasOwnProperty("auto_lap_fav_set_" + arg1)) 
            {
                this["auto_lap_fav_set_" + arg1] = arg2;
            }
            return;
        }

        public function getFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList
        {
            var loc1:*=null;
            if (this.hasOwnProperty("fav_set_" + arg1)) 
            {
                loc1 = new core.sportprofiles.FavFunctionList();
                loc1.fromJson(this["fav_set_" + arg1]);
                if (arg1 == 1) 
                {
                    loc1.active = true;
                }
                return loc1;
            }
            return null;
        }

        public function get modificationDate():Number
        {
            return _modificationDate;
        }

        public function set modificationDate(arg1:Number):void
        {
            _modificationDate = arg1;
            return;
        }

        public function getLapFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList
        {
            var loc1:*=null;
            if (this.hasOwnProperty("lap_fav_set_" + arg1)) 
            {
                loc1 = new core.sportprofiles.FavFunctionList();
                return loc1.fromJson(this["lap_fav_set_" + arg1]);
            }
            return null;
        }

        public function getAutoLapFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList
        {
            var loc1:*=null;
            if (this.hasOwnProperty("auto_lap_fav_set_" + arg1)) 
            {
                loc1 = new core.sportprofiles.FavFunctionList();
                return loc1.fromJson(this["auto_lap_fav_set_" + arg1]);
            }
            return null;
        }

        public override function toString():String
        {
            return "[Sportprofile implements ISynchronisable, IDatabase]";
        }

        public function get sport():core.sport.Sport
        {
            return _sport;
        }

        public function set sport(arg1:core.sport.Sport):void
        {
            _sport = arg1;
            if (_sport) 
            {
                _sportId = _sport.sportId;
            }
            return;
        }

        internal static function initDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter
        {
            var loc1:*=init.BackendInitializer.getInstance().createDateTimeFormatter();
            loc1.dateStyle = "short";
            loc1.timeStyle = "none";
            loc1.setStyle("locale", core.MeasurementConfig.dateFormat != "eu" ? "en_US" : "de_DE");
            return loc1;
        }

        public function get sportId():uint
        {
            return _sportId;
        }

        public function set sportId(arg1:uint):void
        {
            _sportId = arg1;
            return;
        }

        public final function set unit(arg1:core.units.Unit):void
        {
            if (_unit !== arg1) 
            {
                _unit = arg1;
                dispatchEvent(new flash.events.Event("unitChange"));
            }
            return;
        }

        public function get sportprofileId():int
        {
            return _sportprofileId;
        }

        public function set sportprofileId(arg1:int):void
        {
            if (arg1 != _sportprofileId) 
            {
                _sportprofileId = arg1;
                dispatchEvent(new flash.events.Event("currentIdChange"));
            }
            return;
        }

        public final function get unit():core.units.Unit
        {
            return _unit;
        }

        public function get unitGUID():String
        {
            return _unitGUID;
        }

        public function set unitGUID(arg1:String):void
        {
            _unitGUID = arg1;
            return;
        }

        public function clone():core.sportprofiles.Sportprofile
        {
            var loc2:*=flash.utils.getQualifiedClassName(this);
            flash.net.registerClassAlias(loc2, flash.utils.getDefinitionByName(loc2) as Class);
            var loc4:*=this.unit;
            var loc1:*=this.sport;
            this.unit = null;
            this.sport = null;
            var loc3:*=utils.BackendUtil.copy(this) as core.sportprofiles.Sportprofile;
            this.unit = loc4;
            this.sport = loc1;
            loc3.GUID = "";
            loc3.isDeleted = false;
            loc3.selected = false;
            loc3.sportprofileId = 0;
            loc3.unit = this.unit;
            loc3.sport = this.sport;
            return loc3;
        }

        public function copyFrom(arg1:Object):void
        {
            var loc2:*=helper.Object_helper.clone(arg1);
            var loc4:*=0;
            var loc3:*=loc2;
            for (var loc1:* in loc3) 
            {
                if (!this.hasOwnProperty(loc1)) 
                {
                    continue;
                }
                this[loc1] = loc2[loc1];
            }
            return;
        }

        internal var _GUID:String="";

        public var data:Array;

        internal var _isDeleted:Boolean=false;

        internal var _dateOutputString:String="--";

        internal var _modificationDate:Number=0;

        public var profileName:String;

        public var selected:Boolean;

        internal var _sport:core.sport.Sport;

        internal var _sportId:uint=0;

        internal var _sportprofileId:int;

        internal var _unitGUID:String="";

        public static var dateFormatter:utils.interfaces.ICustomDateTimeFormatter;

        public static var initFormatter:Boolean=true;

        internal var _unit:core.units.Unit;
    }
}


