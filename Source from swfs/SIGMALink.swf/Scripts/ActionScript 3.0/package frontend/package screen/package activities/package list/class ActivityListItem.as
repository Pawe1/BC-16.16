//class ActivityListItem
package frontend.screen.activities.list 
{
    import core.activities.*;
    import core.sport.*;
    import frontend.components.list.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class ActivityListItem extends frontend.components.list.SelectableListItem
    {
        public function ActivityListItem()
        {
            this.startDate = new Date();
            super();
            return;
        }

        public var activity:core.activities.Activity;

        public var activityId:uint;

        public var defaultSelected:Boolean=false;

        public var distance:String;

        public var distanceValue:Number=0;

        public var isNew:Boolean=false;

        public var isUpdate:Boolean=false;

        public var name:String="";

        public var shareIcon:starling.textures.Texture;

        public var shared:Boolean=false;

        public var sport:core.sport.Sport;

        public var sportBackgroundSkin:starling.display.Quad;

        public var sportIcon:starling.textures.Texture;

        public var startDate:Date;

        public var trainingTime:String;

        public var trainingTimeValue:Number=0;
    }
}


