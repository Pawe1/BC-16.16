//class BacklightLevelDataProvider
package backend.utils.dataprovider 
{
    import core.settings.interfaces.*;
    import feathers.data.*;
    
    public class BacklightLevelDataProvider extends Object
    {
        public function BacklightLevelDataProvider()
        {
            super();
            return;
        }

        public static function generateDataProvider(arg1:core.settings.interfaces.IBacklightLevel):feathers.data.ListCollection
        {
            var loc1:*=arg1.backlightLevelMin;
            var loc2:*=arg1.backlightLevelMax;
            var loc3:*=0;
            var loc4:*=new feathers.data.ListCollection();
            loc3 = loc1;
            while (loc3 <= loc2) 
            {
                loc4.addItem({"label":loc3 + "", "data":loc3});
                ++loc3;
            }
            return loc4;
        }
    }
}


