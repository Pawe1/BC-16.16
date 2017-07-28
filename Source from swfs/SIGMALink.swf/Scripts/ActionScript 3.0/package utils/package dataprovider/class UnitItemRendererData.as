//class UnitItemRendererData
package utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import utils.*;
    
    public class UnitItemRendererData extends utils.ItemRendererDataObjectBase
    {
        public function UnitItemRendererData(arg1:String="", arg2:Object=null)
        {
            super(arg1, arg2);
            var loc1:*=arg2 as core.general.UnitType;
            usb = !(core.units.UnitFactory.usbSupported().indexOf(loc1) == -1);
            ble = !(core.units.UnitFactory.bleSupported().indexOf(loc1) == -1);
            nfc = !(core.units.UnitFactory.nfcSupported().indexOf(loc1) == -1);
            return;
        }

        public var ble:Boolean=false;

        public var nfc:Boolean=false;

        public var usb:Boolean=false;
    }
}


