//class MyDeviceTrainingsListItem
package frontend.screen.mydevices.list 
{
    import core.training.*;
    import frontend.components.list.*;
    import utils.*;
    
    public class MyDeviceTrainingsListItem extends frontend.components.list.SelectableListItem
    {
        public function MyDeviceTrainingsListItem(arg1:core.training.Training=null)
        {
            super();
            if (this.training != null) 
            {
                this.training = arg1;
            }
            else 
            {
                this.training = new core.training.Training();
            }
            return;
        }

        public function get training():core.training.Training
        {
            return this._training;
        }

        public function set training(arg1:core.training.Training):void
        {
            this._training = arg1;
            if (this._training != null) 
            {
                this.GUID = this._training.GUID;
            }
            if (this.GUID == "") 
            {
                var loc1:*;
                this._training.GUID = loc1 = utils.GUID.create();
                this.GUID = loc1;
            }
            return;
        }

        internal var _training:core.training.Training;
    }
}


