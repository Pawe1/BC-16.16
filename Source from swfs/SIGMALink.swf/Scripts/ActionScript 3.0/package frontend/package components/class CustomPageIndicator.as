//class CustomPageIndicator
package frontend.components 
{
    import feathers.controls.*;
    import frontend.*;
    
    public class CustomPageIndicator extends feathers.controls.PageIndicator
    {
        public function CustomPageIndicator()
        {
            var loc1:*;
            super();
            with ({}) 
            {
            };
            
#error('pushwith') {}
            .selectedSymbolFactory = 
#error('pushwith') {}
            .selectedSymbolFactory = function ():frontend.components.TextureImage
            {
                var loc1:*=new frontend.components.TextureImage();
                loc1.textureName = frontend.Textures.pageindicatorSelected;
                return loc1;
            }
            with ({}) 
            {
            };
            
#error('pushwith') {}
            .normalSymbolFactory = 
#error('pushwith') {}
            .normalSymbolFactory = function ():frontend.components.TextureImage
            {
                var loc1:*=new frontend.components.TextureImage();
                loc1.textureName = frontend.Textures.pageindicatorNormal;
                return loc1;
            }
            return;
        }
    }
}


