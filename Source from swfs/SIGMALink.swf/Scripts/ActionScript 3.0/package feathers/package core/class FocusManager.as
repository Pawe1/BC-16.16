//class FocusManager
package feathers.core 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    public class FocusManager extends Object
    {
        public function FocusManager()
        {
            super();
            return;
        }

        public function disableAll():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=STAGE_TO_STACK;
            for (loc1 in loc6) 
            {
                loc2 = starling.display.Stage(loc1);
                loc3 = STAGE_TO_STACK[loc2];
                while (loc3.length > 0) 
                {
                    loc4 = loc3.pop();
                    loc4.isEnabled = false;
                }
                delete STAGE_TO_STACK[loc2];
            }
            return;
        }

        public static function getFocusManagerForStage(arg1:starling.display.Stage):feathers.core.IFocusManager
        {
            var loc1:*=STAGE_TO_STACK[arg1] as Vector.<feathers.core.IFocusManager>;
            if (!loc1) 
            {
                return null;
            }
            return loc1[(loc1.length - 1)];
        }

        public static function defaultFocusManagerFactory(arg1:starling.display.DisplayObjectContainer):feathers.core.IFocusManager
        {
            return new feathers.core.DefaultFocusManager(arg1);
        }

        public static function isEnabledForStage(arg1:starling.display.Stage):Boolean
        {
            var loc1:*=STAGE_TO_STACK[arg1];
            return !(loc1 == null);
        }

        public static function setEnabledForStage(arg1:starling.display.Stage, arg2:Boolean):void
        {
            var loc2:*=null;
            var loc1:*=STAGE_TO_STACK[arg1];
            if (arg2 && loc1 || !arg2 && !loc1) 
            {
                return;
            }
            if (arg2) 
            {
                STAGE_TO_STACK[arg1] = new Vector.<feathers.core.IFocusManager>(0);
                pushFocusManager(arg1);
            }
            else 
            {
                while (loc1.length > 0) 
                {
                    loc2 = loc1.pop();
                    loc2.isEnabled = false;
                }
                delete STAGE_TO_STACK[arg1];
            }
            return;
        }

        public static function get focus():feathers.core.IFocusDisplayObject
        {
            var loc1:*=getFocusManagerForStage(starling.core.Starling.current.stage);
            if (loc1) 
            {
                return loc1.focus;
            }
            return null;
        }

        public static function set focus(arg1:feathers.core.IFocusDisplayObject):void
        {
            var loc1:*=getFocusManagerForStage(starling.core.Starling.current.stage);
            if (!loc1) 
            {
                throw new Error(FOCUS_MANAGER_NOT_ENABLED_ERROR);
            }
            loc1.focus = arg1;
            return;
        }

        public static function pushFocusManager(arg1:starling.display.DisplayObjectContainer):feathers.core.IFocusManager
        {
            var loc4:*=null;
            var loc1:*=arg1.stage;
            if (!loc1) 
            {
                throw new ArgumentError(FOCUS_MANAGER_ROOT_MUST_BE_ON_STAGE_ERROR);
            }
            var loc2:*=STAGE_TO_STACK[loc1] as Vector.<feathers.core.IFocusManager>;
            if (!loc2) 
            {
                throw new Error(FOCUS_MANAGER_NOT_ENABLED_ERROR);
            }
            var loc3:*=feathers.core.FocusManager.focusManagerFactory(arg1);
            loc3.isEnabled = true;
            if (loc2.length > 0) 
            {
                loc4 = loc2[(loc2.length - 1)];
                loc4.isEnabled = false;
            }
            loc2.push(loc3);
            return loc3;
        }

        public static function removeFocusManager(arg1:feathers.core.IFocusManager):void
        {
            var loc1:*=arg1.root.stage;
            var loc2:*=STAGE_TO_STACK[loc1] as Vector.<feathers.core.IFocusManager>;
            if (!loc2) 
            {
                throw new Error(FOCUS_MANAGER_NOT_ENABLED_ERROR);
            }
            var loc3:*=loc2.indexOf(arg1);
            if (loc3 < 0) 
            {
                return;
            }
            arg1.isEnabled = false;
            loc2.removeAt(loc3);
            if (loc3 > 0 && loc3 == loc2.length) 
            {
                arg1 = loc2[(loc2.length - 1)];
                arg1.isEnabled = true;
            }
            return;
        }

        
        {
            focusManagerFactory = defaultFocusManagerFactory;
        }

        protected static const FOCUS_MANAGER_NOT_ENABLED_ERROR:String="The specified action is not permitted when the focus manager is not enabled.";

        protected static const FOCUS_MANAGER_ROOT_MUST_BE_ON_STAGE_ERROR:String="A focus manager may not be added or removed for a display object that is not on stage.";

        protected static const STAGE_TO_STACK:flash.utils.Dictionary=new flash.utils.Dictionary(true);

        public static var focusManagerFactory:Function;
    }
}


