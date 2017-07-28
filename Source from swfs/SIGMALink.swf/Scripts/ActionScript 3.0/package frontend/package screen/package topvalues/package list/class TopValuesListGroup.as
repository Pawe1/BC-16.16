//class TopValuesListGroup
package frontend.screen.topvalues.list 
{
    public class TopValuesListGroup extends Object
    {
        public function TopValuesListGroup(arg1:String, arg2:uint)
        {
            this.children = new Array();
            this.header = new frontend.screen.topvalues.list.TopValuesListGroupHeader();
            super();
            this.header.iconSource = arg1;
            this.header.color = arg2;
            return;
        }

        public function addItem(arg1:frontend.screen.topvalues.list.TopValuesListItem):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (arg1) 
            {
                loc2 = this.children.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if ((this.children[loc1] as frontend.screen.topvalues.list.TopValuesListItem).field == arg1.field) 
                    {
                        return;
                    }
                    ++loc1;
                }
                this.children.push(arg1);
            }
            return;
        }

        public var children:Array;

        public var header:frontend.screen.topvalues.list.TopValuesListGroupHeader;
    }
}


