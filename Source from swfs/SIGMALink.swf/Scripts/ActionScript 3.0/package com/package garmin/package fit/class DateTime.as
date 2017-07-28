//class DateTime
package com.garmin.fit 
{
    public class DateTime extends Object
    {
        public function DateTime(arg1:*)
        {
            super();
            if (arg1 is Date) 
            {
                this.timestamp = ((arg1 as Date).getTime() - 631065600000) / 1000;
            }
            else if (arg1 is Number) 
            {
                this.timestamp = ((arg1 as Number) - 631065600000) / 1000;
            }
            return;
        }

        public function equals(arg1:com.garmin.fit.DateTime):Boolean
        {
            return this.getTimestamp() == arg1.timestamp;
        }

        public function convertSystemTimeToUTC(arg1:Number):void
        {
            if (timestamp < 268435456) 
            {
                timestamp = timestamp + arg1;
            }
            return;
        }

        public function getTimestamp():Number
        {
            return timestamp;
        }

        public function setTimeStamp(arg1:Number):void
        {
            this.timestamp = arg1;
            return;
        }

        public function getDate():Date
        {
            return new Date(timestamp * 1000 + 631065600000);
        }

        public function toString():String
        {
            return getDate().toString();
        }

        public static const MIN:Number=268435456;

        public static const INVALID:Number=4294967295;

        public static const OFFSET:Number=631065600000;

        internal var timestamp:Number;
    }
}


