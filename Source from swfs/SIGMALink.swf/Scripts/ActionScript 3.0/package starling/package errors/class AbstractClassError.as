//class AbstractClassError
package starling.errors 
{
    public class AbstractClassError extends Error
    {
        public function AbstractClassError(arg1:*="Cannot instantiate abstract class", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


