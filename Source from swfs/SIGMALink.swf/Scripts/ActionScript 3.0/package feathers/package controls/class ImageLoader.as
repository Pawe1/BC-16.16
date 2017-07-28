//class ImageLoader
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.textures.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class ImageLoader extends feathers.core.FeathersControl
    {
        public function ImageLoader()
        {
            super();
            this.isQuickHitAreaEnabled = true;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            if (loc1) 
            {
                this.commitData();
            }
            if (loc1 || loc3) 
            {
                this.commitStyles();
            }
            loc4 = this.autoSizeIfNeeded() || loc4;
            if (loc1 || loc2 || loc4 || loc3) 
            {
                this.layout();
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
            var loc5:*=1;
            var loc6:*=1;
            if (this._scaleContent && this._maintainAspectRatio && !(this._scaleMode === starling.utils.ScaleMode.NONE) && this._scale9Grid === null) 
            {
                if (loc2) 
                {
                    if (this._explicitMaxHeight < this._currentTextureHeight) 
                    {
                        loc5 = this._explicitMaxHeight / (this._currentTextureHeight * this._textureScale);
                    }
                    else if (this._explicitMinHeight > this._currentTextureHeight) 
                    {
                        loc5 = this._explicitMinHeight / (this._currentTextureHeight * this._textureScale);
                    }
                }
                else 
                {
                    loc5 = this._explicitHeight / (this._currentTextureHeight * this._textureScale);
                }
                if (loc1) 
                {
                    if (this._explicitMaxWidth < this._currentTextureWidth) 
                    {
                        loc6 = this._explicitMaxWidth / (this._currentTextureWidth * this._textureScale);
                    }
                    else if (this._explicitMinWidth > this._currentTextureWidth) 
                    {
                        loc6 = this._explicitMinWidth / (this._currentTextureWidth * this._textureScale);
                    }
                }
                else 
                {
                    loc6 = this._explicitWidth / (this._currentTextureWidth * this._textureScale);
                }
            }
            var loc7:*=this._explicitWidth;
            if (loc1) 
            {
                if (this._currentTextureWidth !== this._currentTextureWidth) 
                {
                    loc7 = 0;
                }
                else 
                {
                    loc7 = this._currentTextureWidth * this._textureScale * loc5;
                }
                loc7 = loc7 + (this._paddingLeft + this._paddingRight);
            }
            var loc8:*=this._explicitHeight;
            if (loc2) 
            {
                if (this._currentTextureHeight !== this._currentTextureHeight) 
                {
                    loc8 = 0;
                }
                else 
                {
                    loc8 = this._currentTextureHeight * this._textureScale * loc6;
                }
                loc8 = loc8 + (this._paddingTop + this._paddingBottom);
            }
            if (loc2 && loc4) 
            {
                loc5 = 1;
            }
            if (loc1 && loc3) 
            {
                loc6 = 1;
            }
            var loc9:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (this._currentTextureWidth !== this._currentTextureWidth) 
                {
                    loc9 = 0;
                }
                else 
                {
                    loc9 = this._currentTextureWidth * this._textureScale * loc5;
                }
                loc9 = loc9 + (this._paddingLeft + this._paddingRight);
            }
            var loc10:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (this._currentTextureHeight !== this._currentTextureHeight) 
                {
                    loc10 = 0;
                }
                else 
                {
                    loc10 = this._currentTextureHeight * this._textureScale * loc6;
                }
                loc10 = loc10 + (this._paddingTop + this._paddingBottom);
            }
            return this.saveMeasurements(loc7, loc8, loc9, loc10);
        }

        protected function commitData():void
        {
            var loc1:*=null;
            if (this._source is starling.textures.Texture) 
            {
                this._lastURL = null;
                this._texture = starling.textures.Texture(this._source);
                this.refreshCurrentTexture();
            }
            else 
            {
                loc1 = this._source as String;
                if (loc1) 
                {
                    if (loc1 != this._lastURL) 
                    {
                        this._lastURL = loc1;
                        if (this.findSourceInCache()) 
                        {
                            return;
                        }
                        if (this.isATFURL(loc1)) 
                        {
                            if (this.loader) 
                            {
                                this.loader = null;
                            }
                            if (!this.urlLoader) 
                            {
                                this.urlLoader = new flash.net.URLLoader();
                                this.urlLoader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
                            }
                            this.urlLoader.addEventListener(flash.events.Event.COMPLETE, this.rawDataLoader_completeHandler);
                            this.urlLoader.addEventListener(flash.events.ProgressEvent.PROGRESS, this.rawDataLoader_progressHandler);
                            this.urlLoader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.rawDataLoader_ioErrorHandler);
                            this.urlLoader.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.rawDataLoader_securityErrorHandler);
                            this.urlLoader.load(new flash.net.URLRequest(loc1));
                            return;
                        }
                        if (this.urlLoader) 
                        {
                            this.urlLoader = null;
                        }
                        if (!this.loader) 
                        {
                            this.loader = new flash.display.Loader();
                        }
                        this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.loader_completeHandler);
                        this.loader.contentLoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS, this.loader_progressHandler);
                        this.loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.loader_ioErrorHandler);
                        this.loader.contentLoaderInfo.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.loader_securityErrorHandler);
                        this.loader.load(new flash.net.URLRequest(loc1), LOADER_CONTEXT);
                    }
                }
                else 
                {
                    this._lastURL = null;
                }
                this.refreshCurrentTexture();
            }
            return;
        }

        protected function commitStyles():void
        {
            if (!this.image) 
            {
                return;
            }
            this.image.textureSmoothing = this._textureSmoothing;
            this.image.color = this._color;
            this.image.scale9Grid = this._scale9Grid;
            this.image.tileGrid = this._tileGrid;
            this.image.pixelSnapping = this._pixelSnapping;
            return;
        }

        protected function layout():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=null;
            if (!this.image || !this._currentTexture) 
            {
                return;
            }
            if (this._scaleContent) 
            {
                if (this._maintainAspectRatio && this._scale9Grid === null) 
                {
                    HELPER_RECTANGLE.x = 0;
                    HELPER_RECTANGLE.y = 0;
                    HELPER_RECTANGLE.width = this._currentTextureWidth * this._textureScale;
                    HELPER_RECTANGLE.height = this._currentTextureHeight * this._textureScale;
                    HELPER_RECTANGLE2.x = 0;
                    HELPER_RECTANGLE2.y = 0;
                    HELPER_RECTANGLE2.width = this.actualWidth - this._paddingLeft - this._paddingRight;
                    HELPER_RECTANGLE2.height = this.actualHeight - this._paddingTop - this._paddingBottom;
                    starling.utils.RectangleUtil.fit(HELPER_RECTANGLE, HELPER_RECTANGLE2, this._scaleMode, false, HELPER_RECTANGLE);
                    this.image.x = HELPER_RECTANGLE.x + this._paddingLeft;
                    this.image.y = HELPER_RECTANGLE.y + this._paddingTop;
                    this.image.width = HELPER_RECTANGLE.width;
                    this.image.height = HELPER_RECTANGLE.height;
                }
                else 
                {
                    this.image.x = this._paddingLeft;
                    this.image.y = this._paddingTop;
                    this.image.width = this.actualWidth - this._paddingLeft - this._paddingRight;
                    this.image.height = this.actualHeight - this._paddingTop - this._paddingBottom;
                }
            }
            else 
            {
                loc1 = this._currentTextureWidth * this._textureScale;
                loc2 = this._currentTextureHeight * this._textureScale;
                if (this._horizontalAlign !== feathers.layout.HorizontalAlign.RIGHT) 
                {
                    if (this._horizontalAlign !== feathers.layout.HorizontalAlign.CENTER) 
                    {
                        this.image.x = this._paddingLeft;
                    }
                    else 
                    {
                        this.image.x = this._paddingLeft + (this.actualWidth - this._paddingLeft - this._paddingRight - loc1) / 2;
                    }
                }
                else 
                {
                    this.image.x = this.actualWidth - this._paddingRight - loc1;
                }
                if (this._verticalAlign !== feathers.layout.VerticalAlign.BOTTOM) 
                {
                    if (this._verticalAlign !== feathers.layout.VerticalAlign.MIDDLE) 
                    {
                        this.image.y = this._paddingTop;
                    }
                    else 
                    {
                        this.image.y = this._paddingTop + (this.actualHeight - this._paddingTop - this._paddingBottom - loc2) / 2;
                    }
                }
                else 
                {
                    this.image.y = this.actualHeight - this._paddingBottom - loc2;
                }
                this.image.width = loc1;
                this.image.height = loc2;
            }
            if ((!this._scaleContent || this._maintainAspectRatio && !(this._scaleMode === starling.utils.ScaleMode.SHOW_ALL)) && (!(this.actualWidth == loc1) || !(this.actualHeight == loc2))) 
            {
                loc3 = this.image.mask as starling.display.Quad;
                if (loc3 === null) 
                {
                    loc3 = new starling.display.Quad(1, 1, 16711935);
                    loc3.width = this.actualWidth;
                    loc3.height = this.actualHeight;
                    this.image.mask = loc3;
                    this.addChild(loc3);
                }
                else 
                {
                    loc3.x = 0;
                    loc3.y = 0;
                    loc3.width = this.actualWidth;
                    loc3.height = this.actualHeight;
                }
            }
            else 
            {
                loc3 = this.image.mask as starling.display.Quad;
                if (loc3 !== null) 
                {
                    loc3.removeFromParent(true);
                    this.image.mask = null;
                }
            }
            return;
        }

        protected function isATFURL(arg1:String):Boolean
        {
            var loc1:*=arg1.indexOf("?");
            if (loc1 >= 0) 
            {
                arg1 = arg1.substr(0, loc1);
            }
            return arg1.toLowerCase().lastIndexOf(ATF_FILE_EXTENSION) === arg1.length - 3;
        }

        protected function refreshCurrentTexture():void
        {
            var loc1:*=this._isLoaded ? this._texture : null;
            if (!loc1) 
            {
                if (this.loader || this.urlLoader) 
                {
                    loc1 = this._loadingTexture;
                }
                else 
                {
                    loc1 = this._errorTexture;
                }
            }
            if (this._currentTexture == loc1) 
            {
                return;
            }
            this._currentTexture = loc1;
            if (!this._currentTexture) 
            {
                if (this.image) 
                {
                    this.removeChild(this.image, true);
                    this.image = null;
                }
                return;
            }
            var loc2:*=this._currentTexture.frame;
            if (loc2) 
            {
                this._currentTextureWidth = loc2.width;
                this._currentTextureHeight = loc2.height;
            }
            else 
            {
                this._currentTextureWidth = this._currentTexture.width;
                this._currentTextureHeight = this._currentTexture.height;
                this._originalTextureWidth = this._currentTexture.nativeWidth;
                this._originalTextureHeight = this._currentTexture.nativeHeight;
            }
            if (this.image) 
            {
                this.image.texture = this._currentTexture;
                this.image.readjustSize();
            }
            else 
            {
                this.image = new starling.display.Image(this._currentTexture);
                this.addChild(this.image);
            }
            this.image.visible = true;
            return;
        }

        protected function cleanupTexture():void
        {
            if (this._texture) 
            {
                if (this._isTextureOwner) 
                {
                    this._texture.dispose();
                }
                else if (this._textureCache && this._source is String) 
                {
                    this._textureCache.releaseTexture(this._source as String);
                }
            }
            if (this._pendingBitmapDataTexture) 
            {
                this._pendingBitmapDataTexture.dispose();
            }
            if (this._pendingRawTextureData) 
            {
                this._pendingRawTextureData.clear();
            }
            this._currentTexture = null;
            this._currentTextureWidth = NaN;
            this._currentTextureHeight = NaN;
            this._originalTextureWidth = NaN;
            this._originalTextureHeight = NaN;
            this._pendingBitmapDataTexture = null;
            this._pendingRawTextureData = null;
            this._texture = null;
            this._isTextureOwner = false;
            return;
        }

        protected function cleanupLoaders(arg1:Boolean):void
        {
            if (this.urlLoader) 
            {
                this.urlLoader.removeEventListener(flash.events.Event.COMPLETE, this.rawDataLoader_completeHandler);
                this.urlLoader.removeEventListener(flash.events.ProgressEvent.PROGRESS, this.rawDataLoader_progressHandler);
                this.urlLoader.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.rawDataLoader_ioErrorHandler);
                this.urlLoader.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.rawDataLoader_securityErrorHandler);
                if (arg1) 
                {
                    try 
                    {
                        this.urlLoader.close();
                    }
                    catch (error:Error)
                    {
                    };
                }
                this.urlLoader = null;
            }
            if (this.loader) 
            {
                this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.loader_completeHandler);
                this.loader.contentLoaderInfo.removeEventListener(flash.events.ProgressEvent.PROGRESS, this.loader_progressHandler);
                this.loader.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.loader_ioErrorHandler);
                this.loader.contentLoaderInfo.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.loader_securityErrorHandler);
                if (arg1) 
                {
                    this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.orphanedLoader_completeHandler);
                }
                this.loader = null;
            }
            return;
        }

        protected function findSourceInCache():Boolean
        {
            var loc1:*=this._source as String;
            if (this._textureCache && !this._isRestoringTexture && this._textureCache.hasTexture(loc1)) 
            {
                this._texture = this._textureCache.retainTexture(loc1);
                this._isTextureOwner = false;
                this._isRestoringTexture = false;
                this._isLoaded = true;
                this.refreshCurrentTexture();
                this.dispatchEventWith(starling.events.Event.COMPLETE);
                return true;
            }
            return false;
        }

        protected function verifyCurrentStarling():void
        {
            if (this.stage === null || starling.core.Starling.current.stage === this.stage) 
            {
                return;
            }
            this.stage.starling.makeCurrent();
            return;
        }

        protected function replaceBitmapDataTexture(arg1:flash.display.BitmapData):void
        {
            var loc2:*=null;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (!loc1.contextValid) 
            {
                trace(CONTEXT_LOST_WARNING);
                flash.utils.setTimeout(this.replaceBitmapDataTexture, 1, arg1);
                return;
            }
            if (!starling.utils.SystemUtil.isDesktop && !starling.utils.SystemUtil.isApplicationActive) 
            {
                starling.utils.SystemUtil.executeWhenApplicationIsActive(this.replaceBitmapDataTexture, arg1);
                return;
            }
            this.verifyCurrentStarling();
            if (this.findSourceInCache()) 
            {
                arg1.dispose();
                this.invalidate(INVALIDATION_FLAG_DATA);
                return;
            }
            if (!this._texture) 
            {
                this._texture = starling.textures.Texture.empty(arg1.width / this._scaleFactor, arg1.height / this._scaleFactor, true, false, false, this._scaleFactor, this._textureFormat);
                loc2 = this._source as String;
                this._texture.root.onRestore = this.createTextureOnRestore(this._texture, loc2, this._textureFormat, this._scaleFactor);
                if (this._textureCache) 
                {
                    this._textureCache.addTexture(loc2, this._texture, true);
                }
            }
            this._texture.root.uploadBitmapData(arg1);
            if (this.image !== null) 
            {
                this.image.setRequiresRedraw();
            }
            arg1.dispose();
            this._isTextureOwner = this._textureCache === null;
            this._isRestoringTexture = false;
            this._isLoaded = true;
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(starling.events.Event.COMPLETE);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.ImageLoader.globalStyleProvider;
        }

        protected function replaceRawTextureData(arg1:flash.utils.ByteArray):void
        {
            var loc2:*=null;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (!loc1.contextValid) 
            {
                trace(CONTEXT_LOST_WARNING);
                flash.utils.setTimeout(this.replaceRawTextureData, 1, arg1);
                return;
            }
            if (!starling.utils.SystemUtil.isDesktop && !starling.utils.SystemUtil.isApplicationActive) 
            {
                starling.utils.SystemUtil.executeWhenApplicationIsActive(this.replaceRawTextureData, arg1);
                return;
            }
            this.verifyCurrentStarling();
            if (this.findSourceInCache()) 
            {
                arg1.clear();
                this.invalidate(INVALIDATION_FLAG_DATA);
                return;
            }
            if (this._texture) 
            {
                this._texture.root.uploadAtfData(arg1);
            }
            else 
            {
                this._texture = starling.textures.Texture.fromAtfData(arg1, this._scaleFactor);
                loc2 = this._source as String;
                this._texture.root.onRestore = this.createTextureOnRestore(this._texture, loc2, this._textureFormat, this._scaleFactor);
                if (this._textureCache) 
                {
                    this._textureCache.addTexture(loc2, this._texture, true);
                }
            }
            arg1.clear();
            this._isTextureOwner = this._textureCache === null;
            this._isRestoringTexture = false;
            this._isLoaded = true;
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(starling.events.Event.COMPLETE);
            return;
        }

        public function get source():Object
        {
            return this._source;
        }

        public function set source(arg1:Object):void
        {
            var loc1:*=null;
            if (this._source == arg1) 
            {
                return;
            }
            this._isRestoringTexture = false;
            if (this._isInTextureQueue) 
            {
                this.removeFromTextureQueue();
            }
            if (this._isTextureOwner && arg1 && !(arg1 is starling.textures.Texture)) 
            {
                loc1 = this._texture;
                this._isTextureOwner = false;
            }
            this.cleanupTexture();
            this._source = arg1;
            if (loc1) 
            {
                this._texture = loc1;
                this._isTextureOwner = true;
            }
            if (this.image) 
            {
                this.image.visible = false;
            }
            this.cleanupLoaders(true);
            this._lastURL = null;
            if (this._source is starling.textures.Texture) 
            {
                this._isLoaded = true;
            }
            else 
            {
                this._isLoaded = false;
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function set paddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingRight === arg1) 
            {
                return;
            }
            this._paddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textureCache():feathers.utils.textures.TextureCache
        {
            return this._textureCache;
        }

        public function set textureCache(arg1:feathers.utils.textures.TextureCache):void
        {
            this._textureCache = arg1;
            return;
        }

        protected function addToTextureQueue():void
        {
            if (!this._delayTextureCreation) 
            {
                throw new flash.errors.IllegalOperationError("Cannot add loader to delayed texture queue if delayTextureCreation is false.");
            }
            if (this._textureQueueDuration == Number.POSITIVE_INFINITY) 
            {
                throw new flash.errors.IllegalOperationError("Cannot add loader to delayed texture queue if textureQueueDuration is Number.POSITIVE_INFINITY.");
            }
            if (this._isInTextureQueue) 
            {
                throw new flash.errors.IllegalOperationError("Cannot add loader to delayed texture queue more than once.");
            }
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.imageLoader_removedFromStageHandler);
            this._isInTextureQueue = true;
            if (textureQueueTail) 
            {
                textureQueueTail._textureQueueNext = this;
                this._textureQueuePrevious = textureQueueTail;
                textureQueueTail = this;
            }
            else 
            {
                textureQueueHead = this;
                textureQueueTail = this;
                this.preparePendingTexture();
            }
            return;
        }

        public function get loadingTexture():starling.textures.Texture
        {
            return this._loadingTexture;
        }

        public function set loadingTexture(arg1:starling.textures.Texture):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._loadingTexture === arg1) 
            {
                return;
            }
            this._loadingTexture = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function removeFromTextureQueue():void
        {
            if (!this._isInTextureQueue) 
            {
                return;
            }
            var loc1:*=this._textureQueuePrevious;
            var loc2:*=this._textureQueueNext;
            this._textureQueuePrevious = null;
            this._textureQueueNext = null;
            this._isInTextureQueue = false;
            this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.imageLoader_removedFromStageHandler);
            this.removeEventListener(starling.events.EnterFrameEvent.ENTER_FRAME, this.processTextureQueue_enterFrameHandler);
            if (loc1) 
            {
                loc1._textureQueueNext = loc2;
            }
            if (loc2) 
            {
                loc2._textureQueuePrevious = loc1;
            }
            var loc3:*=textureQueueHead == this;
            var loc4:*=textureQueueTail == this;
            if (loc4) 
            {
                textureQueueTail = loc1;
                if (loc3) 
                {
                    textureQueueHead = loc1;
                }
            }
            if (loc3) 
            {
                textureQueueHead = loc2;
                if (loc4) 
                {
                    textureQueueTail = loc2;
                }
            }
            if (loc3 && textureQueueHead) 
            {
                textureQueueHead.preparePendingTexture();
            }
            return;
        }

        public function get errorTexture():starling.textures.Texture
        {
            return this._errorTexture;
        }

        public function set errorTexture(arg1:starling.textures.Texture):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._errorTexture === arg1) 
            {
                return;
            }
            this._errorTexture = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function preparePendingTexture():void
        {
            if (this._textureQueueDuration > 0) 
            {
                this._accumulatedPrepareTextureTime = 0;
                this.addEventListener(starling.events.EnterFrameEvent.ENTER_FRAME, this.processTextureQueue_enterFrameHandler);
            }
            else 
            {
                this.processPendingTexture();
            }
            return;
        }

        public function get isLoaded():Boolean
        {
            return this._isLoaded;
        }

        protected function processPendingTexture():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._pendingBitmapDataTexture) 
            {
                loc1 = this._pendingBitmapDataTexture;
                this._pendingBitmapDataTexture = null;
                this.replaceBitmapDataTexture(loc1);
            }
            if (this._pendingRawTextureData) 
            {
                loc2 = this._pendingRawTextureData;
                this._pendingRawTextureData = null;
                this.replaceRawTextureData(loc2);
            }
            if (this._isInTextureQueue) 
            {
                this.removeFromTextureQueue();
            }
            return;
        }

        public function get textureScale():Number
        {
            return this._textureScale;
        }

        public function set textureScale(arg1:Number):void
        {
            if (this._textureScale == arg1) 
            {
                return;
            }
            this._textureScale = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected function createTextureOnRestore(arg1:starling.textures.Texture, arg2:String, arg3:String, arg4:Number):Function
        {
            var texture:starling.textures.Texture;
            var source:String;
            var format:String;
            var scaleFactor:Number;

            var loc1:*;
            texture = arg1;
            source = arg2;
            format = arg3;
            scaleFactor = arg4;
            return function ():void
            {
                if (_texture === texture) 
                {
                    texture_onRestore();
                    return;
                }
                var loc1:*=new feathers.controls.ImageLoader();
                loc1.source = source;
                loc1._texture = texture;
                loc1._textureFormat = format;
                loc1._scaleFactor = scaleFactor;
                loc1.validate();
                loc1.addEventListener(starling.events.Event.COMPLETE, onRestore_onComplete);
                return;
            }
        }

        public function get scaleFactor():Number
        {
            return this._textureScale;
        }

        public function set scaleFactor(arg1:Number):void
        {
            if (this._scaleFactor == arg1) 
            {
                return;
            }
            this._scaleFactor = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected function onRestore_onComplete(arg1:starling.events.Event):void
        {
            var loc1:*=feathers.controls.ImageLoader(arg1.currentTarget);
            loc1._isTextureOwner = false;
            loc1._texture = null;
            loc1.dispose();
            return;
        }

        public function get textureSmoothing():String
        {
            return this._textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._textureSmoothing === arg1) 
            {
                return;
            }
            this._textureSmoothing = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function texture_onRestore():void
        {
            this._isRestoringTexture = true;
            this._lastURL = null;
            this._isLoaded = false;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get scale9Grid():flash.geom.Rectangle
        {
            return this._scale9Grid;
        }

        public function set scale9Grid(arg1:flash.geom.Rectangle):void
        {
            if (this._scale9Grid == arg1) 
            {
                return;
            }
            this._scale9Grid = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function processTextureQueue_enterFrameHandler(arg1:starling.events.EnterFrameEvent):void
        {
            this._accumulatedPrepareTextureTime = this._accumulatedPrepareTextureTime + arg1.passedTime;
            if (this._accumulatedPrepareTextureTime >= this._textureQueueDuration) 
            {
                this.removeEventListener(starling.events.EnterFrameEvent.ENTER_FRAME, this.processTextureQueue_enterFrameHandler);
                this.processPendingTexture();
            }
            return;
        }

        public function get tileGrid():flash.geom.Rectangle
        {
            return this._tileGrid;
        }

        public function set tileGrid(arg1:flash.geom.Rectangle):void
        {
            if (this._tileGrid == arg1) 
            {
                return;
            }
            this._tileGrid = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function imageLoader_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (this._isInTextureQueue) 
            {
                this.removeFromTextureQueue();
            }
            return;
        }

        public function get pixelSnapping():Boolean
        {
            return this._pixelSnapping;
        }

        public function set pixelSnapping(arg1:Boolean):void
        {
            if (this._pixelSnapping == arg1) 
            {
                return;
            }
            this._pixelSnapping = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function loader_completeHandler(arg1:flash.events.Event):void
        {
            var loc1:*=flash.display.Bitmap(this.loader.content);
            this.cleanupLoaders(false);
            var loc2:*=loc1.bitmapData;
            var loc3:*=this._texture && this._texture.nativeWidth === loc2.width && this._texture.nativeHeight === loc2.height && this._texture.scale === this._scaleFactor && this._texture.format === this._textureFormat;
            if (!loc3) 
            {
                this.cleanupTexture();
            }
            if (this._delayTextureCreation && !this._isRestoringTexture) 
            {
                this._pendingBitmapDataTexture = loc2;
                if (this._textureQueueDuration < Number.POSITIVE_INFINITY) 
                {
                    this.addToTextureQueue();
                }
            }
            else 
            {
                this.replaceBitmapDataTexture(loc2);
            }
            return;
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._color === arg1) 
            {
                return;
            }
            this._color = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function loader_progressHandler(arg1:flash.events.ProgressEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.PROGRESS, false, arg1.bytesLoaded / arg1.bytesTotal);
            return;
        }

        public function get textureFormat():String
        {
            return this._textureFormat;
        }

        public function set textureFormat(arg1:String):void
        {
            if (this._textureFormat == arg1) 
            {
                return;
            }
            this._textureFormat = arg1;
            this._lastURL = null;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function loader_ioErrorHandler(arg1:flash.events.IOErrorEvent):void
        {
            this.cleanupLoaders(false);
            this.cleanupTexture();
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, arg1);
            this.dispatchEventWith(starling.events.Event.IO_ERROR, false, arg1);
            return;
        }

        public function get scaleContent():Boolean
        {
            return this._scaleContent;
        }

        public function set scaleContent(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._scaleContent === arg1) 
            {
                return;
            }
            this._scaleContent = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function loader_securityErrorHandler(arg1:flash.events.SecurityErrorEvent):void
        {
            this.cleanupLoaders(false);
            this.cleanupTexture();
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, arg1);
            this.dispatchEventWith(starling.events.Event.SECURITY_ERROR, false, arg1);
            return;
        }

        public function get maintainAspectRatio():Boolean
        {
            return this._maintainAspectRatio;
        }

        public function set maintainAspectRatio(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._maintainAspectRatio === arg1) 
            {
                return;
            }
            this._maintainAspectRatio = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function orphanedLoader_completeHandler(arg1:flash.events.Event):void
        {
            var loc1:*=flash.display.LoaderInfo(arg1.currentTarget);
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.orphanedLoader_completeHandler);
            var loc2:*=loc1.loader;
            var loc3:*=flash.display.Bitmap(loc2.content);
            loc3.bitmapData.dispose();
            loc2.unload();
            return;
        }

        public function get scaleMode():String
        {
            return this._scaleMode;
        }

        public function set scaleMode(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._scaleMode === arg1) 
            {
                return;
            }
            this._scaleMode = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function rawDataLoader_completeHandler(arg1:flash.events.Event):void
        {
            var loc1:*=flash.utils.ByteArray(this.urlLoader.data);
            this.cleanupLoaders(false);
            if (!this._isRestoringTexture) 
            {
                this.cleanupTexture();
            }
            if (this._delayTextureCreation && !this._isRestoringTexture) 
            {
                this._pendingRawTextureData = loc1;
                if (this._textureQueueDuration < Number.POSITIVE_INFINITY) 
                {
                    this.addToTextureQueue();
                }
            }
            else 
            {
                this.replaceRawTextureData(loc1);
            }
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._horizontalAlign === arg1) 
            {
                return;
            }
            this._horizontalAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function rawDataLoader_ioErrorHandler(arg1:flash.events.ErrorEvent):void
        {
            this.cleanupLoaders(false);
            this.cleanupTexture();
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, arg1);
            this.dispatchEventWith(starling.events.Event.IO_ERROR, false, arg1);
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._verticalAlign === arg1) 
            {
                return;
            }
            this._verticalAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get originalSourceWidth():Number
        {
            if (this._originalTextureWidth === this._originalTextureWidth) 
            {
                return this._originalTextureWidth;
            }
            return 0;
        }

        public function get originalSourceHeight():Number
        {
            if (this._originalTextureHeight === this._originalTextureHeight) 
            {
                return this._originalTextureHeight;
            }
            return 0;
        }

        protected function rawDataLoader_securityErrorHandler(arg1:flash.events.ErrorEvent):void
        {
            this.cleanupLoaders(false);
            this.cleanupTexture();
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, arg1);
            this.dispatchEventWith(starling.events.Event.SECURITY_ERROR, false, arg1);
            return;
        }

        
        {
            LOADER_CONTEXT.imageDecodingPolicy = flash.system.ImageDecodingPolicy.ON_LOAD;
        }

        protected function rawDataLoader_progressHandler(arg1:flash.events.ProgressEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.PROGRESS, false, arg1.bytesLoaded / arg1.bytesTotal);
            return;
        }

        public function get delayTextureCreation():Boolean
        {
            return this._delayTextureCreation;
        }

        public function set delayTextureCreation(arg1:Boolean):void
        {
            if (this._delayTextureCreation == arg1) 
            {
                return;
            }
            this._delayTextureCreation = arg1;
            if (!this._delayTextureCreation) 
            {
                this.processPendingTexture();
            }
            return;
        }

        public function get textureQueueDuration():Number
        {
            return this._textureQueueDuration;
        }

        public function set textureQueueDuration(arg1:Number):void
        {
            if (this._textureQueueDuration == arg1) 
            {
                return;
            }
            var loc1:*=this._textureQueueDuration;
            this._textureQueueDuration = arg1;
            if (this._delayTextureCreation) 
            {
                if ((this._pendingBitmapDataTexture || this._pendingRawTextureData) && loc1 == Number.POSITIVE_INFINITY && this._textureQueueDuration < Number.POSITIVE_INFINITY) 
                {
                    this.addToTextureQueue();
                }
                else if (this._isInTextureQueue && this._textureQueueDuration == Number.POSITIVE_INFINITY) 
                {
                    this.removeFromTextureQueue();
                }
            }
            return;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingTop === arg1) 
            {
                return;
            }
            this._paddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingBottom === arg1) 
            {
                return;
            }
            this._paddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingLeft === arg1) 
            {
                return;
            }
            this._paddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function dispose():void
        {
            this._isRestoringTexture = false;
            this.cleanupLoaders(true);
            this.cleanupTexture();
            super.dispose();
            return;
        }

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        internal static const HELPER_RECTANGLE:flash.geom.Rectangle=new flash.geom.Rectangle();

        internal static const HELPER_RECTANGLE2:flash.geom.Rectangle=new flash.geom.Rectangle();

        internal static const CONTEXT_LOST_WARNING:String="ImageLoader: Context lost while processing loaded image, retrying...";

        protected static const LOADER_CONTEXT:flash.system.LoaderContext=new flash.system.LoaderContext(true);

        protected static const ATF_FILE_EXTENSION:String="atf";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        protected var _isTextureOwner:Boolean=false;

        protected var _source:Object;

        protected var _loadingTexture:starling.textures.Texture;

        protected var _errorTexture:starling.textures.Texture;

        protected var _isLoaded:Boolean=false;

        internal var _textureScale:Number=1;

        internal var _scaleFactor:Number=1;

        internal var _textureSmoothing:String="bilinear";

        internal var _scale9Grid:flash.geom.Rectangle;

        internal var _tileGrid:flash.geom.Rectangle;

        internal var _pixelSnapping:Boolean=true;

        internal var _color:uint=16777215;

        internal var _textureFormat:String="bgra";

        internal var _scaleContent:Boolean=true;

        internal var _maintainAspectRatio:Boolean=true;

        internal var _scaleMode:String="showAll";

        protected var _horizontalAlign:String="left";

        protected var _currentTextureHeight:Number=NaN;

        protected var _pendingBitmapDataTexture:flash.display.BitmapData;

        protected var _pendingRawTextureData:flash.utils.ByteArray;

        protected var _textureQueuePrevious:feathers.controls.ImageLoader;

        protected var _delayTextureCreation:Boolean=false;

        protected var _paddingBottom:Number=0;

        protected var _textureQueueNext:feathers.controls.ImageLoader;

        protected var _accumulatedPrepareTextureTime:Number;

        protected var _paddingLeft:Number=0;

        protected var _paddingTop:Number=0;

        protected var _textureCache:feathers.utils.textures.TextureCache;

        protected var _textureQueueDuration:Number=Infinity;

        protected var _isInTextureQueue:Boolean=false;

        protected var image:starling.display.Image;

        protected var loader:flash.display.Loader;

        protected var urlLoader:flash.net.URLLoader;

        protected var _lastURL:String;

        protected var _originalTextureWidth:Number=NaN;

        protected static var textureQueueHead:feathers.controls.ImageLoader;

        protected static var textureQueueTail:feathers.controls.ImageLoader;

        protected var _verticalAlign:String="top";

        protected var _originalTextureHeight:Number=NaN;

        protected var _currentTextureWidth:Number=NaN;

        protected var _currentTexture:starling.textures.Texture;

        protected var _isRestoringTexture:Boolean=false;

        protected var _texture:starling.textures.Texture;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _paddingRight:Number=0;
    }
}


