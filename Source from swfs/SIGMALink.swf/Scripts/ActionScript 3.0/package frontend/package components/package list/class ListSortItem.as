//class ListSortItem
package frontend.components.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.*;
    import frontend.components.core.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ListSortItem extends frontend.components.core.Group
    {
        public function ListSortItem(arg1:String, arg2:String, arg3:Boolean)
        {
            super();
            this.text = arg1;
            this.sortField = arg2;
            this.ascending = arg3;
            this.validateLayout();
            this.validateSortItem();
            addEventListener(starling.events.TouchEvent.TOUCH, this.itemTouch_handler);
            return;
        }

        public function get ascending():Boolean
        {
            return this._ascending;
        }

        public function set ascending(arg1:Boolean):void
        {
            if (this._ascending != arg1) 
            {
                this._ascending = arg1;
                this.validateSortItem();
            }
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            if (this._selected != arg1) 
            {
                this._selected = arg1;
                this.validateSortItem();
            }
            return;
        }

        protected function validateLayout():void
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = ITEM_GAP;
            loc1.horizontalAlign = feathers.layout.HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
            loc1.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            layout = loc1;
            height = ITEM_HEIGHT;
            percentWidth = 100;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        internal function validateSkin():void
        {
            height = ITEM_HEIGHT;
            return;
        }

        protected function validateSortItem():void
        {
            removeChildren(0);
            var loc1:*=new feathers.controls.Label();
            loc1.text = this.text;
            addChild(loc1);
            if (this.selected) 
            {
                this.icon = new frontend.components.TextureImage();
                this.icon.textureName = this.ascending ? "iconup" : "icondown";
                var loc2:*;
                this.icon.scaleY = loc2 = 0.5;
                this.icon.scaleX = loc2;
                addChild(this.icon);
                backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }
            else 
            {
                backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }
            return;
        }

        internal function itemTouch_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.selected) 
            {
                this.ascending = !this.ascending;
            }
            else 
            {
                this.selected = true;
            }
            if (this.sortFunction != null) 
            {
                this.sortFunction(this);
            }
            return;
        }

        
        {
            ITEM_GAP = 16 * SIGMALink.scaleFactor;
            ITEM_HEIGHT = 65 * SIGMALink.scaleFactor;
        }

        internal var _ascending:Boolean=true;

        public var icon:frontend.components.TextureImage;

        internal var _selected:Boolean=true;

        public var sortField:String;

        public var sortFunction:Function;

        public var text:String;

        public static var ITEM_GAP:Number;

        public static var ITEM_HEIGHT:Number;
    }
}


