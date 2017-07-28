//class CustomFullscreenContentPopUp
package frontend.components.popup 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.ui.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.screen.component.*;
    import handler.*;
    import helper.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CustomFullscreenContentPopUp extends frontend.components.popup.PopUpBase
    {
        public function CustomFullscreenContentPopUp(arg1:feathers.controls.LayoutGroup, arg2:Boolean=true, arg3:Function=null, arg4:Function=null)
        {
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            height = SIGMALink.appHeight;
            width = SIGMALink.appWidth;
            this._contentGroup = arg1;
            this._showOkButton = arg2;
            this.okCallback = arg3;
            this.cancelCallback = arg4;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc2:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc2 = new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = this.headline;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.addChild(loc3);
            var loc4:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc4.y = (HEADER_HEIGHT - 1);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function androidBackButtonHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!helper.Capabilities_helper.isAndroid()) 
            {
                return;
            }
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                if (this.cancelCallback != null) 
                {
                    this.cancelCallback(this);
                }
            }
            return;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=new Vector.<frontend.components.button.IconButton>();
            if (!helper.Capabilities_helper.isAndroid()) 
            {
                loc4 = new frontend.components.button.IconButton();
                loc4.touchHandler = this.cancelButton_handler;
                loc4.image = frontend.Textures.backbutton;
                loc1.push(loc4);
            }
            if (this._showOkButton) 
            {
                loc5 = new frontend.components.button.IconButton();
                loc5.touchHandler = this.okButton_handler;
                loc5.image = this.okButtonTexture;
                loc1.push(loc5);
            }
            var loc2:*=new frontend.screen.component.Footer();
            loc2.showBackButton = false;
            loc2.forceRightButton = true;
            loc2.setButtonGroup(loc1);
            var loc3:*=new feathers.controls.LayoutGroup();
            loc3.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc3.layout = new feathers.layout.AnchorLayout();
            loc3.addChild(loc2);
            return loc3;
        }

        protected override function addContent():void
        {
            super.addContent();
            if (!this._contentGroup) 
            {
                return;
            }
            this._contentGroup.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this._contentGroup.layoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0, NaN, 0);
            contentHolder.height = height;
            contentHolder.addChild(this._contentGroup);
            return;
        }

        public override function validate():void
        {
            super.validate();
            return;
        }

        internal function okButton_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.okCallback != null) 
            {
                this.okCallback(this);
            }
            return;
        }

        internal function cancelButton_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.cancelCallback != null) 
            {
                this.cancelCallback(this);
            }
            return;
        }

        public function get headline():String
        {
            return this._1115058732headline;
        }

        public function set headline(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1115058732headline;
            if (loc1 !== arg1) 
            {
                this._1115058732headline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headline", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get okButtonTexture():String
        {
            return this._2082819827okButtonTexture;
        }

        public function set okButtonTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2082819827okButtonTexture;
            if (loc1 !== arg1) 
            {
                this._2082819827okButtonTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "okButtonTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var cancelCallback:Function;

        internal var _1115058732headline:String="INFO";

        internal var _2082819827okButtonTexture:String="arrowRight";

        public var okCallback:Function;

        internal var _contentGroup:feathers.controls.LayoutGroup;

        internal var _showOkButton:Boolean=true;
    }
}


