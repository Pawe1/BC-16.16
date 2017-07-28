//class AutoLapDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AutoLapDataProvider extends starling.events.EventDispatcher
    {
        public function AutoLapDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAutoLapDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAutoLapDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function filter(arg1:Array):feathers.data.ListCollection
        {
            var loc6:*=null;
            var loc1:*=new feathers.data.ListCollection();
            var loc2:*=DATA_PROVIDER.length;
            var loc3:*=arg1.length;
            var loc4:*=0;
            var loc5:*=0;
            while (loc4 < loc2) 
            {
                loc6 = DATA_PROVIDER.getItemAt(loc4);
                if (loc6.hasOwnProperty("data")) 
                {
                    loc5 = 0;
                    while (loc5 < loc3) 
                    {
                        if (loc6.data == arg1[loc5]) 
                        {
                            loc1.push(loc6);
                        }
                        ++loc5;
                    }
                }
                ++loc4;
            }
            return loc1;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


