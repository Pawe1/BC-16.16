//class StatisticChart
package frontend.screen.statistic.tabs 
{
    import debug.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.components.charts.*;
    
    public class StatisticChart extends feathers.controls.LayoutGroup
    {
        public function StatisticChart(arg1:Boolean=false)
        {
            super();
            this._showLoadingLabel = arg1;
            this._layoutGroup = new feathers.controls.LayoutGroup();
            this._layoutGroup.width = SIGMALink.appWidth;
            this._layoutGroup.height = height;
            this._layoutGroup.layout = new feathers.layout.AnchorLayout();
            addChild(this._layoutGroup);
            this._headerTitle = new feathers.controls.Label();
            this._headerTitle.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_DARKLABEL;
            this._headerTitle.text = " ";
            this._headerTitle.layoutData = new feathers.layout.AnchorLayoutData(HEADER_PADDING, NaN, NaN, HEADER_PADDING);
            this._layoutGroup.addChild(this._headerTitle);
            this._headerTitle.validate();
            var loc1:*;
            this._headerHeight = loc1 = this._headerTitle.height + 2 * HEADER_PADDING;
            frontend.components.charts.ColumnChartList.HEADER_HEIGHT = loc1;
            this._headerMaxYValueLabel = new feathers.controls.Label();
            this._headerMaxYValueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._headerMaxYValueLabel.layoutData = new feathers.layout.AnchorLayoutData(HEADER_PADDING, HEADER_PADDING, NaN, NaN);
            this._layoutGroup.addChild(this._headerMaxYValueLabel);
            this._chartIndex = this._layoutGroup.numChildren;
            this._scaleTimer = new flash.utils.Timer(100, 1);
            return;
        }

        public function drawChart():void
        {
            if (!this.item) 
            {
                return;
            }
            debug.Debug.debug("drawChart - " + this.item.title + ", " + this.item.type);
            if (this._chart) 
            {
                this._chart.item = this.item;
            }
            else 
            {
                this._chart = new frontend.components.charts.ColumnChartList();
                this._chart.alpha = 1;
                this._chart.dropLabels = this.dropLabels;
                this._chart.parentHeight = height;
                this._chart.item = this.item;
                this._layoutGroup.addChildAt(this._chart, this._chartIndex);
            }
            this.updateHiddenFlag();
            return;
        }

        internal function updateHiddenFlag():void
        {
            debug.Debug.debug("updateHiddenFlag => item.dataChanged: " + this.item.dataChanged.toString());
            if (this._scaleTimer) 
            {
                this._scaleTimer.removeEventListener(flash.events.TimerEvent.TIMER, this._chart.scaleIn);
                this._scaleTimer.reset();
            }
            if (this.item.dataChanged) 
            {
                this._chart.validateItem();
                this.item.dataChanged = false;
            }
            if (this.item.hidden) 
            {
                this._chart.scaleOut();
            }
            else 
            {
                this._scaleTimer.addEventListener(flash.events.TimerEvent.TIMER, this._chart.scaleIn);
                this._scaleTimer.start();
            }
            this.updateHeader();
            return;
        }

        internal function updateHeader():void
        {
            var loc1:*=this.item.converter ? this.item.converter.convert(this.item.yMax) : this.item.yMax;
            this._headerTitle.text = this.item.title;
            this._headerMaxYValueLabel.text = this.item.formatter ? this.item.formatter.format(loc1) : loc1.toString();
            return;
        }

        public static const HEADER_PADDING:Number=12 * SIGMALink.scaleFactor;

        public var dropLabels:Boolean=true;

        public var item:frontend.screen.statistic.tabs.StatisticTabItem;

        internal var _chart:frontend.components.charts.ColumnChartList;

        internal var _chartIndex:int=0;

        internal var _headerHeight:Number;

        internal var _headerMaxYValueLabel:feathers.controls.Label;

        internal var _headerTitle:feathers.controls.Label;

        internal var _layoutGroup:feathers.controls.LayoutGroup;

        internal var _scaleTimer:flash.utils.Timer;

        internal var _showLoadingLabel:Boolean=false;
    }
}


