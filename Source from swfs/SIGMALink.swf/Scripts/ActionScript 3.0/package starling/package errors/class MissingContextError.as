//class MissingContextError
package starling.errors 
{
    public class MissingContextError extends Error
    {
        public function MissingContextError(arg1:*="Starling context is missing", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


