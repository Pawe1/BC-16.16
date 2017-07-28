//package screenNavigator
//  class CustomScreenNavigatorItem
package frontend.components.screenNavigator 
{
    import feathers.controls.*;
    
    public class CustomScreenNavigatorItem extends feathers.controls.ScreenNavigatorItem
    {
        public function CustomScreenNavigatorItem(arg1:Object=null, arg2:Object=null, arg3:Object=null)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function set properties(arg1:Object):void
        {
            var value:Object;

            var loc1:*;
            value = arg1;
            try 
            {
                super.properties = value;
            }
            catch (e:Error)
            {
                throw new Error(e.message);
            }
            return;
        }

        protected var pushEventsObj:Object;

        protected var transition:Function;
    }
}


