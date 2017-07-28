//package list
//  class ActivitiesListGroup
package frontend.screen.activities.list 
{
    public class ActivitiesListGroup extends Object
    {
        public function ActivitiesListGroup(arg1:String, arg2:String)
        {
            this.children = new Array();
            this.header = new frontend.screen.activities.list.ActivitiesListGroupHeader();
            super();
            this.header.date = arg1;
            this.header.title = arg2;
            return;
        }

        public function addItem(arg1:frontend.screen.activities.list.ActivityListItem):void
        {
            if (arg1) 
            {
                this.children.push(arg1);
                this.sumDistance = this.sumDistance + arg1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime + arg1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(this.children.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public function addItemAt(arg1:frontend.screen.activities.list.ActivityListItem, arg2:int):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1) 
            {
                loc1 = [];
                loc3 = this.children.length;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    if (loc2 == arg2) 
                    {
                        loc1.push(arg1);
                    }
                    loc1.push(this.children[loc2]);
                    ++loc2;
                }
                if (arg2 == loc3) 
                {
                    loc1.push(arg1);
                }
                this.children = loc1;
                this.sumDistance = this.sumDistance + arg1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime + arg1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(loc1.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public function removeItem(arg1:int):void
        {
            var loc1:*=null;
            if (arg1 < this.children.length) 
            {
                loc1 = this.children.removeAt(arg1);
                this.sumDistance = this.sumDistance - loc1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime - loc1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(this.children.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public var children:Array;

        public var footer:frontend.screen.activities.list.ActivitiesListGroupFooter;

        public var header:frontend.screen.activities.list.ActivitiesListGroupHeader;

        internal var sumDistance:Number=0;

        internal var sumTrainingTime:Number=0;
    }
}


//  class ActivitiesListGroupFooter
package frontend.screen.activities.list 
{
    import frontend.*;
    import starling.textures.*;
    
    public class ActivitiesListGroupFooter extends Object
    {
        public function ActivitiesListGroupFooter(arg1:uint, arg2:Number, arg3:Number)
        {
            super();
            this.length = arg1;
            this.distance = arg2;
            this.trainingTime = arg3;
            this.statisticIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmallcount);
            this.distanceIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalldistance);
            this.timeIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalltime);
            return;
        }

        public function toString():String
        {
            return "";
        }

        public var distance:Number;

        public var distanceIcon:starling.textures.Texture;

        public var length:uint;

        public var statisticIcon:starling.textures.Texture;

        public var timeIcon:starling.textures.Texture;

        public var trainingTime:Number;
    }
}


//  class ActivitiesListGroupHeader
package frontend.screen.activities.list 
{
    public class ActivitiesListGroupHeader extends Object
    {
        public function ActivitiesListGroupHeader()
        {
            super();
            return;
        }

        public function toString():String
        {
            return "";
        }

        public var date:String;

        public var title:String;
    }
}


//  class ActivitiesSelectorItemRenderer
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


//  class ActivityListEvent
package frontend.screen.activities.list 
{
    import core.activities.*;
    import flash.events.*;
    
    public class ActivityListEvent extends flash.events.Event
    {
        public function ActivityListEvent(arg1:String, arg2:core.activities.Activity=null, arg3:String="", arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            this.activity = arg2;
            this.GUID = arg3;
            return;
        }

        public static const DELETE:String="deleteActivityEvent";

        public static const RELOAD:String="reloadActivitiesEvent";

        public static const UPDATE:String="updateActivityInListEvent";

        public var GUID:String="";

        public var activity:core.activities.Activity;

        public var resetLastScrollPosition:Boolean=false;
    }
}


//  class ActivityListItem
package frontend.screen.activities.list 
{
    import core.activities.*;
    import core.sport.*;
    import frontend.components.list.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class ActivityListItem extends frontend.components.list.SelectableListItem
    {
        public function ActivityListItem()
        {
            this.startDate = new Date();
            super();
            return;
        }

        public var activity:core.activities.Activity;

        public var activityId:uint;

        public var defaultSelected:Boolean=false;

        public var distance:String;

        public var distanceValue:Number=0;

        public var isNew:Boolean=false;

        public var isUpdate:Boolean=false;

        public var name:String="";

        public var shareIcon:starling.textures.Texture;

        public var shared:Boolean=false;

        public var sport:core.sport.Sport;

        public var sportBackgroundSkin:starling.display.Quad;

        public var sportIcon:starling.textures.Texture;

        public var startDate:Date;

        public var trainingTime:String;

        public var trainingTimeValue:Number=0;
    }
}


//  class ActivityListItemFooterRenderer
package frontend.screen.activities.list 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import starling.display.*;
    
    public class ActivityListItemFooterRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityListItemFooterRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            super();
            touchable = false;
            height = footerHeight;
            return;
        }

        public override function set data(arg1:Object):void
        {
            super.data = arg1;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.layout = new feathers.layout.AnchorLayout();
            this._group.width = SIGMALink.appWidth;
            this._group.height = footerHeight;
            this._group.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            addChild(this._group);
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = customPadding;
            loc1.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            this.statisticGroup = new feathers.controls.LayoutGroup();
            this.statisticGroup.height = footerHeight;
            this.statisticGroup.layout = loc1;
            this.statisticGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding, NaN, 0);
            this._group.addChild(this.statisticGroup);
            this._imgStatistic = new frontend.components.TextureImage();
            this.statisticGroup.addChild(this._imgStatistic);
            this._labelStatistic = new feathers.controls.Label();
            this._labelStatistic.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.statisticGroup.addChild(this._labelStatistic);
            this.distGroup = new feathers.controls.LayoutGroup();
            this.distGroup.height = footerHeight;
            this.distGroup.layout = loc1;
            this._group.addChild(this.distGroup);
            this._imgDistance = new frontend.components.TextureImage();
            this.distGroup.addChild(this._imgDistance);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.distGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this.distGroup.addChild(this._labelDistanceUnit);
            this.timeGroup = new feathers.controls.LayoutGroup();
            this.timeGroup.height = footerHeight;
            this.timeGroup.layout = loc1;
            this.timeGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, customPadding, NaN, NaN, NaN, 0);
            this._group.addChild(this.timeGroup);
            this._imgTime = new frontend.components.TextureImage();
            this.timeGroup.addChild(this._imgTime);
            this._labelTime = new feathers.controls.Label();
            this._labelTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.timeGroup.addChild(this._labelTime);
            this._labelTimeUnit = new feathers.controls.Label();
            this._labelTimeUnit.width = unitWidth;
            this._labelTimeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelTimeUnit.text = backend.utils.DataUtils.unitStringTimeHours;
            this.timeGroup.addChild(this._labelTimeUnit);
            var loc2:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc2);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.list.ActivitiesListGroupFooter;
            if (!loc1) 
            {
                return;
            }
            this._labelStatistic.text = loc1.length + "";
            this._labelDistance.text = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc1.distance));
            this._labelTime.text = backend.utils.DataUtils.timeFormatter.format(loc1.trainingTime);
            this._imgStatistic.source = loc1.statisticIcon;
            this.statisticGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.statisticGroup.validate();
            this._imgDistance.source = loc1.distanceIcon;
            this.distGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.distGroup.validate();
            this._imgTime.source = loc1.timeIcon;
            this.timeGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.timeGroup.validate();
            var loc2:*=(SIGMALink.appWidth - this.statisticGroup.width - this.distGroup.width - this.timeGroup.width - 4 * customPadding) / 2;
            loc2 = loc2 + (customPadding * 2 + this.statisticGroup.width);
            this.distGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, loc2, NaN, 0);
            return;
        }

        
        {
            customPadding = 17 * SIGMALink.scaleFactor;
            footerHeight = 70 * SIGMALink.scaleFactor;
            unitWidth = 50 * SIGMALink.scaleFactor;
        }

        internal var _group:feathers.controls.LayoutGroup;

        internal var _imgDistance:frontend.components.TextureImage;

        internal var _imgStatistic:frontend.components.TextureImage;

        internal var _imgTime:frontend.components.TextureImage;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _labelStatistic:feathers.controls.Label;

        internal var _labelTime:feathers.controls.Label;

        internal var _labelTimeUnit:feathers.controls.Label;

        internal var distGroup:feathers.controls.LayoutGroup;

        internal var statisticGroup:feathers.controls.LayoutGroup;

        internal var timeGroup:feathers.controls.LayoutGroup;

        internal static var customPadding:Number;

        internal static var footerHeight:Number;

        internal static var unitWidth:Number;
    }
}


//  class ActivityListItemHeaderRenderer
package frontend.screen.activities.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    
    public class ActivityListItemHeaderRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityListItemHeaderRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            this._labelDate = new feathers.controls.Label();
            super();
            touchable = false;
            height = headerHeight;
            styleProvider = null;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.layout = new feathers.layout.AnchorLayout();
            this._group.width = SIGMALink.appWidth;
            this._group.height = headerHeight;
            this._group.backgroundSkin = new starling.display.Quad(SIGMALink.appWidth, headerHeight, core.general.Colors.LIGHTGREY);
            addChild(this._group);
            this._labelDate = new feathers.controls.Label();
            this._labelDate.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
            this._labelDate.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, NaN, PADDING, NaN, PADDING / 2);
            this._group.addChild(this._labelDate);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.list.ActivitiesListGroupHeader;
            if (!loc1) 
            {
                return;
            }
            this._labelDate.text = loc1.title;
            return;
        }

        
        {
            headerHeight = 67 * SIGMALink.scaleFactor;
        }

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _labelDate:feathers.controls.Label;

        internal static var headerHeight:Number;
    }
}


//  class ActivityListItemRenderer
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


