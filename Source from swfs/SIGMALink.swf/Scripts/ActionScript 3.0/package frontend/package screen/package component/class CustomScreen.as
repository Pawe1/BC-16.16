//class CustomScreen
package frontend.screen.component 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CustomScreen extends feathers.controls.Screen
    {
        public function CustomScreen()
        {
            super();
            layout = new feathers.layout.AnchorLayout();
            width = SIGMALink.appWidth;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        public function get title():String
        {
            return this._title;
        }

        internal function set _110371416title(arg1:String):void
        {
            this._title = arg1;
            handler.ViewHandler.getInstance().currentTitle = this._title;
            return;
        }

        protected override function initialize():void
        {
            if (this.initialized) 
            {
                return;
            }
            this.addContent();
            super.initialize();
            this.initialized = true;
            return;
        }

        public override function validate():void
        {
            var loc1:*=isInvalid(feathers.core.FeathersControl.INVALIDATION_FLAG_DATA);
            super.validate();
            if (loc1) 
            {
                this.validateProperties();
            }
            return;
        }

        protected function validateProperties():void
        {
            return;
        }

        protected function addContent():void
        {
            return;
        }

        public function set title(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.title;
            if (loc1 !== arg1) 
            {
                this._110371416title = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "title", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var allowCaching:Boolean=true;

        public var hasBackwardNavigation:Boolean=false;

        public var initialized:Boolean=false;

        public var saveAsOldScreen:Boolean=true;

        public var savePropertiesForBackNavigation:Boolean=false;

        internal var _title:String;
    }
}


