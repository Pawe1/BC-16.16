//class PropertyChangeEventKind
package mx.events 
{
    import mx.core.*;
    
    use namespace mx_internal;
    
    public final class PropertyChangeEventKind extends Object
    {
        public function PropertyChangeEventKind()
        {
            super();
            return;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";

        public static const UPDATE:String="update";

        public static const DELETE:String="delete";
    }
}


