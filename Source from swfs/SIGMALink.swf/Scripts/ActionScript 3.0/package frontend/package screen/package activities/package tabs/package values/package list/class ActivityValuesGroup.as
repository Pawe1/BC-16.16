//class ActivityValuesGroup
package frontend.screen.activities.tabs.values.list 
{
    public class ActivityValuesGroup extends Object
    {
        public function ActivityValuesGroup()
        {
            this.children = [];
            this.footer = {"text":""};
            super();
            return;
        }

        public function addChild(arg1:frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject):void
        {
            if (arg1 is frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject) 
            {
                this.children.push(arg1);
            }
            return;
        }

        public var children:Array;

        public var footer:Object;

        public var header:Object;
    }
}


