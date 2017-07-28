//package validator
//  class TextInputRestrictions
package utils.validator 
{
    public class TextInputRestrictions extends Object
    {
        public function TextInputRestrictions()
        {
            super();
            return;
        }

        public static function getValidSQLString(arg1:String):String
        {
            if (arg1 == null) 
            {
                return "";
            }
            if (arg1.indexOf("\"") != -1) 
            {
                arg1 = arg1.replace("\"", "");
                return getValidSQLString(arg1);
            }
            return arg1;
        }

        public static function replaceSpaces(arg1:String, arg2:String="_"):String
        {
            return arg1.replace(new RegExp(" ", "g"), arg2);
        }

        public static function getValidSingleLineText(arg1:String):String
        {
            var loc1:*=arg1.replace("\n", " ");
            loc1 = loc1.replace("\t", " ");
            return loc1;
        }

        public static function getValidFileNameString(arg1:String):String
        {
            var loc1:*=arg1.match(new RegExp("[^!¡?¿\"¨#$%&\'´()*.,;:=\\^\\\\\\/{}\\[\\]|\\<\\>~¢©®ª£¤¥¦§«»¬¯°º±¹²³µ¶·×Ø÷]+", "g"));
            return loc1.join("");
        }

        public static function getValidPrintDescription(arg1:String, arg2:int):String
        {
            if (arg1.length > arg2 && arg2 > 0) 
            {
                arg1 = arg1.substr(0, arg2);
                arg1 = arg1 + "...";
            }
            return arg1;
        }

        public static const SQL_VALID:String="^\"";
    }
}


