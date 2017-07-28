//class NaviItem
package frontend.screen.menu 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class NaviItem extends feathers.controls.LayoutGroup
    {
        public function NaviItem()
        {
            super();
            touchGroup = true;
            layout = new feathers.layout.AnchorLayout();
            addEventListener(feathers.events.FeathersEventType.INITIALIZE, this.onInit);
            addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=null;
            var loc1:*=0;
            if (this.texture != "") 
            {
                loc2 = new frontend.components.TextureImage();
                loc2.textureName = this.texture;
                addChild(loc2);
                loc2.validate();
                loc3 = ITEM_GAP;
                if (loc2.width < ICON_GROUP_WIDTH) 
                {
                    loc3 = (ICON_GROUP_WIDTH - loc2.width) / 2;
                }
                loc2.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, loc3, NaN, 0);
                loc1 = ICON_GROUP_WIDTH;
            }
            if (this.labeltext != "") 
            {
                loc4 = new feathers.controls.Label();
                loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NAVIITEM;
                loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, loc1 + ITEM_GAP, NaN, 0);
                loc4.text = this.labeltext;
                addChild(loc4);
            }
            if (this.useBackgroundSkin) 
            {
                backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            }
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.destination == "") 
            {
                if (this.touchFunction != null) 
                {
                    this.touchFunction();
                }
            }
            else 
            {
                handler.ViewHandler.getInstance().clearHistory();
                handler.ViewHandler.getInstance().mainLayoutGroup.dispatchEventWith(handler.ViewHandler.EVENT_TOGGLE_LEFT_MENU);
                handler.ViewHandler.getInstance().showScreen(this.destination, null, null, true);
            }
            return;
        }

        internal static const ICON_GROUP_WIDTH:Number=105 * SIGMALink.scaleFactor;

        internal static const ITEM_GAP:Number=10 * SIGMALink.scaleFactor;

        public var destination:String="";

        public var labeltext:String="";

        public var texture:String="";

        public var touchFunction:Function;

        public var useBackgroundSkin:Boolean=true;
    }
}


