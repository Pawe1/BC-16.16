//class MapSearchResult
package service.openstreetmap 
{
    public class MapSearchResult extends Object
    {
        public function MapSearchResult()
        {
            super();
            return;
        }

        public var city:String=null;

        public var confidence:String=null;

        public var country:String=null;

        public var formattedAddress:String=null;

        public var houseNumber:String="";

        public var latitude:Number;

        public var longitude:Number;

        public var name:String=null;

        public var postalCode:String=null;

        public var precision:Number=-1;

        public var road:String=null;

        public var state:String=null;

        public var town:String=null;

        public var village:String=null;
    }
}


