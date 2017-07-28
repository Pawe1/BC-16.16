//class MyDeviceSettingsListItem
package frontend.screen.mydevices.list 
{
    import core.settings.*;
    import frontend.components.list.*;
    
    public class MyDeviceSettingsListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDeviceSettingsListItem()
        {
            super();
            return;
        }

        public var lastChanges:String;

        public var name:String;

        public var setting:core.settings.Settings;
    }
}


