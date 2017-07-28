//package list
//  class ActivityValueDataProviderObject
package frontend.screen.activities.tabs.values.list 
{
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class ActivityValueDataProviderObject extends Object
    {
        public function ActivityValueDataProviderObject()
        {
            this.footer = {"label":"test"};
            super();
            return;
        }

        public function setValue(arg1:Object, arg2:utils.converter.IConverter=null, arg3:utils.interfaces.ICustomFormatterBase=null):void
        {
            if (arg2) 
            {
                if (arg3) 
                {
                    this.value = arg3.format(arg2.convert(arg1));
                }
                else 
                {
                    this.value = arg2.convert(arg1).toString();
                }
            }
            else if (arg3) 
            {
                this.value = arg3.format(arg1);
            }
            else 
            {
                this.value = arg1 + "";
            }
            return;
        }

        public var clickCallback:Function;

        public var footer:Object;

        public var header:Object;

        public var iconSource:String;

        public var iconText:String;

        public var isHline:Boolean=false;

        public var isSeperator:Boolean=false;

        public var key:String;

        public var speedBasedValue:Number;

        public var unit:String;

        public var value:String;

        public var valueIconSource:String;
    }
}


//  class ActivityValueListFooterItemRenderer
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


//  class ActivityValueListHeaderItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ActivityValueListHeaderItemRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityValueListHeaderItemRenderer()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            height = ROW_HEIGHT;
            padding = 0;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            this.icon = new frontend.components.TextureImage();
            this.icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.icon);
            this.text = new feathers.controls.Label();
            this.text.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this.text.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding + COL_ICON_WIDTH, NaN, 0);
            this.holderGroup.addChild(this.text);
            this.value = new feathers.controls.Label();
            this.value.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.value.layoutData = new feathers.layout.AnchorLayoutData(NaN, ipadding + COL_ICON_WIDTH, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.value);
            this.unit = new feathers.controls.Label();
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SIGMALink.appWidth - COL_ICON_WIDTH, NaN, 0);
            this.unit.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.holderGroup.addChild(this.unit);
            addChild(this.holderGroup);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            if (loc1.clickCallback != null) 
            {
                loc1.clickCallback();
            }
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            this.icon.textureName = loc1.iconSource;
            this.text.text = loc1.iconText;
            this.value.text = loc1.value;
            this.unit.text = loc1.unit;
            this.value.validate();
            this.text.maxWidth = width - 2 * ipadding - 2 * COL_ICON_WIDTH - this.value.width;
            return;
        }

        
        {
            COL_ICON_WIDTH = 80 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 85 * SIGMALink.scaleFactor;
            ipadding = 17 * SIGMALink.scaleFactor;
        }

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var icon:frontend.components.TextureImage;

        internal var text:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var value:feathers.controls.Label;

        internal static var COL_ICON_WIDTH:uint;

        internal static var ROW_HEIGHT:Number;

        internal static var ipadding:Number;
    }
}


//  class ActivityValueListItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ActivityValueListItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function ActivityValueListItemRenderer()
        {
            super();
            height = ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_MIDDLE;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            this.icon = new frontend.components.TextureImage();
            this.icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.icon);
            this.text = new feathers.controls.Label();
            this.text.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this.text.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.text);
            this.value = new feathers.controls.Label();
            this.value.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.value.layoutData = new feathers.layout.AnchorLayoutData(NaN, ipadding + COL_ICON_WIDTH, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.value);
            this.unit = new feathers.controls.Label();
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SIGMALink.appWidth - COL_ICON_WIDTH, NaN, 0);
            this.unit.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.holderGroup.addChild(this.unit);
            addChild(this.holderGroup);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            if (loc1.clickCallback != null) 
            {
                loc1.clickCallback();
            }
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            this.icon.textureName = loc1.iconSource;
            this.text.text = loc1.iconText;
            this.value.text = loc1.value;
            this.unit.text = loc1.unit;
            return;
        }

        
        {
            COL_ICON_WIDTH = 80 * SIGMALink.scaleFactor;
            COL_UNIT_WIDTH = 50 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 51 * SIGMALink.scaleFactor;
            ipadding = 17 * SIGMALink.scaleFactor;
        }

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var icon:frontend.components.TextureImage;

        internal var text:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var value:feathers.controls.Label;

        internal static var COL_ICON_WIDTH:uint;

        internal static var COL_UNIT_WIDTH:uint;

        internal static var ROW_HEIGHT:uint;

        internal static var ipadding:Number;
    }
}


//  class ActivityValuesGroup
package frontend.screen.activities.tabs.values.list 
{
    public class ActivityValuesGroup extends Object
    {
        public function ActivityValuesGroup()
        {
            this.children = [];
            this.footer = {"text":""};
            super();
            return;
        }

        public function addChild(arg1:frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject):void
        {
            if (arg1 is frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject) 
            {
                this.children.push(arg1);
            }
            return;
        }

        public var children:Array;

        public var footer:Object;

        public var header:Object;
    }
}


