//class ActivityValueListFooterItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.renderers.*;
    import starling.display.*;
    
    public class ActivityValueListFooterItemRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityValueListFooterItemRenderer()
        {
            super();
            height = ROW_HEIGHT;
            styleProvider = null;
            backgroundSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.LIGHTGREY);
            contentLabelFunction = this.noLabelFunction;
            return;
        }

        internal function noLabelFunction(arg1:Object):String
        {
            return "";
        }

        internal static const ROW_HEIGHT:Number=29 * SIGMALink.scaleFactor;
    }
}


