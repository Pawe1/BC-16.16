//class FieldComponent
package com.garmin.fit 
{
    public class FieldComponent extends Object
    {
        public function FieldComponent(arg1:int, arg2:Boolean, arg3:int, arg4:Number, arg5:Number)
        {
            super();
            this.fieldNum = arg1;
            this.accumulate = arg2;
            this.bits = arg3;
            this.scale = arg4;
            this.offset = arg5;
            return;
        }

        public var fieldNum:int;

        public var accumulate:Boolean;

        public var bits:int;

        public var scale:Number;

        public var offset:Number;
    }
}


