//class MapXyzPartition
package frontend.components.map 
{
    public class MapXyzPartition extends Object
    {
        public function MapXyzPartition(arg1:String, arg2:String, arg3:String)
        {
            super();
            var loc1:*=arg3.split(".");
            this._dir1 = arg1;
            this._dir2 = arg2;
            this._extension = loc1.pop();
            this._filename = loc1.join("");
            return;
        }

        public function get dir1():String
        {
            return this._dir1;
        }

        public function get dir2():String
        {
            return this._dir2;
        }

        public function get extension():String
        {
            return this._extension;
        }

        public function get filename():String
        {
            return this._filename;
        }

        public function getPath():String
        {
            return this._dir1 + "/" + this._dir2 + "/" + this._filename + "." + this._extension;
        }

        internal var _dir1:String;

        internal var _dir2:String;

        internal var _extension:String;

        internal var _filename:String;
    }
}


