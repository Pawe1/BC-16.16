//class CalloutPopUpContentManager
package feathers.controls.popups 
{
    import feathers.controls.*;
    import flash.errors.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CalloutPopUpContentManager extends starling.events.EventDispatcher implements feathers.controls.popups.IPopUpContentManager
    {
        public function CalloutPopUpContentManager()
        {
            this.direction = feathers.controls.Callout.DIRECTION_ANY;
            super();
            return;
        }

        public function get overlayFactory():Function
        {
            return this._overlayFactory;
        }

        public function set overlayFactory(arg1:Function):void
        {
            this._overlayFactory = arg1;
            return;
        }

        public function get isOpen():Boolean
        {
            return !(this.content === null);
        }

        public function open(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            if (this.isOpen) 
            {
                throw new flash.errors.IllegalOperationError("Pop-up content is already open. Close the previous content before opening new content.");
            }
            this.content = arg1;
            this.callout = feathers.controls.Callout.show(arg1, arg2, this.direction, this.isModal, this.calloutFactory, this._overlayFactory);
            this.callout.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.callout_removedFromStageHandler);
            this.dispatchEventWith(starling.events.Event.OPEN);
            return;
        }

        public function close():void
        {
            if (!this.isOpen) 
            {
                return;
            }
            this.callout.close();
            return;
        }

        public function dispose():void
        {
            this.close();
            return;
        }

        protected function cleanup():void
        {
            this.content = null;
            this.callout.content = null;
            this.callout.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.callout_removedFromStageHandler);
            this.callout = null;
            return;
        }

        protected function callout_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.cleanup();
            this.dispatchEventWith(starling.events.Event.CLOSE);
            return;
        }

        public var calloutFactory:Function;

        public var direction:String;

        public var isModal:Boolean=true;

        protected var _overlayFactory:Function=null;

        protected var content:starling.display.DisplayObject;

        protected var callout:feathers.controls.Callout;
    }
}


