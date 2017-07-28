//class TabContainer
package frontend.components.tab 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.utils.*;
    import frontend.components.scrollContainer.*;
    import frontend.components.tabbarbase.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class TabContainer extends feathers.controls.LayoutGroup
    {
        public function TabContainer()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            layout = new feathers.layout.AnchorLayout();
            return;
        }

        internal function onInit():void
        {
            var loc1:*=NaN;
            loc1 = TAB_HEIGHT;
            this.customScroller = new frontend.components.scrollContainer.CustomHScrollContainer();
            this.customScroller.clipContent = true;
            this.customScroller.layout = new feathers.layout.HorizontalLayout();
            this.customScroller.layoutData = new feathers.layout.AnchorLayoutData(loc1);
            this.customScroller.snapToPages = true;
            this.customScroller.hasElasticEdges = false;
            this.customScroller.autoHideBackground = true;
            this.customScroller.scrollBarDisplayMode = feathers.controls.List.SCROLL_BAR_DISPLAY_MODE_NONE;
            this.customScroller.horizontalScrollPolicy = feathers.controls.List.SCROLL_POLICY_ON;
            this.customScroller.verticalScrollPolicy = feathers.controls.List.SCROLL_POLICY_OFF;
            this.customScroller.addEventListener(feathers.events.FeathersEventType.SCROLL_COMPLETE, this.list_scrollHandler);
            this.customScroller.width = width;
            this.customScroller.height = height - TAB_HEIGHT;
            this.customScroller.pageWidth = width;
            addChild(this.customScroller);
            this.tabbar = new feathers.controls.TabBar();
            this.tabbar.dataProvider = new feathers.data.ListCollection();
            this.tabbar.height = TAB_HEIGHT;
            this.tabbar.width = width;
            this.tabbar.layoutData = new feathers.layout.AnchorLayoutData(0, 0, NaN, 0);
            this.tabbar.styleProvider = null;
            this.tabbar.tabFactory = this.useIconTabs ? frontend.components.tabbarbase.TabBarBase.getIconTabFactory : frontend.components.tabbarbase.TabBarBase.getLabelTabFactory;
            this.tabbar.addEventListener(starling.events.Event.CHANGE, this.onTabSelectionChange);
            addChild(this.tabbar);
            return;
        }

        public function addTab(arg1:frontend.components.tabbarbase.ITabLayoutContainer, arg2:Boolean=false):void
        {
            if (!this.tabbar) 
            {
                this.onInit();
            }
            var loc1:*=new frontend.components.tabbarbase.TabBarDataProviderObject(arg1);
            if (this.useIconTabs) 
            {
                loc1.defaultTexture = arg1.icon;
            }
            this.tabbar.dataProvider.push(loc1);
            if (arg2) 
            {
                this.tabbar.selectedIndex = (this.tabbar.dataProvider.length - 1);
            }
            if (loc1.instance) 
            {
                loc1.instance.width = width;
                loc1.instance.height = height - TAB_HEIGHT;
                this.customScroller.addChild(loc1.instance as starling.display.DisplayObject);
            }
            return;
        }

        public function removeTabs():void
        {
            var loc1:*=0;
            var loc3:*=null;
            if (!this.customScroller) 
            {
                return;
            }
            var loc2:*=this.tabbar.dataProvider.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = (this.tabbar.dataProvider.getItemAt(loc1) as frontend.components.tabbarbase.TabBarDataProviderObject).instance as starling.display.DisplayObject;
                loc3.dispose();
                ++loc1;
            }
            this.tabbar.dataProvider = new feathers.data.ListCollection();
            this.customScroller.removeChildren();
            this.tabbar.selectedIndex = -1;
            return;
        }

        protected function list_scrollHandler(arg1:starling.events.Event):void
        {
            this.tabbar.selectedIndex = this.customScroller.horizontalPageIndex;
            return;
        }

        protected function onTabSelectionChange(arg1:starling.events.Event):void
        {
            if (this._checkTabLater != 0) 
            {
                flash.utils.clearTimeout(this._checkTabLater);
                this._checkTabLater = 0;
            }
            this.customScroller.scrollToPageIndex(this.tabbar.selectedIndex, 0, handler.ViewHandler.ANIMATION_DURATION);
            this._checkTabLater = flash.utils.setTimeout(this.commitCurrentPageIndex, handler.ViewHandler.ANIMATION_DURATION * 1000);
            return;
        }

        internal function commitCurrentPageIndex():void
        {
            var loc1:*=this.selectedItem();
            if (!loc1) 
            {
                return;
            }
            if (this.tabbarSubHeaderLabel) 
            {
                this.tabbarSubHeaderLabel.text = loc1.label;
            }
            var loc2:*=new frontend.components.tab.TabEvent(frontend.components.tab.TabEvent.CHANGED, loc1.instance, loc1);
            dispatchEvent(loc2);
            return;
        }

        public function selectedItem():frontend.components.tabbarbase.TabBarDataProviderObject
        {
            if (this.tabbar.dataProvider && !(this.tabbar.selectedIndex == -1)) 
            {
                return this.tabbar.dataProvider.getItemAt(this.tabbar.selectedIndex) as frontend.components.tabbarbase.TabBarDataProviderObject;
            }
            return null;
        }

        public static const SUB_HEADER_HEIGHT:Number=55 * SIGMALink.scaleFactor;

        public static const TAB_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public var customScroller:frontend.components.scrollContainer.CustomHScrollContainer;

        public var tabbar:feathers.controls.TabBar;

        public var useIconTabs:Boolean=false;

        internal var _checkTabLater:uint;

        internal var tabbarSubHeader:feathers.controls.LayoutGroup;

        internal var tabbarSubHeaderLabel:feathers.controls.Label;
    }
}


