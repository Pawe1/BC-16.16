//class CloudURLStream
package service.cloud 
{
    import flash.net.*;
    
    public class CloudURLStream extends flash.net.URLStream
    {
        public function CloudURLStream()
        {
            super();
            return;
        }

        public var data:Object;

        public var type:String;
    }
}


