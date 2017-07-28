//class ListStateHandler
package frontend.components.list 
{
    import feathers.controls.*;
    import feathers.events.*;
    import starling.events.*;
    
    public class ListStateHandler extends starling.events.EventDispatcher
    {
        public function ListStateHandler(arg1:feathers.controls.Scroller)
        {
            super();
            this._currentListState = frontend.components.list.SelectableListEvent.STATE_NORMAL;
            this._multiStateList = arg1;
            return;
        }

        public function swapState():void
        {
            var loc2:*=this._currentListState;
            switch (loc2) 
            {
                case frontend.components.list.SelectableListEvent.STATE_SELECTABLE:
                {
                    this._currentListState = frontend.components.list.SelectableListEvent.STATE_NORMAL;
                    this.editState = false;
                    break;
                }
                case frontend.components.list.SelectableListEvent.STATE_NORMAL:
                {
                    this._currentListState = frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
                    this.editState = true;
                    break;
                }
            }
            frontend.components.list.SelectableListItem.reset();
            var loc1:*=new frontend.components.list.SelectableListEvent(frontend.components.list.SelectableListEvent.CHANGE_STATE, this._currentListState);
            this.onListStateChanged(loc1);
            return;
        }

        public function setNormalState():void
        {
            this._currentListState = frontend.components.list.SelectableListEvent.STATE_NORMAL;
            this.editState = false;
            frontend.components.list.SelectableListItem.reset();
            var loc1:*=new frontend.components.list.SelectableListEvent(frontend.components.list.SelectableListEvent.CHANGE_STATE, this._currentListState);
            this.onListStateChanged(loc1);
            return;
        }

        protected function onListStateChanged(arg1:frontend.components.list.SelectableListEvent):void
        {
            if (this._multiStateList) 
            {
                this._multiStateList.dispatchEvent(arg1);
            }
            return;
        }

        public function get editState():Boolean
        {
            return this._1877107545editState;
        }

        public function set editState(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1877107545editState;
            if (loc1 !== arg1) 
            {
                this._1877107545editState = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editState", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal var _1877107545editState:Boolean=false;

        protected var _currentListState:String;

        protected var _multiStateList:feathers.controls.Scroller;
    }
}


