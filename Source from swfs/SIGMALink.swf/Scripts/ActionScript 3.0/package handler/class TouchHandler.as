//class TouchHandler
package handler 
{
    import starling.display.*;
    import starling.events.*;
    
    public class TouchHandler extends Object
    {
        public function TouchHandler()
        {
            super();
            throw new Error("Diese Klasse darf nicht instanziiert werden. Methoden sollen statisch aufgerufen werden.");
        }

        public static function isTouch(arg1:starling.events.TouchEvent):Boolean
        {
            var loc1:*=arg1.currentTarget as starling.display.DisplayObject;
            var loc2:*=arg1.getTouch(loc1);
            if (loc2) 
            {
                if (loc2.phase == starling.events.TouchPhase.BEGAN) 
                {
                    movedStartX = loc2.globalX;
                    movedStartY = loc2.globalY;
                }
                if (loc2.phase == starling.events.TouchPhase.ENDED) 
                {
                    if (Math.max(movedStartX, loc2.globalX) - Math.min(movedStartX, loc2.globalX) <= MOVE_TOLLERANCE && Math.max(movedStartY, loc2.globalY) - Math.min(movedStartY, loc2.globalY) <= MOVE_TOLLERANCE) 
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        
        {
            movedStartX = 0;
            movedStartY = 0;
        }

        internal static const MOVE_TOLLERANCE:uint=10 * SIGMALink.scaleFactor;

        internal static var movedStartX:uint=0;

        internal static var movedStartY:uint=0;
    }
}


