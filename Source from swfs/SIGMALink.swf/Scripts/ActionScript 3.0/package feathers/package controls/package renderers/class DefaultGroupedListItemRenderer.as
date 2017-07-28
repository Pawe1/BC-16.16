//class DefaultGroupedListItemRenderer
package feathers.controls.renderers 
{
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.skins.*;
    
    public class DefaultGroupedListItemRenderer extends feathers.controls.renderers.BaseDefaultItemRenderer implements feathers.controls.renderers.IGroupedListItemRenderer
    {
        public function DefaultGroupedListItemRenderer()
        {
            super();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.renderers.DefaultGroupedListItemRenderer.globalStyleProvider;
        }

        public function get owner():feathers.controls.GroupedList
        {
            return feathers.controls.GroupedList(this._owner);
        }

        public function get groupIndex():int
        {
            return this._groupIndex;
        }

        public function set groupIndex(arg1:int):void
        {
            this._groupIndex = arg1;
            return;
        }

        public function set owner(arg1:feathers.controls.GroupedList):void
        {
            var loc1:*=null;
            if (this._owner == arg1) 
            {
                return;
            }
            if (this._owner) 
            {
                this._owner.removeEventListener(feathers.events.FeathersEventType.SCROLL_START, owner_scrollStartHandler);
                this._owner.removeEventListener(feathers.events.FeathersEventType.SCROLL_COMPLETE, owner_scrollCompleteHandler);
            }
            this._owner = arg1;
            if (this._owner) 
            {
                loc1 = feathers.controls.GroupedList(this._owner);
                this.isSelectableWithoutToggle = loc1.isSelectable;
                this._owner.addEventListener(feathers.events.FeathersEventType.SCROLL_START, owner_scrollStartHandler);
                this._owner.addEventListener(feathers.events.FeathersEventType.SCROLL_COMPLETE, owner_scrollCompleteHandler);
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get itemIndex():int
        {
            return this._itemIndex;
        }

        public function set itemIndex(arg1:int):void
        {
            this._itemIndex = arg1;
            return;
        }

        public override function dispose():void
        {
            this.owner = null;
            super.dispose();
            return;
        }

        public function get layoutIndex():int
        {
            return this._layoutIndex;
        }

        public function set layoutIndex(arg1:int):void
        {
            this._layoutIndex = arg1;
            return;
        }

        public static const ACCESSORY_POSITION_MANUAL:String="manual";

        public static const LAYOUT_ORDER_LABEL_ACCESSORY_ICON:String="labelAccessoryIcon";

        public static const LAYOUT_ORDER_LABEL_ICON_ACCESSORY:String="labelIconAccessory";

        public static const ALTERNATE_STYLE_NAME_DRILL_DOWN:String="feathers-drill-down-item-renderer";

        public static const ALTERNATE_STYLE_NAME_CHECK:String="feathers-check-item-renderer";

        public static const DEFAULT_CHILD_STYLE_NAME_LABEL:String="feathers-item-renderer-label";

        public static const DEFAULT_CHILD_STYLE_NAME_ICON_LABEL:String="feathers-item-renderer-icon-label";

        public static const DEFAULT_CHILD_STYLE_NAME_ACCESSORY_LABEL:String="feathers-item-renderer-accessory-label";

        public static const STATE_UP:String="up";

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_DISABLED:String="disabled";

        public static const STATE_UP_AND_SELECTED:String="upAndSelected";

        public static const STATE_DOWN_AND_SELECTED:String="downAndSelected";

        public static const STATE_HOVER_AND_SELECTED:String="hoverAndSelected";

        public static const STATE_DISABLED_AND_SELECTED:String="disabledAndSelected";

        public static const ICON_POSITION_TOP:String="top";

        public static const ICON_POSITION_RIGHT:String="right";

        public static const ICON_POSITION_BOTTOM:String="bottom";

        public static const ICON_POSITION_LEFT:String="left";

        public static const ICON_POSITION_MANUAL:String="manual";

        public static const ICON_POSITION_LEFT_BASELINE:String="leftBaseline";

        public static const ICON_POSITION_RIGHT_BASELINE:String="rightBaseline";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const ACCESSORY_POSITION_TOP:String="top";

        public static const ACCESSORY_POSITION_RIGHT:String="right";

        public static const ACCESSORY_POSITION_BOTTOM:String="bottom";

        public static const ACCESSORY_POSITION_LEFT:String="left";

        protected var _groupIndex:int=-1;

        protected var _itemIndex:int=-1;

        protected var _layoutIndex:int=-1;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


