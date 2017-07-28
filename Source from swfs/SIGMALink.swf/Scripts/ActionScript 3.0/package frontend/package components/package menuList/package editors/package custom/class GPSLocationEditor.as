//class GPSLocationEditor
package frontend.components.menuList.editors.custom 
{
    import core.general.*;
    import core.gps.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.layout.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.mydevices.pointNavigation.locationEditorTabs.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class GPSLocationEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function GPSLocationEditor()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.autoCorrect = false;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                return loc1;
            }
            super();
            orientation = ORIENTATION_INLINE;
            useTween = false;
            showSaveButton = false;
            this._tabContainer = new frontend.components.tab.TabContainer();
            this._tabContainer.useIconTabs = false;
            this._tabContainer.width = SIGMALink.appWidth;
            return;
        }

        protected override function getContentGroupLayoutData():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.top = owner.getBounds(stage).top + owner.height;
            return loc1;
        }

        protected override function addContent():void
        {
            var loc1:*=NaN;
            var loc3:*=null;
            loc1 = 16 * SIGMALink.scaleFactor;
            createVerticalContentGroup();
            contentGroup.addChild(headerGroup);
            editorInputWidth = SIGMALink.appWidth - 2 * padding;
            this._tabContainer.removeChildren();
            contentGroup.addChild(this._tabContainer);
            this._tabDecimal = new frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal();
            this._tabDecimal.pointChangedCallback = this.onDezimalDegreesChanged;
            this._tabDecimal.label = utils.LanguageManager.getString("POINT_NAVIGATION_LOCATION_INPUT_DECIMAL");
            this._tabDecimal.currentMode = frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal.MODE_DECIMAL;
            this._tabDecimal.point = this.point;
            this._tabDecimal.createLayout();
            this._tabDMS = new frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal();
            this._tabDMS.pointChangedCallback = this.onDegreesMinutesSecondsChanged;
            this._tabDMS.label = utils.LanguageManager.getString("POINT_NAVIGATION_LOCATION_INPUT_DEGREES_MIN_SEC");
            this._tabDMS.currentMode = frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal.MODE_DEGREES_MINUTES_SECONDS;
            this._tabDMS.point = this.point;
            this._tabDMS.createLayout();
            this._tabContainer.height = Math.max(this._tabDecimal.height, this._tabDMS.height);
            this._tabContainer.addTab(this._tabDecimal as frontend.components.tabbarbase.ITabLayoutContainer, true);
            this._tabContainer.addTab(this._tabDMS as frontend.components.tabbarbase.ITabLayoutContainer);
            this._saveButton = new feathers.controls.Button();
            this._saveButton.label = utils.LanguageManager.getString("POINT_NAVIGATION_LOCATION_INPUT_OK");
            this._saveButton.addEventListener(starling.events.Event.TRIGGERED, this.saveButton_triggeredHandler);
            var loc2:*=new feathers.layout.HorizontalLayout();
            loc2.paddingRight = loc1;
            loc2.paddingBottom = loc1;
            loc2.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc3 = new feathers.controls.LayoutGroup();
            loc3.layout = loc2;
            loc3.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc3.width = SIGMALink.appWidth;
            loc3.addChild(this._saveButton);
            contentGroup.addChild(loc3);
            addChild(contentGroup);
            contentGroup.validate();
            contentGroup.layoutData = this.getContentGroupLayoutData();
            return;
        }

        public function updatePoint(arg1:core.gps.LatLon):void
        {
            this.point = arg1;
            if (this._tabDecimal) 
            {
                this._tabDecimal.point = this.point;
                this._tabDecimal.updateInputs();
            }
            if (this._tabDMS) 
            {
                this._tabDMS.point = this.point;
                this._tabDMS.updateInputs();
            }
            return;
        }

        internal function onDegreesMinutesSecondsChanged():void
        {
            if (!this._tabDecimal) 
            {
                return;
            }
            this._tabDecimal.point = this._tabDMS.point;
            this._tabDecimal.updateInputs();
            return;
        }

        internal function onDezimalDegreesChanged():void
        {
            if (!this._tabDMS) 
            {
                return;
            }
            this._tabDMS.point = this._tabDecimal.point;
            this._tabDMS.updateInputs();
            return;
        }

        internal function saveButton_triggeredHandler(arg1:starling.events.Event):void
        {
            this.point = this._tabContainer.tabbar.selectedIndex != 0 ? this._tabDMS.point : this._tabDecimal.point;
            this.closeEditor();
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            return null;
        }

        protected override function saveValue():void
        {
            return;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            return;
        }

        internal function onTextInputChange(arg1:starling.events.Event=null):void
        {
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event=null):void
        {
            return;
        }

        protected override function onOutsideTouch(arg1:starling.events.TouchEvent):void
        {
            this.point = null;
            super.onOutsideTouch(arg1);
            return;
        }

        public override function dispose():void
        {
            if (this._saveButton) 
            {
                this._saveButton.removeEventListener(starling.events.Event.TRIGGERED, this.saveButton_triggeredHandler);
            }
            super.dispose();
            return;
        }

        protected override function closeEditor():void
        {
            super.closeEditor();
            dispatchEventWith(CLOSED);
            return;
        }

        public static const CLOSED:String="closedEvent";

        public var point:core.gps.LatLon;

        internal var _saveButton:feathers.controls.Button;

        internal var _tabContainer:frontend.components.tab.TabContainer;

        internal var _tabDMS:frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal;

        internal var _tabDecimal:frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal;

        internal var stageTextEditorFunc:Function;

        internal var ti:feathers.controls.TextInput;
    }
}


