//class ListLoader
package frontend.components.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.components.button.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import utils.*;
    
    public class ListLoader extends feathers.controls.LayoutGroup
    {
        public function ListLoader()
        {
            this._noResultText = utils.LanguageManager.getString("LISTLOADER_DEFAULT_NORESULT_TEXT");
            this._loadingAtlas = frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            this._noDataCallout = new frontend.components.button.IconButtonCallout();
            super();
            layout = new feathers.layout.AnchorLayout();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            layoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }

        internal function init():void
        {
            if (this._initialized) 
            {
                return;
            }
            if (this._list == null) 
            {
                flash.utils.setTimeout(this.init, 100);
                return;
            }
            addChild(this._list);
            addChild(this._noResult);
            addChild(this._movie);
            validate();
            this.startLoading();
            addChild(this._noDataCallout);
            return;
        }

        public function set list(arg1:feathers.controls.Scroller):void
        {
            if (!arg1) 
            {
                return;
            }
            this._list = arg1;
            this.listStateHandler = new frontend.components.list.ListStateHandler(this._list);
            this.init();
            return;
        }

        public function startLoading():void
        {
            if (this._loadingAtlas) 
            {
                if (!this._movieClip || this._movieClip.isPlaying) 
                {
                    return;
                }
                this._movieClip = new starling.display.MovieClip(this._loadingAtlas.getTextures("frame_"), 30);
                this._movie.addChild(this._movieClip);
                this._movieClip.play();
                if (!starling.core.Starling.juggler.contains(this._movieClip)) 
                {
                    starling.core.Starling.juggler.add(this._movieClip);
                }
                this.loading = true;
            }
            return;
        }

        public function stopLoading():void
        {
            this.loading = false;
            if (!this._movieClip || !this._movieClip.isPlaying) 
            {
                return;
            }
            if (this._movieClip) 
            {
                this._movieClip.stop();
                if (starling.core.Starling.juggler.contains(this._movieClip)) 
                {
                    starling.core.Starling.juggler.remove(this._movieClip);
                }
            }
            this._movie.removeChildren();
            return;
        }

        public function get loading():Boolean
        {
            return this._loading;
        }

        public function set loading(arg1:Boolean):void
        {
            this._loading = arg1;
            this._list.visible = !this._loading;
            this._list.includeInLayout = !this._loading;
            this._movie.visible = this._loading;
            this._movie.includeInLayout = this._loading;
            this.checkDataProvider();
            return;
        }

        public override function set mxmlContent(arg1:Array):void
        {
            super.mxmlContent = arg1;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._noResult = new feathers.controls.Label();
            this._noResult.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._noResult.maxWidth = SIGMALink.appWidth;
            this._noResult.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._noResult.text = this._noResultText;
            this._noResult.wordWrap = true;
            this._movie = new feathers.controls.LayoutGroup();
            this._movie.includeInLayout = true;
            this._movie.visible = true;
            this._movie.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            return;
        }

        public function get noDataIconButtonAnchor():frontend.components.button.IconButton
        {
            return this._noDataIconButtonAnchor;
        }

        internal function set _66501941noDataIconButtonAnchor(arg1:frontend.components.button.IconButton):void
        {
            this._noDataIconButtonAnchor = arg1;
            this._noDataCallout.anchor = this.noDataIconButtonAnchor;
            this.checkDataProvider();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeChildren();
            return;
        }

        public function get listStateHandler():frontend.components.list.ListStateHandler
        {
            return this._873259721listStateHandler;
        }

        public function set noResultText(arg1:String):void
        {
            this._noResultText = arg1;
            if (this._noResult != null) 
            {
                this._noResult.text = this._noResultText;
            }
            return;
        }

        public function set listStateHandler(arg1:frontend.components.list.ListStateHandler):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._873259721listStateHandler;
            if (loc1 !== arg1) 
            {
                this._873259721listStateHandler = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listStateHandler", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set noDataIconButtonAnchor(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.noDataIconButtonAnchor;
            if (loc1 !== arg1) 
            {
                this._66501941noDataIconButtonAnchor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "noDataIconButtonAnchor", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get noDataText():String
        {
            return this._1346902824noDataText;
        }

        public function set noDataText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1346902824noDataText;
            if (loc1 !== arg1) 
            {
                this._1346902824noDataText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "noDataText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function setNormalState():void
        {
            if (this.listStateHandler != null) 
            {
                this.listStateHandler.setNormalState();
            }
            return;
        }

        public function swapState():void
        {
            if (this.listStateHandler != null) 
            {
                this.listStateHandler.swapState();
            }
            return;
        }

        public function checkDataProvider():void
        {
            var loc1:*=0;
            if (this._list != null) 
            {
                if (this._list is feathers.controls.List) 
                {
                    if ((this._list as feathers.controls.List).dataProvider != null) 
                    {
                        loc1 = (this._list as feathers.controls.List).dataProvider.length;
                    }
                }
                else if (this._list is feathers.controls.GroupedList) 
                {
                    if ((this._list as feathers.controls.GroupedList).dataProvider != null) 
                    {
                        loc1 = (this._list as feathers.controls.GroupedList).dataProvider.getLength();
                    }
                }
            }
            var loc2:*;
            this._noResult.includeInLayout = loc2 = false;
            this._noResult.visible = loc2;
            if (this._noDataCallout) 
            {
                this._noDataCallout.includeInLayout = loc2 = false;
                this._noDataCallout.visible = loc2;
            }
            if (loc1 == 0) 
            {
                this._noResult.includeInLayout = loc2 = true;
                this._noResult.visible = loc2;
                if (this._noDataCallout && this.noDataIconButtonAnchor) 
                {
                    this._noDataCallout.calloutText = this.noDataText;
                    this._noDataCallout.includeInLayout = loc2 = true;
                    this._noDataCallout.visible = loc2;
                }
            }
            return;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            this.init();
            if (this.listStateHandler != null) 
            {
                this.listStateHandler.setNormalState();
            }
            return;
        }

        internal var _list:feathers.controls.Scroller;

        internal var _873259721listStateHandler:frontend.components.list.ListStateHandler;

        internal var _loading:Boolean=true;

        internal var _noDataIconButtonAnchor:frontend.components.button.IconButton;

        internal var _1346902824noDataText:String="";

        internal var _noResultText:String;

        internal var _initialized:Boolean=false;

        internal var _loadingAtlas:starling.textures.TextureAtlas;

        internal var _movie:feathers.controls.LayoutGroup;

        internal var _noResult:feathers.controls.Label;

        internal var _showNoDataTimeout:uint=0;

        internal var _noDataCallout:frontend.components.button.IconButtonCallout;

        internal var _movieClip:starling.display.MovieClip;
    }
}


