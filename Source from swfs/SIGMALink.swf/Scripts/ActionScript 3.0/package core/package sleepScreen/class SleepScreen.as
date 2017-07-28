//class SleepScreen
package core.sleepScreen 
{
    import flash.display.*;
    
    public class SleepScreen extends Object
    {
        public function SleepScreen(arg1:XML)
        {
            super();
            xml = arg1;
            title = xml.@title;
            id = xml.@id;
            sprite = core.sleepScreen.SleepScreenSign.signs[id];
            return;
        }

        public var id:String;

        public var sprite:flash.display.Sprite;

        public var title:String;

        public var xml:XML;
    }
}


