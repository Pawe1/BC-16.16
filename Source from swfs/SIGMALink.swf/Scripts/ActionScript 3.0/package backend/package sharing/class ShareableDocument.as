//class ShareableDocument
package backend.sharing 
{
    import feathers.controls.*;
    import feathers.events.*;
    import flash.display.*;
    import starling.events.*;
    
    public class ShareableDocument extends flash.display.Sprite
    {
        public function ShareableDocument()
        {
            super();
            addEventListener(feathers.events.FeathersEventType.INITIALIZE, this.onInit);
            addEventListener(feathers.events.FeathersEventType.CREATION_COMPLETE, this.onCompleteCreated);
            return;
        }

        public function get shareImageWidth():int
        {
            return this._shareImageWidth;
        }

        public function set shareImageWidth(arg1:int):void
        {
            var loc1:*;
            width = loc1 = arg1;
            this._shareImageWidth = loc1;
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            removeEventListener(feathers.events.FeathersEventType.INITIALIZE, this.onCompleteCreated);
            addChild(this.createHeader());
            addChild(this.createFooter());
            addChild(this.createContent());
            return;
        }

        protected function onCompleteCreated(arg1:starling.events.Event):void
        {
            removeEventListener(feathers.events.FeathersEventType.CREATION_COMPLETE, this.onCompleteCreated);
            this.completeCreated = true;
            return;
        }

        protected function createHeader():flash.display.DisplayObject
        {
            return null;
        }

        protected function createContent():flash.display.DisplayObject
        {
            return null;
        }

        protected function createFooter():flash.display.DisplayObject
        {
            return null;
        }

        public var completeCreated:Boolean=false;

        public var hGutter:Number=0;

        public var hasToCreate:Boolean=true;

        internal var _shareImageWidth:int=1500;

        public var totalPages:uint=0;

        public var vGutter:Number=0;

        protected var _header:feathers.controls.LayoutGroup;

        protected var _mxmlContentArray:Array;
    }
}


