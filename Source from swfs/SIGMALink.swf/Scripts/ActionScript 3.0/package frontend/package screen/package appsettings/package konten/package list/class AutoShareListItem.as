//class AutoShareListItem
package frontend.screen.appsettings.konten.list 
{
    import configCache.*;
    
    public class AutoShareListItem extends Object
    {
        public function AutoShareListItem()
        {
            super();
            return;
        }

        public function get selected():Boolean
        {
            if (this.key != "") 
            {
                return configCache.ConfigCache.getInstance().getValue(this.key, true);
            }
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            if (this.key == "") 
            {
                this._selected = arg1;
            }
            else 
            {
                configCache.ConfigCache.getInstance().setValue(this.key, arg1);
            }
            return;
        }

        public var key:String="";

        public var label:String="";

        internal var _selected:Boolean=false;

        public var sportId:uint=0;

        public var userId:uint=0;
    }
}


