//class TabBarBase
package frontend.components.tabbarbase 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.themes.*;
    import flash.text.engine.*;
    import frontend.components.tabbarbase.skins.*;
    
    public class TabBarBase extends Object
    {
        public function TabBarBase()
        {
            super();
            return;
        }

        public static function getIconTabFactory():feathers.controls.ToggleButton
        {
            var loc1:*=getTab(true);
            return loc1;
        }

        public static function getLabelTabFactory():feathers.controls.ToggleButton
        {
            var loc1:*=getTab();
            return loc1;
        }

        internal static function getTab(arg1:Boolean=false):feathers.controls.ToggleButton
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new feathers.controls.ToggleButton();
            loc1.styleProvider = null;
            loc1.defaultSkin = new frontend.components.tabbarbase.skins.TabBarDefaultSkin();
            loc1.defaultSelectedSkin = new frontend.components.tabbarbase.skins.TabBarSelectedSkin();
            loc1.iconPosition = feathers.controls.Button.ICON_POSITION_TOP;
            if (arg1) 
            {
                loc1.hasLabelTextRenderer = false;
            }
            loc1.gap = 0;
            loc3 = new flash.text.engine.FontDescription(feathers.themes.BaseSIGMATheme.FONT_NAME_ARIAL, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            loc2 = new flash.text.engine.ElementFormat(loc3, Math.round(24 * SIGMALink.scaleFactor), core.general.Colors.DARKFONT);
            loc4 = new flash.text.engine.ElementFormat(loc3, Math.round(24 * SIGMALink.scaleFactor), core.general.Colors.DARKFONT);
            loc1.defaultLabelProperties.elementFormat = loc2;
            loc1.defaultSelectedLabelProperties.elementFormat = loc4;
            return loc1;
        }
    }
}


