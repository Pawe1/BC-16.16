//class AssetsManagerCustom
package frontend 
{
    import flash.system.*;
    
    public class AssetsManagerCustom extends Assets
    {
        public function AssetsManagerCustom(arg1:Number=1, arg2:Boolean=false)
        {
            super(arg1, arg2);
            return;
        }

        protected override function init(arg1:Number=1):void
        {
            super.init(arg1);
            var loc1:*=0;
            while (loc1 < ATLASLIST_TO_LOAD.length) 
            {
                addAtlas(ATLASLIST_TO_LOAD[loc1]);
                ++loc1;
            }
            queueAssets();
            isInitialized = true;
            return;
        }

        public static function getInstance():frontend.AssetsManagerCustom
        {
            if (!_instance) 
            {
                initialize();
            }
            return _instance;
        }

        public static function initialize(arg1:Number=1):void
        {
            _instance = new AssetsManagerCustom(arg1);
            _instance.verbose = flash.system.Capabilities.isDebugger;
            _instance.init(arg1);
            return;
        }

        internal static const ATLASLIST_TO_LOAD:Array=["mainAtlas", "devicPictures", "cloudAnimation", "loaderAnimation", "connectPictures", "sportIcons", "backgrounds"];

        internal static var _instance:frontend.AssetsManagerCustom;
    }
}


