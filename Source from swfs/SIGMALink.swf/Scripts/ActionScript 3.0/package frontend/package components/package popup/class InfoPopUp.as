//class InfoPopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class InfoPopUp extends frontend.components.popup.PopUpBase
    {
        public function InfoPopUp(arg1:Boolean=true, arg2:Boolean=true, arg3:Function=null, arg4:Function=null)
        {
            this._1642565809_cancelBtnLabel = utils.LanguageManager.getString("CANCEL_BUTTON");
            this._description = new feathers.controls.Label();
            this._1513957997_okBtnLabel = utils.LanguageManager.getString("OK_BUTTON");
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            this._showOkButton = arg1;
            this._showCancelButton = arg2;
            this.okCallback = arg3;
            this.cancelCallback = arg4;
            return;
        }

        public function setOkButtonLabel(arg1:String, arg2:Boolean=true):void
        {
            if (arg2) 
            {
                this._okBtnLabel = utils.LanguageManager.getString(arg1);
            }
            else 
            {
                this._okBtnLabel = arg1;
            }
            return;
        }

        public function setCancelButtonLabel(arg1:String, arg2:Boolean=true):void
        {
            if (arg2) 
            {
                this._cancelBtnLabel = utils.LanguageManager.getString(arg1);
            }
            else 
            {
                this._cancelBtnLabel = arg1;
            }
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.45;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            var loc2:*=new feathers.controls.LayoutGroup();
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

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.width = SIGMALink.appWidth;
            loc2.layoutData = footerLayoutData;
            loc1.addChild(loc2);
            if (this._showOkButton) 
            {
                loc3 = new feathers.controls.Button();
                loc3.label = this._okBtnLabel;
                loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
                loc3.addEventListener(starling.events.Event.TRIGGERED, this.okButton_triggeredHandler);
                loc2.addChild(loc3);
            }
            if (this._showCancelButton) 
            {
                loc4 = new feathers.controls.Button();
                loc4.label = this._cancelBtnLabel;
                loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, _layoutGap, NaN, NaN, NaN, 0);
                loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
                loc2.addChild(loc4);
            }
            return loc1;
        }

        protected override function addContent():void
        {
            super.addContent();
            this._description.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this._description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            this._description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._description.wordWrap = true;
            contentHolder.addChild(this._description);
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.validatePopUpContent();
            return;
        }

        protected function validatePopUpContent():void
        {
            this._description.text = this.text;
            return;
        }

        internal function okButton_triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.okCallback != null) 
            {
                this.okCallback(this);
            }
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
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

        internal function get _cancelBtnLabel():String
        {
            return this._1642565809_cancelBtnLabel;
        }

        internal function set _cancelBtnLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1642565809_cancelBtnLabel;
            if (loc1 !== arg1) 
            {
                this._1642565809_cancelBtnLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_cancelBtnLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _okBtnLabel():String
        {
            return this._1513957997_okBtnLabel;
        }

        internal function set _okBtnLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1513957997_okBtnLabel;
            if (loc1 !== arg1) 
            {
                this._1513957997_okBtnLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_okBtnLabel", loc1, arg1, this);
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

        public var data:Object;

        internal var _1115058732headline:String="INFO";

        public var okCallback:Function;

        public var text:String;

        internal var _1642565809_cancelBtnLabel:String;

        internal var _description:feathers.controls.Label;

        internal var _1513957997_okBtnLabel:String;

        internal var _showCancelButton:Boolean=true;

        internal var _showOkButton:Boolean=true;
    }
}


