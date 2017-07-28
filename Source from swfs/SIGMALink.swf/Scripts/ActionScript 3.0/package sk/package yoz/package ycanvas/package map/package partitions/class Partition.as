//class Partition
package sk.yoz.ycanvas.map.partitions 
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import sk.yoz.ycanvas.interfaces.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import sk.yoz.ycanvas.starling.interfaces.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class Partition extends Object implements sk.yoz.ycanvas.starling.interfaces.IPartitionStarling
    {
        public function Partition(arg1:int, arg2:int, arg3:sk.yoz.ycanvas.interfaces.ILayer, arg4:sk.yoz.ycanvas.map.valueObjects.MapConfig, arg5:flash.events.IEventDispatcher, arg6:sk.yoz.ycanvas.map.partitions.IPartitionLoader)
        {
            _x = arg1;
            _y = arg2;
            _layer = arg3;
            _config = arg4;
            this.dispatcher = arg5;
            this.partitionLoader = arg6;
            validateEmptyTexture();
            _content = new starling.display.Image(EMPTY_TEXTURE);
            content.touchable = false;
            content.x = arg1;
            content.y = arg2;
            content.alpha = 0;
            super();
            return;
        }

        public function get concatenatedMatrix():flash.geom.Matrix
        {
            return content.getTransformationMatrix(content.stage);
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

        public function get config():sk.yoz.ycanvas.map.valueObjects.MapConfig
        {
            return _config;
        }

        public function set config(arg1:sk.yoz.ycanvas.map.valueObjects.MapConfig):void
        {
            if (config == arg1) 
            {
                return;
            }
            _config = arg1;
            load();
            return;
        }

        internal function validateEmptyTexture():void
        {
            if (EMPTY_TEXTURE) 
            {
                return;
            }
            var loc1:*=new flash.display.BitmapData(expectedWidth, expectedHeight, true, 16777215);
            EMPTY_TEXTURE = starling.textures.Texture.fromBitmapData(loc1);
            return;
        }

        public function get content():starling.display.DisplayObject
        {
            return _content;
        }

        public function get expectedHeight():uint
        {
            return config.tileHeight;
        }

        public function get expectedWidth():uint
        {
            return config.tileWidth;
        }

        public function toString():String
        {
            return "Partition: [x:" + x + ", y:" + y + "]";
        }

        public function get layer():sk.yoz.ycanvas.interfaces.ILayer
        {
            return _layer;
        }

        public function get loaded():Boolean
        {
            return bitmapData || error;
        }

        public function get loading():Boolean
        {
            return !(loader == null);
        }

        internal function onLoaderComplete(arg1:flash.events.Event):void
        {
            var loc1:*=flash.display.LoaderInfo(arg1.target);
            if (loc1.content is flash.display.Bitmap) 
            {
                bitmapData = flash.display.Bitmap(loc1.content).bitmapData;
            }
            else if (loc1.content is flash.display.MovieClip) 
            {
                bitmapData = new flash.display.BitmapData((loader.content as flash.display.MovieClip).width, (loader.content as flash.display.MovieClip).height);
                bitmapData.draw(loader.content as flash.display.MovieClip);
            }
            stopLoading();
            tween = com.greensock.TweenNano.to(content, 0.5, {"alpha":1, "onComplete":onRevealComplete});
            var loc2:*="partitionLoaded";
            dispatcher.dispatchEvent(new sk.yoz.ycanvas.map.events.PartitionEvent(loc2, this));
            return;
        }

        public function get x():int
        {
            return _x;
        }

        internal function onLoaderError(arg1:flash.events.Event):void
        {
            error = true;
            bitmapData = null;
            stopLoading();
            return;
        }

        public function get y():int
        {
            return _y;
        }

        protected function get url():String
        {
            var loc1:*=config.urlTemplates;
            var loc2:*=x / 5 + y / 3 + layer.level;
            var loc3:*=loc1[(loc2 < 0 ? -loc2 : loc2) % loc1.length];
            loc3 = loc3.replace("${x}", x / expectedWidth / layer.level);
            loc3 = loc3.replace("${y}", y / expectedHeight / layer.level);
            loc3 = loc3.replace("${z}", 18 - getLevel(layer.level));
            return loc3;
        }

        internal function onRevealComplete():void
        {
            disposeTween();
            return;
        }

        internal function get bitmapData():flash.display.BitmapData
        {
            return _bitmapData;
        }

        internal function set bitmapData(arg1:flash.display.BitmapData):void
        {
            var loc1:*=null;
            if (bitmapData == arg1) 
            {
                return;
            }
            disposeBitmapData();
            disposeTexture();
            _bitmapData = arg1;
            try 
            {
                loc1 = bitmapData ? starling.textures.Texture.fromBitmapData(bitmapData, false) : EMPTY_TEXTURE;
                _content.texture = loc1;
            }
            catch (error:Error)
            {
            };
            return;
        }

        public function getLevel(arg1:uint):uint
        {
            var loc1:*=0;
            while (arg1 > 1) 
            {
                arg1 = arg1 / 2;
                ++loc1;
            }
            return loc1;
        }

        public function load():void
        {
            stopLoading();
            error = false;
            var loc2:*=new flash.system.LoaderContext(true);
            loc2.imageDecodingPolicy = "onLoad";
            var loc1:*=new flash.net.URLRequest(url);
            if (partitionLoader) 
            {
                loader = partitionLoader.load(loc1, loc2);
            }
            else 
            {
                loader = new flash.display.Loader();
                loader.load(loc1, loc2);
            }
            var loc3:*=loader.contentLoaderInfo;
            loc3.addEventListener("complete", onLoaderComplete, false, -1, true);
            loc3.addEventListener("ioError", onLoaderError, false, -1, true);
            return;
        }

        public function stopLoading():void
        {
            if (!loading) 
            {
                return;
            }
            var loc1:*=loader.contentLoaderInfo;
            if (loc1) 
            {
                loc1.removeEventListener("complete", onLoaderComplete, false);
                loc1.removeEventListener("ioError", onLoaderError, false);
            }
            if (partitionLoader) 
            {
                partitionLoader.disposeLoader(loader);
            }
            loader = null;
            return;
        }

        public function applyIBitmapDrawable(arg1:flash.display.IBitmapDrawable, arg2:flash.geom.Matrix):void
        {
            return;
        }

        public function dispose():void
        {
            stopLoading();
            disposeTween();
            disposeBitmapData();
            disposeTexture();
            content.dispose();
            return;
        }

        internal function disposeBitmapData():void
        {
            if (!bitmapData) 
            {
                return;
            }
            _bitmapData = null;
            return;
        }

        internal function disposeTexture():void
        {
            if (!content || !_content.texture || _content.texture == EMPTY_TEXTURE) 
            {
                return;
            }
            _content.texture.dispose();
            return;
        }

        internal var _config:sk.yoz.ycanvas.map.valueObjects.MapConfig;

        internal var _content:starling.display.Image;

        internal var _layer:sk.yoz.ycanvas.interfaces.ILayer;

        internal var _x:int;

        internal var _y:int;

        internal var _bitmapData:flash.display.BitmapData;

        internal var partitionLoader:sk.yoz.ycanvas.map.partitions.IPartitionLoader;

        internal var tween:com.greensock.TweenNano;

        internal var dispatcher:flash.events.IEventDispatcher;

        internal var error:Boolean;

        internal var loader:flash.display.Loader;

        internal static var EMPTY_TEXTURE:starling.textures.Texture;
    }
}


