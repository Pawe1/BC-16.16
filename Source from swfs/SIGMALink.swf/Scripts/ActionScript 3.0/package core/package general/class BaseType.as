//class BaseType
package core.general 
{
    public class BaseType extends Object
    {
        public function BaseType(arg1:String=null)
        {
            super();
            data = arg1;
            return;
        }

        public function toString():String
        {
            return this.data;
        }

        public function equals(arg1:core.general.BaseType):Boolean
        {
            return !(arg1 == null) && data == arg1.data;
        }

        public var data:String;
    }
}


