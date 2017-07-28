//class YCanvasMap
package sk.yoz.ycanvas.map 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import sk.yoz.ycanvas.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.display.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.layers.*;
    import sk.yoz.ycanvas.map.partitions.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.starling.*;
    import sk.yoz.ycanvas.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    public class YCanvasMap extends sk.yoz.ycanvas.AbstractYCanvas implements flash.events.IEventDispatcher
    {
        public function YCanvasMap(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg2:sk.yoz.ycanvas.map.valueObjects.Transformation, arg3:uint=0, arg4:uint=0)
        {
            dispatcher = new flash.events.EventDispatcher();
            mapLayers = new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapLayer>();
            timer = new flash.utils.Timer(250, 1);
            _config = arg1;
            this.marginOffset = arg3;
            this.maxLayers = arg4;
            _root = new sk.yoz.ycanvas.starling.YCanvasRootStarling();
            _display = new sk.yoz.ycanvas.map.display.MapDisplay();
            display.addChild(root as sk.yoz.ycanvas.starling.YCanvasRootStarling);
            display.addEventListener("viewPortUpdated", onComponentViewPortUpdated);
            super(getViewPort());
            partitionFactory = new sk.yoz.ycanvas.map.partitions.PartitionFactory(arg1, this);
            layerFactory = new sk.yoz.ycanvas.map.layers.LayerFactory(arg1, partitionFactory);
            center = new flash.geom.Point(arg2.centerX, arg2.centerY);
            scale = arg2.scale;
            rotation = arg2.rotation;
            addEventListener("canvasTransformationStarted", onCanvasTransformationStarted);
            addEventListener("canvasTransformationFinished", onCanvasTransformationFinished);
            addEventListener("partitionLoaded", onPartitionLoaded);
            timer.addEventListener("timerComplete", onTimerComplete);
            return;
        }

        public override function set center(arg1:flash.geom.Point):void
        {
            var loc1:*=0;
            super(
#error('findrop') center
            ).center = arg1;
            loc1 = mapLayers.length;
            while (loc1--) 
            {
                mapLayers[loc1].center = arg1;
            }
            dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasCenterChanged"));
            return;
        }

        internal function resetTimer():void
        {
            if (timer.running) 
            {
                return;
            }
            timer.reset();
            timer.start();
            return;
        }

        public function get config():sk.yoz.ycanvas.map.valueObjects.MapConfig
        {
            return _config;
        }

        public function set config(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig):void
        {
            var loc2:*=0;
            var loc1:*=0;
            if (config == arg1) 
            {
                return;
            }
            _config = arg1;
            if (partitionFactory) 
            {
                (partitionFactory as sk.yoz.ycanvas.map.partitions.PartitionFactory).config = config;
            }
            while (layers.length > 1) 
            {
                disposeLayer(layers[0]);
            }
            (layers[0] as sk.yoz.ycanvas.map.layers.Layer).config = config;
            var loc3:*;
            (loc3 = layers[0].partitions).sort(sortByDistanceFromCenter);
            loc2 = 0;
            loc1 = loc3.length;
            while (loc2 < loc1) 
            {
                (loc3[loc2] as sk.yoz.ycanvas.map.partitions.Partition).config = config;
                ++loc2;
            }
            return;
        }

        internal function onCanvasTransformationStarted(arg1:sk.yoz.ycanvas.map.events.CanvasEvent):void
        {
            resetTimer();
            return;
        }

        public function get display():sk.yoz.ycanvas.map.display.MapDisplay
        {
            return _display;
        }

        public function get mainLayer():sk.yoz.ycanvas.map.layers.Layer
        {
            return layers[(layers.length - 1)] as sk.yoz.ycanvas.map.layers.Layer;
        }

        public override function set rotation(arg1:Number):void
        {
            var loc1:*=0;
            super(
#error('findrop') rotation
            ).rotation = arg1;
            loc1 = mapLayers.length;
            while (loc1--) 
            {
                mapLayers[loc1].rotation = rotation;
            }
            dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasRotationChanged"));
            return;
        }

        public override function set scale(arg1:Number):void
        {
            var loc1:*=0;
            super(
#error('findrop') scale
            ).scale = arg1;
            loc1 = mapLayers.length;
            while (loc1--) 
            {
                mapLayers[loc1].mapScale = arg1;
            }
            dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasScaleChanged"));
            return;
        }

        public override function set viewPort(arg1:flash.geom.Rectangle):void
        {
            var loc1:*=0;
            super(
#error('findrop') viewPort
            ).viewPort = arg1;
            loc1 = mapLayers.length;
            while (loc1--) 
            {
                mapLayers[loc1].width = arg1.width;
                mapLayers[loc1].height = arg1.height;
            }
            resetTimer();
            return;
        }

        internal function onCanvasTransformationFinished(arg1:sk.yoz.ycanvas.map.events.CanvasEvent):void
        {
            render();
            return;
        }

        internal function onPartitionLoaded(arg1:sk.yoz.ycanvas.map.events.PartitionEvent):void
        {
            var loc1:*=arg1.partition;
            var loc3:*=loc1.layer;
            if (mainLayer != loc3) 
            {
                return;
            }
            var loc2:*=sk.yoz.ycanvas.utils.IPartitionUtils.getLower(this, loc3, loc1);
            sk.yoz.ycanvas.utils.IPartitionUtils.diposeLayerPartitionsList(this, loc2);
            sk.yoz.ycanvas.utils.ILayerUtils.disposeEmpty(this);
            if (maxLayers) 
            {
                sk.yoz.ycanvas.utils.ILayerUtils.disposeDeep(this, maxLayers);
            }
            return;
        }

        internal function onTimerComplete(arg1:flash.events.Event):void
        {
            render();
            return;
        }

        internal function onComponentViewPortUpdated():void
        {
            viewPort = getViewPort();
            render();
            return;
        }

        public override function render():void
        {
            var loc1:*=null;
            super.render();
            sk.yoz.ycanvas.utils.IPartitionUtils.disposeInvisible(this);
            sk.yoz.ycanvas.utils.ILayerUtils.disposeEmpty(this);
            if (layers.length) 
            {
                loc1 = mainLayer;
                var loc4:*=0;
                var loc3:*=layers;
                for each (var loc2:* in loc3) 
                {
                    loc2 != loc1 ? stopLoading(loc2) : startLoading(loc2);
                }
            }
            dispatchEvent(new sk.yoz.ycanvas.map.events.CanvasEvent("canvasRendered"));
            return;
        }

        public function hitTestComponent(arg1:Number, arg2:Number):Boolean
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (config.forTouch) 
            {
                loc2 = starling.core.Starling.current.viewPort;
                loc3 = new flash.geom.Point(arg1 - loc2.x, arg2 - loc2.y);
                loc1 = display.stage.hitTest(loc3);
                return loc1 == display;
            }
            loc4 = new flash.geom.Point(arg1, arg2);
            return (loc5 = display.globalToLocal(loc4)).x >= display.x && loc5.x <= display.x + display.width && loc5.y >= display.y && loc5.y <= display.y + display.height;
        }

        public function addMapLayer(arg1:sk.yoz.ycanvas.map.display.MapLayer):void
        {
            arg1.width = viewPort.width;
            arg1.height = viewPort.height;
            arg1.center = center;
            arg1.mapScale = scale;
            arg1.rotation = rotation;
            mapLayers.push(arg1);
            display.addChild(arg1);
            return;
        }

        public function removeMapLayer(arg1:sk.yoz.ycanvas.map.display.MapLayer):void
        {
            mapLayers.splice(mapLayers.indexOf(arg1), 1);
            display.removeChild(arg1);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            while (mapLayers.length) 
            {
                loc1 = mapLayers[0];
                loc1.removeChildren();
                removeMapLayer(loc1);
            }
            timer.removeEventListener("timerComplete", onTimerComplete);
            timer.stop();
            timer = null;
            super.dispose();
            return;
        }

        public function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            dispatcher.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            dispatcher.removeEventListener(arg1, arg2, arg3);
            return;
        }

        public function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return dispatcher.dispatchEvent(arg1);
        }

        public function hasEventListener(arg1:String):Boolean
        {
            return dispatcher.hasEventListener(arg1);
        }

        public function willTrigger(arg1:String):Boolean
        {
            return dispatcher.willTrigger(arg1);
        }

        internal function startLoading(arg1:sk.yoz.ycanvas.map.layers.Layer):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            var loc4:*;
            (loc4 = arg1.partitions).sort(sortByDistanceFromCenter);
            loc3 = 0;
            loc2 = loc4.length;
            while (loc3 < loc2) 
            {
                loc1 = loc4[loc3] as sk.yoz.ycanvas.map.partitions.Partition;
                if (!loc1.loading && !loc1.loaded) 
                {
                    loc1.load();
                }
                ++loc3;
            }
            return;
        }

        internal function stopLoading(arg1:sk.yoz.ycanvas.map.layers.Layer):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            var loc4:*=arg1.partitions;
            loc3 = 0;
            loc2 = loc4.length;
            while (loc3 < loc2) 
            {
                loc1 = loc4[loc3] as sk.yoz.ycanvas.map.partitions.Partition;
                if (loc1.loading) 
                {
                    loc1.stopLoading();
                }
                ++loc3;
            }
            return;
        }

        internal function getViewPort():flash.geom.Rectangle
        {
            var loc1:*=display.localToGlobal(new flash.geom.Point(0, 0));
            return new flash.geom.Rectangle(starling.core.Starling.current.viewPort.x + loc1.x, starling.core.Starling.current.viewPort.y + loc1.y, display.width, display.height);
        }

        internal function sortByDistanceFromCenter(arg1:sk.yoz.ycanvas.map.partitions.Partition, arg2:sk.yoz.ycanvas.map.partitions.Partition):Number
        {
            var loc2:*=arg1.x + arg1.expectedWidth * 0.5 - center.x;
            var loc1:*=arg1.y + arg1.expectedHeight * 0.5 - center.y;
            var loc4:*=arg2.x + arg2.expectedWidth * 0.5 - center.x;
            var loc3:*=arg2.y + arg2.expectedHeight * 0.5 - center.y;
            return loc2 * loc2 + loc1 * loc1 - (loc4 * loc4 + loc3 * loc3);
        }

        internal var _config:sk.yoz.ycanvas.map.valueObjects.MapConfig;

        internal var _display:sk.yoz.ycanvas.map.display.MapDisplay;

        protected var maxLayers:uint;

        internal var dispatcher:flash.events.EventDispatcher;

        internal var mapLayers:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapLayer>;

        internal var timer:flash.utils.Timer;
    }
}


