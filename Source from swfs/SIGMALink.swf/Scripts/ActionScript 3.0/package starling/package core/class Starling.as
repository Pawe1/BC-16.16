//class Starling
package starling.core 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class Starling extends starling.events.EventDispatcher
    {
        public function Starling(arg1:Class, arg2:flash.display.Stage, arg3:flash.geom.Rectangle=null, arg4:flash.display.Stage3D=null, arg5:String="auto", arg6:Object="auto")
        {
            var loc1:*=null;
            super();
            if (arg2 == null) 
            {
                throw new ArgumentError("Stage must not be null");
            }
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Rectangle(0, 0, arg2.stageWidth, arg2.stageHeight);
            }
            if (arg4 == null) 
            {
                arg4 = arg2.stage3Ds[0];
            }
            starling.utils.SystemUtil.initialize();
            sAll.push(this);
            this.makeCurrent();
            this._rootClass = arg1;
            this._viewPort = arg3;
            this._previousViewPort = new flash.geom.Rectangle();
            this._stage = new starling.display.Stage(arg3.width, arg3.height, arg2.color);
            this._nativeOverlay = new flash.display.Sprite();
            this._nativeStage = arg2;
            this._nativeStage.addChild(this._nativeOverlay);
            this._touchProcessor = new starling.events.TouchProcessor(this._stage);
            this._juggler = new starling.animation.Juggler();
            this._antiAliasing = 0;
            this._supportHighResolutions = false;
            this._painter = new starling.rendering.Painter(arg4);
            this._frameTimestamp = flash.utils.getTimer() / 1000;
            this._frameID = 1;
            arg2.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            arg2.align = flash.display.StageAlign.TOP_LEFT;
            var loc2:*=0;
            var loc3:*=this.touchEventTypes;
            for each (loc1 in loc3) 
            {
                arg2.addEventListener(loc1, this.onTouch, false, 0, true);
            }
            arg2.addEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
            arg2.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKey, false, 0, true);
            arg2.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKey, false, 0, true);
            arg2.addEventListener(flash.events.Event.RESIZE, this.onResize, false, 0, true);
            arg2.addEventListener(flash.events.Event.MOUSE_LEAVE, this.onMouseLeave, false, 0, true);
            arg4.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false, 10, true);
            arg4.addEventListener(flash.events.ErrorEvent.ERROR, this.onStage3DError, false, 10, true);
            if (this._painter.shareContext) 
            {
                flash.utils.setTimeout(this.initialize, 1);
            }
            else 
            {
                if (!starling.utils.SystemUtil.supportsDepthAndStencil) 
                {
                    trace("[Starling] Mask support requires \'depthAndStencil\' to be enabled" + " in the application descriptor.");
                }
                this._painter.requestContext3D(arg5, arg6);
            }
            return;
        }

        public function set rootClass(arg1:Class):void
        {
            if (!(this._rootClass == null) && !(this._root == null)) 
            {
                throw new Error("Root class may not change after root has been instantiated");
            }
            if (this._rootClass == null) 
            {
                this._rootClass = arg1;
                if (this.context) 
                {
                    this.initializeRoot();
                }
            }
            return;
        }

        public function get shareContext():Boolean
        {
            return this._painter.shareContext;
        }

        public function set shareContext(arg1:Boolean):void
        {
            this._painter.shareContext = arg1;
            return;
        }

        public function get profile():String
        {
            return this._painter.profile;
        }

        public function get supportHighResolutions():Boolean
        {
            return this._supportHighResolutions;
        }

        public function set supportHighResolutions(arg1:Boolean):void
        {
            if (this._supportHighResolutions != arg1) 
            {
                this._supportHighResolutions = arg1;
                if (this.contextValid) 
                {
                    this.updateViewPort(true);
                }
            }
            return;
        }

        public function get skipUnchangedFrames():Boolean
        {
            return this._skipUnchangedFrames;
        }

        public function set skipUnchangedFrames(arg1:Boolean):void
        {
            this._skipUnchangedFrames = arg1;
            this._nativeStageEmpty = false;
            return;
        }

        public function get touchProcessor():starling.events.TouchProcessor
        {
            return this._touchProcessor;
        }

        public function set touchProcessor(arg1:starling.events.TouchProcessor):void
        {
            if (arg1 == null) 
            {
                throw new ArgumentError("TouchProcessor must not be null");
            }
            if (arg1 != this._touchProcessor) 
            {
                this._touchProcessor.dispose();
                this._touchProcessor = arg1;
            }
            return;
        }

        public function get isStarted():Boolean
        {
            return this._started;
        }

        public function get frameID():uint
        {
            return this._frameID;
        }

        public function get contextValid():Boolean
        {
            return this._painter.contextValid;
        }

        public static function get current():starling.core.Starling
        {
            return sCurrent;
        }

        public static function get all():__AS3__.vec.Vector.<starling.core.Starling>
        {
            return sAll;
        }

        public static function get context():flash.display3D.Context3D
        {
            return sCurrent ? sCurrent.context : null;
        }

        public static function get juggler():starling.animation.Juggler
        {
            return sCurrent ? sCurrent._juggler : null;
        }

        public static function get painter():starling.rendering.Painter
        {
            return sCurrent ? sCurrent._painter : null;
        }

        public static function get contentScaleFactor():Number
        {
            return sCurrent ? sCurrent.contentScaleFactor : 1;
        }

        public static function get multitouchEnabled():Boolean
        {
            return flash.ui.Multitouch.inputMode == flash.ui.MultitouchInputMode.TOUCH_POINT;
        }

        public static function set multitouchEnabled(arg1:Boolean):void
        {
            if (sCurrent) 
            {
                throw new flash.errors.IllegalOperationError("\'multitouchEnabled\' must be set before Starling instance is created");
            }
            flash.ui.Multitouch.inputMode = arg1 ? flash.ui.MultitouchInputMode.TOUCH_POINT : flash.ui.MultitouchInputMode.NONE;
            return;
        }

        public static function get frameID():uint
        {
            return sCurrent ? sCurrent._frameID : 0;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            this.stop(true);
            this._nativeStage.removeEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrame, false);
            this._nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKey, false);
            this._nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKey, false);
            this._nativeStage.removeEventListener(flash.events.Event.RESIZE, this.onResize, false);
            this._nativeStage.removeEventListener(flash.events.Event.MOUSE_LEAVE, this.onMouseLeave, false);
            this._nativeStage.removeChild(this._nativeOverlay);
            this.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated, false);
            this.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextRestored, false);
            this.stage3D.removeEventListener(flash.events.ErrorEvent.ERROR, this.onStage3DError, false);
            var loc3:*=0;
            var loc4:*=this.touchEventTypes;
            for each (loc1 in loc4) 
            {
                this._nativeStage.removeEventListener(loc1, this.onTouch, false);
            }
            this._touchProcessor.dispose();
            this._painter.dispose();
            this._stage.dispose();
            loc2 = sAll.indexOf(this);
            if (loc2 != -1) 
            {
                sAll.removeAt(loc2);
            }
            if (sCurrent == this) 
            {
                sCurrent = null;
            }
            return;
        }

        internal function initialize():void
        {
            this.makeCurrent();
            this.updateViewPort(true);
            dispatchEventWith(flash.events.Event.CONTEXT3D_CREATE, false, this.context);
            this.initializeRoot();
            this._frameTimestamp = flash.utils.getTimer() / 1000;
            return;
        }

        internal function initializeRoot():void
        {
            if (this._root == null && !(this._rootClass == null)) 
            {
                this._root = new this._rootClass() as starling.display.DisplayObject;
                if (this._root == null) 
                {
                    throw new Error("Invalid root class: " + this._rootClass);
                }
                this._stage.addChildAt(this._root, 0);
                dispatchEventWith(starling.events.Event.ROOT_CREATED, false, this._root);
            }
            return;
        }

        public function nextFrame():void
        {
            var loc1:*=flash.utils.getTimer() / 1000;
            var loc2:*=loc1 - this._frameTimestamp;
            this._frameTimestamp = loc1;
            if (loc2 > 1) 
            {
                loc2 = 1;
            }
            if (loc2 < 0) 
            {
                loc2 = 1 / this._nativeStage.frameRate;
            }
            this.advanceTime(loc2);
            this.render();
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            if (!this.contextValid) 
            {
                return;
            }
            this.makeCurrent();
            this._touchProcessor.advanceTime(arg1);
            this._stage.advanceTime(arg1);
            this._juggler.advanceTime(arg1);
            return;
        }

        public function render():void
        {
            var loc2:*=false;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (!this.contextValid) 
            {
                return;
            }
            this.makeCurrent();
            this.updateViewPort();
            var loc1:*=this._stage.requiresRedraw || this.mustAlwaysRender;
            if (loc1) 
            {
                dispatchEventWith(starling.events.Event.RENDER);
                loc2 = this._painter.shareContext;
                loc3 = this._viewPort.width / this._stage.stageWidth;
                loc4 = this._viewPort.height / this._stage.stageHeight;
                this._painter.nextFrame();
                this._painter.pixelSize = 1 / this.contentScaleFactor;
                this._painter.state.setProjectionMatrix(this._viewPort.x < 0 ? (-this._viewPort.x) / loc3 : 0, this._viewPort.y < 0 ? (-this._viewPort.y) / loc4 : 0, this._clippedViewPort.width / loc3, this._clippedViewPort.height / loc4, this._stage.stageWidth, this._stage.stageHeight, this._stage.cameraPosition);
                if (!loc2) 
                {
                    this._painter.clear(this._stage.color, 0);
                }
                this._stage.render(this._painter);
                this._painter.finishFrame();
                var loc5:*;
                var loc6:*;
                this._painter.frameID = loc5._frameID = loc6 = ((loc5 = this)._frameID + 1);
                if (!loc2) 
                {
                    this._painter.present();
                }
            }
            if (this._statsDisplay) 
            {
                this._statsDisplay.drawCount = this._painter.drawCount;
                if (!loc1) 
                {
                    this._statsDisplay.markFrameAsSkipped();
                }
            }
            return;
        }

        internal function updateViewPort(arg1:Boolean=false):void
        {
            var loc1:*=NaN;
            if (arg1 || !starling.utils.RectangleUtil.compare(this._viewPort, this._previousViewPort)) 
            {
                this._previousViewPort.setTo(this._viewPort.x, this._viewPort.y, this._viewPort.width, this._viewPort.height);
                this._clippedViewPort = this._viewPort.intersection(new flash.geom.Rectangle(0, 0, this._nativeStage.stageWidth, this._nativeStage.stageHeight));
                loc1 = this._supportHighResolutions ? this._nativeStage.contentsScaleFactor : 1;
                this._painter.configureBackBuffer(this._clippedViewPort, loc1, this._antiAliasing, true);
            }
            return;
        }

        internal function updateNativeOverlay():void
        {
            this._nativeOverlay.x = this._viewPort.x;
            this._nativeOverlay.y = this._viewPort.y;
            this._nativeOverlay.scaleX = this._viewPort.width / this._stage.stageWidth;
            this._nativeOverlay.scaleY = this._viewPort.height / this._stage.stageHeight;
            return;
        }

        public function stopWithFatalError(arg1:String):void
        {
            var loc1:*=new flash.display.Shape();
            loc1.graphics.beginFill(0, 0.8);
            loc1.graphics.drawRect(0, 0, this._stage.stageWidth, this._stage.stageHeight);
            loc1.graphics.endFill();
            var loc2:*=new flash.text.TextField();
            var loc3:*=new flash.text.TextFormat("Verdana", 14, 16777215);
            loc3.align = flash.text.TextFormatAlign.CENTER;
            loc2.defaultTextFormat = loc3;
            loc2.wordWrap = true;
            loc2.width = this._stage.stageWidth * 0.75;
            loc2.autoSize = flash.text.TextFieldAutoSize.CENTER;
            loc2.text = arg1;
            loc2.x = (this._stage.stageWidth - loc2.width) / 2;
            loc2.y = (this._stage.stageHeight - loc2.height) / 2;
            loc2.background = true;
            loc2.backgroundColor = 5570560;
            this.updateNativeOverlay();
            this.nativeOverlay.addChild(loc1);
            this.nativeOverlay.addChild(loc2);
            this.stop(true);
            trace("[Starling]", arg1);
            dispatchEventWith(starling.events.Event.FATAL_ERROR, false, arg1);
            return;
        }

        public function makeCurrent():void
        {
            sCurrent = this;
            return;
        }

        public function start():void
        {
            var loc1:*;
            this._rendering = loc1 = true;
            this._started = loc1;
            this._frameTimestamp = flash.utils.getTimer() / 1000;
            flash.utils.setTimeout(this.setRequiresRedraw, 100);
            return;
        }

        public function stop(arg1:Boolean=false):void
        {
            this._started = false;
            this._rendering = !arg1;
            return;
        }

        public function setRequiresRedraw():void
        {
            this._stage.setRequiresRedraw();
            return;
        }

        internal function onStage3DError(arg1:flash.events.ErrorEvent):void
        {
            var loc1:*=null;
            if (arg1.errorID != 3702) 
            {
                this.stopWithFatalError("Stage3D error: " + arg1.text);
            }
            else 
            {
                loc1 = flash.system.Capabilities.playerType != "Desktop" ? "wmode" : "renderMode";
                this.stopWithFatalError("Context3D not available! Possible reasons: wrong " + loc1 + " or missing device support.");
            }
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            this.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            this.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextRestored, false, 10, true);
            trace("[Starling] Context ready. Display Driver:", this.context.driverInfo);
            this.initialize();
            return;
        }

        internal function onContextRestored(arg1:flash.events.Event):void
        {
            trace("[Starling] Context restored.");
            this.updateViewPort(true);
            dispatchEventWith(flash.events.Event.CONTEXT3D_CREATE, false, this.context);
            return;
        }

        internal function onEnterFrame(arg1:flash.events.Event):void
        {
            if (!this.shareContext) 
            {
                if (this._started) 
                {
                    this.nextFrame();
                }
                else if (this._rendering) 
                {
                    this.render();
                }
            }
            this.updateNativeOverlay();
            return;
        }

        internal function onKey(arg1:flash.events.KeyboardEvent):void
        {
            if (!this._started) 
            {
                return;
            }
            var loc1:*=new starling.events.KeyboardEvent(arg1.type, arg1.charCode, arg1.keyCode, arg1.keyLocation, arg1.ctrlKey, arg1.altKey, arg1.shiftKey);
            this.makeCurrent();
            this._stage.dispatchEvent(loc1);
            if (loc1.isDefaultPrevented()) 
            {
                arg1.preventDefault();
            }
            return;
        }

        internal function onResize(arg1:flash.events.Event):void
        {
            var event:flash.events.Event;
            var stageWidth:int;
            var stageHeight:int;
            var dispatchResizeEvent:Function;

            var loc1:*;
            stageWidth = 0;
            stageHeight = 0;
            dispatchResizeEvent = null;
            event = arg1;
            dispatchResizeEvent = function ():void
            {
                makeCurrent();
                removeEventListener(flash.events.Event.CONTEXT3D_CREATE, dispatchResizeEvent);
                _stage.dispatchEvent(new starling.events.ResizeEvent(flash.events.Event.RESIZE, stageWidth, stageHeight));
                return;
            }
            stageWidth = event.target.stageWidth;
            stageHeight = event.target.stageHeight;
            if (this.contextValid) 
            {
                dispatchResizeEvent();
            }
            else 
            {
                addEventListener(flash.events.Event.CONTEXT3D_CREATE, dispatchResizeEvent);
            }
            return;
        }

        internal function onMouseLeave(arg1:flash.events.Event):void
        {
            this._touchProcessor.enqueueMouseLeftStage();
            return;
        }

        internal function onTouch(arg1:flash.events.Event):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=null;
            var loc8:*=null;
            var loc9:*=null;
            if (!this._started) 
            {
                return;
            }
            var loc5:*=1;
            var loc6:*=1;
            var loc7:*=1;
            if (arg1 is flash.events.MouseEvent) 
            {
                loc8 = arg1 as flash.events.MouseEvent;
                loc1 = loc8.stageX;
                loc2 = loc8.stageY;
                loc3 = 0;
                if (arg1.type != flash.events.MouseEvent.MOUSE_DOWN) 
                {
                    if (arg1.type == flash.events.MouseEvent.MOUSE_UP) 
                    {
                        this._leftMouseDown = false;
                    }
                }
                else 
                {
                    this._leftMouseDown = true;
                }
            }
            else 
            {
                loc9 = arg1 as flash.events.TouchEvent;
                if (flash.ui.Mouse.supportsCursor && loc9.isPrimaryTouchPoint) 
                {
                    return;
                }
                loc1 = loc9.stageX;
                loc2 = loc9.stageY;
                loc3 = loc9.touchPointID;
                loc5 = loc9.pressure;
                loc6 = loc9.sizeX;
                loc7 = loc9.sizeY;
            }
            var loc10:*=arg1.type;
            switch (loc10) 
            {
                case flash.events.TouchEvent.TOUCH_BEGIN:
                {
                    loc4 = starling.events.TouchPhase.BEGAN;
                    break;
                }
                case flash.events.TouchEvent.TOUCH_MOVE:
                {
                    loc4 = starling.events.TouchPhase.MOVED;
                    break;
                }
                case flash.events.TouchEvent.TOUCH_END:
                {
                    loc4 = starling.events.TouchPhase.ENDED;
                    break;
                }
                case flash.events.MouseEvent.MOUSE_DOWN:
                {
                    loc4 = starling.events.TouchPhase.BEGAN;
                    break;
                }
                case flash.events.MouseEvent.MOUSE_UP:
                {
                    loc4 = starling.events.TouchPhase.ENDED;
                    break;
                }
                case flash.events.MouseEvent.MOUSE_MOVE:
                {
                    loc4 = this._leftMouseDown ? starling.events.TouchPhase.MOVED : starling.events.TouchPhase.HOVER;
                    break;
                }
            }
            loc1 = this._stage.stageWidth * (loc1 - this._viewPort.x) / this._viewPort.width;
            loc2 = this._stage.stageHeight * (loc2 - this._viewPort.y) / this._viewPort.height;
            this._touchProcessor.enqueue(loc3, loc4, loc1, loc2, loc5, loc6, loc7);
            if (arg1.type == flash.events.MouseEvent.MOUSE_UP && flash.ui.Mouse.supportsCursor) 
            {
                this._touchProcessor.enqueue(loc3, starling.events.TouchPhase.HOVER, loc1, loc2);
            }
            return;
        }

        internal function get touchEventTypes():Array
        {
            var loc1:*=[];
            if (multitouchEnabled) 
            {
                loc1.push(flash.events.TouchEvent.TOUCH_BEGIN, flash.events.TouchEvent.TOUCH_MOVE, flash.events.TouchEvent.TOUCH_END);
            }
            if (!multitouchEnabled || flash.ui.Mouse.supportsCursor) 
            {
                loc1.push(flash.events.MouseEvent.MOUSE_DOWN, flash.events.MouseEvent.MOUSE_MOVE, flash.events.MouseEvent.MOUSE_UP);
            }
            return loc1;
        }

        internal function get mustAlwaysRender():Boolean
        {
            var loc1:*=false;
            var loc2:*=false;
            if (!this._skipUnchangedFrames || this._painter.shareContext) 
            {
                return true;
            }
            if (starling.utils.SystemUtil.isDesktop && !(this.profile == flash.display3D.Context3DProfile.BASELINE_CONSTRAINED)) 
            {
                return false;
            }
            loc1 = isNativeDisplayObjectEmpty(this._nativeStage);
            loc2 = !loc1 || !this._nativeStageEmpty;
            this._nativeStageEmpty = loc1;
            return loc2;
        }

        
        {
            sAll = new Vector.<>(0);
        }

        public function get juggler():starling.animation.Juggler
        {
            return this._juggler;
        }

        public function get painter():starling.rendering.Painter
        {
            return this._painter;
        }

        public function get context():flash.display3D.Context3D
        {
            return this._painter.context;
        }

        public function get simulateMultitouch():Boolean
        {
            return this._touchProcessor.simulateMultitouch;
        }

        public function set simulateMultitouch(arg1:Boolean):void
        {
            this._touchProcessor.simulateMultitouch = arg1;
            return;
        }

        public function get enableErrorChecking():Boolean
        {
            return this._painter.enableErrorChecking;
        }

        public function set enableErrorChecking(arg1:Boolean):void
        {
            this._painter.enableErrorChecking = arg1;
            return;
        }

        public function get antiAliasing():int
        {
            return this._antiAliasing;
        }

        public function set antiAliasing(arg1:int):void
        {
            if (this._antiAliasing != arg1) 
            {
                this._antiAliasing = arg1;
                if (this.contextValid) 
                {
                    this.updateViewPort(true);
                }
            }
            return;
        }

        public function get viewPort():flash.geom.Rectangle
        {
            return this._viewPort;
        }

        public function set viewPort(arg1:flash.geom.Rectangle):void
        {
            this._viewPort = arg1.clone();
            return;
        }

        public function get contentScaleFactor():Number
        {
            return this._viewPort.width * this._painter.backBufferScaleFactor / this._stage.stageWidth;
        }

        public function get nativeOverlay():flash.display.Sprite
        {
            return this._nativeOverlay;
        }

        public function get showStats():Boolean
        {
            return this._showStats;
        }

        public function set showStats(arg1:Boolean):void
        {
            this._showStats = arg1;
            if (arg1) 
            {
                if (this._statsDisplay) 
                {
                    this._stage.addChild(this._statsDisplay);
                }
                else 
                {
                    this.showStatsAt();
                }
            }
            else if (this._statsDisplay) 
            {
                this._statsDisplay.removeFromParent();
            }
            return;
        }

        public function showStatsAt(arg1:String="left", arg2:String="top", arg3:Number=1):void
        {
            var horizontalAlign:String="left";
            var verticalAlign:String="top";
            var scale:Number=1;
            var onRootCreated:Function;
            var stageWidth:int;
            var stageHeight:int;

            var loc1:*;
            onRootCreated = null;
            stageWidth = 0;
            stageHeight = 0;
            horizontalAlign = arg1;
            verticalAlign = arg2;
            scale = arg3;
            onRootCreated = function ():void
            {
                if (_showStats) 
                {
                    showStatsAt(horizontalAlign, verticalAlign, scale);
                }
                removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
                return;
            }
            this._showStats = true;
            if (this.context != null) 
            {
                stageWidth = this._stage.stageWidth;
                stageHeight = this._stage.stageHeight;
                if (this._statsDisplay == null) 
                {
                    this._statsDisplay = new StatsDisplay();
                    this._statsDisplay.touchable = false;
                }
                this._stage.addChild(this._statsDisplay);
                var loc2:*;
                this._statsDisplay.scaleY = loc2 = scale;
                this._statsDisplay.scaleX = loc2;
                if (horizontalAlign != starling.utils.Align.LEFT) 
                {
                    if (horizontalAlign != starling.utils.Align.RIGHT) 
                    {
                        if (horizontalAlign != starling.utils.Align.CENTER) 
                        {
                            throw new ArgumentError("Invalid horizontal alignment: " + horizontalAlign);
                        }
                        else 
                        {
                            this._statsDisplay.x = (stageWidth - this._statsDisplay.width) / 2;
                        }
                    }
                    else 
                    {
                        this._statsDisplay.x = stageWidth - this._statsDisplay.width;
                    }
                }
                else 
                {
                    this._statsDisplay.x = 0;
                }
                if (verticalAlign != starling.utils.Align.TOP) 
                {
                    if (verticalAlign != starling.utils.Align.BOTTOM) 
                    {
                        if (verticalAlign != starling.utils.Align.CENTER) 
                        {
                            throw new ArgumentError("Invalid vertical alignment: " + verticalAlign);
                        }
                        else 
                        {
                            this._statsDisplay.y = (stageHeight - this._statsDisplay.height) / 2;
                        }
                    }
                    else 
                    {
                        this._statsDisplay.y = stageHeight - this._statsDisplay.height;
                    }
                }
                else 
                {
                    this._statsDisplay.y = 0;
                }
            }
            else 
            {
                addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
            }
            return;
        }

        public function get stage():starling.display.Stage
        {
            return this._stage;
        }

        public function get stage3D():flash.display.Stage3D
        {
            return this._painter.stage3D;
        }

        public function get nativeStage():flash.display.Stage
        {
            return this._nativeStage;
        }

        public function get root():starling.display.DisplayObject
        {
            return this._root;
        }

        public function get rootClass():Class
        {
            return this._rootClass;
        }

        public static const VERSION:String="2.1";

        internal var _stage:starling.display.Stage;

        internal var _rootClass:Class;

        internal var _root:starling.display.DisplayObject;

        internal var _juggler:starling.animation.Juggler;

        internal var _painter:starling.rendering.Painter;

        internal var _touchProcessor:starling.events.TouchProcessor;

        internal var _antiAliasing:int;

        internal var _frameTimestamp:Number;

        internal var _frameID:uint;

        internal var _leftMouseDown:Boolean;

        internal var _started:Boolean;

        internal var _rendering:Boolean;

        internal var _supportHighResolutions:Boolean;

        internal var _skipUnchangedFrames:Boolean;

        internal var _showStats:Boolean;

        internal var _viewPort:flash.geom.Rectangle;

        internal var _previousViewPort:flash.geom.Rectangle;

        internal var _clippedViewPort:flash.geom.Rectangle;

        internal var _nativeStage:flash.display.Stage;

        internal var _nativeStageEmpty:Boolean;

        internal var _nativeOverlay:flash.display.Sprite;

        internal var _statsDisplay:StatsDisplay;

        internal static var sAll:__AS3__.vec.Vector.<starling.core.Starling>;

        internal static var sCurrent:starling.core.Starling;
    }
}


const isNativeDisplayObjectEmpty:Function=function (arg1:flash.display.DisplayObject):Boolean
{
    var loc1:*=null;
    var loc2:*=0;
    var loc3:*=0;
    if (arg1 == null) 
    {
        return true;
    }
    if (arg1 is flash.display.DisplayObjectContainer) 
    {
        loc1 = arg1 as flash.display.DisplayObjectContainer;
        loc2 = loc1.numChildren;
        loc3 = 0;
        while (loc3 < loc2) 
        {
            if (!isNativeDisplayObjectEmpty(loc1.getChildAt(loc3))) 
            {
                return false;
            }
            ++loc3;
        }
        return true;
    }
    return !arg1.visible;
}

