//class ActivityListItemHeaderRenderer
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


