//class CommonSamplingRateDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonSamplingRateDataProvider extends Object
    {
        public function CommonSamplingRateDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_PC2814 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_RC1411 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":"1 s", "data":1}, {"label":"2 s", "data":2}, {"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_BC2316 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}]);
            V_DATA_PROVIDER_ROX110 = __AS3__.vec.Vector.<Object>([{"label":"1 s", "data":1}, {"label":"2 s", "data":2}, {"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC2316:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_PC2814:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RC1411:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX110:__AS3__.vec.Vector.<Object>;
    }
}


