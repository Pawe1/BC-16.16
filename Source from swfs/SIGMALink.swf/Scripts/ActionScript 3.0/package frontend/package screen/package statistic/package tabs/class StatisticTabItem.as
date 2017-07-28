//class StatisticTabItem
package frontend.screen.statistic.tabs 
{
    import __AS3__.vec.*;
    import debug.*;
    import feathers.data.*;
    import frontend.components.charts.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class StatisticTabItem extends Object
    {
        public function StatisticTabItem(arg1:Boolean=false)
        {
            this._dataProvider = new feathers.data.ListCollection();
            super();
            if (arg1) 
            {
                this.title = "typicalItemTitle";
                this.yMax = 10;
                this.dataProvider = new feathers.data.ListCollection();
                this.converter = null;
                this.formatter = null;
                this.yInterval = 5;
                this.maxVisibleColumns = 53;
                this.scrollHandler = null;
                this.zoomHandler = null;
            }
            return;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            this.dataChanged = true;
            return;
        }

        public function get hidden():Boolean
        {
            return this._hidden;
        }

        public function set hidden(arg1:Boolean):void
        {
            this._hidden = arg1;
            this.dataChanged = true;
            return;
        }

        public function updateDataProvider(arg1:__AS3__.vec.Vector.<frontend.components.charts.ColumnChartItem>):void
        {
            if (isEqual(arg1, this.dataProvider.data as Vector.<frontend.components.charts.ColumnChartItem>)) 
            {
                debug.Debug.debug("same dp - " + this.title);
            }
            else 
            {
                debug.Debug.debug("new dp - " + this.title);
                this.dataProvider = new feathers.data.ListCollection(arg1);
            }
            return;
        }

        internal static function isEqual(arg1:__AS3__.vec.Vector.<frontend.components.charts.ColumnChartItem>, arg2:__AS3__.vec.Vector.<frontend.components.charts.ColumnChartItem>):Boolean
        {
            var loc1:*=0;
            if (!arg2) 
            {
                return false;
            }
            if (arg1.length != arg2.length) 
            {
                return false;
            }
            var loc2:*=arg1.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (arg1[loc1].ySum != arg2[loc1].ySum) 
                {
                    return false;
                }
                ++loc1;
            }
            return true;
        }

        public var converter:utils.converter.IConverter;

        public var dataChanged:Boolean=true;

        internal var _dataProvider:feathers.data.ListCollection;

        public var formatter:utils.interfaces.ICustomFormatterBase;

        internal var _hidden:Boolean=true;

        public var landscapeCloseHandler:Function;

        public var maxVisibleColumns:Number;

        public var scrollHandler:Function;

        public var title:String;

        public var type:String;

        public var yInterval:Number;

        public var yMax:Number;

        public var zoomHandler:Function;
    }
}


