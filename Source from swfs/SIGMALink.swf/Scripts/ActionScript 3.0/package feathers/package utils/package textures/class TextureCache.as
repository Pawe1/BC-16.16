//class TextureCache
package feathers.utils.textures 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import starling.textures.*;
    
    public class TextureCache extends Object
    {
        public function TextureCache(arg1:int=2147483647)
        {
            this._unretainedKeys = new Vector.<String>(0);
            this._unretainedTextures = {};
            this._retainedTextures = {};
            this._retainCounts = {};
            super();
            this._maxUnretainedTextures = arg1;
            return;
        }

        public function get maxUnretainedTextures():int
        {
            return this._maxUnretainedTextures;
        }

        public function set maxUnretainedTextures(arg1:int):void
        {
            if (this._maxUnretainedTextures === arg1) 
            {
                return;
            }
            this._maxUnretainedTextures = arg1;
            if (this._unretainedKeys.length > arg1) 
            {
                this.trimCache();
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._unretainedTextures;
            for each (loc1 in loc3) 
            {
                loc1.dispose();
            }
            loc2 = 0;
            loc3 = this._retainedTextures;
            for each (loc1 in loc3) 
            {
                loc1.dispose();
            }
            this._retainedTextures = null;
            this._unretainedTextures = null;
            this._retainCounts = null;
            return;
        }

        public function addTexture(arg1:String, arg2:starling.textures.Texture, arg3:Boolean=true):void
        {
            if (!this._retainedTextures) 
            {
                throw new flash.errors.IllegalOperationError("Cannot add a texture after the cache has been disposed.");
            }
            if (arg1 in this._unretainedTextures || arg1 in this._retainedTextures) 
            {
                throw new ArgumentError("Key \"" + arg1 + "\" already exists in the cache.");
            }
            if (arg3) 
            {
                this._retainedTextures[arg1] = arg2;
                this._retainCounts[arg1] = 1 as int;
                return;
            }
            this._unretainedTextures[arg1] = arg2;
            this._unretainedKeys[this._unretainedKeys.length] = arg1;
            if (this._unretainedKeys.length > this._maxUnretainedTextures) 
            {
                this.trimCache();
            }
            return;
        }

        public function removeTexture(arg1:String, arg2:Boolean=false):void
        {
            if (!this._unretainedTextures) 
            {
                return;
            }
            var loc1:*=this._unretainedTextures[arg1] as starling.textures.Texture;
            if (loc1) 
            {
                this.removeUnretainedKey(arg1);
            }
            else 
            {
                loc1 = this._retainedTextures[arg1] as starling.textures.Texture;
                delete this._retainedTextures[arg1];
                delete this._retainCounts[arg1];
            }
            if (arg2 && loc1) 
            {
                loc1.dispose();
            }
            return;
        }

        public function hasTexture(arg1:String):Boolean
        {
            if (!this._retainedTextures) 
            {
                return false;
            }
            return arg1 in this._retainedTextures || arg1 in this._unretainedTextures;
        }

        public function getRetainCount(arg1:String):int
        {
            if (this._retainCounts && arg1 in this._retainCounts) 
            {
                return this._retainCounts[arg1] as int;
            }
            return 0;
        }

        public function retainTexture(arg1:String):starling.textures.Texture
        {
            var loc2:*=0;
            if (!this._retainedTextures) 
            {
                throw new flash.errors.IllegalOperationError("Cannot retain a texture after the cache has been disposed.");
            }
            if (arg1 in this._retainedTextures) 
            {
                loc2 = this._retainCounts[arg1] as int;
                ++loc2;
                this._retainCounts[arg1] = loc2;
                return starling.textures.Texture(this._retainedTextures[arg1]);
            }
            if (!(arg1 in this._unretainedTextures)) 
            {
                throw new ArgumentError("Texture with key \"" + arg1 + "\" cannot be retained because it has not been added to the cache.");
            }
            var loc1:*=starling.textures.Texture(this._unretainedTextures[arg1]);
            this.removeUnretainedKey(arg1);
            this._retainedTextures[arg1] = loc1;
            this._retainCounts[arg1] = 1 as int;
            return loc1;
        }

        public function releaseTexture(arg1:String):void
        {
            var loc2:*=null;
            if (!this._retainedTextures || !(arg1 in this._retainedTextures)) 
            {
                return;
            }
            var loc1:*=this._retainCounts[arg1] as int;
            --loc1;
            if (loc1 !== 0) 
            {
                this._retainCounts[arg1] = loc1;
            }
            else 
            {
                loc2 = starling.textures.Texture(this._retainedTextures[arg1]);
                delete this._retainCounts[arg1];
                delete this._retainedTextures[arg1];
                this._unretainedTextures[arg1] = loc2;
                this._unretainedKeys[this._unretainedKeys.length] = arg1;
                if (this._unretainedKeys.length > this._maxUnretainedTextures) 
                {
                    this.trimCache();
                }
            }
            return;
        }

        protected function removeUnretainedKey(arg1:String):void
        {
            var loc1:*=this._unretainedKeys.indexOf(arg1);
            if (loc1 < 0) 
            {
                return;
            }
            this._unretainedKeys.removeAt(loc1);
            delete this._unretainedTextures[arg1];
            return;
        }

        protected function trimCache():void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=this._unretainedKeys.length;
            var loc2:*=this._maxUnretainedTextures;
            while (loc1 > loc2) 
            {
                loc3 = this._unretainedKeys.shift();
                loc4 = starling.textures.Texture(this._unretainedTextures[loc3]);
                loc4.dispose();
                delete this._unretainedTextures[loc3];
                --loc1;
            }
            return;
        }

        protected var _unretainedKeys:__AS3__.vec.Vector.<String>;

        protected var _unretainedTextures:Object;

        protected var _retainedTextures:Object;

        protected var _retainCounts:Object;

        protected var _maxUnretainedTextures:int;
    }
}


