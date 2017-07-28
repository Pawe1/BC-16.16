//class FavsetLayoutBase
package frontend.screen.mydevices.sportprofiles 
{
    import core.general.*;
    import core.sportprofiles.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class FavsetLayoutBase extends feathers.controls.LayoutGroup
    {
        public function FavsetLayoutBase()
        {
            this._1670629978defaultFunctions = [];
            this._80214450hLayout = new feathers.layout.HorizontalLayout();
            this._379635904vLayout = new feathers.layout.VerticalLayout();
            super();
            this.hLayout.padding = 0;
            this.hLayout.gap = this.gap;
            this.hLayout.verticalAlign = feathers.layout.VerticalAlign.TOP;
            this.hLayout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this.vLayout.padding = 0;
            this.vLayout.gap = this.gap;
            this.vLayout.verticalAlign = feathers.layout.VerticalAlign.TOP;
            this.vLayout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            layoutData = new feathers.layout.VerticalLayoutData(100, 100);
            layout = new feathers.layout.VerticalLayout();
            (layout as feathers.layout.VerticalLayout).padding = 0;
            (layout as feathers.layout.VerticalLayout).gap = this.gap;
            (layout as feathers.layout.VerticalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            (layout as feathers.layout.VerticalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            return;
        }

        public function get padding():Number
        {
            return this._padding;
        }

        public function set padding(arg1:Number):void
        {
            this._padding = arg1;
            if (layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).padding = this.padding;
            }
            if (layout is feathers.layout.HorizontalLayout) 
            {
                (layout as feathers.layout.HorizontalLayout).padding = this.padding;
            }
            return;
        }

        public function set touchFunction(arg1:Function):void
        {
            this._touchFunction = arg1;
            if (this.touchFunction == null) 
            {
                this.removeEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            }
            else 
            {
                this.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            }
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        protected function set defaultFunctions(arg1:Array):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1670629978defaultFunctions;
            if (loc1 !== arg1) 
            {
                this._1670629978defaultFunctions = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "defaultFunctions", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        internal function set _102102gap(arg1:Number):void
        {
            this._gap = arg1;
            if (this.hLayout != null) 
            {
                this.hLayout.gap = this.gap;
            }
            if (this.vLayout != null) 
            {
                this.vLayout.gap = this.gap;
            }
            if (layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).gap = this.gap;
            }
            if (layout is feathers.layout.HorizontalLayout) 
            {
                (layout as feathers.layout.HorizontalLayout).gap = this.gap;
            }
            return;
        }

        internal function set _1191572123selected(arg1:Boolean):void
        {
            this._selected = arg1;
            backgroundSkin = new starling.display.Quad(1, 1, this.selected ? core.general.Colors.RED : core.general.Colors.GREY);
            return;
        }

        protected function onFavsetBoxTouched(arg1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox):void
        {
            if (this.favsetBoxTouchFunction != null) 
            {
                this.favsetBoxTouchFunction(arg1);
            }
            return;
        }

        public function get touchFunction():Function
        {
            return this._touchFunction;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.touchFunction != null) 
            {
                this.favFunctionList = new core.sportprofiles.FavFunctionList();
                this.setDefaultFavFunctionList(this.templateId);
                this.touchFunction(this);
            }
            return;
        }

        public function setDefaultFavFunctionList(arg1:uint):void
        {
            var loc1:*=undefined;
            if (this.defaultFunctions == null || this.defaultFunctions.length <= 0 || this.favFunctionList == null) 
            {
                return;
            }
            this.favFunctionList.templateId = this.templateId;
            this.favFunctionList.resetFavFunctions();
            var loc2:*=0;
            var loc3:*=this.defaultFunctions;
            for (loc1 in loc3) 
            {
                if (!(loc1 > 0)) 
                {
                    continue;
                }
                this.favFunctionList.changeFavFunction(new core.sportprofiles.FavFunctionlistItem(this.defaultFunctions[loc1] as uint, loc1));
            }
            debug.Debug.debug("Neue FavFunctionList (Default-Werte): " + this.favFunctionList.toJson());
            return;
        }

        public function get editable():Boolean
        {
            return this._1602416228editable;
        }

        public function set editable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1602416228editable;
            if (loc1 !== arg1) 
            {
                this._1602416228editable = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editable", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get favFunctionList():core.sportprofiles.FavFunctionList
        {
            return this._1342962513favFunctionList;
        }

        public function set favFunctionList(arg1:core.sportprofiles.FavFunctionList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1342962513favFunctionList;
            if (loc1 !== arg1) 
            {
                this._1342962513favFunctionList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "favFunctionList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set gap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.gap;
            if (loc1 !== arg1) 
            {
                this._102102gap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "gap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set selected(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.selected;
            if (loc1 !== arg1) 
            {
                this._1191572123selected = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selected", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get showLabel():Boolean
        {
            return this._1921447433showLabel;
        }

        public function set showLabel(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1921447433showLabel;
            if (loc1 !== arg1) 
            {
                this._1921447433showLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "showLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get defaultFunctions():Array
        {
            return this._1670629978defaultFunctions;
        }

        protected function get hLayout():feathers.layout.HorizontalLayout
        {
            return this._80214450hLayout;
        }

        protected function set hLayout(arg1:feathers.layout.HorizontalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._80214450hLayout;
            if (loc1 !== arg1) 
            {
                this._80214450hLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get vLayout():feathers.layout.VerticalLayout
        {
            return this._379635904vLayout;
        }

        protected function set vLayout(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._379635904vLayout;
            if (loc1 !== arg1) 
            {
                this._379635904vLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static const FAVSET_DEFAULT_GAP:Number=2;

        internal var _1342962513favFunctionList:core.sportprofiles.FavFunctionList;

        public var favsetBoxTouchFunction:Function;

        public var label:String;

        public var numberOfFunctions:uint=0;

        internal var _padding:Number=0;

        internal var _selected:Boolean=false;

        public var templateId:uint;

        internal var _touchFunction:Function;

        internal var _gap:Number=2;

        internal var _1921447433showLabel:Boolean=true;

        protected var _80214450hLayout:feathers.layout.HorizontalLayout;

        protected var _379635904vLayout:feathers.layout.VerticalLayout;

        public var dataProvider:Array;

        internal var _1602416228editable:Boolean=false;

        protected var _1670629978defaultFunctions:Array;
    }
}


