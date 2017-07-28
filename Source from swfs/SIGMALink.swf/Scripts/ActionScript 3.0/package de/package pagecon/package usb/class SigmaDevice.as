//class SigmaDevice
package de.pagecon.usb 
{
    public class SigmaDevice extends Object
    {
        public function SigmaDevice(arg1:int, arg2:int, arg3:int=-1)
        {
            super();
            mID = arg3;
            mVID = arg1;
            mPID = arg2;
            return;
        }

        public function get id():int
        {
            return mID;
        }

        public function get pid():int
        {
            return mPID;
        }

        public function get vid():int
        {
            return mVID;
        }

        public function toString():String
        {
            return "ID: " + mID + " vID: " + mVID + " pID: " + mPID;
        }

        public function equals(arg1:de.pagecon.usb.SigmaDevice):Boolean
        {
            if (!(arg1 == null) && arg1.id == this.id && arg1.vid == this.vid && arg1.pid == this.pid) 
            {
                return true;
            }
            return false;
        }

        internal var mID:int=-1;

        internal var mPID:int=-1;

        internal var mVID:int=-1;
    }
}


