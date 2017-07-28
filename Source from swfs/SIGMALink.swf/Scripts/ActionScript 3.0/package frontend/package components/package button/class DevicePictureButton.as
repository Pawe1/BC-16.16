//class DevicePictureButton
package frontend.components.button 
{
    import core.general.*;
    import debug.*;
    import frontend.*;
    
    public class DevicePictureButton extends frontend.components.button.IconButton
    {
        public function DevicePictureButton()
        {
            super();
            return;
        }

        public override function set image(arg1:String):void
        {
            debug.Debug.error("Image darf nicht von außen gesetzt werden!");
            throw new Error("Image darf nicht von außen gesetzt werden!");
        }

        public function get unitType():core.general.UnitType
        {
            return this._unitType;
        }

        public function set unitType(arg1:core.general.UnitType):void
        {
            this._unitType = arg1;
            var loc1:*=frontend.Textures.getUnitTexture(arg1);
            super.image = loc1;
            return;
        }

        internal var _unitType:core.general.UnitType;
    }
}


