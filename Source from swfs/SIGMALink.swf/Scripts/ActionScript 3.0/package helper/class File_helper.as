//class File_helper
package helper 
{
    import flash.filesystem.*;
    
    public class File_helper extends Object
    {
        public function File_helper()
        {
            super();
            return;
        }

        public static function createDirIfNotExist(arg1:String):void
        {
            var loc1:*=new flash.filesystem.File(arg1);
            if (!loc1.exists) 
            {
                loc1.createDirectory();
            }
            return;
        }

        public static function directoryExists(arg1:String):Boolean
        {
            var loc1:*=new flash.filesystem.File(arg1);
            return loc1.exists;
        }

        public static function directorySize(arg1:String):Number
        {
            var loc1:*=new flash.filesystem.File(arg1);
            if (!loc1.exists) 
            {
                return 0;
            }
            return getFileSize(loc1);
        }

        public static function deleteDirectory(arg1:String):void
        {
            var loc1:*=new flash.filesystem.File(arg1);
            if (loc1.exists) 
            {
                loc1.deleteDirectoryAsync(true);
            }
            return;
        }

        public static function getFileSize(arg1:flash.filesystem.File):Number
        {
            var loc3:*=null;
            var loc1:*=0;
            if (arg1 == null || arg1.exists == false) 
            {
                return 0;
            }
            if (arg1.isDirectory) 
            {
                loc3 = arg1.getDirectoryListing();
                var loc5:*=0;
                var loc4:*=loc3;
                for each (var loc2:* in loc4) 
                {
                    if (loc2.isDirectory) 
                    {
                        loc1 = loc1 + getFileSize(loc2);
                        continue;
                    }
                    loc1 = loc1 + loc2.size;
                }
            }
            else 
            {
                return arg1.size;
            }
            return loc1;
        }
    }
}


