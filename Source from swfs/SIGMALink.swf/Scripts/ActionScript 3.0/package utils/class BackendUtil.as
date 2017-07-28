//class BackendUtil
package utils 
{
    import flash.utils.*;
    
    public class BackendUtil extends Object
    {
        public function BackendUtil()
        {
            super();
            return;
        }

        public static function copy(arg1:Object):Object
        {
            var loc2:*=new flash.utils.ByteArray();
            loc2.writeObject(arg1);
            loc2.position = 0;
            var loc1:*=loc2.readObject();
            return loc1;
        }

        public static function generateStatementText(arg1:String, arg2:Array):String
        {
            arg1 = arg1 + (" (" + arg2.join(",") + ") VALUES (");
            var loc2:*=0;
            var loc1:*=arg2.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                arg2[loc2] = "?";
                ++loc2;
            }
            arg1 = arg1 + (arg2.join(",") + ")");
            return arg1;
        }
    }
}


