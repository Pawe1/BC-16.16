//class TextInputNavigation
package feathers.utils.text 
{
    public class TextInputNavigation extends Object
    {
        public function TextInputNavigation()
        {
            super();
            return;
        }

        public static function findPreviousWordStartIndex(arg1:String, arg2:int):int
        {
            var loc3:*=false;
            if (arg2 <= 0) 
            {
                return 0;
            }
            var loc1:*=IS_WORD.test(arg1.charAt((arg2 - 1)));
            var loc2:*=arg2 - 2;
            while (loc2 >= 0) 
            {
                loc3 = IS_WORD.test(arg1.charAt(loc2));
                if (!loc3 && loc1) 
                {
                    return loc2 + 1;
                }
                loc1 = loc3;
                --loc2;
            }
            return 0;
        }

        public static function findCurrentWordStartIndex(arg1:String, arg2:int):int
        {
            var loc3:*=false;
            if (arg2 <= 0) 
            {
                return 0;
            }
            var loc1:*=IS_WORD.test(arg1.charAt(arg2 + 1));
            var loc2:*=arg2;
            while (loc2 >= 0) 
            {
                loc3 = IS_WORD.test(arg1.charAt(loc2));
                if (!loc3 && loc2 === arg2) 
                {
                    return findPreviousWordStartIndex(arg1, arg2);
                }
                if (!loc3 && loc1) 
                {
                    return loc2 + 1;
                }
                loc1 = loc3;
                --loc2;
            }
            return 0;
        }

        public static function findCurrentWordEndIndex(arg1:String, arg2:int):int
        {
            var loc3:*=false;
            var loc4:*=0;
            var loc1:*=arg1.length;
            if (arg2 >= (loc1 - 1)) 
            {
                return loc1;
            }
            var loc2:*=arg2;
            while (loc2 < loc1) 
            {
                loc3 = IS_WORD.test(arg1.charAt(loc2));
                if (!loc3 && loc2 === arg2) 
                {
                    loc4 = findNextWordStartIndex(arg1, arg2);
                    return findCurrentWordEndIndex(arg1, loc4);
                }
                if (!loc3) 
                {
                    return loc2;
                }
                ++loc2;
            }
            return loc1;
        }

        public static function findNextWordStartIndex(arg1:String, arg2:int):int
        {
            var loc4:*=false;
            var loc1:*=arg1.length;
            if (arg2 >= (loc1 - 1)) 
            {
                return loc1;
            }
            var loc2:*=!IS_WHITESPACE.test(arg1.charAt(arg2));
            var loc3:*=arg2 + 1;
            while (loc3 < loc1) 
            {
                loc4 = IS_WORD.test(arg1.charAt(loc3));
                if (loc4 && !loc2) 
                {
                    return loc3;
                }
                loc2 = loc4;
                ++loc3;
            }
            return loc1;
        }

        protected static const IS_WORD:RegExp=new RegExp("\\w");

        protected static const IS_WHITESPACE:RegExp=new RegExp("\\s");
    }
}


