//class UnitEditor
package frontend.components.menuList.editors.custom 
{
    import feathers.controls.*;
    import feathers.data.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.component.devices.*;
    import frontend.screen.mydevices.list.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class UnitEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function UnitEditor()
        {
            super();
            title = utils.LanguageManager.getString("DEVICES.SELECT_DEVICE");
            orientation = ORIENTATION_CENTERED;
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddetToStage);
            return;
        }

        public override function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            super.dataProvider = arg1;
            if (this._deviceList && !(dataProvider == null)) 
            {
                this._deviceList.setUnits(dataProvider);
            }
            return;
        }

        public function get showLines():uint
        {
            return this._showLines;
        }

        public function set showLines(arg1:uint):void
        {
            if (arg1 < SHOW_LINES_MIN) 
            {
                arg1 = SHOW_LINES_MIN;
            }
            if (arg1 > SHOW_LINES_MAX) 
            {
                arg1 = SHOW_LINES_MAX;
            }
            this._showLines = arg1;
            return;
        }

        internal function onAddetToStage(arg1:starling.events.Event):void
        {
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            this._editorGroup = new feathers.controls.LayoutGroup();
            this._deviceList = new frontend.screen.component.devices.DeviceList();
            this._deviceList.triggeredHandler = this.onDeviceClicked;
            if (dataProvider) 
            {
                this._deviceList.dataProvider = _dataProvider;
                this.showLines = dataProvider.length;
            }
            this._deviceList.height = this.showLines * frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._editorGroup.height = this.showLines * frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._editorGroup.addChild(this._deviceList);
            return this._editorGroup;
        }

        internal function onDeviceClicked(arg1:frontend.screen.mydevices.list.MyDevicesListItem):void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = arg1;
            saveValue();
            closeEditor();
            return;
        }

        internal static const SHOW_LINES_MAX:uint=5;

        internal static const SHOW_LINES_MIN:uint=1;

        public var loadUnitsOnInit:Boolean=true;

        internal var _showLines:uint=1;

        internal var _deviceList:frontend.screen.component.devices.DeviceList;

        internal var _editorGroup:feathers.controls.LayoutGroup;
    }
}


