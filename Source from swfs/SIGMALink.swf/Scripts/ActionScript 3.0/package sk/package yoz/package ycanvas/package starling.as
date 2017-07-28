//package starling
//  package interfaces
//    class ILayerStarling
package sk.yoz.ycanvas.starling.interfaces 
{
    import sk.yoz.ycanvas.interfaces.*;
    import starling.display.*;
    
    public dynamic interface ILayerStarling extends sk.yoz.ycanvas.interfaces.ILayer
    {
        function get content():starling.display.DisplayObjectContainer;
    }
}


//    class IPartitionStarling
package sk.yoz.ycanvas.starling.interfaces 
{
    import sk.yoz.ycanvas.interfaces.*;
    import starling.display.*;
    
    public dynamic interface IPartitionStarling extends sk.yoz.ycanvas.interfaces.IPartition
    {
        function get content():starling.display.DisplayObject;
    }
}


//  class YCanvasRootStarling
package sk.yoz.ycanvas.starling 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.starling.interfaces.*;
    import starling.display.*;
    
    public class YCanvasRootStarling extends starling.display.Sprite implements sk.yoz.ycanvas.interfaces.IYCanvasRoot
    {
        public function YCanvasRootStarling()
        {
            _layers = new __AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>();
            super();
            return;
        }

        public function get layers():__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>
        {
            return _layers;
        }

        public function set yCanvasScale(arg1:Number):void
        {
            scaleX = scaleY = arg1;
            return;
        }

        public function addLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            var loc2:*=arg1 as sk.yoz.ycanvas.starling.interfaces.ILayerStarling;
            var loc1:*=layers.indexOf(arg1);
            if (loc1 != -1) 
            {
                if (loc1 != (layers.length - 1)) 
                {
                    setLayerChildIndex(loc2.content, (layers.length - 1));
                    layers.splice(loc1, 1);
                    layers.push(arg1);
                }
            }
            else 
            {
                addLayerChild(loc2.content);
                layers.push(arg1);
            }
            return;
        }

        public function removeLayer(arg1:sk.yoz.ycanvas.interfaces.ILayer):void
        {
            var loc2:*=arg1 as sk.yoz.ycanvas.starling.interfaces.ILayerStarling;
            removeLayerChild(loc2.content);
            var loc1:*=layers.indexOf(arg1);
            layers.splice(loc1, 1);
            return;
        }

        protected function addLayerChild(arg1:starling.display.DisplayObject):void
        {
            addChild(arg1);
            return;
        }

        protected function setLayerChildIndex(arg1:starling.display.DisplayObject, arg2:int):void
        {
            setChildIndex(arg1, arg2);
            return;
        }

        protected function removeLayerChild(arg1:starling.display.DisplayObject):void
        {
            removeChild(arg1);
            return;
        }

        internal var _layers:__AS3__.vec.Vector.<sk.yoz.ycanvas.interfaces.ILayer>;
    }
}


