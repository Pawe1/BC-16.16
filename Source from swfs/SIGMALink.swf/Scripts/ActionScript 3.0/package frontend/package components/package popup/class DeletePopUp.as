//class DeletePopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class DeletePopUp extends frontend.components.popup.PopUpBase
    {
        public function DeletePopUp()
        {
            this.closeBtnLabel = utils.LanguageManager.getString("CANCEL_BUTTON");
            this.deleteBtnLabel = utils.LanguageManager.getString("DELETE_BUTTON");
            this.description = new feathers.controls.Label();
            super();
            _backgroundSkinColor = core.general.Colors.RED;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.33;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc4:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc2 = new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = title;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.addChild(loc3);
            loc4 = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc4.y = (HEADER_HEIGHT - 1);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.width = SIGMALink.appWidth;
            loc2.layoutData = footerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Button();
            loc3.label = this.deleteBtnLabel;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            loc3.addEventListener(starling.events.Event.TRIGGERED, this.deleteButton_triggeredHandler);
            loc2.addChild(loc3);
            var loc4:*=new feathers.controls.Button();
            loc4.label = this.closeBtnLabel;
            loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, _layoutGap, NaN, NaN, NaN, 0);
            loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function addContent():void
        {
            super.addContent();
            this.description.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this.description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            this.description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this.description.wordWrap = true;
            contentHolder.addChild(this.description);
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
            this.description.text = this.text;
            return;
        }

        internal function deleteButton_triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.deleteCallback != null) 
            {
                this.deleteCallback();
            }
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            if (this.cancelCallback != null) 
            {
                this.cancelCallback();
            }
            return;
        }

        public var cancelCallback:Function;

        public var deleteCallback:Function;

        public var text:String;

        protected var closeBtnLabel:String;

        protected var deleteBtnLabel:String;

        protected var description:feathers.controls.Label;
    }
}


