//class PopUpManager
package feathers.core 
{
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    public class PopUpManager extends Object
    {
        public function PopUpManager()
        {
            super();
            return;
        }

        public static function defaultPopUpManagerFactory():feathers.core.IPopUpManager
        {
            return new feathers.core.DefaultPopUpManager();
        }

        public static function forStarling(arg1:starling.core.Starling):feathers.core.IPopUpManager
        {
            var loc2:*=null;
            if (!arg1) 
            {
                throw new ArgumentError("PopUpManager not found. Starling cannot be null.");
            }
            var loc1:*=_starlingToPopUpManager[arg1];
            if (!loc1) 
            {
                loc2 = feathers.core.PopUpManager.popUpManagerFactory;
                if (loc2 === null) 
                {
                    loc2 = feathers.core.PopUpManager.defaultPopUpManagerFactory;
                }
                loc1 = loc2();
                if (!loc1.root || !arg1.stage.contains(loc1.root)) 
                {
                    loc1.root = starling.core.Starling.current.stage;
                }
                feathers.core.PopUpManager._starlingToPopUpManager[arg1] = loc1;
            }
            return loc1;
        }

        public static function get overlayFactory():Function
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).overlayFactory;
        }

        public static function set overlayFactory(arg1:Function):void
        {
            feathers.core.PopUpManager.forStarling(starling.core.Starling.current).overlayFactory = arg1;
            return;
        }

        public static function defaultOverlayFactory():starling.display.DisplayObject
        {
            return feathers.core.DefaultPopUpManager.defaultOverlayFactory();
        }

        public static function get root():starling.display.DisplayObjectContainer
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).root;
        }

        public static function set root(arg1:starling.display.DisplayObjectContainer):void
        {
            feathers.core.PopUpManager.forStarling(starling.core.Starling.current).root = arg1;
            return;
        }

        public static function get popUpCount():int
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).popUpCount;
        }

        public static function addPopUp(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Boolean=true, arg4:Function=null):starling.display.DisplayObject
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).addPopUp(arg1, arg2, arg3, arg4);
        }

        public static function removePopUp(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).removePopUp(arg1, arg2);
        }

        public static function removeAllPopUps(arg1:Boolean=false):void
        {
            feathers.core.PopUpManager.forStarling(starling.core.Starling.current).removeAllPopUps(arg1);
            return;
        }

        public static function isPopUp(arg1:starling.display.DisplayObject):Boolean
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).isPopUp(arg1);
        }

        public static function isTopLevelPopUp(arg1:starling.display.DisplayObject):Boolean
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).isTopLevelPopUp(arg1);
        }

        public static function centerPopUp(arg1:starling.display.DisplayObject):void
        {
            feathers.core.PopUpManager.forStarling(starling.core.Starling.current).centerPopUp(arg1);
            return;
        }

        
        {
            popUpManagerFactory = defaultPopUpManagerFactory;
        }

        protected static const _starlingToPopUpManager:flash.utils.Dictionary=new flash.utils.Dictionary(true);

        public static var popUpManagerFactory:Function;
    }
}


