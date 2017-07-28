//class TouchMarker
package starling.events 
{
    import flash.display.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.textures.*;
    
    internal class TouchMarker extends starling.display.Sprite
    {
        public function TouchMarker()
        {
            var loc2:*=null;
            super();
            this._center = new flash.geom.Point();
            this._texture = this.createTexture();
            var loc1:*=0;
            while (loc1 < 2) 
            {
                loc2 = new starling.display.Image(this._texture);
                loc2.pivotX = this._texture.width / 2;
                loc2.pivotY = this._texture.height / 2;
                loc2.touchable = false;
                addChild(loc2);
                ++loc1;
            }
            return;
        }

        public override function dispose():void
        {
            this._texture.dispose();
            super.dispose();
            return;
        }

        public function moveMarker(arg1:Number, arg2:Number, arg3:Boolean=false):void
        {
            if (arg3) 
            {
                this._center.x = this._center.x + (arg1 - this.realMarker.x);
                this._center.y = this._center.y + (arg2 - this.realMarker.y);
            }
            this.realMarker.x = arg1;
            this.realMarker.y = arg2;
            this.mockMarker.x = 2 * this._center.x - arg1;
            this.mockMarker.y = 2 * this._center.y - arg2;
            return;
        }

        public function moveCenter(arg1:Number, arg2:Number):void
        {
            this._center.x = arg1;
            this._center.y = arg2;
            this.moveMarker(this.realX, this.realY);
            return;
        }

        internal function createTexture():starling.textures.Texture
        {
            var loc1:*=starling.core.Starling.contentScaleFactor;
            var loc2:*=12 * loc1;
            var loc3:*=32 * loc1;
            var loc4:*=32 * loc1;
            var loc5:*=1.5 * loc1;
            var loc6:*=new flash.display.Shape();
            loc6.graphics.lineStyle(loc5, 0, 0.3);
            loc6.graphics.drawCircle(loc3 / 2, loc4 / 2, loc2 + loc5);
            loc6.graphics.beginFill(16777215, 0.4);
            loc6.graphics.lineStyle(loc5, 16777215);
            loc6.graphics.drawCircle(loc3 / 2, loc4 / 2, loc2);
            loc6.graphics.endFill();
            var loc7:*=new flash.display.BitmapData(loc3, loc4, true, 0);
            loc7.draw(loc6);
            return starling.textures.Texture.fromBitmapData(loc7, false, false, loc1);
        }

        internal function get realMarker():starling.display.Image
        {
            return getChildAt(0) as starling.display.Image;
        }

        internal function get mockMarker():starling.display.Image
        {
            return getChildAt(1) as starling.display.Image;
        }

        public function get realX():Number
        {
            return this.realMarker.x;
        }

        public function get realY():Number
        {
            return this.realMarker.y;
        }

        public function get mockX():Number
        {
            return this.mockMarker.x;
        }

        public function get mockY():Number
        {
            return this.mockMarker.y;
        }

        internal var _center:flash.geom.Point;

        internal var _texture:starling.textures.Texture;
    }
}


