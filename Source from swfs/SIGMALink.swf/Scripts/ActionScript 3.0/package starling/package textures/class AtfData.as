//class AtfData
package starling.textures 
{
    import flash.display3D.*;
    import flash.utils.*;
    
    public class AtfData extends Object
    {
        public function AtfData(arg1:flash.utils.ByteArray)
        {
            var loc2:*=false;
            var loc3:*=0;
            super();
            if (!isAtfData(arg1)) 
            {
                throw new ArgumentError("Invalid ATF data");
            }
            if (arg1[6] != 255) 
            {
                arg1.position = 6;
            }
            else 
            {
                arg1.position = 12;
            }
            var loc1:*=arg1.readUnsignedByte();
            var loc4:*=loc1 & 127;
            switch (loc4) 
            {
                case 0:
                case 1:
                {
                    this._format = flash.display3D.Context3DTextureFormat.BGRA;
                    break;
                }
                case 12:
                case 2:
                case 3:
                {
                    this._format = flash.display3D.Context3DTextureFormat.COMPRESSED;
                    break;
                }
                case 13:
                case 4:
                case 5:
                {
                    this._format = "compressedAlpha";
                    break;
                }
                default:
                {
                    throw new Error("Invalid ATF format");
                }
            }
            this._width = Math.pow(2, arg1.readUnsignedByte());
            this._height = Math.pow(2, arg1.readUnsignedByte());
            this._numTextures = arg1.readUnsignedByte();
            this._isCubeMap = !((loc1 & 128) == 0);
            this._data = arg1;
            if (!(arg1[5] == 0) && arg1[6] == 255) 
            {
                loc2 = (arg1[5] & 1) == 1;
                loc3 = arg1[5] >> 1 & 127;
                this._numTextures = loc2 ? 1 : loc3;
            }
            return;
        }

        public function get format():String
        {
            return this._format;
        }

        public function get width():int
        {
            return this._width;
        }

        public function get height():int
        {
            return this._height;
        }

        public function get numTextures():int
        {
            return this._numTextures;
        }

        public function get isCubeMap():Boolean
        {
            return this._isCubeMap;
        }

        public function get data():flash.utils.ByteArray
        {
            return this._data;
        }

        public static function isAtfData(arg1:flash.utils.ByteArray):Boolean
        {
            var loc1:*=null;
            if (arg1.length < 3) 
            {
                return false;
            }
            loc1 = String.fromCharCode(arg1[0], arg1[1], arg1[2]);
            return loc1 == "ATF";
        }

        internal var _format:String;

        internal var _width:int;

        internal var _height:int;

        internal var _numTextures:int;

        internal var _isCubeMap:Boolean;

        internal var _data:flash.utils.ByteArray;
    }
}


