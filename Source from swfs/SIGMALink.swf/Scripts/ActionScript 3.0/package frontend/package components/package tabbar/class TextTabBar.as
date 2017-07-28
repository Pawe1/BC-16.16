//class TextTabBar
package frontend.components.tabbar 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.themes.*;
    import starling.display.*;
    
    public class TextTabBar extends feathers.controls.TabBar
    {
        public function TextTabBar()
        {
            super();
            tabFactory = this.customTabfactory;
            return;
        }

        protected override function layoutTabs():void
        {
            var loc1:*=null;
            super.layoutTabs();
            var loc2:*=0;
            var loc3:*=this.activeTabs;
            for each (loc1 in loc3) 
            {
                loc1.height = loc1.isSelected ? SELECTED_HEIGHT : DEFAULT_HEIGHT;
                loc1.y = loc1.isSelected ? 0 : SELECTED_HEIGHT - DEFAULT_HEIGHT;
                loc1.gap = 0;
                loc1.labelOffsetY = -10 * SIGMALink.scaleFactor;
                loc1.verticalAlign = "bottom";
                this.validateTabStyle(loc1);
            }
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            var loc1:*=null;
            super.selectedIndex = arg1;
            var loc2:*=0;
            var loc3:*=this.activeTabs;
            for each (loc1 in loc3) 
            {
                this.validateTabStyle(loc1);
            }
            return;
        }

        internal function validateTabStyle(arg1:feathers.controls.ToggleButton):void
        {
            arg1.customLabelStyleName = arg1.isSelected ? feathers.themes.CustomSIGMATheme.TABBAR_SELECTED_STYLE_TEXT : feathers.themes.CustomSIGMATheme.TABBAR_NORMAL_STYLE_TEXT;
            arg1.invalidate(INVALIDATION_FLAG_STYLES);
            arg1.validate();
            return;
        }

        internal function customTabfactory():feathers.controls.ToggleButton
        {
            var loc1:*=new feathers.controls.ToggleButton();
            loc1.styleProvider = null;
            loc1.defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            loc1.defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            loc1.customLabelStyleName = feathers.themes.CustomSIGMATheme.TABBAR_NORMAL_STYLE_TEXT;
            return loc1;
        }

        public static const DEFAULT_HEIGHT:Number=40 * SIGMALink.scaleFactor;

        public static const SELECTED_HEIGHT:Number=48 * SIGMALink.scaleFactor;
    }
}


