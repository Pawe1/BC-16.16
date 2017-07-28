//class CustomShape
package frontend.screen.statistic.tabs 
{
    import frontend.components.charts.*;
    
    public class CustomShape extends Object
    {
        public function CustomShape()
        {
            super();
            return;
        }

        public var chartItem:frontend.components.charts.ColumnChartItem;

        public var color:uint;

        public var heightFrom:Number;

        public var heightTo:Number;

        public var id:String;

        public var label:String="";

        public var showLabel:Boolean=true;

        public var widthFrom:Number;

        public var widthTo:Number;

        public var xFrom:Number;

        public var xTo:Number;

        public var yFrom:Number;

        public var yTo:Number;
    }
}


