//class IStravaSegmentsSupported
package core.units.interfaces 
{
    import core.strava.*;
    
    public dynamic interface IStravaSegmentsSupported
    {
        function get currentStravaSegment():core.strava.StravaSegment;

        function set currentStravaSegment(arg1:core.strava.StravaSegment):void;
    }
}


