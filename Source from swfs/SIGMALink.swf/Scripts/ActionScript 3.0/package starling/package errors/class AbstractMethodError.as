//class AbstractMethodError
package starling.errors 
{
    public class AbstractMethodError extends Error
    {
        public function AbstractMethodError(arg1:*="Method needs to be implemented in subclass", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


