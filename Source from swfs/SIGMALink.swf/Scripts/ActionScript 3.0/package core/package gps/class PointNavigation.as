//class PointNavigation
package core.gps 
{
    import core.general.*;
    import core.general.interfaces.*;
    
    public class PointNavigation extends core.gps.LatLon implements core.general.interfaces.ISynchronisable
    {
        public function PointNavigation()
        {
            super();
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

        public function get isDeleted():Boolean
        {
            return _isDeleted;
        }

        public function set isDeleted(arg1:Boolean):void
        {
            _isDeleted = arg1;
            return;
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

        internal var _GUID:String="";

        internal var _isDeleted:Boolean=false;

        internal var _modificationDate:Number=0;

        public var pointNavigationId:int;

        public var selected:Boolean=false;

        public var text1:String="";

        public var text2:String="";

        public var unitGUID:String="";

        public var unitType:core.general.UnitType;
    }
}


