//package managers
//  class AbstractTransformationManager
package sk.yoz.ycanvas.map.managers 
{
    import com.greensock.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.utils.*;
    import starling.display.*;
    
    public class AbstractTransformationManager extends Object
    {
        public function AbstractTransformationManager(arg1:sk.yoz.ycanvas.map.YCanvasMap, arg2:sk.yoz.ycanvas.map.valueObjects.Limit, arg3:Number=0.5)
        {
            transformation = new sk.yoz.ycanvas.map.valueObjects.Transformation();
            transformationTarget = new sk.yoz.ycanvas.map.valueObjects.Transformation();
            super();
            this.controller = arg1;
            this.limit = arg2;
            this.transitionDuration = arg3;
            allowMove = true;
            allowZoom = true;
            allowRotate = true;
            updateTransformation();
            arg1.addEventListener("canvasTransformationFinished", onCanvasTransformationFinished);
            return;
        }

        internal function onTweenComplete():void
        {
            disposeTween();
            controller.dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasTransformationFinished"));
            return;
        }

        public function get allowMove():Boolean
        {
            return _allowMove;
        }

        public function set allowMove(arg1:Boolean):void
        {
            if (allowMove == arg1) 
            {
                return;
            }
            _allowMove = arg1;
            validateInteractions();
            return;
        }

        internal function onMoveToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.moveTo(controller, new flash.geom.Point(transformation.centerX, transformation.centerY));
            return;
        }

        public function get allowRotate():Boolean
        {
            return _allowRotate;
        }

        public function set allowRotate(arg1:Boolean):void
        {
            if (allowRotate == arg1) 
            {
                return;
            }
            _allowRotate = arg1;
            validateInteractions();
            return;
        }

        internal function onMoveRotateToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.moveRotateTo(controller, new flash.geom.Point(transformation.centerX, transformation.centerY), transformation.rotation);
            return;
        }

        public function get allowZoom():Boolean
        {
            return _allowZoom;
        }

        public function set allowZoom(arg1:Boolean):void
        {
            if (allowZoom == arg1) 
            {
                return;
            }
            _allowZoom = arg1;
            validateInteractions();
            return;
        }

        internal function onMoveRotateScaleToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.moveRotateTo(controller, new flash.geom.Point(transformation.centerX, transformation.centerY), transformation.rotation);
            controller.scale = transformation.scale;
            return;
        }

        protected function get allowInteractions():Boolean
        {
            return _allowInteractions;
        }

        protected function set allowInteractions(arg1:Boolean):void
        {
            if (allowInteractions == arg1) 
            {
                return;
            }
            _allowInteractions = arg1;
            return;
        }

        internal function onRotateToTweenUpdate(arg1:flash.geom.Point):Function
        {
            var lock:flash.geom.Point;

            lock = arg1;
            return function ():void
            {
                sk.yoz.ycanvas.utils.TransformationUtils.rotateTo(controller, transformation.rotation, lock);
                var loc1:*;
                transformation.centerX = loc1 = controller.center.x;
                transformationTarget.centerX = loc1;
                transformation.centerY = loc1 = controller.center.y;
                transformationTarget.centerY = loc1;
                return;
            }
        }

        internal function onRotateScaleToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.rotateScaleTo(controller, transformation.rotation, transformation.scale);
            return;
        }

        internal function onScaleToTweenUpdate(arg1:flash.geom.Point):Function
        {
            var lock:flash.geom.Point;

            lock = arg1;
            return function ():void
            {
                sk.yoz.ycanvas.utils.TransformationUtils.scaleTo(controller, transformation.scale, lock);
                var loc1:*;
                transformation.centerX = loc1 = controller.center.x;
                transformationTarget.centerX = loc1;
                transformation.centerY = loc1 = controller.center.y;
                transformationTarget.centerY = loc1;
                return;
            }
        }

        internal function onMoveScaleToTweenUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.scaleTo(controller, transformation.scale, new flash.geom.Point(transformationTarget.centerX, transformationTarget.centerY));
            controller.center = new flash.geom.Point(transformation.centerX, transformation.centerY);
            return;
        }

        protected function get transforming():Boolean
        {
            return _transforming;
        }

        protected function set transforming(arg1:Boolean):void
        {
            if (transforming == arg1) 
            {
                return;
            }
            _transforming = arg1;
            return;
        }

        internal function onCanvasTransformationFinished(arg1:sk.yoz.ycanvas.map.events.CanvasEvent):void
        {
            transforming = false;
            updateTransformation();
            return;
        }

        protected static function normalizeRadians(arg1:Number):Number
        {
            arg1 = arg1 % 6.28318530718;
            if (arg1 > 3.14159265359) 
            {
                arg1 = arg1 - 6.28318530718;
            }
            else if (arg1 < -3.14159265359) 
            {
                arg1 = arg1 + 6.28318530718;
            }
            return arg1;
        }

        internal function validateInteractions():void
        {
            allowInteractions = allowMove || allowZoom || allowRotate;
            return;
        }

        public function dispose():void
        {
            stop();
            disposeTween();
            allowMove = false;
            allowZoom = false;
            allowRotate = false;
            allowInteractions = false;
            controller.removeEventListener("canvasTransformationFinished", onCanvasTransformationFinished);
            controller = null;
            return;
        }

        protected function limitScale(arg1:Number):Number
        {
            if (arg1 > limit.minScale) 
            {
                return limit.minScale;
            }
            if (arg1 < limit.maxScale) 
            {
                return limit.maxScale;
            }
            return arg1;
        }

        protected function limitCenterX(arg1:Number):Number
        {
            if (arg1 < limit.minCenterX) 
            {
                return limit.minCenterX;
            }
            if (arg1 > limit.maxCenterX) 
            {
                return limit.maxCenterX;
            }
            return arg1;
        }

        protected function limitCenterY(arg1:Number):Number
        {
            if (arg1 < limit.minCenterY) 
            {
                return limit.minCenterY;
            }
            if (arg1 > limit.maxCenterY) 
            {
                return limit.maxCenterY;
            }
            return arg1;
        }

        protected function stop():void
        {
            return;
        }

        public function rotateByTween(arg1:Number, arg2:flash.geom.Point=null):void
        {
            rotateToTween(transformationTarget.rotation + arg1);
            return;
        }

        internal function updateTransformation():void
        {
            var loc1:*;
            transformation.centerX = loc1 = controller.center.x;
            transformationTarget.centerX = loc1;
            transformation.centerY = loc1 = controller.center.y;
            transformationTarget.centerY = loc1;
            transformation.scale = loc1 = controller.scale;
            transformationTarget.scale = loc1;
            transformation.rotation = loc1 = controller.rotation;
            transformationTarget.rotation = loc1;
            return;
        }

        public function moveByTween(arg1:Number, arg2:Number):void
        {
            moveToTween(transformationTarget.centerX + arg1, transformationTarget.centerY + arg2);
            return;
        }

        public function moveToTween(arg1:Number, arg2:Number):void
        {
            doTween(arg1, arg2, NaN, NaN, onMoveToTweenUpdate);
            return;
        }

        public function moveRotateToTween(arg1:Number, arg2:Number, arg3:Number):void
        {
            var loc1:*=normalizeRadians(arg3 - transformationTarget.rotation);
            arg3 = transformationTarget.rotation + loc1;
            doTween(arg1, arg2, NaN, arg3, onMoveRotateToTweenUpdate);
            return;
        }

        public function moveRotateScaleToTween(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            var loc1:*=normalizeRadians(arg3 - transformationTarget.rotation);
            arg3 = transformationTarget.rotation + loc1;
            doTween(arg1, arg2, arg4, arg3, onMoveRotateScaleToTweenUpdate);
            return;
        }

        public function rotateToTween(arg1:Number, arg2:flash.geom.Point=null):void
        {
            var loc1:*=normalizeRadians(arg1 - transformationTarget.rotation);
            arg1 = transformationTarget.rotation + loc1;
            doTween(NaN, NaN, NaN, arg1, onRotateToTweenUpdate(arg2));
            return;
        }

        public function rotateScaleToTween(arg1:Number, arg2:Number):void
        {
            var loc1:*=normalizeRadians(arg1 - transformationTarget.rotation);
            arg1 = transformationTarget.rotation + loc1;
            doTween(NaN, NaN, arg2, arg1, onRotateScaleToTweenUpdate);
            return;
        }

        public function scaleByTween(arg1:Number, arg2:flash.geom.Point=null):void
        {
            scaleToTween(transformationTarget.scale * arg1, arg2);
            return;
        }

        public function scaleToTween(arg1:Number, arg2:flash.geom.Point=null):void
        {
            doTween(NaN, NaN, arg1, NaN, onScaleToTweenUpdate(arg2));
            return;
        }

        public function showBoundsTween(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            var loc2:*=(arg1 + arg2) / 2;
            var loc1:*=(arg3 + arg4) / 2;
            var loc11:*=controller.canvasToViewPort(new flash.geom.Point(arg1, arg3));
            var loc12:*=controller.canvasToViewPort(new flash.geom.Point(arg2, arg4));
            var loc5:*=Math.min(loc11.x, loc12.x);
            var loc9:*=Math.max(loc11.x, loc12.x);
            var loc3:*=Math.min(loc11.y, loc12.y);
            var loc10:*=Math.max(loc11.y, loc12.y);
            var loc6:*=Math.abs(controller.viewPort.width) / Math.abs(loc9 - loc5);
            var loc7:*=Math.abs(controller.viewPort.height) / Math.abs(loc10 - loc3);
            var loc8:*=Math.min(loc6, loc7);
            var loc4:*=controller.scale * loc8;
            doTween(loc2, loc1, loc4, controller.rotation, onMoveScaleToTweenUpdate);
            return;
        }

        public function showDisplayObjectTween(arg1:starling.display.DisplayObject):void
        {
            showBoundsTween(arg1.bounds.left - arg1.pivotX, arg1.bounds.right - arg1.pivotX, arg1.bounds.top - arg1.pivotY, arg1.bounds.bottom - arg1.pivotY);
            return;
        }

        internal function doTween(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Function):void
        {
            var loc1:*={"onUpdate":arg5, "onComplete":onTweenComplete};
            if (isNaN(arg1)) 
            {
                var loc2:*;
                transformation.centerX = loc2 = controller.center.x;
                transformationTarget.centerX = loc2;
            }
            else 
            {
                loc1.centerX = loc2 = limitCenterX(arg1);
                transformationTarget.centerX = loc2;
            }
            if (isNaN(arg2)) 
            {
                transformation.centerY = loc2 = controller.center.y;
                transformationTarget.centerY = loc2;
            }
            else 
            {
                loc1.centerY = loc2 = limitCenterY(arg2);
                transformationTarget.centerY = loc2;
            }
            if (isNaN(arg3)) 
            {
                transformation.scale = loc2 = controller.scale;
                transformationTarget.scale = loc2;
            }
            else 
            {
                loc1.scale = loc2 = limitScale(arg3);
                transformationTarget.scale = loc2;
            }
            if (isNaN(arg4)) 
            {
                transformation.rotation = loc2 = controller.rotation;
                transformationTarget.rotation = loc2;
            }
            else 
            {
                loc1.rotation = loc2 = arg4;
                transformationTarget.rotation = loc2;
            }
            disposeTween();
            tween = com.greensock.TweenNano.to(transformation, transitionDuration, loc1);
            transforming = true;
            controller.dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasTransformationStarted"));
            return;
        }

        internal function disposeTween():void
        {
            if (!tween) 
            {
                return;
            }
            tween.kill();
            tween = null;
            return;
        }

        public static const PI2:Number=6.28318530718;

        internal var _allowMove:Boolean;

        internal var _allowRotate:Boolean;

        internal var _allowZoom:Boolean;

        internal var _allowInteractions:Boolean;

        protected var controller:sk.yoz.ycanvas.map.YCanvasMap;

        protected var transformation:sk.yoz.ycanvas.map.valueObjects.Transformation;

        protected var transformationTarget:sk.yoz.ycanvas.map.valueObjects.Transformation;

        internal var _transforming:Boolean;

        protected var transitionDuration:Number=0.25;

        internal var limit:sk.yoz.ycanvas.map.valueObjects.Limit;

        public static var yStartCorrection:Number=0;

        internal var tween:com.greensock.TweenNano;
    }
}


//  class MouseTransformationManager
package sk.yoz.ycanvas.map.managers 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import starling.core.*;
    
    public class MouseTransformationManager extends sk.yoz.ycanvas.map.managers.AbstractTransformationManager
    {
        public function MouseTransformationManager(arg1:sk.yoz.ycanvas.map.YCanvasMap, arg2:sk.yoz.ycanvas.map.valueObjects.Limit, arg3:Number=0.5)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function set allowMove(arg1:Boolean):void
        {
            if (allowMove == arg1) 
            {
                return;
            }
            super(
#error('findrop') allowMove
            ).allowMove = arg1;
            if (allowMove) 
            {
                stage.addEventListener("mouseDown", onStageMouseDown);
            }
            else 
            {
                stage.removeEventListener("mouseDown", onStageMouseDown);
            }
            return;
        }

        public override function set allowZoom(arg1:Boolean):void
        {
            if (allowZoom == arg1) 
            {
                return;
            }
            super(
#error('findrop') allowZoom
            ).allowZoom = arg1;
            if (allowZoom) 
            {
                stage.addEventListener("mouseWheel", onStageMouseWheel);
            }
            else 
            {
                stage.removeEventListener("mouseWheel", onStageMouseWheel);
            }
            return;
        }

        protected override function set allowInteractions(arg1:Boolean):void
        {
            if (allowInteractions == arg1) 
            {
                return;
            }
            super(
#error('findrop') allowInteractions
            ).allowInteractions = arg1;
            if (allowInteractions) 
            {
                stage.addEventListener("mouseLeave", onStageMouseLeave);
            }
            else 
            {
                stage.removeEventListener("mouseLeave", onStageMouseLeave);
            }
            return;
        }

        internal function get globalPointInTweenTarget():flash.geom.Point
        {
            var loc1:*=new flash.geom.Point(transformationTarget.centerX, transformationTarget.centerY);
            var loc4:*=new flash.geom.Point(stage.mouseX, stage.mouseY);
            var loc3:*=controller.globalToViewPort(loc4);
            var loc2:*=controller.getConversionMatrix(loc1, transformationTarget.scale, transformationTarget.rotation, controller.viewPort);
            loc2.invert();
            return loc2.transformPoint(loc3);
        }

        internal function get globalPointOnCanvas():flash.geom.Point
        {
            return controller.globalToCanvas(new flash.geom.Point(stage.mouseX, stage.mouseY - yStartCorrection));
        }

        internal function get stage():flash.display.Stage
        {
            return starling.core.Starling.current.nativeStage;
        }

        public override function dispose():void
        {
            stage.removeEventListener("mouseWheel", onStageMouseWheel);
            super.dispose();
            return;
        }

        internal function hitTest(arg1:Number, arg2:Number):Boolean
        {
            return controller.hitTestComponent(arg1, arg2);
        }

        protected override function stop():void
        {
            super.stop();
            stage.removeEventListener("mouseUp", onStageMouseUp);
            stage.removeEventListener("mouseMove", onStageMouseMove);
            return;
        }

        internal function onStageMouseDown(arg1:flash.events.MouseEvent):void
        {
            if (!hitTest(arg1.stageX, arg1.stageY)) 
            {
                return;
            }
            last = globalPointInTweenTarget;
            stage.addEventListener("mouseUp", onStageMouseUp);
            stage.addEventListener("mouseMove", onStageMouseMove);
            return;
        }

        internal function onStageMouseMove(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=globalPointInTweenTarget;
            moveByTween(last.x - loc1.x, last.y - loc1.y);
            last = globalPointInTweenTarget;
            return;
        }

        internal function onStageMouseUp(arg1:flash.events.MouseEvent):void
        {
            stop();
            return;
        }

        internal function onStageMouseWheel(arg1:flash.events.MouseEvent):void
        {
            var loc2:*=NaN;
            loc2 = 1.25;
            if (!hitTest(arg1.stageX, arg1.stageY)) 
            {
                return;
            }
            var loc1:*=arg1.delta < 0 ? 1 / 1.25 : 1.25;
            var loc3:*;
            (loc3 = globalPointOnCanvas).x = limitCenterX(loc3.x);
            loc3.y = limitCenterY(loc3.y);
            scaleByTween(loc1, loc3);
            return;
        }

        internal function onStageMouseLeave(arg1:flash.events.Event):void
        {
            stop();
            return;
        }

        internal var last:flash.geom.Point;
    }
}


//  class TouchTransformationManager
package sk.yoz.ycanvas.map.managers 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import sk.yoz.touch.*;
    import sk.yoz.touch.events.*;
    import sk.yoz.ycanvas.map.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.utils.*;
    import starling.core.*;
    
    public class TouchTransformationManager extends sk.yoz.ycanvas.map.managers.AbstractTransformationManager
    {
        public function TouchTransformationManager(arg1:sk.yoz.ycanvas.map.YCanvasMap, arg2:sk.yoz.ycanvas.map.valueObjects.Limit, arg3:Number=0.25)
        {
            multitouch = new sk.yoz.touch.TransitionMultitouch();
            flash.ui.Multitouch.inputMode = "touchPoint";
            super(arg1, arg2, arg3);
            multitouch.attach(stage);
            multitouch.transitionDuration = arg3;
            multitouch.addEventListener("transitionMultitouchTransitionComplete", onMultitouchTransitionComplete);
            stage.addEventListener("twoFingerScaleAndRotate", onStageScaleAndRotate);
            stage.addEventListener("touchBegin", onStageTouchBegin);
            stage.addEventListener("touchEnd", onStageTouchEnd);
            stage.addEventListener("touchRollOut", onStageTouchRollOut);
            stage.addEventListener("touchTap", onStageTap);
            return;
        }

        internal function get stage():flash.display.Stage
        {
            return starling.core.Starling.current.nativeStage;
        }

        internal function onStageTap(arg1:flash.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!hitTest(arg1.stageX, arg1.stageY)) 
            {
                return;
            }
            if (!allowInteractions) 
            {
                return;
            }
            if (multitouch.isTweening || multitouch.countFingers > 1) 
            {
                return;
            }
            ++_tapCount;
            if (_tapCount >= 2) 
            {
                resetTapCount();
                killTween();
                resetTransformationTarget();
                resetTransformation();
                dispatchTransformationStarted();
                loc1 = getGlobalPointInTweenTarget(new flash.geom.Point(arg1.stageX, arg1.stageY - yStartCorrection));
                transformationTarget.centerX = limitCenterX(loc1.x);
                transformationTarget.centerY = limitCenterY(loc1.y);
                transformationTarget.scale = limitScale(controller.scale + 0.125);
                com.greensock.TweenNano.to(transformation, transitionDuration, {"scale":transformationTarget.scale, "centerX":transformationTarget.centerX, "centerY":transformationTarget.centerY, "onUpdate":onScaleTransformationUpdate});
                flash.utils.setTimeout(onZoomFinish, transitionDuration);
                return;
            }
            _tapCountTimeoutId = flash.utils.setTimeout(resetTapCount, 300);
            return;
        }

        internal function onScaleTransformationUpdate():void
        {
            controller.center = new flash.geom.Point(transformation.centerX, transformation.centerY);
            controller.scale = transformation.scale;
            return;
        }

        internal function onZoomFinish():void
        {
            dispatchTransformationFinished();
            resetTransformationTarget();
            resetTransformation();
            resetTapCount();
            return;
        }

        internal function resetTapCount():void
        {
            flash.utils.clearTimeout(_tapCountTimeoutId);
            _tapCount = 0;
            return;
        }

        public override function dispose():void
        {
            multitouch.detach(stage);
            multitouch.removeEventListener("transitionMultitouchTransitionComplete", onMultitouchTransitionComplete);
            multitouch = null;
            stage.removeEventListener("twoFingerScaleAndRotate", onStageScaleAndRotate);
            stage.removeEventListener("touchBegin", onStageTouchBegin);
            stage.removeEventListener("touchEnd", onStageTouchEnd);
            stage.removeEventListener("touchRollOut", onStageTouchRollOut);
            stage.removeEventListener("touchMove", onStageTouchMove, false);
            stage.removeEventListener("touchTap", onStageTap);
            resetTapCount();
            super.dispose();
            return;
        }

        internal function getGlobalPointInTweenTarget(arg1:flash.geom.Point):flash.geom.Point
        {
            var loc2:*=controller.globalToViewPort(arg1);
            var loc1:*=controller.getConversionMatrix(new flash.geom.Point(transformationTarget.centerX, transformationTarget.centerY), controller.scale, controller.rotation, controller.viewPort);
            loc1.invert();
            return loc1.transformPoint(loc2);
        }

        internal function killTween():void
        {
            com.greensock.TweenNano.killTweensOf(transformation);
            return;
        }

        internal function resetTransformation():void
        {
            transformation.centerX = controller.center.x;
            transformation.centerY = controller.center.y;
            transformation.scale = controller.scale;
            transformation.rotation = controller.rotation;
            return;
        }

        internal function resetTransformationTarget():void
        {
            transformationTarget.centerX = controller.center.x;
            transformationTarget.centerY = controller.center.y;
            transformationTarget.scale = controller.scale;
            transformationTarget.rotation = controller.rotation;
            return;
        }

        internal function dispatchTransformationStarted():void
        {
            if (transforming) 
            {
                return;
            }
            transforming = true;
            controller.dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasTransformationStarted"));
            return;
        }

        internal function dispatchTransformationFinished():void
        {
            if (multitouch.isTweening || multitouch.countFingers) 
            {
                return;
            }
            if (!transforming) 
            {
                return;
            }
            transforming = false;
            controller.dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasTransformationFinished"));
            return;
        }

        internal function hitTest(arg1:Number, arg2:Number):Boolean
        {
            var loc1:*=false;
            try 
            {
                loc1 = controller.hitTestComponent(arg1, arg2);
            }
            catch (e:Error)
            {
                trace("hitTestComponent - error: " + e.message);
            }
            return loc1;
        }

        internal function onStageScaleAndRotate(arg1:sk.yoz.touch.events.TwoFingerEvent):void
        {
            if (!hitTest(arg1.source.stageX, arg1.source.stageY)) 
            {
                return;
            }
            if (arg1.scale == 1 && arg1.rotation == 0) 
            {
                return;
            }
            if (!(multitouch.countFingers == 2) || !allowInteractions || !allowZoom) 
            {
                return;
            }
            dispatchTransformationStarted();
            var loc2:*=controller.globalToCanvas(new flash.geom.Point(arg1.lock.x, arg1.lock.y - yStartCorrection));
            var loc1:*=controller.rotation;
            sk.yoz.ycanvas.utils.TransformationUtils.rotateScaleTo(controller, controller.rotation + normalizeRadians(arg1.rotation), limitScale(controller.scale * arg1.scale), loc2);
            if (!allowRotate) 
            {
                controller.rotation = loc1;
            }
            resetTransformation();
            resetTransformationTarget();
            return;
        }

        internal function onMultitouchTransitionComplete(arg1:sk.yoz.touch.events.TransitionMultitouchEvent):void
        {
            dispatchTransformationFinished();
            return;
        }

        internal function onStageTouchBegin(arg1:flash.events.TouchEvent):void
        {
            if (!hitTest(arg1.stageX, arg1.stageY)) 
            {
                return;
            }
            if (!allowInteractions) 
            {
                return;
            }
            killTween();
            resetTransformationTarget();
            previousPosition = getGlobalPointInTweenTarget(multitouch.getPoint(arg1));
            stage.addEventListener("touchMove", onStageTouchMove, false, 1);
            return;
        }

        internal function onStageTouchMove(arg1:flash.events.TouchEvent):void
        {
            dispatchTransformationStarted();
            killTween();
            var loc2:*=multitouch.getPoint(arg1);
            var loc1:*=getGlobalPointInTweenTarget(loc2);
            if (!previousPosition || multitouch.isTweening || !(multitouch.countFingers == 1)) 
            {
                previousPosition = loc1;
                return;
            }
            transformationTarget.centerX = transformationTarget.centerX + (previousPosition.x - loc1.x);
            transformationTarget.centerY = transformationTarget.centerY + (previousPosition.y - loc1.y);
            resetTransformation();
            com.greensock.TweenNano.to(transformation, transitionDuration, {"centerX":transformationTarget.centerX, "centerY":transformationTarget.centerY, "onUpdate":onTransformationUpdate});
            previousPosition = getGlobalPointInTweenTarget(loc2);
            return;
        }

        internal function onStageTouchEnd(arg1:flash.events.TouchEvent):void
        {
            stage.removeEventListener("touchMove", onStageTouchMove, false);
            resetTransformationTarget();
            previousPosition = null;
            dispatchTransformationFinished();
            return;
        }

        internal function onStageTouchRollOut(arg1:flash.events.TouchEvent):void
        {
            onStageTouchEnd(arg1);
            return;
        }

        internal function onTransformationUpdate():void
        {
            sk.yoz.ycanvas.utils.TransformationUtils.moveTo(controller, new flash.geom.Point(transformation.centerX, transformation.centerY));
            return;
        }

        internal var _tapCount:int=0;

        internal var _tapCountTimeoutId:uint=0;

        internal var multitouch:sk.yoz.touch.TransitionMultitouch;

        internal var previousPosition:flash.geom.Point;
    }
}


