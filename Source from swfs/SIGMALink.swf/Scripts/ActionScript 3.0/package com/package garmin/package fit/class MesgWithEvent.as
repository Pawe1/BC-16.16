//class MesgWithEvent
package com.garmin.fit 
{
    public dynamic interface MesgWithEvent
    {
        function getTimestamp():com.garmin.fit.DateTime;

        function setTimestamp(arg1:com.garmin.fit.DateTime):void;

        function getEvent():com.garmin.fit.FITEvent;

        function setEvent(arg1:com.garmin.fit.FITEvent):void;

        function getEventType():com.garmin.fit.EventType;

        function setEventType(arg1:com.garmin.fit.EventType):void;

        function getEventGroup():int;

        function setEventGroup(arg1:int):void;
    }
}


