//class ExclusiveTouch
package feathers.events 
{
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ExclusiveTouch extends starling.events.EventDispatcher
    {
        public function ExclusiveTouch(arg1:starling.display.Stage)
        {
            this._claims = new flash.utils.Dictionary();
            super();
            if (!arg1) 
            {
                throw new ArgumentError("Stage cannot be null.");
            }
            this._stage = arg1;
            return;
        }

        public function claimTouch(arg1:int, arg2:starling.display.DisplayObject):Boolean
        {
            if (!arg2) 
            {
                throw new ArgumentError("Target cannot be null.");
            }
            if (arg2.stage != this._stage) 
            {
                throw new ArgumentError("Target cannot claim a touch on the selected stage because it appears on a different stage.");
            }
            if (arg1 < 0) 
            {
                throw new ArgumentError("Invalid touch. Touch ID must be >= 0.");
            }
            var loc1:*=starling.display.DisplayObject(this._claims[arg1]);
            if (loc1) 
            {
                return false;
            }
            this._claims[arg1] = arg2;
            if (this._stageListenerCount == 0) 
            {
                this._stage.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            }
            var loc2:*;
            var loc3:*=((loc2 = this)._stageListenerCount + 1);
            loc2._stageListenerCount = loc3;
            this.dispatchEventWith(starling.events.Event.CHANGE, false, arg1);
            return true;
        }

        public function removeClaim(arg1:int):void
        {
            var loc1:*=starling.display.DisplayObject(this._claims[arg1]);
            if (!loc1) 
            {
                return;
            }
            delete this._claims[arg1];
            this.dispatchEventWith(starling.events.Event.CHANGE, false, arg1);
            return;
        }

        public function getClaim(arg1:int):starling.display.DisplayObject
        {
            if (arg1 < 0) 
            {
                throw new ArgumentError("Invalid touch. Touch ID must be >= 0.");
            }
            return starling.display.DisplayObject(this._claims[arg1]);
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=this._claims;
            for (loc1 in loc5) 
            {
                loc2 = loc1 as int;
                loc3 = arg1.getTouch(this._stage, starling.events.TouchPhase.ENDED, loc2);
                if (!loc3) 
                {
                    continue;
                }
                delete this._claims[loc1];
                var loc6:*;
                var loc7:*=((loc6 = this)._stageListenerCount - 1);
                loc6._stageListenerCount = loc7;
            }
            if (this._stageListenerCount == 0) 
            {
                this._stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            }
            return;
        }

        public static function forStage(arg1:starling.display.Stage):feathers.events.ExclusiveTouch
        {
            if (!arg1) 
            {
                throw new ArgumentError("Stage cannot be null.");
            }
            var loc1:*=ExclusiveTouch(stageToObject[arg1]);
            if (loc1) 
            {
                return loc1;
            }
            loc1 = new ExclusiveTouch(arg1);
            stageToObject[arg1] = loc1;
            return loc1;
        }

        public static function disposeForStage(arg1:starling.display.Stage):void
        {
            delete stageToObject[arg1];
            return;
        }

        protected static const stageToObject:flash.utils.Dictionary=new flash.utils.Dictionary(true);

        protected var _stageListenerCount:int=0;

        protected var _stage:starling.display.Stage;

        protected var _claims:flash.utils.Dictionary;
    }
}


