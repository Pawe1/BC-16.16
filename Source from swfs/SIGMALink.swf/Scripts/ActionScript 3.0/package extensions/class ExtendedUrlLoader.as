//class ExtendedUrlLoader
package extensions 
{
    import flash.net.*;
    
    public class ExtendedUrlLoader extends flash.net.URLLoader
    {
        public function ExtendedUrlLoader(arg1:flash.net.URLRequest=null)
        {
            super(arg1);
            return;
        }

        public var extendedData:Object;
    }
}


