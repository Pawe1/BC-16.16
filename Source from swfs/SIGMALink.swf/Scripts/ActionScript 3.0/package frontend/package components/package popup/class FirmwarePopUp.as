//class FirmwarePopUp
package frontend.components.popup 
{
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import frontend.*;
    import starling.display.*;
    import starling.events.*;
    
    public class FirmwarePopUp extends frontend.components.popup.PopUpBase
    {
        public function FirmwarePopUp()
        {
            super();
            _backgroundSkinColor = core.general.Colors.RED;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = 215 * SIGMALink.scaleFactor;
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
            loc2.height = 3;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc3.y = 2;
            loc2.addChild(loc3);
            return loc1;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc4:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.layout.VerticalLayout();
            loc2.gap = BUTTON_PADDING;
            loc2.padding = BUTTON_PADDING;
            var loc3:*=SIGMALink.appWidth - 2 * BUTTON_PADDING;
            loc4 = new feathers.controls.LayoutGroup();
            loc4.layout = loc2;
            loc4.width = SIGMALink.appWidth;
            loc4.layoutData = footerLayoutData;
            loc1.addChild(loc4);
            var loc5:*=new feathers.controls.Button();
            loc5.width = loc3;
            loc5.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_WHATS_NEW");
            loc5.addEventListener(starling.events.Event.TRIGGERED, this.whatsNewButton_triggeredHandler);
            loc4.addChild(loc5);
            var loc6:*=new feathers.controls.Button();
            loc6.width = loc3;
            loc6.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_UPDATE");
            loc6.addEventListener(starling.events.Event.TRIGGERED, this.updateButton_triggeredHandler);
            loc4.addChild(loc6);
            var loc7:*=new feathers.controls.Button();
            loc7.width = loc3;
            loc7.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_CANCEL");
            loc7.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc4.addChild(loc7);
            return loc1;
        }

        protected function whatsNewButton_triggeredHandler(arg1:starling.events.Event):void
        {
            debug.Debug.debug("whats new?");
            return;
        }

        protected function updateButton_triggeredHandler(arg1:starling.events.Event):void
        {
            debug.Debug.debug("Update!");
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            frontend.components.popup.PopUpBase.closePopUp();
            return;
        }

        internal static const BUTTON_PADDING:uint=10;

        public var cancelCallback:Function;
    }
}


