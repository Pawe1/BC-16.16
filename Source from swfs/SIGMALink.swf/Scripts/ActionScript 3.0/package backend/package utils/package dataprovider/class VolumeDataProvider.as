//class VolumeDataProvider
package backend.utils.dataprovider 
{
    import __AS3__.vec.*;
    import feathers.data.*;
    import starling.events.*;
    
    public class VolumeDataProvider extends starling.events.EventDispatcher
    {
        public function VolumeDataProvider()
        {
            super();
            return;
        }

        public static const DATA_PROVIDER:feathers.data.ListCollection=new feathers.data.ListCollection(Vector.<Object>([{"label":"1", "data":1}, {"label":"2", "data":2}, {"label":"3", "data":3}, {"label":"4", "data":4}, {"label":"5", "data":5}]));
    }
}


