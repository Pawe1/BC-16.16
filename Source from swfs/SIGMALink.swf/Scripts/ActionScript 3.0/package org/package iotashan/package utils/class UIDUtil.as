//class UIDUtil
package org.iotashan.utils 
{
    import flash.utils.*;
    import mx.core.*;
    import mx.utils.*;
    
    use namespace mx_internal;
    
    public class UIDUtil extends Object
    {
        public function UIDUtil()
        {
            super();
            return;
        }

        public static function createUID():String
        {
            var loc2:*=0;
            var loc3:*=0;
            UIDBuffer.position = 0;
            loc2 = 0;
            while (loc2 < 8) 
            {
                UIDBuffer.writeByte(ALPHA_CHAR_CODES[Math.random() * 16]);
                ++loc2;
            }
            loc2 = 0;
            while (loc2 < 3) 
            {
                UIDBuffer.writeByte(45);
                loc3 = 0;
                while (loc3 < 4) 
                {
                    UIDBuffer.writeByte(ALPHA_CHAR_CODES[Math.random() * 16]);
                    ++loc3;
                }
                ++loc2;
            }
            UIDBuffer.writeByte(45);
            var loc4:*;
            var loc1:*=(loc4 = new Date().getTime()).toString(16).toUpperCase();
            loc2 = 8;
            while (loc2 > loc1.length) 
            {
                UIDBuffer.writeByte(48);
                --loc2;
            }
            UIDBuffer.writeUTFBytes(loc1);
            loc2 = 0;
            while (loc2 < 4) 
            {
                UIDBuffer.writeByte(ALPHA_CHAR_CODES[Math.random() * 16]);
                ++loc2;
            }
            return UIDBuffer.toString();
        }

        public static function fromByteArray(arg1:flash.utils.ByteArray):String
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*=0;
            if (!(arg1 == null) && arg1.length >= 16 && arg1.bytesAvailable >= 16) 
            {
                UIDBuffer.position = 0;
                loc2 = 0;
                loc3 = 0;
                while (loc3 < 16) 
                {
                    if (loc3 == 4 || loc3 == 6 || loc3 == 8 || loc3 == 10) 
                    {
                        UIDBuffer.writeByte(45);
                    }
                    loc1 = arg1.readByte();
                    UIDBuffer.writeByte(ALPHA_CHAR_CODES[(loc1 & 240) >>> 4]);
                    UIDBuffer.writeByte(ALPHA_CHAR_CODES[loc1 & 15]);
                    ++loc3;
                }
                return UIDBuffer.toString();
            }
            return null;
        }

        public static function isUID(arg1:String):Boolean
        {
            var loc2:*=0;
            var loc1:*=NaN;
            if (!(arg1 == null) && arg1.length == 36) 
            {
                loc2 = 0;
                while (loc2 < 36) 
                {
                    loc1 = arg1.charCodeAt(loc2);
                    if (loc2 == 8 || loc2 == 13 || loc2 == 18 || loc2 == 23) 
                    {
                        if (loc1 != 45) 
                        {
                            return false;
                        }
                    }
                    else if (loc1 < 48 || loc1 > 70 || loc1 > 57 && loc1 < 65) 
                    {
                        return false;
                    }
                    ++loc2;
                }
                return true;
            }
            return false;
        }

        public static function toByteArray(arg1:String):flash.utils.ByteArray
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=null;
            var loc4:*=0;
            var loc5:*=0;
            if (isUID(arg1)) 
            {
                loc1 = new flash.utils.ByteArray();
                loc3 = 0;
                while (loc3 < arg1.length) 
                {
                    loc2 = arg1.charAt(loc3);
                    if (loc2 != "-") 
                    {
                        loc4 = getDigit(loc2);
                        ++loc3;
                        loc5 = getDigit(arg1.charAt(loc3));
                        loc1.writeByte((loc4 << 4 | loc5) & 255);
                    }
                    ++loc3;
                }
                loc1.position = 0;
                return loc1;
            }
            return null;
        }

        public static function getUID(arg1:Object):String
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=null;
            if (arg1 == null) 
            {
                return loc1;
            }
            if (arg1 is mx.core.IUID) 
            {
                loc1 = mx.core.IUID(arg1).uid;
                if (loc1 == null || loc1.length == 0) 
                {
                    loc1 = createUID();
                    mx.core.IUID(arg1).uid = loc1;
                }
            }
            else if (arg1 is mx.core.IPropertyChangeNotifier && !(arg1 is mx.core.IUIComponent)) 
            {
                loc1 = mx.core.IPropertyChangeNotifier(arg1).uid;
                if (loc1 == null || loc1.length == 0) 
                {
                    loc1 = createUID();
                    mx.core.IPropertyChangeNotifier(arg1).uid = loc1;
                }
            }
            else 
            {
                if (arg1 is String) 
                {
                    return arg1 as String;
                }
                try 
                {
                    if (arg1 is XMLList && arg1.length == 1) 
                    {
                        arg1 = arg1[0];
                    }
                    if (arg1 is XML) 
                    {
                        loc2 = XML(arg1);
                        if ((loc3 = loc2.nodeKind()) == "text" || loc3 == "attribute") 
                        {
                            var loc6:*;
                            return loc6 = loc2.toString();
                        }
                        if (!((loc4 = loc2.notification()) is Function)) 
                        {
                            loc4 = mx.utils.XMLNotifier.mx_internal::initializeXMLForNotification();
                            loc2.setNotification(loc4);
                        }
                        if (loc4["uid"] == undefined) 
                        {
                            var loc7:*;
                            loc4["uid"] = loc7 = createUID();
                            loc1 = loc7;
                        }
                        loc1 = loc4["uid"];
                    }
                    else 
                    {
                        if ("mx_internal_uid" in arg1) 
                        {
                            return loc7 = arg1.mx_internal_uid;
                        }
                        if ("uid" in arg1) 
                        {
                            var loc8:*;
                            return loc8 = arg1.uid;
                        }
                        loc1 = uidDictionary[arg1];
                        if (!loc1) 
                        {
                            loc1 = createUID();
                            try 
                            {
                                arg1.mx_internal_uid = loc1;
                            }
                            catch (e:Error)
                            {
                                uidDictionary[arg1] = loc1;
                            }
                        }
                    }
                }
                catch (e:Error)
                {
                    loc1 = arg1.toString();
                }
            }
            return loc1;
        }

        internal static function getDigit(arg1:String):uint
        {
            var loc1:*=arg1;
            while ("A" === loc1) 
            {
                return 10;
                return 11;
                return 12;
                return 13;
                return 14;
                return 15;
                return new uint(arg1);
            }
        }

        
        {
            uidDictionary = new flash.utils.Dictionary(true);
        }

        internal static const ALPHA_CHAR_CODES:Array=[48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70];

        internal static const DASH:int=45;

        internal static const UIDBuffer:flash.utils.ByteArray=new flash.utils.ByteArray();

        internal static var uidDictionary:flash.utils.Dictionary;
    }
}


