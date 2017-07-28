//class MyDeviceSportprofilesListItem
package frontend.screen.mydevices.list 
{
    import core.sportprofiles.*;
    import frontend.components.list.*;
    import utils.*;
    
    public class MyDeviceSportprofilesListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDeviceSportprofilesListItem()
        {
            super();
            return;
        }

        public function get sportprofile():core.sportprofiles.Sportprofile
        {
            return this._sportprofile;
        }

        public function set sportprofile(arg1:core.sportprofiles.Sportprofile):void
        {
            this._sportprofile = arg1;
            if (this._sportprofile != null) 
            {
                this.GUID = this._sportprofile.GUID;
            }
            if (this.GUID == "") 
            {
                var loc1:*;
                this._sportprofile.GUID = loc1 = utils.GUID.create();
                this.GUID = loc1;
            }
            return;
        }

        internal var _sportprofile:core.sportprofiles.Sportprofile;
    }
}


