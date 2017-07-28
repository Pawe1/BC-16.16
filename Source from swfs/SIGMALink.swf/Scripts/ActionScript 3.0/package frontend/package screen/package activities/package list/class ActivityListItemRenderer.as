//class ActivityListItemRenderer
package frontend.screen.activities.list 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ActivityListItemRenderer extends frontend.components.list.SelectableGroupedListItemRenderer
    {
        public function ActivityListItemRenderer()
        {
            super();
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

        protected override function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            activitiesEditState = arg1.newState == frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
            invalidate(INVALIDATION_FLAG_SIZE);
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
                loc1.removeSelection();
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._iconGroup = new feathers.controls.LayoutGroup();
            this._iconGroup.width = iconGroupWidth;
            this._iconGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._iconGroup.layout = new feathers.layout.AnchorLayout();
            this._iconGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, 0);
            this._group.addChild(this._iconGroup);
            this._image = new frontend.components.TextureImage();
            this._image.layoutData = new feathers.layout.AnchorLayoutData(iconPaddingTop, NaN, NaN, NaN, 0, NaN);
            this._image.touchable = false;
            this._iconGroup.addChild(this._image);
            this._labelDayOfMonth = new feathers.controls.Label();
            this._labelDayOfMonth.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, customPadding);
            this._iconGroup.addChild(this._labelDayOfMonth);
            this._labelName = new feathers.controls.Label();
            this._labelName.wordWrap = false;
            this._labelName.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this._labelName.layoutData = new feathers.layout.AnchorLayoutData(customPadding, NaN, NaN, customPadding + iconGroupWidth);
            this._group.addChild(this._labelName);
            this._shareIcon = new frontend.components.TextureImage();
            this._shareIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, customPadding, customPadding + iconGroupWidth);
            this._shareIcon.addEventListener(starling.events.Event.TRIGGERED, this.onShareIconTriggered);
            this._group.addChild(this._shareIcon);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDistance.layoutData = new feathers.layout.AnchorLayoutData(customPadding, unitWidth + (customPadding << 1), NaN, NaN);
            this._group.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelDistanceUnit.layoutData = new feathers.layout.AnchorLayoutData(customPadding, NaN, NaN, SIGMALink.appWidth - unitWidth - customPadding);
            this._group.addChild(this._labelDistanceUnit);
            this._labelTrainingTime = new feathers.controls.Label();
            this._labelTrainingTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelTrainingTime.layoutData = new feathers.layout.AnchorLayoutData(NaN, unitWidth + (customPadding << 1), customPadding);
            this._group.addChild(this._labelTrainingTime);
            this._labelTrainingTimeUnit = new feathers.controls.Label();
            this._labelTrainingTimeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelTrainingTimeUnit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, customPadding, SIGMALink.appWidth - unitWidth - customPadding);
            this._group.addChild(this._labelTrainingTimeUnit);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        internal function onShareIconTriggered(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            arg1.stopImmediatePropagation();
            var loc1:*=this.activity();
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_SHARE_ACTIVITY, {"activityId":loc1.activityId}, handler.ViewHandler.slideToLeftTransition());
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
            this._labelDayOfMonth.text = loc1.startDate.date + "";
            this._labelDayOfMonth.styleName = loc1.sport.labelColor != 16777215 ? feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL : feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_WHITE;
            this._image.source = loc1.sportIcon;
            this._iconGroup.backgroundSkin = loc1.sportBackgroundSkin;
            this._labelName.text = loc1.name;
            if (this._group.contains(this._shareIcon)) 
            {
                if (loc1.shareIcon) 
                {
                    this._shareIcon.includeInLayout = true;
                    this._shareIcon.source = loc1.shareIcon;
                }
                else 
                {
                    this._shareIcon.includeInLayout = false;
                }
            }
            this._labelDistance.text = loc1.distance;
            this._labelDistance.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistance.validate();
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this._labelDistanceUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistanceUnit.validate();
            this._labelTrainingTime.text = loc1.trainingTime;
            this._labelTrainingTimeUnit.text = backend.utils.DataUtils.unitStringTimeHours;
            this._group.x = activitiesEditState ? editGroupWidth + 1 : 0;
            this._group.width = activitiesEditState ? (SIGMALink.appWidth - editGroupWidth - 1) : SIGMALink.appWidth;
            var loc2:*=SIGMALink.appWidth - unitWidth - iconGroupWidth - 4 * customPadding - this._labelDistance.width;
            var loc3:*=SIGMALink.appWidth - unitWidth - customPadding;
            if (activitiesEditState) 
            {
                loc2 = loc2 - editGroupWidth;
                loc3 = loc3 - editGroupWidth;
            }
            this._labelName.width = loc2;
            var loc4:*=this._labelDistanceUnit.layoutData as feathers.layout.AnchorLayoutData;
            loc4.top = customPadding + (this._labelDistance.height - this._labelDistanceUnit.height >> 1);
            loc4.left = loc3;
            var loc5:*=this._labelTrainingTimeUnit.layoutData as feathers.layout.AnchorLayoutData;
            loc5.bottom = loc4.top;
            loc5.left = loc3;
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

        protected override function layoutContent():void
        {
            super.layoutContent();
            var loc1:*=this.activity();
            if (!loc1) 
            {
                return;
            }
            editGroup.visible = activitiesEditState;
            checkbox.isSelected = loc1.isSelected();
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

        internal var _group:feathers.controls.LayoutGroup;

        internal var _iconGroup:feathers.controls.LayoutGroup;

        internal var _image:frontend.components.TextureImage;

        internal var _labelDayOfMonth:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _labelName:feathers.controls.Label;

        internal var _labelTrainingTime:feathers.controls.Label;

        internal var _labelTrainingTimeUnit:feathers.controls.Label;

        internal var _moving:Boolean=false;

        internal var _shareIcon:frontend.components.TextureImage;

        internal static var activitiesEditState:Boolean=false;

        internal static var customPadding:Number;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;

        internal static var unitWidth:Number;
    }
}


