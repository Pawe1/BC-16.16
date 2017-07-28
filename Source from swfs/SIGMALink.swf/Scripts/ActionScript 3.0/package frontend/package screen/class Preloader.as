//class Preloader
package frontend.screen 
{
    import configCache.*;
    import core.general.*;
    import debug.*;
    import feathers.layout.*;
    import feathers.system.*;
    import feathers.themes.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.utils.*;
    import frontend.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    import utils.*;
    
    public class Preloader extends flash.display.Sprite
    {
        public function Preloader()
        {
            var screenSize:flash.geom.Rectangle;
            var nativeScaleFactor:Number;
            var scaledDPI:int;
            var _originalDPI:Number;
            var workers:Workers;

            var loc1:*;
            this._preloaderPercent = new flash.display.Shape();
            super();
            configCache.ConfigCache.getInstance().loadCache();
            this._stageWidth = Math.min(stage.fullScreenWidth, stage.fullScreenHeight);
            this._stageHeight = Math.max(stage.fullScreenHeight, stage.fullScreenWidth);
            screenSize = new flash.geom.Rectangle(0, 0, this._stageWidth, this._stageHeight);
            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.align = flash.display.StageAlign.TOP_LEFT;
            this._maxWidth = stage.fullScreenWidth / 1.5;
            starling.core.Starling.multitouchEnabled = true;
            this._starling = new starling.core.Starling(SIGMALink, stage, screenSize, null, flash.display3D.Context3DRenderMode.AUTO, flash.display3D.Context3DProfile.BASELINE_EXTENDED);
            this._starling.stage.stageWidth = this._stageWidth;
            this._starling.stage.stageHeight = this._stageHeight;
            this._starling.antiAliasing = 4;
            this._starling.supportHighResolutions = true;
            this._starling.enableErrorChecking = flash.system.Capabilities.isDebugger;
            this._starling.simulateMultitouch = false;
            this._starling.nativeStage.frameRate = 60;
            this._starling.showStats = flash.system.Capabilities.isDebugger;
            if (this._starling.showStats) 
            {
                this._starling.showStatsAt(feathers.layout.HorizontalAlign.RIGHT, feathers.layout.VerticalAlign.TOP);
            }
            this._starling.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, this.onContextCreated);
            nativeScaleFactor = 1;
            if (this._starling.supportHighResolutions) 
            {
                nativeScaleFactor = this._starling.nativeStage.contentsScaleFactor;
            }
            scaledDPI = feathers.system.DeviceCapabilities.dpi / (this._starling.contentScaleFactor / nativeScaleFactor);
            _originalDPI = scaledDPI;
            if (this._scaleToDPI) 
            {
                _originalDPI = feathers.themes.BaseSIGMATheme.ORIGINAL_DPI_IPAD_RETINA;
            }
            this._scaleFactor = scaledDPI / _originalDPI;
            this._assetsScaleFactor = 1 / this._scaleFactor;
            SIGMALink.appHeight = this._stageHeight;
            SIGMALink.appWidth = this._stageWidth;
            SIGMALink.scaleFactor = this._scaleFactor;
            frontend.Textures.init();
            frontend.AssetsManagerCustom.initialize(this._assetsScaleFactor);
            this.initElements();
            workers = new Workers();
            workers.addEventListener(Workers.EVENT_WORKERS_INITIALIZED, function ():void
            {
                debug.Debug.debug("Worker fertig!");
                return;
            })
            workers.initializeWorkers();
            this._starling.addEventListener(starling.events.Event.ROOT_CREATED, function ():void
            {
                _main = _starling.root as SIGMALink;
                loadLabels();
                return;
            })
            this._starling.start();
            return;
        }

        internal function loadLabels():void
        {
            var loc1:*=null;
            if (frontend.AssetsManagerCustom.getInstance().isInitialized) 
            {
                loc1 = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.LANGUAGE, core.general.LanguageSoftware.EN_US);
                utils.LanguageManager.getStringFunction = frontend.Locales.locale().getString;
                frontend.Locales.locale().localeChain = [loc1];
                frontend.Locales.locale().addBundle(loc1, frontend.Locales.DEFAULT_LANGUAGE_BUNDLENAME, true, this.loadLabelsReady);
            }
            else 
            {
                flash.utils.setTimeout(this.loadLabels, 500);
            }
            return;
        }

        internal function loadLabelsReady(arg1:Object=null, arg2:Object=null, arg3:Object=null):void
        {
            this.loadAssets();
            return;
        }

        internal function loadAssets():void
        {
            if (frontend.AssetsManagerCustom.getInstance().isInitialized) 
            {
                frontend.AssetsManagerCustom.getInstance().addEventListener(Assets.EVENT_ASSETS_LOADED, this.assetsLoaded);
                frontend.AssetsManagerCustom.getInstance().addEventListener(Assets.EVENT_ASSETS_PROGRESS, this.assetsProgress);
                frontend.AssetsManagerCustom.getInstance().load();
            }
            else 
            {
                debug.Debug.info("AssetsManager not initialized, try again later");
                flash.utils.setTimeout(this.loadAssets, 500);
            }
            return;
        }

        internal function assetsLoaded(arg1:starling.events.Event):void
        {
            var p_event:starling.events.Event;

            var loc1:*;
            p_event = arg1;
            frontend.AssetsManagerCustom.getInstance().removeEventListener(Assets.EVENT_ASSETS_LOADED, this.assetsLoaded);
            frontend.AssetsManagerCustom.getInstance().removeEventListener(Assets.EVENT_ASSETS_PROGRESS, this.assetsProgress);
            flash.system.System.pauseForGCIfCollectionImminent(0);
            flash.system.System.gc();
            if (!starling.utils.SystemUtil.isDesktop) 
            {
                flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, function (arg1:*):void
                {
                    _starling.start();
                    return;
                })
                flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, function (arg1:*):void
                {
                    _starling.stop(true);
                    return;
                })
            }
            this._main.startApp();
            flash.utils.setTimeout(this.startApp, 1500);
            return;
        }

        internal function startApp():void
        {
            if (this._mBackground) 
            {
                this._starling.nativeOverlay.removeChild(this._mBackground);
                this._mBackground = null;
            }
            if (this._preloaderPercent) 
            {
                this._starling.nativeOverlay.removeChild(this._preloaderPercent);
                this._preloaderPercent = null;
            }
            return;
        }

        internal function assetsProgress(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.data as Number;
            this._preloaderPercent.width = this._preLoaderWidth * loc1 / 100;
            this._preloaderPercent.height = 20 * this._scaleFactor;
            return;
        }

        internal function initElements():void
        {
            var bgPath:String;
            var bgFile:flash.filesystem.File;
            var bytes:flash.utils.ByteArray;
            var stream:flash.filesystem.FileStream;

            var loc1:*;
            bgPath = BG_PNG_PATH;
            bgFile = flash.filesystem.File.applicationDirectory.resolvePath(bgPath);
            bytes = new flash.utils.ByteArray();
            stream = new flash.filesystem.FileStream();
            stream.open(bgFile, flash.filesystem.FileMode.READ);
            stream.readBytes(bytes, 0, stream.bytesAvailable);
            stream.close();
            this._mBackground = new flash.display.Loader();
            this._mBackground.loadBytes(bytes);
            this._mBackground.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, function (arg1:Object):void
            {
                (_mBackground.content as flash.display.Bitmap).smoothing = true;
                var loc1:*=Math.max(stage.stageHeight, stage.stageWidth);
                var loc2:*=Math.min(stage.stageWidth, stage.stageHeight);
                var loc3:*=loc2 / (_mBackground.content as flash.display.Bitmap).width;
                var loc4:*=loc1 / (_mBackground.content as flash.display.Bitmap).height;
                SIGMALink.appHeight = loc1;
                (_mBackground.content as flash.display.Bitmap).scaleX = loc3;
                (_mBackground.content as flash.display.Bitmap).scaleY = loc4;
                return;
            })
            this._preLoaderWidth = this._stageWidth / 100 * 80;
            this._preloaderPercent.graphics.beginFill(268435455);
            this._preloaderPercent.graphics.drawRect(0, 0, this._preLoaderWidth, 20 * this._scaleFactor);
            this._preloaderPercent.graphics.endFill();
            this._preloaderPercent.x = this._stageWidth / 2 - this._preLoaderWidth / 2;
            this._preloaderPercent.y = this._stageHeight * 0.9 - 20 * this._scaleFactor;
            this._preloaderPercent.width = 1;
            this._starling.nativeOverlay.addChild(this._mBackground);
            this._starling.nativeOverlay.addChild(this._preloaderPercent);
            return;
        }

        internal function onContextCreated(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            if (starling.core.Starling.current.showStats) 
            {
                loc1 = starling.core.Starling.current.stage.getChildAt((starling.core.Starling.current.stage.numChildren - 1));
                var loc2:*;
                loc1.scaleY = loc2 = 2 * this._scaleFactor;
                loc1.scaleX = loc2;
                loc1.x = SIGMALink.appWidth - loc1.width;
            }
            return;
        }

        public static const BG_PNG_PATH:String="Default-414w-736h@3x.png";

        internal var _assetsScaleFactor:Number;

        internal var _mBackground:flash.display.Loader;

        internal var _main:SIGMALink;

        internal var _maxWidth:uint=400;

        internal var _preLoaderWidth:uint=0;

        internal var _preloaderPercent:flash.display.Shape;

        internal var _scaleFactor:Number;

        internal var _scaleToDPI:Boolean=true;

        internal var _stageHeight:int=480;

        internal var _stageWidth:int=320;

        internal var _starling:starling.core.Starling;
    }
}


