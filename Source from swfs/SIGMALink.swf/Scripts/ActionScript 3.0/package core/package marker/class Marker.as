//class Marker
package core.marker 
{
    import core.activities.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import utils.*;
    
    public class Marker extends core.marker.MarkerEntity
    {
        public function Marker(arg1:Object=null, arg2:flash.events.IEventDispatcher=null)
        {
            super(arg2);
            if (!allowMarkerCopy && !core.marker.MarkerFactory.isFactoryInstance(arg1)) 
            {
                throw new flash.errors.IllegalOperationError("Instantiation only via Factory Class allowed!");
            }
            return;
        }

        public function setPrimaryKey(arg1:int):void
        {
            if (markerId == 0) 
            {
                markerId = arg1;
            }
            return;
        }

        public function getPrimaryKey():int
        {
            return markerId;
        }

        public final function generateXML():XML
        {
            return null;
        }

        public function getLoggingInfo():String
        {
            var loc1:*="\t-markerId " + markerId.toString() + "\t-markerType " + type.toString();
            if (logReference != null) 
            {
                loc1 = loc1 + ("\t-logId " + logReference.activityId.toString());
            }
            return loc1;
        }

        public override function toString():String
        {
            return "[Marker extends EventDispatcher implements IGeneralMarkerInformation, IMarkerNumber, IMarkerTime, IMarkerTimeAbsolute]";
        }

        public static function copy(arg1:core.marker.Marker, arg2:core.activities.Activity=null):core.marker.Marker
        {
            var loc2:*=flash.utils.getQualifiedClassName(arg1);
            flash.net.registerClassAlias(loc2, flash.utils.getDefinitionByName(loc2) as Class);
            var loc1:*=arg2 ? arg2 : arg1.logReference;
            arg1.logReference = null;
            allowMarkerCopy = true;
            var loc3:*=utils.BackendUtil.copy(arg1) as Marker;
            allowMarkerCopy = false;
            loc3.markerId = 0;
            arg1.logReference = loc1;
            return loc3;
        }

        public var calculateMarkerCalories:Boolean=true;

        public var hasCallout:Boolean=true;

        public var isLastMarker:Boolean=false;

        public var isSelected:Boolean=false;

        public var logReference:core.activities.Activity;

        internal static var allowMarkerCopy:Boolean=false;
    }
}


