//class TextureAtlas
package starling.textures 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.utils.*;
    
    public class TextureAtlas extends Object
    {
        public function TextureAtlas(arg1:starling.textures.Texture, arg2:XML=null)
        {
            super();
            this._subTextures = new flash.utils.Dictionary();
            this._atlasTexture = arg1;
            if (arg2) 
            {
                this.parseAtlasXml(arg2);
            }
            return;
        }

        public function dispose():void
        {
            this._atlasTexture.dispose();
            return;
        }

        protected function parseAtlasXml(arg1:XML):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=false;
            var loc1:*=this._atlasTexture.scale;
            var loc2:*=new flash.geom.Rectangle();
            var loc3:*=new flash.geom.Rectangle();
            var loc15:*=0;
            var loc16:*=arg1.SubTexture;
            for each (loc4 in loc16) 
            {
                loc5 = starling.utils.StringUtil.clean(loc4.@name);
                loc6 = parseFloat(loc4.@x) / loc1;
                loc7 = parseFloat(loc4.@y) / loc1;
                loc8 = parseFloat(loc4.@width) / loc1;
                loc9 = parseFloat(loc4.@height) / loc1;
                loc10 = parseFloat(loc4.@frameX) / loc1;
                loc11 = parseFloat(loc4.@frameY) / loc1;
                loc12 = parseFloat(loc4.@frameWidth) / loc1;
                loc13 = parseFloat(loc4.@frameHeight) / loc1;
                loc14 = parseBool(loc4.@rotated);
                loc2.setTo(loc6, loc7, loc8, loc9);
                loc3.setTo(loc10, loc11, loc12, loc13);
                if (loc12 > 0 && loc13 > 0) 
                {
                    this.addRegion(loc5, loc2, loc3, loc14);
                    continue;
                }
                this.addRegion(loc5, loc2, null, loc14);
            }
            return;
        }

        public function getTexture(arg1:String):starling.textures.Texture
        {
            return this._subTextures[arg1];
        }

        public function getTextures(arg1:String="", arg2:__AS3__.vec.Vector.<starling.textures.Texture>=null):__AS3__.vec.Vector.<starling.textures.Texture>
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                arg2 = new Vector.<starling.textures.Texture>(0);
            }
            var loc2:*=0;
            var loc3:*=this.getNames(arg1, sNames);
            for each (loc1 in loc3) 
            {
                arg2[arg2.length] = this.getTexture(loc1);
            }
            sNames.length = 0;
            return arg2;
        }

        public function getNames(arg1:String="", arg2:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                arg2 = new Vector.<String>(0);
            }
            if (this._subTextureNames == null) 
            {
                this._subTextureNames = new Vector.<String>(0);
                var loc2:*=0;
                var loc3:*=this._subTextures;
                for (loc1 in loc3) 
                {
                    this._subTextureNames[this._subTextureNames.length] = loc1;
                }
                this._subTextureNames.sort(Array.CASEINSENSITIVE);
            }
            loc2 = 0;
            loc3 = this._subTextureNames;
            for each (loc1 in loc3) 
            {
                if (loc1.indexOf(arg1) != 0) 
                {
                    continue;
                }
                arg2[arg2.length] = loc1;
            }
            return arg2;
        }

        public function getRegion(arg1:String):flash.geom.Rectangle
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.region : null;
        }

        public function getFrame(arg1:String):flash.geom.Rectangle
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.frame : null;
        }

        public function getRotation(arg1:String):Boolean
        {
            var loc1:*=this._subTextures[arg1];
            return loc1 ? loc1.rotated : false;
        }

        public function addRegion(arg1:String, arg2:flash.geom.Rectangle, arg3:flash.geom.Rectangle=null, arg4:Boolean=false):void
        {
            this._subTextures[arg1] = new starling.textures.SubTexture(this._atlasTexture, arg2, false, arg3, arg4);
            this._subTextureNames = null;
            return;
        }

        public function removeRegion(arg1:String):void
        {
            var loc1:*=this._subTextures[arg1];
            if (loc1) 
            {
                loc1.dispose();
            }
            delete this._subTextures[arg1];
            this._subTextureNames = null;
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._atlasTexture;
        }

        internal static function parseBool(arg1:String):Boolean
        {
            return arg1.toLowerCase() == "true";
        }

        
        {
            sNames = new Vector.<String>(0);
        }

        internal var _atlasTexture:starling.textures.Texture;

        internal var _subTextures:flash.utils.Dictionary;

        internal var _subTextureNames:__AS3__.vec.Vector.<String>;

        internal static var sNames:__AS3__.vec.Vector.<String>;
    }
}


