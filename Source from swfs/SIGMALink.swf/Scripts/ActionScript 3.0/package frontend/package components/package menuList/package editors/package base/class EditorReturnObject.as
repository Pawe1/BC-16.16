//class EditorReturnObject
package frontend.components.menuList.editors.base 
{
    public class EditorReturnObject extends Object
    {
        public function EditorReturnObject()
        {
            super();
            return;
        }

        public var dispatchCompleteEvent:Boolean=false;

        public var rawValue:Object;

        public var selectedDataProviderItem:Object;

        public var selectedIndex:uint;

        public var value:String;
    }
}


