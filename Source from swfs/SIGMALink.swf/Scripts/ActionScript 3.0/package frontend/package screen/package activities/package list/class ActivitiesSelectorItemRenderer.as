//class ActivitiesSelectorItemRenderer
package frontend.screen.activities.list 
{
    import backend.utils.*;
    import core.activities.*;
    import core.general.*;
    import core.sport.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.text.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.menuList.editors.custom.*;
    import frontend.components.popup.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class ActivitiesSelectorItemRenderer extends frontend.components.list.SelectableGroupedListItemRenderer
    {
        public function ActivitiesSelectorItemRenderer()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.textAlign = "left";
                loc1.autoCorrect = true;
                loc1.softKeyboardType = flash.text.SoftKeyboardType.DEFAULT;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                return loc1;
            }
            super();
            return;
        }

        public override function set data(arg1:Object):void
        {
            super.data = arg1;
            return;
        }

        public override function set isSelected(arg1:Boolean):void
        {
            if (activitiesEditState) 
            {
                return;
            }
            super.isSelected = arg1;
            return;
        }

        public override function set owner(arg1:feathers.controls.GroupedList):void
        {
            super.owner = arg1;
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            editGroup.visible = activitiesEditState;
            return;
        }

        internal function activity():frontend.screen.activities.list.ActivityListItem
        {
            if (data is frontend.screen.activities.list.ActivityListItem) 
            {
                return data as frontend.screen.activities.list.ActivityListItem;
            }
            return null;
        }

        
        {
            activitiesEditState = false;
            customPadding = 17 * SIGMALink.scaleFactor;
            iconGroupWidth = 65 * SIGMALink.scaleFactor;
            iconPaddingTop = 6 * SIGMALink.scaleFactor;
            unitWidth = 50 * SIGMALink.scaleFactor;
        }

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            activitiesEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
            var loc1:*=this.activity();
            if (loc1 && !activitiesEditState) 
            {
                frontend.components.list.SelectableListItem.reset();
            }
            super.multiStateChange_handler(arg1);
            return;
        }

        protected override function check_changeHandler(arg1:starling.events.Event):void
        {
            super.check_changeHandler(arg1);
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            if ((arg1.currentTarget as feathers.controls.Check).isSelected) 
            {
                loc1.addSelection();
            }
            else 
            {
                loc1.defaultSelected = false;
                loc1.removeSelection();
            }
            return;
        }

        internal function onGroupTouched(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc2:*=handler.SportHandler.getInstance().sports.length;
            var loc3:*=new feathers.data.ListCollection();
            var loc4:*=(this.activity() as frontend.screen.activities.list.ActivityListItem).activity;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (handler.SportHandler.getInstance().sports[loc1].keyName != core.sport.Sport.ACTIVITY_TRACKER) 
                {
                    loc3.push({"label":handler.SportHandler.getInstance().sports[loc1].name, "data":handler.SportHandler.getInstance().sports[loc1].sportId, "selected":handler.SportHandler.getInstance().sports[loc1].sportId == loc4.sportId});
                }
                ++loc1;
            }
            this._editor = new frontend.components.menuList.editors.custom.SportAndNameEditor();
            this._editor.dataProvider = loc3;
            this._editor.owner = new frontend.components.menuList.MenuListItem();
            this._editor.rawValue = {"name":loc4.name, "sport":loc4.sportId};
            this._editor.title = utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_NAME");
            this._editor.saveCompleteCallback = this.valueChanged;
            frontend.components.popup.PopUpBase.showModalPopUp(this._editor, true, true);
            return;
        }

        internal function valueChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            debug.Debug.debug("p_returnObj: " + arg2.rawValue);
            var loc1:*=this.activity();
            if (loc1) 
            {
                if (arg2.rawValue.hasOwnProperty("name")) 
                {
                    loc1.name = arg2.rawValue.name;
                    loc1.activity.name = arg2.rawValue.name;
                }
                else 
                {
                    debug.Debug.error("Return-Wert für Name fehlt!");
                }
                if (arg2.rawValue.hasOwnProperty("sport")) 
                {
                    loc1.activity.sportId = arg2.rawValue.sport;
                    loc1.activity.sport = handler.SportHandler.getInstance().resolveSportById(arg2.rawValue.sport);
                    loc1.sport = loc1.activity.sport;
                    loc1.sportIcon = handler.SportHandler.getSportIcon(loc1.sport);
                    loc1.sportBackgroundSkin = handler.SportHandler.getSportBackgroundSkin(loc1.sport);
                }
                else 
                {
                    debug.Debug.error("Return-Wert für Sport fehlt!");
                }
                this.commitData();
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._labelNewOrUpdate = new feathers.controls.Label();
            this._labelNewOrUpdate.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLWHITELABEL;
            this._labelNewOrUpdate.layoutData = new feathers.layout.VerticalLayoutData();
            editGroup.addChild(this._labelNewOrUpdate);
            this._holderGroup = new feathers.controls.LayoutGroup();
            this._holderGroup.width = SIGMALink.appWidth;
            this._holderGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._holderGroup.layout = new feathers.layout.AnchorLayout();
            this._holderGroup.touchGroup = true;
            this._holderGroup.touchable = true;
            this._holderGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this._holderGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onGroupTouched);
            addChild(this._holderGroup);
            this._editIcon = new frontend.components.TextureImage();
            this._editIcon.textureName = frontend.Textures.linkiconsmall;
            this._editIcon.layoutData = new feathers.layout.AnchorLayoutData(1, 1);
            this._holderGroup.addChild(this._editIcon);
            this._iconGroup = new feathers.controls.LayoutGroup();
            this._iconGroup.width = iconGroupWidth;
            this._iconGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._iconGroup.layout = new feathers.layout.AnchorLayout();
            this._iconGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, 0);
            this._holderGroup.addChild(this._iconGroup);
            this._image = new frontend.components.TextureImage();
            this._image.layoutData = new feathers.layout.AnchorLayoutData(iconPaddingTop, NaN, NaN, NaN, 0, NaN);
            this._image.touchable = false;
            this._iconGroup.addChild(this._image);
            this._labelDayOfMonth = new feathers.controls.Label();
            this._labelDayOfMonth.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, customPadding);
            this._iconGroup.addChild(this._labelDayOfMonth);
            this._labelActivityName = new feathers.controls.Label();
            this._labelActivityName.width = SIGMALink.appWidth - editGroupWidth - iconGroupWidth;
            this._labelActivityName.layoutData = new feathers.layout.AnchorLayoutData(customPadding, NaN, NaN, customPadding + iconGroupWidth);
            this._labelActivityName.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
            this._holderGroup.addChild(this._labelActivityName);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDistance.layoutData = new feathers.layout.AnchorLayoutData(customPadding, unitWidth + (customPadding << 1), NaN, NaN);
            this._holderGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelDistanceUnit.layoutData = new feathers.layout.AnchorLayoutData(customPadding, NaN, NaN, SIGMALink.appWidth - unitWidth - customPadding);
            this._holderGroup.addChild(this._labelDistanceUnit);
            this._labelTrainingTime = new feathers.controls.Label();
            this._labelTrainingTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelTrainingTime.layoutData = new feathers.layout.AnchorLayoutData(NaN, unitWidth + (customPadding << 1), customPadding);
            this._holderGroup.addChild(this._labelTrainingTime);
            this._labelTrainingTimeUnit = new feathers.controls.Label();
            this._labelTrainingTimeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelTrainingTimeUnit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, customPadding, SIGMALink.appWidth - unitWidth - customPadding);
            this._holderGroup.addChild(this._labelTrainingTimeUnit);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            if (loc1.isUpdate) 
            {
                this._labelNewOrUpdate.text = utils.LanguageManager.getString("ACTIVITY_SELECTOR.IS_UPDATE");
            }
            else if (loc1.isNew) 
            {
                this._labelNewOrUpdate.text = utils.LanguageManager.getString("ACTIVITY_SELECTOR.IS_NEW");
            }
            else 
            {
                this._labelNewOrUpdate.text = " ";
            }
            this._labelDayOfMonth.text = loc1.startDate.date + "";
            this._labelDayOfMonth.styleName = loc1.sport.labelColor != 16777215 ? feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL : feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_WHITE;
            this._image.source = loc1.sportIcon;
            this._iconGroup.backgroundSkin = loc1.sportBackgroundSkin;
            if (loc1.name != "") 
            {
                this._labelActivityName.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL;
                this._labelActivityName.text = loc1.name;
            }
            else 
            {
                this._labelActivityName.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_LIGHT;
                this._labelActivityName.text = utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_NAME_PLACEHOLDER");
            }
            this._labelDistance.text = loc1.distance;
            this._labelDistance.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistance.validate();
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this._labelDistanceUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistanceUnit.validate();
            this._labelTrainingTime.text = loc1.trainingTime;
            this._labelTrainingTimeUnit.text = backend.utils.DataUtils.unitStringTimeHours;
            this._labelTrainingTime.validate();
            this._holderGroup.x = activitiesEditState ? editGroupWidth + 1 : 0;
            this._holderGroup.width = activitiesEditState ? (SIGMALink.appWidth - editGroupWidth - 1) : SIGMALink.appWidth;
            this._labelActivityName.width = SIGMALink.appWidth - editGroupWidth - iconGroupWidth - this._labelTrainingTime.width - unitWidth - 4 * customPadding;
            var loc2:*=SIGMALink.appWidth - unitWidth - customPadding;
            if (activitiesEditState) 
            {
                loc2 = loc2 - editGroupWidth;
            }
            var loc3:*=this._labelDistanceUnit.layoutData as feathers.layout.AnchorLayoutData;
            loc3.top = customPadding + (this._labelDistance.height - this._labelDistanceUnit.height >> 1);
            loc3.left = loc2;
            var loc4:*=this._labelTrainingTimeUnit.layoutData as feathers.layout.AnchorLayoutData;
            loc4.bottom = loc3.top;
            loc4.left = loc2;
            if (loc1.defaultSelected) 
            {
                loc1.addSelection();
                checkbox.isSelected = true;
            }
            else 
            {
                checkbox.isSelected = loc1.isSelected();
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        internal var _editIcon:frontend.components.TextureImage;

        internal var _editor:frontend.components.menuList.editors.custom.SportAndNameEditor;

        internal var _holderGroup:feathers.controls.LayoutGroup;

        internal var _iconGroup:feathers.controls.LayoutGroup;

        internal var _image:frontend.components.TextureImage;

        internal var _labelActivityName:feathers.controls.Label;

        internal var _labelDayOfMonth:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _labelNewOrUpdate:feathers.controls.Label;

        internal var _labelTrainingTime:feathers.controls.Label;

        internal var _labelTrainingTimeUnit:feathers.controls.Label;

        internal var stageTextEditorFunc:Function;

        internal static var activitiesEditState:Boolean=false;

        internal static var customPadding:Number;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;

        internal static var unitWidth:Number;

        internal var _moving:Boolean=false;
    }
}


