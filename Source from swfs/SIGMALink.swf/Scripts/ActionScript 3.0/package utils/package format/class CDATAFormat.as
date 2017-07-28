//class CDATAFormat
package utils.format 
{
    public class CDATAFormat extends Object
    {
        public function CDATAFormat()
        {
            super();
            return;
        }

        public static function getCDataAsXMLNode(arg1:String, arg2:String):XML
        {
            return new XML("<" + (arg1 + " ") + ">" + new XML("<![CDATA[" + arg2 + "]]>") + "</" + (arg1 + " ") + ">");
        }
    }
}


