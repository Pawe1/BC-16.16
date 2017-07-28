//class CollectionEventType
package feathers.events 
{
    public class CollectionEventType extends Object
    {
        public function CollectionEventType()
        {
            super();
            return;
        }

        public static const RESET:String="reset";

        public static const ADD_ITEM:String="addItem";

        public static const REMOVE_ITEM:String="removeItem";

        public static const REPLACE_ITEM:String="replaceItem";

        public static const UPDATE_ITEM:String="updateItem";

        public static const UPDATE_ALL:String="updateAll";
    }
}


