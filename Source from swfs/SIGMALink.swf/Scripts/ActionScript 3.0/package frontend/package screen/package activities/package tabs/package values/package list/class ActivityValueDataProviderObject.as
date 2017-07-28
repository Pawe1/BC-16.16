//class ActivityValueDataProviderObject
package frontend.screen.activities.tabs.values.list 
{
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class ActivityValueDataProviderObject extends Object
    {
        public function ActivityValueDataProviderObject()
        {
            this.footer = {"label":"test"};
            super();
            return;
        }

        public function setValue(arg1:Object, arg2:utils.converter.IConverter=null, arg3:utils.interfaces.ICustomFormatterBase=null):void
        {
            if (arg2) 
            {
                if (arg3) 
                {
                    this.value = arg3.format(arg2.convert(arg1));
                }
                else 
                {
                    this.value = arg2.convert(arg1).toString();
                }
            }
            else if (arg3) 
            {
                this.value = arg3.format(arg1);
            }
            else 
            {
                this.value = arg1 + "";
            }
            return;
        }

        public var clickCallback:Function;

        public var footer:Object;

        public var header:Object;

        public var iconSource:String;

        public var iconText:String;

        public var isHline:Boolean=false;

        public var isSeperator:Boolean=false;

        public var key:String;

        public var speedBasedValue:Number;

        public var unit:String;

        public var value:String;

        public var valueIconSource:String;
    }
}


