//class CustomListCollection
package backend.utils.container 
{
    import __AS3__.vec.*;
    import debug.*;
    import flash.events.*;
    import helper.*;
    import init.interfaces.*;
    
    public class CustomListCollection extends flash.events.EventDispatcher implements init.interfaces.IVectorList
    {
        public function CustomListCollection(arg1:*=null)
        {
            super();
            this.source = arg1;
            return;
        }

        public function get length():int
        {
            return this._source.length;
        }

        public function get source():*
        {
            return this._source;
        }

        public function set source(arg1:*):void
        {
            if (arg1 && !helper.Vector_helper.isVector(arg1)) 
            {
                throw new TypeError("The source of a VectorList must be a Vector");
            }
            this._source = arg1 ? arg1 : new Vector.<>();
            return;
        }

        public function addItem(arg1:Object):void
        {
            this._source.push(arg1);
            return;
        }

        public function contains(arg1:Object):Boolean
        {
            return this._source.indexOf(arg1) >= 0;
        }

        public function createVectorList(arg1:*=null):init.interfaces.IVectorList
        {
            this.source = arg1;
            return this;
        }

        public function getItemAt(arg1:int, arg2:int=0):Object
        {
            if (arg2 > 0) 
            {
                debug.Debug.warning("ACHTUNG! Parameter prefetch wird nicht berücksichtigt.");
            }
            return this._source[arg1];
        }

        public function toArray():Array
        {
            return helper.Array_helper.toArray(this._source);
        }

        internal var _source:*;
    }
}


