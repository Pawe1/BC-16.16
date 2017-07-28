//class MyTracksListItem
package frontend.screen.tracks.tabs.list 
{
    import core.route.*;
    import frontend.components.list.*;
    
    public class MyTracksListItem extends frontend.components.list.SelectableListItem
    {
        public function MyTracksListItem()
        {
            super();
            return;
        }

        public var altitude:String;

        public var altitudeUnit:String;

        public var distance:String;

        public var distanceUnit:String;

        public var icon:String;

        public var track:core.route.Route;
    }
}


