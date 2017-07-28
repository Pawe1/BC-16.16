//class ActivitiesListGroupFooter
package frontend.screen.activities.list 
{
    import frontend.*;
    import starling.textures.*;
    
    public class ActivitiesListGroupFooter extends Object
    {
        public function ActivitiesListGroupFooter(arg1:uint, arg2:Number, arg3:Number)
        {
            super();
            this.length = arg1;
            this.distance = arg2;
            this.trainingTime = arg3;
            this.statisticIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmallcount);
            this.distanceIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalldistance);
            this.timeIcon = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.dashboardsmalltime);
            return;
        }

        public function toString():String
        {
            return "";
        }

        public var distance:Number;

        public var distanceIcon:starling.textures.Texture;

        public var length:uint;

        public var statisticIcon:starling.textures.Texture;

        public var timeIcon:starling.textures.Texture;

        public var trainingTime:Number;
    }
}


