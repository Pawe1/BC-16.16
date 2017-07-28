//class ActivitiesListShortcutElement
package frontend.screen.dashboard 
{
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import flash.data.*;
    import frontend.components.*;
    
    public class ActivitiesListShortcutElement extends frontend.screen.dashboard.ShortcutElement
    {
        public function ActivitiesListShortcutElement()
        {
            super();
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = elementGap;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this._hGroup = new feathers.controls.LayoutGroup();
            this._hGroup.layout = loc1;
            this._counterLabel = new feathers.controls.Label();
            this._counterLabel.styleName = "DASHBOARD_SHORTCUT_VALUE";
            this._counterLabel.touchable = false;
            addChild(this._hGroup);
            return;
        }

        public function updateNumberOfActivities():void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.activities.ActivityMapper.countActivitiesStatement(" and sportId != 16"), this.numberOfActivitiesComplete, this.numberOfActivitiesError);
            return;
        }

        protected override function addIcon():void
        {
            var loc1:*=null;
            if (iconName != "") 
            {
                loc1 = new frontend.components.TextureImage();
                loc1.textureName = iconName;
                loc1.touchable = false;
                this._hGroup.addChild(loc1);
            }
            return;
        }

        protected override function addLabel():void
        {
            label = new feathers.controls.Label();
            label.text = labelText;
            label.styleName = "DASHBOARD_SHORTCUT_LABEL";
            label.touchable = false;
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = elementGap;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.paddingBottom = 18.5 * SIGMALink.scaleFactor;
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = loc1;
            loc2.layoutData = new feathers.layout.VerticalLayoutData(100, 100);
            loc2.addChild(this._counterLabel);
            loc2.addChild(label);
            this._hGroup.addChild(loc2);
            return;
        }

        internal function numberOfActivitiesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.getResult();
            if (loc1.length == 1) 
            {
                this._counterLabel.text = loc1[0].activities;
            }
            debug.Debug.debug("numberOfActivitiesComplete");
            return;
        }

        internal function numberOfActivitiesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("numberOfActivitiesComplete");
            return;
        }

        internal var _counterLabel:feathers.controls.Label;

        internal var _hGroup:feathers.controls.LayoutGroup;
    }
}


