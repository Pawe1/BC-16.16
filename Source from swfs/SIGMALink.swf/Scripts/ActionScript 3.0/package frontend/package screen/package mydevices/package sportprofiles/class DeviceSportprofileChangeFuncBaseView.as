//class DeviceSportprofileChangeFuncBaseView
package frontend.screen.mydevices.sportprofiles 
{
    import core.general.*;
    import core.sportprofiles.*;
    import debug.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
    import feathers.events.*;
    import frontend.components.list.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class DeviceSportprofileChangeFuncBaseView extends frontend.screen.component.CustomScreen
    {
        public function DeviceSportprofileChangeFuncBaseView()
        {
            this.listLoader = new frontend.components.list.ListLoader();
            super();
            return;
        }

        protected override function validateProperties():void
        {
            super.validateProperties();
            core.sportprofiles.SportprofileFavFunctions.currentSportprofile = this.sportprofile;
            return;
        }

        protected function createItemRendererFactory():feathers.controls.renderers.IListItemRenderer
        {
            debug.Debug.error("please override");
            return null;
        }

        protected function createDataProvider():feathers.data.ListCollection
        {
            debug.Debug.error("please override");
            return new feathers.data.ListCollection();
        }

        protected function goBack():void
        {
            debug.Debug.error("please override");
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            allowCaching = false;
            hasBackwardNavigation = true;
            saveAsOldScreen = false;
            handler.ViewHandler.getInstance().addBackFunction(this.goBack);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        protected override function addContent():void
        {
            super.addContent();
            this.listLoader = new frontend.components.list.ListLoader();
            this.listLoader.startLoading();
            this.listLoader.height = SIGMALink.containerHeight;
            this.listLoader.width = SIGMALink.appWidth;
            addChild(this.listLoader);
            addChild(new frontend.screen.component.Footer());
            this._customList = new frontend.components.list.CustomList();
            this._customList.addEventListener(starling.events.TouchEvent.TOUCH, this.onListTouch);
            this._customList.height = SIGMALink.containerHeight;
            this._customList.width = SIGMALink.appWidth;
            this._customList.allowMultipleSelection = false;
            this._customList.autoHideBackground = false;
            this._customList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._customList.itemRendererFactory = this.createItemRendererFactory;
            this._customList.dataProvider = this.createDataProvider();
            this.listLoader.list = this._customList;
            this.listLoader.checkDataProvider();
            return;
        }

        internal function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.onListTouchedOk(arg1);
            return;
        }

        protected function onListTouchedOk(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.error("please override");
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().removeBackFunction(this.goBack);
            return;
        }

        protected function get _customList():frontend.components.list.CustomList
        {
            return this._493623986_customList;
        }

        protected function set _customList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._493623986_customList;
            if (loc1 !== arg1) 
            {
                this._493623986_customList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_customList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var category:uint=0;

        public var favsetBox:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox;

        public var favsetNr:uint;

        public var sportprofile:core.sportprofiles.Sportprofile;

        public var viewFilter:uint=1;

        protected var _493623986_customList:frontend.components.list.CustomList;

        protected var listLoader:frontend.components.list.ListLoader;
    }
}


