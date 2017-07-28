//package tabbarbase
//  package skins
//    class TabBarDefaultSkin
package frontend.components.tabbarbase.skins 
{
    import core.general.*;
    import starling.display.*;
    
    public class TabBarDefaultSkin extends starling.display.Sprite
    {
        public function TabBarDefaultSkin()
        {
            super();
            var loc1:*=new starling.display.Quad(1, 19 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc2:*=new starling.display.Quad(1, 2 * SIGMALink.scaleFactor, core.general.Colors.MIDGREY);
            loc2.y = 19 * SIGMALink.scaleFactor;
            addChild(loc2);
            addChild(loc1);
            return;
        }
    }
}


//    class TabBarSelectedSkin
package frontend.components.tabbarbase.skins 
{
    import core.general.*;
    import starling.display.*;
    
    public class TabBarSelectedSkin extends starling.display.Sprite
    {
        public function TabBarSelectedSkin()
        {
            super();
            var loc1:*=new starling.display.Quad(1, 19 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc2:*=new starling.display.Quad(1, 2 * SIGMALink.scaleFactor, core.general.Colors.RED);
            loc2.y = 19 * SIGMALink.scaleFactor;
            addChild(loc2);
            addChild(loc1);
            return;
        }
    }
}


//  class ITabLayoutContainer
package frontend.components.tabbarbase 
{
    public interface ITabLayoutContainer
    {
        function get height():Number;

        function set height(arg1:Number):void;

        function get icon():String;

        function get label():String;

        function get subHeader():String;

        function get width():Number;

        function set width(arg1:Number):void;

        function showContent():void;

        function hideContent():void;
    }
}


//  class TabBarBase
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


//  class TabBarDataProviderObject
package frontend.components.tabbarbase 
{
    import frontend.*;
    import starling.display.*;
    
    public class TabBarDataProviderObject extends Object
    {
        public function TabBarDataProviderObject(arg1:frontend.components.tabbarbase.ITabLayoutContainer)
        {
            super();
            this.instance = arg1;
            this.defaultTexture = arg1.icon;
            this.label = arg1.label;
            return;
        }

        public function get defaultTexture():String
        {
            return this._defaultTexture;
        }

        public function set defaultTexture(arg1:String):void
        {
            this._defaultTexture = arg1;
            if (this._defaultTexture && !(this._defaultTexture == "")) 
            {
                this.defaultIcon = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this._defaultTexture));
            }
            else 
            {
                this.defaultIcon = null;
            }
            return;
        }

        public var defaultIcon:starling.display.Image;

        internal var _defaultTexture:String="";

        public var instance:frontend.components.tabbarbase.ITabLayoutContainer;

        public var label:String="";
    }
}


//  class TabLayoutGroup
package frontend.components.tabbarbase 
{
    import core.general.*;
    import feathers.controls.*;
    import starling.display.*;
    
    public class TabLayoutGroup extends feathers.controls.LayoutGroup implements frontend.components.tabbarbase.ITabLayoutContainer
    {
        public function TabLayoutGroup()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            return;
        }

        public function get subHeader():String
        {
            return this._subHeader;
        }

        public function set subHeader(arg1:String):void
        {
            this._subHeader = arg1;
            return;
        }

        public function showContent():void
        {
            return;
        }

        public function hideContent():void
        {
            return;
        }

        internal var _icon:String="";

        internal var _label:String="";

        internal var _subHeader:String="";
    }
}


//  class TabLayoutScroller
package frontend.components.tabbarbase 
{
    import core.general.*;
    import frontend.components.scrollContainer.*;
    import starling.display.*;
    
    public class TabLayoutScroller extends frontend.components.scrollContainer.CustomVScrollContainer implements frontend.components.tabbarbase.ITabLayoutContainer
    {
        public function TabLayoutScroller()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            return;
        }

        public function get subHeader():String
        {
            return this._subHeader;
        }

        public function set subHeader(arg1:String):void
        {
            this._subHeader = arg1;
            return;
        }

        public function showContent():void
        {
            return;
        }

        public function hideContent():void
        {
            return;
        }

        internal var _icon:String="";

        internal var _label:String="";

        internal var _subHeader:String="";
    }
}


