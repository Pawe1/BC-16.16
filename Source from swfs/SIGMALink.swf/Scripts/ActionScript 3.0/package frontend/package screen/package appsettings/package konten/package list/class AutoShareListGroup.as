//class AutoShareListGroup
package frontend.screen.appsettings.konten.list 
{
    public class AutoShareListGroup extends Object
    {
        public function AutoShareListGroup()
        {
            this.children = new Array();
            super();
            return;
        }

        public function addItem(arg1:frontend.screen.appsettings.konten.list.AutoShareListItem):void
        {
            if (arg1) 
            {
                this.children.push(arg1);
            }
            return;
        }

        public var children:Array;

        public var header:frontend.screen.appsettings.konten.list.AutoShareListGroupHeader;
    }
}


