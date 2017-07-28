//class BaseMediaPlayer
package feathers.media 
{
    import feathers.controls.*;
    import feathers.layout.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.events.*;
    
    public class BaseMediaPlayer extends feathers.controls.LayoutGroup implements feathers.media.IMediaPlayer
    {
        public function BaseMediaPlayer()
        {
            super();
            if (Object(this).constructor === feathers.media.BaseMediaPlayer) 
            {
                throw new starling.errors.AbstractClassError();
            }
            this.addEventListener(starling.events.Event.ADDED, this.mediaPlayer_addedHandler);
            this.addEventListener(starling.events.Event.REMOVED, this.mediaPlayer_removedHandler);
            return;
        }

        protected override function initialize():void
        {
            if (this._layout === null) 
            {
                this._layout = new feathers.layout.AnchorLayout();
            }
            super.initialize();
            return;
        }

        protected function handleAddedChild(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1 is feathers.media.IMediaPlayerControl) 
            {
                feathers.media.IMediaPlayerControl(arg1).mediaPlayer = this;
            }
            if (arg1 is starling.display.DisplayObjectContainer) 
            {
                loc1 = starling.display.DisplayObjectContainer(arg1);
                loc2 = loc1.numChildren;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    arg1 = loc1.getChildAt(loc3);
                    this.handleAddedChild(arg1);
                    ++loc3;
                }
            }
            return;
        }

        protected function handleRemovedChild(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (arg1 is feathers.media.IMediaPlayerControl) 
            {
                feathers.media.IMediaPlayerControl(arg1).mediaPlayer = null;
            }
            if (arg1 is starling.display.DisplayObjectContainer) 
            {
                loc1 = starling.display.DisplayObjectContainer(arg1);
                loc2 = loc1.numChildren;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    arg1 = loc1.getChildAt(loc3);
                    this.handleRemovedChild(arg1);
                    ++loc3;
                }
            }
            return;
        }

        protected function mediaPlayer_addedHandler(arg1:starling.events.Event):void
        {
            var loc1:*=starling.display.DisplayObject(arg1.target);
            this.handleAddedChild(loc1);
            return;
        }

        protected function mediaPlayer_removedHandler(arg1:starling.events.Event):void
        {
            var loc1:*=starling.display.DisplayObject(arg1.target);
            this.handleRemovedChild(loc1);
            return;
        }
    }
}


