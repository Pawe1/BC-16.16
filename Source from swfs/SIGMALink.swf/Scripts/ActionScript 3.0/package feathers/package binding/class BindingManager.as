//class BindingManager
package feathers.binding 
{
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class BindingManager extends Object
    {
        public function BindingManager()
        {
            super();
            return;
        }

        public static function addBinding(arg1:Object, arg2:String, arg3:feathers.binding.Binding):void
        {
            if (!arg1._bindingsByDestination) 
            {
                arg1._bindingsByDestination = {};
                arg1._bindingsBeginWithWord = {};
            }
            arg1._bindingsByDestination[arg2] = arg3;
            arg1._bindingsBeginWithWord[getFirstWord(arg2)] = true;
            return;
        }

        public static function setEnabled(arg1:Object, arg2:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            if (arg1 is feathers.binding.IBindingClient && arg1._bindings) 
            {
                loc1 = arg1._bindings as Array;
                loc2 = 0;
                while (loc2 < loc1.length) 
                {
                    loc3 = loc1[loc2];
                    loc3.mx_internal::isEnabled = arg2;
                    ++loc2;
                }
            }
            return;
        }

        public static function executeBindings(arg1:Object, arg2:String, arg3:Object):void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (!arg2 || arg2 == "") 
            {
                return;
            }
            if (arg1 && (arg1 is feathers.binding.IBindingClient || arg1.hasOwnProperty("_bindingsByDestination")) && arg1._bindingsByDestination && arg1._bindingsBeginWithWord[getFirstWord(arg2)]) 
            {
                var loc3:*=0;
                var loc4:*=arg1._bindingsByDestination;
                for (loc1 in loc4) 
                {
                    if (loc1.charAt(0) != arg2.charAt(0)) 
                    {
                        continue;
                    }
                    loc2 = arg2.length;
                    if (!(loc2 < loc1.length && loc1.indexOf(arg2) == 0 && (loc1.charAt(loc2) == "." || loc1.charAt(loc2) == "[") || loc1 == arg2)) 
                    {
                        continue;
                    }
                    arg1._bindingsByDestination[loc1].execute(arg3);
                }
            }
            return;
        }

        public static function enableBindings(arg1:Object, arg2:String, arg3:Boolean=true):void
        {
            var loc1:*=null;
            if (!arg2 || arg2 == "") 
            {
                return;
            }
            if (arg1 && (arg1 is feathers.binding.IBindingClient || arg1.hasOwnProperty("_bindingsByDestination")) && arg1._bindingsByDestination && arg1._bindingsBeginWithWord[getFirstWord(arg2)]) 
            {
                var loc2:*=0;
                var loc3:*=arg1._bindingsByDestination;
                for (loc1 in loc3) 
                {
                    if (loc1.charAt(0) != arg2.charAt(0)) 
                    {
                        continue;
                    }
                    if (!(loc1.indexOf(arg2 + ".") == 0 || loc1.indexOf(arg2 + "[") == 0 || loc1 == arg2)) 
                    {
                        continue;
                    }
                    arg1._bindingsByDestination[loc1].isEnabled = arg3;
                }
            }
            return;
        }

        internal static function getFirstWord(arg1:String):String
        {
            var loc1:*=arg1.indexOf(".");
            var loc2:*=arg1.indexOf("[");
            if (loc1 == loc2) 
            {
                return arg1;
            }
            var loc3:*=Math.min(loc1, loc2);
            if (loc3 == -1) 
            {
                loc3 = Math.max(loc1, loc2);
            }
            return arg1.substr(0, loc3);
        }

        public static function debugBinding(arg1:String):void
        {
            debugDestinationStrings[arg1] = true;
            return;
        }

        
        {
            debugDestinationStrings = {};
        }

        static var debugDestinationStrings:Object;
    }
}


