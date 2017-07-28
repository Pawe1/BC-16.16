//class ColumnChartItem
package frontend.components.charts 
{
    public class ColumnChartItem extends Object
    {
        public function ColumnChartItem()
        {
            this.activityGUIDs = [];
            this.yValues = [];
            this.yValuesFormat = [];
            super();
            return;
        }

        public var activityGUIDs:Array;

        public var color:uint=13046322;

        public var date:Date;

        public var label:String="";

        public var sortField:String="";

        public var xValue:String="";

        public var ySum:Number=0;

        public var yValues:Array;

        public var yValuesFormat:Array;
    }
}


