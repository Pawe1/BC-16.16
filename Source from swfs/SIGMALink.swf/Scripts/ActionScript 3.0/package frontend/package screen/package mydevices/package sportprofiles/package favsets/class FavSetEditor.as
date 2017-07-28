//class FavSetEditor
package frontend.screen.mydevices.sportprofiles.favsets 
{
    import core.general.*;
    import core.sportprofiles.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.sportprofiles.favsets.layouts.*;
    import starling.display.*;
    import starling.events.*;
    
    public class FavSetEditor extends feathers.controls.LayoutGroup
    {
        public function FavSetEditor()
        {
            this.favFunctionList = new core.sportprofiles.FavFunctionList();
            super();
            layout = new feathers.layout.VerticalLayout();
            (layout as feathers.layout.VerticalLayout).padding = this.padding;
            (layout as feathers.layout.VerticalLayout).gap = this.gap;
            layoutData = new feathers.layout.VerticalLayoutData(100, 100);
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        internal function set _102102gap(arg1:Number):void
        {
            this._gap = arg1;
            if (!(layout == null) && layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).gap = arg1;
            }
            return;
        }

        public function get padding():Number
        {
            return this._padding;
        }

        internal function set _806339567padding(arg1:Number):void
        {
            this._padding = arg1;
            if (!(layout == null) && layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).padding = arg1;
            }
            return;
        }

        public function initEditor():void
        {
            this._manInitialize = true;
            this.onInit();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            if (this.autoInitialize) 
            {
                this.onInit();
            }
            return;
        }

        internal function onInit():void
        {
            if (!this.autoInitialize && !this._manInitialize) 
            {
                return;
            }
            this._manInitialize = true;
            if (this.favFunctionList.templateId <= 0) 
            {
                this.favFunctionList.templateId = 1;
            }
            this.loadTemplateById(this.favFunctionList.templateId);
            return;
        }

        public function loadTemplateById(arg1:uint=1):void
        {
            if (arg1 == this.favFunctionList.templateId && this._templateInitialized) 
            {
                return;
            }
            var loc1:*=frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayoutsConfig.getTemplateById(arg1);
            var loc2:*=!(arg1 == this.favFunctionList.templateId);
            if (loc1 != null) 
            {
                this.removeChildren();
                this._favsetlayout = new loc1();
                this._favsetlayout.editable = true;
                this._favsetlayout.favFunctionList = this.favFunctionList;
                this._favsetlayout.favsetBoxTouchFunction = this.onFavsetBoxTouched;
                this._favsetlayout.gap = this.gap;
                if (loc2) 
                {
                    this._favsetlayout.setDefaultFavFunctionList(arg1);
                }
                this.addChild(this._favsetlayout);
                if (!(this.favsetBoxTouchFunction == null) && this._templateInitialized) 
                {
                    this.favsetBoxTouchFunction(this.favFunctionList);
                }
                this._templateInitialized = true;
            }
            return;
        }

        internal function onFavsetBoxTouched(arg1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox):void
        {
            if (this.favsetBoxTouchFunction != null) 
            {
                this.favsetBoxTouchFunction(arg1);
            }
            return;
        }

        public function set padding(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.padding;
            if (loc1 !== arg1) 
            {
                this._806339567padding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "padding", loc1, arg1, this);
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

        public static const DEFAULT_GAP:Number=20;

        public static const DEFAULT_PADDING:Number=20;

        public var autoInitialize:Boolean=true;

        public var enabled:Boolean;

        public var favFunctionList:core.sportprofiles.FavFunctionList;

        public var favsetBoxTouchFunction:Function;

        internal var _gap:Number=20;

        internal var _padding:Number=20;

        internal var _favsetlayout:frontend.screen.mydevices.sportprofiles.FavsetLayoutBase;

        internal var _manInitialize:Boolean=false;

        internal var _templateInitialized:Boolean=false;
    }
}


