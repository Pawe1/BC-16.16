//class WebView
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.utils.display.*;
    import feathers.utils.geom.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class WebView extends feathers.core.FeathersControl
    {
        public function WebView()
        {
            super();
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.webView_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.webView_removedFromStageHandler);
            return;
        }

        protected function stageWebView_completeHandler(arg1:flash.events.Event):void
        {
            this.dispatchEventWith(starling.events.Event.COMPLETE);
            return;
        }

        public static function get isSupported():Boolean
        {
            var loc1:*;
            if (!STAGE_WEB_VIEW_CLASS) 
            {
                try 
                {
                    STAGE_WEB_VIEW_CLASS = Class(flash.utils.getDefinitionByName(STAGE_WEB_VIEW_FULLY_QUALIFIED_CLASS_NAME));
                }
                catch (error:Error)
                {
                    return false;
                }
            }
            return STAGE_WEB_VIEW_CLASS.isSupported;
        }

        public function get useNative():Boolean
        {
            return this._useNative;
        }

        public function set useNative(arg1:Boolean):void
        {
            if (this.isCreated) 
            {
                throw new flash.errors.IllegalOperationError(USE_NATIVE_ERROR);
            }
            this._useNative = arg1;
            return;
        }

        public function get location():String
        {
            if (this.stageWebView) 
            {
                return this.stageWebView.location;
            }
            return null;
        }

        public function get title():String
        {
            if (this.stageWebView) 
            {
                return this.stageWebView.title;
            }
            return null;
        }

        public function get isHistoryBackEnabled():Boolean
        {
            if (this.stageWebView) 
            {
                return this.stageWebView.isHistoryBackEnabled;
            }
            return false;
        }

        public function get isHistoryForwardEnabled():Boolean
        {
            if (this.stageWebView) 
            {
                return this.stageWebView.isHistoryForwardEnabled;
            }
            return false;
        }

        public override function dispose():void
        {
            if (this.stageWebView) 
            {
                this.stageWebView.stage = null;
                this.stageWebView.dispose();
                this.stageWebView = null;
            }
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            this.refreshViewPort();
            super.render(arg1);
            return;
        }

        public function loadURL(arg1:String):void
        {
            this.validate();
            this.stageWebView.loadURL(arg1);
            return;
        }

        public function loadString(arg1:String, arg2:String="text/html"):void
        {
            this.validate();
            this.stageWebView.loadString(arg1, arg2);
            return;
        }

        public function stop():void
        {
            this.validate();
            this.stageWebView.stop();
            return;
        }

        public function reload():void
        {
            this.validate();
            this.stageWebView.reload();
            return;
        }

        public function historyBack():void
        {
            this.validate();
            this.stageWebView.historyBack();
            return;
        }

        public function historyForward():void
        {
            this.validate();
            this.stageWebView.historyForward();
            return;
        }

        protected override function initialize():void
        {
            this.createStageWebView();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            loc2 = this.autoSizeIfNeeded() || loc2;
            if (loc2) 
            {
                this.refreshViewPort();
            }
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            var loc5:*=this._explicitWidth;
            if (loc1) 
            {
                loc5 = DEFAULT_SIZE;
            }
            var loc6:*=this._explicitWidth;
            if (loc2) 
            {
                loc6 = DEFAULT_SIZE;
            }
            var loc7:*=this._explicitMinWidth;
            if (loc3) 
            {
                loc7 = DEFAULT_MIN_SIZE;
            }
            var loc8:*=this._explicitMinHeight;
            if (loc4) 
            {
                loc8 = DEFAULT_MIN_SIZE;
            }
            return this.saveMeasurements(loc5, loc6, loc7, loc8);
        }

        protected function createStageWebView():void
        {
            if (isSupported) 
            {
                this.stageWebView = new STAGE_WEB_VIEW_CLASS(this._useNative);
            }
            else 
            {
                throw new flash.errors.IllegalOperationError(STAGE_WEB_VIEW_NOT_SUPPORTED_ERROR);
            }
            this.stageWebView.addEventListener(flash.events.ErrorEvent.ERROR, this.stageWebView_errorHandler);
            this.stageWebView.addEventListener("locationChange", this.stageWebView_locationChangeHandler);
            this.stageWebView.addEventListener("locationChanging", this.stageWebView_locationChangingHandler);
            this.stageWebView.addEventListener(flash.events.Event.COMPLETE, this.stageWebView_completeHandler);
            return;
        }

        protected function refreshViewPort():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.viewPort;
            var loc3:*=this.stageWebView.viewPort;
            if (!loc3) 
            {
                loc3 = new flash.geom.Rectangle();
            }
            var loc4:*=starling.utils.Pool.getPoint();
            var loc5:*=starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, loc5);
            var loc6:*=feathers.utils.geom.matrixToScaleX(loc5);
            var loc7:*=feathers.utils.geom.matrixToScaleY(loc5);
            starling.utils.MatrixUtil.transformCoords(loc5, 0, 0, loc4);
            var loc8:*=1;
            if (loc1.supportHighResolutions) 
            {
                loc8 = loc1.nativeStage.contentsScaleFactor;
            }
            var loc9:*=loc1.contentScaleFactor / loc8;
            loc3.x = Math.round(loc2.x + loc4.x * loc9);
            loc3.y = Math.round(loc2.y + loc4.y * loc9);
            var loc10:*=Math.round(this.actualWidth * loc9 * loc6);
            if (loc10 < 1 || !(loc10 === loc10)) 
            {
                loc10 = 1;
            }
            var loc11:*=Math.round(this.actualHeight * loc9 * loc7);
            if (loc11 < 1 || !(loc11 === loc11)) 
            {
                loc11 = 1;
            }
            loc3.width = loc10;
            loc3.height = loc11;
            this.stageWebView.viewPort = loc3;
            starling.utils.Pool.putPoint(loc4);
            starling.utils.Pool.putMatrix(loc5);
            return;
        }

        protected function webView_addedToStageHandler(arg1:starling.events.Event):void
        {
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            this.stageWebView.stage = loc1.nativeStage;
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.webView_enterFrameHandler);
            return;
        }

        protected function webView_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (this.stageWebView) 
            {
                this.stageWebView.stage = null;
            }
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.webView_enterFrameHandler);
            return;
        }

        protected function webView_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this;
            do 
            {
                if (!loc1.visible) 
                {
                    this.stageWebView.stage = null;
                    return;
                }
                loc1 = loc1.parent;
            }
            while (loc1);
            var loc2:*=feathers.utils.display.stageToStarling(this.stage);
            this.stageWebView.stage = loc2.nativeStage;
            return;
        }

        protected function stageWebView_errorHandler(arg1:flash.events.ErrorEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, arg1);
            return;
        }

        protected function stageWebView_locationChangeHandler(arg1:flash.events.Event):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.LOCATION_CHANGE);
            return;
        }

        protected function stageWebView_locationChangingHandler(arg1:flash.events.Event):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.LOCATION_CHANGING, false, arg1);
            return;
        }

        protected static const USE_NATIVE_ERROR:String="The useNative property may only be set before the WebView component validates for the first time.";

        protected static const DEFAULT_SIZE:Number=320;

        protected static const DEFAULT_MIN_SIZE:Number=50;

        protected static const STAGE_WEB_VIEW_FULLY_QUALIFIED_CLASS_NAME:String="flash.media.StageWebView";

        protected static const STAGE_WEB_VIEW_NOT_SUPPORTED_ERROR:String="Feathers WebView is only supported in Adobe AIR. It cannot be used in Adobe Flash Player.";

        protected var stageWebView:Object;

        protected var _useNative:Boolean=false;

        protected static var STAGE_WEB_VIEW_CLASS:Class;
    }
}


