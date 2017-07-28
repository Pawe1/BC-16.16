//class SubField
package com.garmin.fit 
{
    import __AS3__.vec.*;
    
    public class SubField extends Object
    {
        public function SubField(arg1:String, arg2:int, arg3:Number, arg4:Number, arg5:String)
        {
            super();
            this._name = new String(arg1);
            this._type = arg2;
            this._scale = arg3;
            this._offset = arg4;
            this._units = new String(arg5);
            this.maps = new __AS3__.vec.Vector.<SubFieldMap>(0);
            return;
        }

        public function get name():String
        {
            return _name;
        }

        public function get type():int
        {
            return _type;
        }

        public function get scale():Number
        {
            return _scale;
        }

        public function get offset():Number
        {
            return _offset;
        }

        public function get units():String
        {
            return _units;
        }

        protected function getName():String
        {
            return name;
        }

        protected function getType():int
        {
            return type;
        }

        protected function getUnits():String
        {
            return units;
        }

        public function addMap(arg1:int, arg2:Number):void
        {
            maps.push(new SubFieldMap(arg1, arg2));
            return;
        }

        public function canMesgSupport(arg1:com.garmin.fit.Mesg):Boolean
        {
            var loc3:*=0;
            var loc2:*=maps;
            for each (var loc1:* in loc2) 
            {
                if (!loc1.canMesgSupport(arg1)) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        internal var _name:String;

        internal var _type:int;

        internal var _scale:Number;

        internal var _offset:Number;

        internal var _units:String;

        internal var maps:__AS3__.vec.Vector.<SubFieldMap>;
    }
}


class SubFieldMap extends Object
{
    public function SubFieldMap(arg1:int, arg2:Number)
    {
        super();
        this.refFieldNum = arg1;
        this.refFieldValue = arg2;
        return;
    }

    public function canMesgSupport(arg1:com.garmin.fit.Mesg):Boolean
    {
        var loc2:*=NaN;
        var loc1:*=arg1.getField(refFieldNum);
        if (loc1 != null) 
        {
            loc2 = loc1.getLongValue(0, 65535);
            if (!isNaN(loc2)) 
            {
                if (loc2 == refFieldValue) 
                {
                    return true;
                }
            }
        }
        return false;
    }

    internal var refFieldNum:int;

    internal var refFieldValue:Number;
}

