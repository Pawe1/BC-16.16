//class TabEvent
package frontend.components.tab 
{
    import frontend.components.tabbarbase.*;
    import starling.events.*;
    
    public class TabEvent extends starling.events.Event
    {
        public function TabEvent(arg1:String, arg2:frontend.components.tabbarbase.ITabLayoutContainer=null, arg3:frontend.components.tabbarbase.TabBarDataProviderObject=null, arg4:Object=null)
        {
            if (arg2) 
            {
                this.instance = arg2;
            }
            this.dpObj = arg3;
            super(arg1, arg4, false);
            return;
        }

        public static const CHANGED:String="tabChanged";

        public var dpObj:frontend.components.tabbarbase.TabBarDataProviderObject;

        public var instance:frontend.components.tabbarbase.ITabLayoutContainer=null;
    }
}


