//class MouseTransformationManager
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


