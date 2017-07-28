//class GZIPBytesEncoder
package utils.file 
{
    import flash.errors.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class GZIPBytesEncoder extends Object
    {
        public function GZIPBytesEncoder()
        {
            super();
            return;
        }

        public function compressToByteArray(arg1:flash.utils.ByteArray, arg2:Date=null):flash.utils.ByteArray
        {
            var loc1:*=0;
            if (arg1 == null) 
            {
                throw new ArgumentError("src can\'t be null.");
            }
            var loc10:*=arg1.position;
            var loc12:*;
            (loc12 = new flash.utils.ByteArray()).writeBytes(arg1);
            var loc4:*;
            (loc4 = new flash.utils.ByteArray()).endian = "littleEndian";
            var loc8:*=31;
            loc4.writeByte(loc8);
            var loc7:*=139;
            loc4.writeByte(loc7);
            var loc3:*=8;
            loc4.writeByte(loc3);
            var loc2:*=parseInt("00000000", 2);
            loc4.writeByte(loc2);
            var loc5:*=arg2 != null ? arg2.time : 0;
            loc4.writeUnsignedInt(loc5);
            var loc13:*=parseInt("00000100", 2);
            loc4.writeByte(loc13);
            if (flash.system.Capabilities.os.indexOf("Windows") >= 0) 
            {
                loc1 = 11;
            }
            else if (flash.system.Capabilities.os.indexOf("Mac OS") >= 0) 
            {
                loc1 = 7;
            }
            else 
            {
                loc1 = 3;
            }
            loc4.writeByte(loc1);
            var loc6:*;
            var loc11:*=(loc6 = new utils.file.CRC32Generator()).generateCRC32(loc12);
            var loc9:*=loc12.length % Math.pow(2, 32);
            loc12.deflate();
            loc4.writeBytes(loc12, 0, loc12.length);
            loc4.writeUnsignedInt(loc11);
            loc4.writeUnsignedInt(loc9);
            return loc4;
        }

        public function uncompressToByteArray(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc2:*=null;
            loc2 = parseGZIPData(arg1);
            var loc1:*=loc2.getCompressedData();
            try 
            {
                loc1.inflate();
            }
            catch (error:Error)
            {
                throw new flash.errors.IllegalOperationError("The specified source is not a GZIP file format file or data.");
            }
            return loc1;
        }

        public function parseGZIPData(arg1:flash.utils.ByteArray, arg2:String=""):utils.file.GZIPFile
        {
            var loc7:*=null;
            var loc2:*=null;
            var loc15:*=null;
            var loc22:*=null;
            var loc10:*=0;
            if (arg1 == null) 
            {
                throw new ArgumentError("The srcBytes ByteArray can\'t be null.");
            }
            arg1.endian = "littleEndian";
            var loc21:*;
            if ((loc21 = arg1.readUnsignedByte()) != 31) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc19:*;
            if ((loc19 = arg1.readUnsignedByte()) != 139) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc18:*;
            if ((loc18 = arg1.readUnsignedByte()) != 8) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc4:*;
            var loc11:*=((loc4 = arg1.readByte()) >> 7 & 1) == 1;
            var loc16:*=(loc4 >> 6 & 1) == 1;
            var loc13:*=(loc4 >> 5 & 1) == 1;
            var loc20:*=(loc4 >> 4 & 1) == 1;
            var loc1:*=(loc4 >> 3 & 1) == 1;
            var loc6:*=false;
            loc6 = (loc4 >> 2 & 1) != 1 ? loc6 : true;
            loc6 = (loc4 >> 1 & 1) != 1 ? loc6 : true;
            if (loc6 = (loc4 & 1) != 1 ? loc6 : true) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc5:*=arg1.readUnsignedInt();
            var loc23:*=arg1.readUnsignedByte();
            var loc14:*=arg1.readUnsignedByte();
            if (loc13) 
            {
                loc7 = arg1.readUTF();
            }
            var loc12:*=null;
            if (loc20) 
            {
                loc2 = new flash.utils.ByteArray();
                while (arg1.readUnsignedByte() != 0) 
                {
                    --arg1.position;
                    loc2.writeByte(arg1.readByte());
                }
                loc2.position = 0;
                loc12 = loc2.readUTFBytes(loc2.length);
            }
            if (loc1) 
            {
                loc22 = new flash.utils.ByteArray();
                while (arg1.readUnsignedByte() != 0) 
                {
                    --arg1.position;
                    loc22.writeByte(arg1.readByte());
                }
                loc22.position = 0;
                loc15 = loc22.readUTFBytes(loc22.length);
            }
            if (loc16) 
            {
                loc10 = arg1.readUnsignedShort();
            }
            var loc17:*=arg1.length - arg1.position - 8;
            var loc3:*=new flash.utils.ByteArray();
            arg1.readBytes(loc3, 0, loc17);
            var loc9:*=arg1.readUnsignedInt();
            var loc8:*=arg1.readUnsignedInt();
            return new utils.file.GZIPFile(loc3, loc8, new Date(loc5), arg2, loc12, loc15);
        }
    }
}


