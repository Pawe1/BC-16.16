//class SortPopUp
package frontend.components.popup 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.list.*;
    import starling.display.*;
    import utils.*;
    
    public class SortPopUp extends frontend.components.popup.PopUpBase
    {
        public function SortPopUp(arg1:__AS3__.vec.Vector.<frontend.components.list.ListSortItem>, arg2:String, arg3:Boolean=false)
        {
            this.sortItems = arg1;
            this.currentSortField = arg2;
            this.currentSortAscending = arg3;
            super();
            title = utils.LanguageManager.getString("SORT_POPUP.TITLE");
            _backgroundSkinColor = core.general.Colors.WHITE;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 0;
            HEADER_HEIGHT = 65 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth * 0.6;
            height = SIGMALink.appHeight * 0.33;
            minWidth = 240;
            minHeight = 240;
            x = (SIGMALink.appWidth - width) / 2;
            return;
        }

        protected override function initLayout():void
        {
            super.initLayout();
            footerFactory = null;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.height = HEADER_HEIGHT;
            loc1.layoutData = headerLayoutData;
            var loc2:*=new feathers.controls.Label();
            loc2.text = title;
            loc2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc1.addChild(loc2);
            return loc1;
        }

        protected override function addContent():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc4:*=null;
            super.addContent();
            loc1 = new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            contentHolder.layout = loc1;
            var loc3:*=this.sortItems.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = this.sortItems[loc2];
                loc4.ascending = loc4.sortField != this.currentSortField ? false : this.currentSortAscending;
                loc4.selected = loc4.sortField == this.currentSortField;
                loc4.sortFunction = this.applySort;
                contentHolder.addChild(loc4);
                ++loc2;
            }
            this.validatePopUpHeight();
            return;
        }

        protected function validatePopUpHeight():void
        {
            if (contentHolder.numChildren == 0) 
            {
                return;
            }
            var loc1:*=contentHolder.layout as feathers.layout.VerticalLayout;
            var loc2:*=contentHolder.getChildAt(0) as frontend.components.list.ListSortItem;
            height = HEADER_HEIGHT + contentHolder.numChildren * loc2.height + loc1.gap * (contentHolder.numChildren - 1);
            return;
        }

        internal function applySort(arg1:frontend.components.list.ListSortItem):void
        {
            var loc1:*=0;
            var loc2:*=this.sortItems.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (this.sortItems[loc1] != arg1) 
                {
                    this.sortItems[loc1].selected = false;
                }
                ++loc1;
            }
            if (this.sortCallback != null) 
            {
                this.sortCallback(arg1);
            }
            return;
        }

        public var sortCallback:Function;

        protected var sortItems:__AS3__.vec.Vector.<frontend.components.list.ListSortItem>;

        internal var currentSortAscending:Boolean=false;

        internal var currentSortField:String;
    }
}


