//class MeasureTextResult
package feathers.controls.text 
{
    public class MeasureTextResult extends Object
    {
        public function MeasureTextResult(arg1:Number=0, arg2:Number=0, arg3:Boolean=false)
        {
            super();
            this.width = arg1;
            this.height = arg2;
            this.isTruncated = arg3;
            return;
        }

        public var width:Number;

        public var height:Number;

        public var isTruncated:Boolean;
    }
}


