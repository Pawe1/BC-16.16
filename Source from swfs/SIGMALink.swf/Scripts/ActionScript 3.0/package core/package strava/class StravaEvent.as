//class StravaEvent
package core.strava 
{
    import flash.events.*;
    
    public class StravaEvent extends flash.events.Event
    {
        public function StravaEvent(arg1:String, arg2:core.strava.StravaSegment=null, arg3:Object=null)
        {
            extendedData = arg3;
            stravaSegment = arg2;
            super(arg1, bubbles, cancelable);
            return;
        }

        public static const EVENT_LOAD_SEGMENTS_COMPLETE:String="loadSegmentsComplete";

        public static const EVENT_LOAD_SEGMENTS_HEADER_DOWNLOADED:String="loadSegmentsHeaderDownloaded";

        public static const EVENT_LOAD_SEGMENTS_PROGRESS:String="loadSegmentsProgress";

        public static const EVENT_LOAD_SEGMENTS_TIMEOUT:String="loadSegmentsTimeout";

        public static const EVENT_LOAD_SINGLE_SEGMENT_DETAIL_COMPLETE:String="loadSegmentDetailsDownloaded";

        public var extendedData:Object;

        public var stravaSegment:core.strava.StravaSegment;
    }
}


