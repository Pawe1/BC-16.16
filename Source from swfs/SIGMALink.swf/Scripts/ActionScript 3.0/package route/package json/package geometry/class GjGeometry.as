//class GjGeometry
package route.json.geometry 
{
    import flash.errors.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class GjGeometry extends flash.events.EventDispatcher
    {
        public function GjGeometry()
        {
            super();
            return;
        }

        public function get toJSON():String
        {
            throw new flash.errors.IllegalOperationError("Please override this method");
            return null;
        }

        public static function fromObject(arg1:Object):route.json.geometry.GjGeometry
        {
            var loc2:*=null;
            var loc1:*=null;
            if (!arg1.hasOwnProperty("type")) 
            {
                return null;
            }
            if (flash.utils.getQualifiedClassName(arg1.type) != flash.utils.getQualifiedClassName(String)) 
            {
                return null;
            }
            try 
            {
                loc2 = flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(GjGeometry).replace("Geometry", arg1.type as String)) as Class;
                if (flash.utils.getQualifiedSuperclassName(loc2) != flash.utils.getQualifiedClassName(GjGeometry)) 
                {
                    var loc4:*;
                    return loc4 = null;
                }
                loc1 = loc2.fromObject(arg1);
            }
            catch (error:Error)
            {
                var loc5:*=null;
                return loc5;
            }
            return loc1;
        }

        public static const EVENT_COORDINATES_CHANGED:String="CoordinatesChangedEvent";
    }
}


