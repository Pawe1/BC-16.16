//class SigmaLapMesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaLapMesg extends com.garmin.fit.custom.rox100.SigmaMarkerROX100Mesg
    {
        public function SigmaLapMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(65282));
            return;
        }

        public static function get markerROX100LapMesg():com.garmin.fit.Mesg
        {
            return _markerROX100Mesg;
        }

        
        {
            _markerROX100Mesg = new com.garmin.fit.Mesg("sigmaLap", 65282);
            _markerROX100Mesg.addField(createDescription());
            _markerROX100Mesg.addField(createMarkerTime());
            _markerROX100Mesg.addField(createTitle());
            _markerROX100Mesg.addField(createMarkerDistanceAbsolute());
            _markerROX100Mesg.addField(createMarkerDistanceDownhill());
            _markerROX100Mesg.addField(createMarkerDistanceUphill());
            _markerROX100Mesg.addField(createMarkerTimeAbsolute());
            _markerROX100Mesg.addField(createMarkerMinimumSpeed());
            _markerROX100Mesg.addField(createMarkerTimeDownhill());
            _markerROX100Mesg.addField(createMarkerTimeUphill());
        }

        internal static var _markerROX100Mesg:com.garmin.fit.Mesg;
    }
}


