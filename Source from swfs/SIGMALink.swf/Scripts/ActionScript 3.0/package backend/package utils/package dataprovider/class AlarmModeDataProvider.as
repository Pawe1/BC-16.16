//class AlarmModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AlarmModeDataProvider extends starling.events.EventDispatcher
    {
        public function AlarmModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAlarmModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAlarmModeDataProvider.DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


