//class ShortcutElement
package frontend.screen.dashboard 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ShortcutElement extends feathers.controls.LayoutGroup
    {
        public function ShortcutElement()
        {
            this._575915578elementGap = 6 * SIGMALink.scaleFactor;
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            layout = new feathers.layout.VerticalLayout();
            (layout as feathers.layout.VerticalLayout).gap = this.elementGap;
            (layout as feathers.layout.VerticalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            (layout as feathers.layout.VerticalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.addIcon();
            this.addLabel();
            return;
        }

        protected function addIcon():void
        {
            var loc1:*=null;
            if (this.iconName != "") 
            {
                loc1 = new frontend.components.TextureImage();
                loc1.textureName = this.iconName;
                loc1.touchable = false;
                addChild(loc1);
            }
            return;
        }

        protected function addLabel():void
        {
            this.label = new feathers.controls.Label();
            this.label.text = this.labelText;
            this.label.styleName = "DASHBOARD_SHORTCUT_LABEL";
            this.label.touchable = false;
            addChild(this.label);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(this.targetClass, this.viewData, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        public function get iconName():String
        {
            return this._738113884iconName;
        }

        public function set iconName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._738113884iconName;
            if (loc1 !== arg1) 
            {
                this._738113884iconName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get labelText():String
        {
            return this._607740351labelText;
        }

        public function set labelText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._607740351labelText;
            if (loc1 !== arg1) 
            {
                this._607740351labelText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "labelText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get targetClass():String
        {
            return this._2110678425targetClass;
        }

        public function set targetClass(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2110678425targetClass;
            if (loc1 !== arg1) 
            {
                this._2110678425targetClass = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "targetClass", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get elementGap():Number
        {
            return this._575915578elementGap;
        }

        protected function set elementGap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._575915578elementGap;
            if (loc1 !== arg1) 
            {
                this._575915578elementGap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "elementGap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal var _738113884iconName:String="";

        internal var _607740351labelText:String;

        internal var _2110678425targetClass:String;

        public var viewData:Object=null;

        protected var _575915578elementGap:Number;

        protected var label:feathers.controls.Label;
    }
}


