//class PossibleDevicesListItem
package frontend.screen.mydevices.list 
{
    import core.general.*;
    import frontend.components.list.*;
    
    public class PossibleDevicesListItem extends frontend.components.list.SelectableListItem
    {
        public function PossibleDevicesListItem(arg1:core.general.UnitType)
        {
            super();
            this.unitType = arg1;
            this._label = arg1.getLabel();
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        internal var _label:String;

        public var unitType:core.general.UnitType;
    }
}


