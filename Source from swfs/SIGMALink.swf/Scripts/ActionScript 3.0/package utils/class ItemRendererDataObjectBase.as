//class ItemRendererDataObjectBase
package utils 
{
    public class ItemRendererDataObjectBase extends Object
    {
        public function ItemRendererDataObjectBase(arg1:String="", arg2:Object=null)
        {
            super();
            label = arg1;
            data = arg2;
            return;
        }

        public var data:Object;

        public var label:String;
    }
}


