//class ActivitiesListGroup
package frontend.screen.activities.list 
{
    public class ActivitiesListGroup extends Object
    {
        public function ActivitiesListGroup(arg1:String, arg2:String)
        {
            this.children = new Array();
            this.header = new frontend.screen.activities.list.ActivitiesListGroupHeader();
            super();
            this.header.date = arg1;
            this.header.title = arg2;
            return;
        }

        public function addItem(arg1:frontend.screen.activities.list.ActivityListItem):void
        {
            if (arg1) 
            {
                this.children.push(arg1);
                this.sumDistance = this.sumDistance + arg1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime + arg1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(this.children.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public function addItemAt(arg1:frontend.screen.activities.list.ActivityListItem, arg2:int):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1) 
            {
                loc1 = [];
                loc3 = this.children.length;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    if (loc2 == arg2) 
                    {
                        loc1.push(arg1);
                    }
                    loc1.push(this.children[loc2]);
                    ++loc2;
                }
                if (arg2 == loc3) 
                {
                    loc1.push(arg1);
                }
                this.children = loc1;
                this.sumDistance = this.sumDistance + arg1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime + arg1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(loc1.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public function removeItem(arg1:int):void
        {
            var loc1:*=null;
            if (arg1 < this.children.length) 
            {
                loc1 = this.children.removeAt(arg1);
                this.sumDistance = this.sumDistance - loc1.distanceValue;
                this.sumTrainingTime = this.sumTrainingTime - loc1.trainingTimeValue;
                this.footer = new frontend.screen.activities.list.ActivitiesListGroupFooter(this.children.length, this.sumDistance, this.sumTrainingTime);
            }
            return;
        }

        public var children:Array;

        public var footer:frontend.screen.activities.list.ActivitiesListGroupFooter;

        public var header:frontend.screen.activities.list.ActivitiesListGroupHeader;

        internal var sumDistance:Number=0;

        internal var sumTrainingTime:Number=0;
    }
}


