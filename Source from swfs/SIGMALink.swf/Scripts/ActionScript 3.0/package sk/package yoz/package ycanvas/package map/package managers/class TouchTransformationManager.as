//class TouchTransformationManager
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


