//package errors
//  class AbstractClassError
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


//  class AbstractMethodError
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


//  class MissingContextError
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


//  class NotSupportedError
package starling.errors 
{
    public class NotSupportedError extends Error
    {
        public function NotSupportedError(arg1:*="", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


