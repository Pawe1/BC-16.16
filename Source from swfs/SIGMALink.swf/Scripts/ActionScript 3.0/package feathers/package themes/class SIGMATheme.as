//class SIGMATheme
package feathers.themes 
{
    import flash.display.*;
    import starling.textures.*;
    
    public class SIGMATheme extends feathers.themes.CustomSIGMATheme
    {
        public function SIGMATheme(arg1:Boolean=true)
        {
            super(arg1);
            this.initialize();
            return;
        }

        protected override function initialize():void
        {
            this.initializeTextureAtlas();
            super.initialize();
            return;
        }

        protected function initializeTextureAtlas():void
        {
            var loc1:*=flash.display.Bitmap(new ATLAS_BITMAP()).bitmapData;
            var loc2:*=starling.textures.Texture.fromBitmapData(loc1, false);
            loc2.root.onRestore = this.atlasTexture_onRestore;
            loc1.dispose();
            this.atlas = new starling.textures.TextureAtlas(loc2, XML(new ATLAS_XML()));
            return;
        }

        protected function atlasTexture_onRestore():void
        {
            var loc1:*=flash.display.Bitmap(new ATLAS_BITMAP()).bitmapData;
            this.atlas.texture.root.uploadBitmapData(loc1);
            loc1.dispose();
            return;
        }

        protected static const ATLAS_BITMAP:Class=feathers.themes.SIGMATheme_ATLAS_BITMAP;

        protected static const ATLAS_XML:Class=feathers.themes.SIGMATheme_ATLAS_XML;
    }
}


