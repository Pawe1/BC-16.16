//class TabBarDataProviderObject
package frontend.components.tabbarbase 
{
    import frontend.*;
    import starling.display.*;
    
    public class TabBarDataProviderObject extends Object
    {
        public function TabBarDataProviderObject(arg1:frontend.components.tabbarbase.ITabLayoutContainer)
        {
            super();
            this.instance = arg1;
            this.defaultTexture = arg1.icon;
            this.label = arg1.label;
            return;
        }

        public function get defaultTexture():String
        {
            return this._defaultTexture;
        }

        public function set defaultTexture(arg1:String):void
        {
            this._defaultTexture = arg1;
            if (this._defaultTexture && !(this._defaultTexture == "")) 
            {
                this.defaultIcon = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this._defaultTexture));
            }
            else 
            {
                this.defaultIcon = null;
            }
            return;
        }

        public var defaultIcon:starling.display.Image;

        internal var _defaultTexture:String="";

        public var instance:frontend.components.tabbarbase.ITabLayoutContainer;

        public var label:String="";
    }
}


