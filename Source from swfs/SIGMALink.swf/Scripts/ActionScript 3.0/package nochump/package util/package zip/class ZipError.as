//class ZipError
package nochump.util.zip 
{
    import flash.errors.*;
    
    public class ZipError extends flash.errors.IOError
    {
        public function ZipError(arg1:String="", arg2:int=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


