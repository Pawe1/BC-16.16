//class MyDevicePointNavigationListItem
package frontend.screen.mydevices.list 
{
    import core.gps.*;
    import frontend.components.list.*;
    
    public class MyDevicePointNavigationListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDevicePointNavigationListItem()
        {
            super();
            return;
        }

        public var pointNavigation:core.gps.PointNavigation;
    }
}


