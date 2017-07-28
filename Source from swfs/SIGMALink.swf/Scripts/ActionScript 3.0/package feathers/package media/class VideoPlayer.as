//class VideoPlayer
package feathers.media 
{
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.display.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.textures.*;
    
    public class VideoPlayer extends feathers.media.BaseTimedMediaPlayer implements feathers.media.IVideoPlayer, feathers.media.IProgressiveMediaPlayer
    {
        public function VideoPlayer()
        {
            this._netConnectionFactory = defaultNetConnectionFactory;
            super();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.media.VideoPlayer.globalStyleProvider;
        }

        protected function disposeNetConnection():void
        {
            if (this._netConnection === null) 
            {
                return;
            }
            this._netConnection.removeEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netConnection_netStatusHandler);
            this._netConnection.close();
            this._netConnection = null;
            return;
        }

        protected function disposeNetStream():void
        {
            if (this._netStream === null) 
            {
                return;
            }
            this._netStream.removeEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netStream_netStatusHandler);
            this._netStream.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.netStream_ioErrorHandler);
            this._netStream.close();
            this._netStream = null;
            return;
        }

        protected function videoPlayer_enterFrameHandler(arg1:starling.events.Event):void
        {
            this._currentTime = this._netStream.time;
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.CURRENT_TIME_CHANGE);
            return;
        }

        public function get soundTransform():flash.media.SoundTransform
        {
            if (!this._soundTransform) 
            {
                this._soundTransform = new flash.media.SoundTransform();
            }
            return this._soundTransform;
        }

        public function set soundTransform(arg1:flash.media.SoundTransform):void
        {
            this._soundTransform = arg1;
            if (this._netStream) 
            {
                this._netStream.soundTransform = this._soundTransform;
            }
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.SOUND_TRANSFORM_CHANGE);
            return;
        }

        protected function videoPlayer_progress_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc2:*=false;
            var loc3:*=NaN;
            var loc1:*=this._netStream.bytesTotal;
            if (loc1 > 0) 
            {
                loc2 = false;
                loc3 = this._netStream.bytesLoaded;
                if (this._bytesTotal !== loc1) 
                {
                    this._bytesTotal = loc1;
                    loc2 = true;
                }
                if (this._bytesLoaded !== loc3) 
                {
                    this._bytesLoaded = loc3;
                    loc2 = true;
                }
                if (loc2) 
                {
                    this.dispatchEventWith(feathers.events.MediaPlayerEventType.LOAD_PROGRESS, false, loc3 / loc1);
                }
                if (loc3 === loc1) 
                {
                    this.removeEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_progress_enterFrameHandler);
                }
            }
            return;
        }

        protected function videoTexture_onRestore():void
        {
            this.pauseMedia();
            this._isWaitingForTextureReady = true;
            this._texture.root.attachNetStream(this._netStream, this.videoTexture_onComplete);
            this._netStream.play(this._videoSource);
            return;
        }

        public function get texture():starling.textures.Texture
        {
            if (this._isWaitingForTextureReady) 
            {
                return null;
            }
            return this._texture;
        }

        public function get nativeWidth():Number
        {
            if (this._texture) 
            {
                return this._texture.nativeWidth;
            }
            return 0;
        }

        public function get nativeHeight():Number
        {
            if (this._texture) 
            {
                return this._texture.nativeHeight;
            }
            return 0;
        }

        protected function videoTexture_onComplete():void
        {
            this._isWaitingForTextureReady = false;
            this.dispatchEventWith(starling.events.Event.READY);
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            var loc1:*=this._netStream.bytesTotal;
            if (this._bytesTotal === 0 && loc1 > 0) 
            {
                this._bytesLoaded = this._netStream.bytesLoaded;
                this._bytesTotal = loc1;
                this.dispatchEventWith(feathers.events.MediaPlayerEventType.LOAD_PROGRESS, false, this._bytesLoaded / loc1);
                if (this._bytesLoaded !== this._bytesTotal) 
                {
                    this.addEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_progress_enterFrameHandler);
                }
            }
            return;
        }

        protected function netConnection_netStatusHandler(arg1:flash.events.NetStatusEvent):void
        {
            var loc1:*=arg1.info.code;
            var loc2:*=loc1;
            switch (loc2) 
            {
                case NET_STATUS_CODE_NETCONNECTION_CONNECT_SUCCESS:
                {
                    this.playMedia();
                    break;
                }
            }
            return;
        }

        public function get netStream():flash.net.NetStream
        {
            return this._netStream;
        }

        protected function netStream_onMetaData(arg1:Object):void
        {
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.DIMENSIONS_CHANGE);
            this._totalTime = arg1.duration;
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.TOTAL_TIME_CHANGE);
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.METADATA_RECEIVED, false, arg1);
            return;
        }

        protected function netStream_onCuePoint(arg1:Object):void
        {
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.CUE_POINT, false, arg1);
            return;
        }

        public function get videoSource():String
        {
            return this._videoSource;
        }

        public function set videoSource(arg1:String):void
        {
            if (this._videoSource === arg1) 
            {
                return;
            }
            if (this._isPlaying) 
            {
                this.stop();
            }
            this.disposeNetStream();
            if (!arg1) 
            {
                this.disposeNetConnection();
            }
            if (this._texture !== null) 
            {
                this._texture.dispose();
                this._texture = null;
                this.dispatchEventWith(feathers.events.FeathersEventType.CLEAR);
            }
            this._videoSource = arg1;
            if (this._currentTime !== 0) 
            {
                this._currentTime = 0;
                this.dispatchEventWith(feathers.events.MediaPlayerEventType.CURRENT_TIME_CHANGE);
            }
            if (this._totalTime !== 0) 
            {
                this._totalTime = 0;
                this.dispatchEventWith(feathers.events.MediaPlayerEventType.TOTAL_TIME_CHANGE);
            }
            this._bytesLoaded = 0;
            this._bytesTotal = 0;
            if (this._autoPlay && this._videoSource) 
            {
                this.play();
            }
            return;
        }

        protected function netStream_onXMPData(arg1:Object):void
        {
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.XMP_DATA, false, arg1);
            return;
        }

        public function get autoPlay():Boolean
        {
            return this._autoPlay;
        }

        public function set autoPlay(arg1:Boolean):void
        {
            this._autoPlay = arg1;
            return;
        }

        protected function netStream_ioErrorHandler(arg1:flash.events.IOErrorEvent):void
        {
            this.dispatchEventWith(arg1.type, false, arg1);
            return;
        }

        public function get isFullScreen():Boolean
        {
            return this._isFullScreen;
        }

        protected function netStream_netStatusHandler(arg1:flash.events.NetStatusEvent):void
        {
            var loc1:*=arg1.info.code;
            var loc2:*=loc1;
            switch (loc2) 
            {
                case NET_STATUS_CODE_NETSTREAM_PLAY_STREAMNOTFOUND:
                {
                    this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, loc1);
                    break;
                }
                case NET_STATUS_CODE_NETSTREAM_PLAY_NOSUPPORTEDTRACKFOUND:
                {
                    this.dispatchEventWith(feathers.events.FeathersEventType.ERROR, false, loc1);
                    break;
                }
                case NET_STATUS_CODE_NETSTREAM_PLAY_START:
                {
                    if (this._netStream.time !== this._currentTime) 
                    {
                        this._netStream.seek(this._currentTime);
                    }
                    if (this._isPlaying) 
                    {
                        this.addEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_enterFrameHandler);
                    }
                    else 
                    {
                        this.pauseMedia();
                    }
                    break;
                }
                case NET_STATUS_CODE_NETSTREAM_PLAY_STOP:
                {
                    if (this._hasPlayedToEnd) 
                    {
                        return;
                    }
                    this.removeEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_enterFrameHandler);
                    if (starling.core.Starling.context.driverInfo !== "Disposed") 
                    {
                        this.stop();
                        this._hasPlayedToEnd = true;
                        this.dispatchEventWith(starling.events.Event.COMPLETE);
                    }
                    break;
                }
            }
            return;
        }

        public function get normalDisplayState():String
        {
            return this._normalDisplayState;
        }

        public function set normalDisplayState(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._normalDisplayState == arg1) 
            {
                return;
            }
            this._normalDisplayState = arg1;
            if (!this._isFullScreen && this.stage) 
            {
                loc1 = feathers.utils.display.stageToStarling(this.stage);
                loc2 = loc1.nativeStage;
                loc2.displayState = this._normalDisplayState;
            }
            return;
        }

        protected override function playMedia():void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (!this._videoSource) 
            {
                throw new flash.errors.IllegalOperationError(NO_VIDEO_SOURCE_PLAY_ERROR);
            }
            if (this._netConnection === null) 
            {
                loc2 = this._netConnectionFactory === null ? defaultNetConnectionFactory : this._netConnectionFactory;
                this._netConnection = flash.net.NetConnection(loc2());
            }
            if (this._netStream === null) 
            {
                if (!this._netConnection.connected) 
                {
                    this._netConnection.addEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netConnection_netStatusHandler);
                    return;
                }
                this._netStream = new flash.net.NetStream(this._netConnection);
                this._netStream.client = new VideoPlayerNetStreamClient(this.netStream_onMetaData, this.netStream_onCuePoint, this.netStream_onXMPData);
                this._netStream.addEventListener(flash.events.NetStatusEvent.NET_STATUS, this.netStream_netStatusHandler);
                this._netStream.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.netStream_ioErrorHandler);
            }
            if (this._soundTransform === null) 
            {
                this._soundTransform = new flash.media.SoundTransform();
            }
            this._netStream.soundTransform = this._soundTransform;
            var loc1:*=this.videoTexture_onComplete;
            if (this._texture === null) 
            {
                this._isWaitingForTextureReady = true;
                loc3 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                this._texture = starling.textures.Texture.fromNetStream(this._netStream, loc3.contentScaleFactor, loc1);
                this._texture.root.onRestore = this.videoTexture_onRestore;
                this._netStream.play(this._videoSource);
            }
            else if (this._hasPlayedToEnd) 
            {
                this._netStream.play(this._videoSource);
            }
            else 
            {
                this.addEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_enterFrameHandler);
                this._netStream.resume();
            }
            this._hasPlayedToEnd = false;
            return;
        }

        public function get fullScreenDisplayState():String
        {
            return this._fullScreenDisplayState;
        }

        public function set fullScreenDisplayState(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._fullScreenDisplayState == arg1) 
            {
                return;
            }
            this._fullScreenDisplayState = arg1;
            if (this._isFullScreen && this.stage) 
            {
                loc1 = feathers.utils.display.stageToStarling(this.stage);
                loc2 = loc1.nativeStage;
                loc2.displayState = this._fullScreenDisplayState;
            }
            return;
        }

        protected override function mediaPlayer_addedHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreDisplayListEvents) 
            {
                return;
            }
            super.mediaPlayer_addedHandler(arg1);
            return;
        }

        public function get hideRootWhenFullScreen():Boolean
        {
            return this._hideRootWhenFullScreen;
        }

        public function set hideRootWhenFullScreen(arg1:Boolean):void
        {
            this._hideRootWhenFullScreen = arg1;
            return;
        }

        protected override function mediaPlayer_removedHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreDisplayListEvents) 
            {
                return;
            }
            super.mediaPlayer_removedHandler(arg1);
            return;
        }

        public function get netConnectionFactory():Function
        {
            return this._netConnectionFactory;
        }

        public function set netConnectionFactory(arg1:Function):void
        {
            if (this._netConnectionFactory === arg1) 
            {
                return;
            }
            this._netConnectionFactory = arg1;
            this.stop();
            this.disposeNetStream();
            this.disposeNetConnection();
            return;
        }

        protected static function defaultNetConnectionFactory():flash.net.NetConnection
        {
            var loc1:*=new flash.net.NetConnection();
            loc1.connect(null);
            return loc1;
        }

        public function get bytesLoaded():uint
        {
            return this._bytesLoaded;
        }

        public function get bytesTotal():uint
        {
            return this._bytesTotal;
        }

        public override function dispose():void
        {
            this.videoSource = null;
            super.dispose();
            return;
        }

        public override function play():void
        {
            if (this._videoSource === null) 
            {
                return;
            }
            super.play();
            return;
        }

        public override function stop():void
        {
            if (this._videoSource === null) 
            {
                return;
            }
            super.stop();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (this._isFullScreen) 
            {
                return;
            }
            super.render(arg1);
            return;
        }

        public function toggleFullScreen():void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            if (!this.stage) 
            {
                throw new flash.errors.IllegalOperationError("Cannot enter full screen mode if the video player does not have access to the Starling stage.");
            }
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            var loc2:*=loc1.nativeStage;
            var loc3:*=this._ignoreDisplayListEvents;
            this._ignoreDisplayListEvents = true;
            if (this._isFullScreen) 
            {
                this.root.visible = true;
                feathers.core.PopUpManager.removePopUp(this._fullScreenContainer, false);
                loc4 = this._fullScreenContainer.numChildren;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    loc6 = this._fullScreenContainer.getChildAt(0);
                    this.addChild(loc6);
                    ++loc5;
                }
                loc2.displayState = this._normalDisplayState;
            }
            else 
            {
                if (this._hideRootWhenFullScreen) 
                {
                    this.root.visible = false;
                }
                loc2.displayState = this._fullScreenDisplayState;
                if (!this._fullScreenContainer) 
                {
                    this._fullScreenContainer = new feathers.controls.LayoutGroup();
                    this._fullScreenContainer.autoSizeMode = feathers.controls.AutoSizeMode.STAGE;
                }
                this._fullScreenContainer.layout = this._layout;
                loc4 = this.numChildren;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    loc6 = this.getChildAt(0);
                    this._fullScreenContainer.addChild(loc6);
                    ++loc5;
                }
                feathers.core.PopUpManager.addPopUp(this._fullScreenContainer, true, false);
            }
            this._ignoreDisplayListEvents = loc3;
            this._isFullScreen = !this._isFullScreen;
            this.dispatchEventWith(feathers.events.MediaPlayerEventType.DISPLAY_STATE_CHANGE);
            return;
        }

        protected override function pauseMedia():void
        {
            if (!this._videoSource) 
            {
                throw new flash.errors.IllegalOperationError(NO_VIDEO_SOURCE_PAUSE_ERROR);
            }
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.videoPlayer_enterFrameHandler);
            this._netStream.pause();
            return;
        }

        protected override function seekMedia(arg1:Number):void
        {
            if (!this._videoSource) 
            {
                throw new flash.errors.IllegalOperationError(NO_VIDEO_SOURCE_SEEK_ERROR);
            }
            this._currentTime = arg1;
            if (this._hasPlayedToEnd) 
            {
                this.playMedia();
                return;
            }
            this._netStream.seek(arg1);
            return;
        }

        protected static const NET_STATUS_CODE_NETSTREAM_PLAY_START:String="NetStream.Play.Start";

        protected static const NET_STATUS_CODE_NETSTREAM_PLAY_STOP:String="NetStream.Play.Stop";

        protected static const NET_STATUS_CODE_NETSTREAM_PLAY_STREAMNOTFOUND:String="NetStream.Play.StreamNotFound";

        protected static const NET_STATUS_CODE_NETSTREAM_PLAY_NOSUPPORTEDTRACKFOUND:String="NetStream.Play.NoSupportedTrackFound";

        protected static const NO_VIDEO_SOURCE_PLAY_ERROR:String="Cannot play media when videoSource property has not been set.";

        protected static const NO_VIDEO_SOURCE_PAUSE_ERROR:String="Cannot pause media when videoSource property has not been set.";

        protected static const NO_VIDEO_SOURCE_SEEK_ERROR:String="Cannot seek media when videoSource property has not been set.";

        protected static const NET_STATUS_CODE_NETCONNECTION_CONNECT_SUCCESS:String="NetConnection.Connect.Success";

        protected var _fullScreenContainer:feathers.controls.LayoutGroup;

        protected var _ignoreDisplayListEvents:Boolean=false;

        protected var _soundTransform:flash.media.SoundTransform;

        protected var _isWaitingForTextureReady:Boolean=false;

        protected var _texture:starling.textures.Texture;

        protected var _netConnection:flash.net.NetConnection;

        protected var _netStream:flash.net.NetStream;

        protected var _hasPlayedToEnd:Boolean=false;

        protected var _videoSource:String;

        protected var _autoPlay:Boolean=true;

        protected var _isFullScreen:Boolean=false;

        protected var _normalDisplayState:String="normal";

        protected var _hideRootWhenFullScreen:Boolean=true;

        protected var _netConnectionFactory:Function;

        protected var _bytesTotal:uint=0;

        protected var _bytesLoaded:uint=0;

        protected var _fullScreenDisplayState:String="fullScreenInteractive";

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


dynamic class VideoPlayerNetStreamClient extends Object
{
    public function VideoPlayerNetStreamClient(arg1:Function, arg2:Function, arg3:Function)
    {
        super();
        this.onMetaDataCallback = arg1;
        this.onCuePointCallback = arg2;
        this.onXMPDataCallback = arg3;
        return;
    }

    public function onMetaData(arg1:Object):void
    {
        this.onMetaDataCallback(arg1);
        return;
    }

    public function onCuePoint(arg1:Object):void
    {
        this.onCuePointCallback(arg1);
        return;
    }

    public function onXMPData(arg1:Object):void
    {
        this.onXMPDataCallback(arg1);
        return;
    }

    public var onMetaDataCallback:Function;

    public var onCuePointCallback:Function;
}

