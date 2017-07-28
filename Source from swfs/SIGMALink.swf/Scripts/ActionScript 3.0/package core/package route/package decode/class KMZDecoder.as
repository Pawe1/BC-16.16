//class KMZDecoder
package core.route.decode 
{
    import core.route.*;
    import flash.events.*;
    import flash.utils.*;
    import nochump.util.zip.*;
    
    public class KMZDecoder extends flash.events.EventDispatcher
    {
        public function KMZDecoder()
        {
            super();
            return;
        }

        public static function decodeRoute(arg1:flash.utils.IDataInput):core.route.Route
        {
            var loc1:*=decompressKmz(arg1);
            return core.route.decode.KMLDecoder.decodeRoute(loc1);
        }

        public static function decompressKmz(arg1:flash.utils.IDataInput):XML
        {
            var loc4:*=new nochump.util.zip.ZipFile(arg1);
            var loc2:*=loc4.getInput(loc4.entries[0]);
            var loc3:*=loc2.readUTFBytes(loc2.length);
            var loc1:*=new XML(loc3.slice(loc3.indexOf("<"), loc3.length));
            return loc1;
        }
    }
}


