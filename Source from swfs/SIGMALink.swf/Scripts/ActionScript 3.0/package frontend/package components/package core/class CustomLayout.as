//class CustomLayout
package frontend.components.core 
{
    import feathers.controls.*;
    
    public class CustomLayout extends Object
    {
        public function CustomLayout(arg1:feathers.controls.LayoutGroup)
        {
            super();
            this._control = arg1;
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set gap(arg1:Number):void
        {
            this._gap = arg1;
            this.setLayoutProp("gap", arg1);
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            this._horizontalAlign = arg1;
            this.setLayoutProp("horizontalAlign", arg1);
            return;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
            return;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            this._paddingBottom = arg1;
            this.setLayoutProp("paddingBottom", arg1);
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            this._paddingLeft = arg1;
            this.setLayoutProp("paddingLeft", arg1);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function set paddingRight(arg1:Number):void
        {
            this._paddingRight = arg1;
            this.setLayoutProp("paddingRight", arg1);
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            this._paddingTop = arg1;
            this.setLayoutProp("paddingTop", arg1);
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            this._verticalAlign = arg1;
            this.setLayoutProp("verticalAlign", arg1);
            return;
        }

        protected function setLayoutProp(arg1:String, arg2:*):void
        {
            if (this._control.layout && Object(this._control.layout).hasOwnProperty(arg1) && (arg2 is Number && !isNaN(arg2) || arg2 is String && !(arg2 == ""))) 
            {
                this._control.layout[arg1] = arg2;
            }
            return;
        }

        internal var _gap:Number=NaN;

        internal var _horizontalAlign:String;

        internal var _paddingBottom:Number=NaN;

        internal var _paddingLeft:Number=NaN;

        internal var _paddingRight:Number=NaN;

        internal var _paddingTop:Number=NaN;

        internal var _verticalAlign:String;

        internal var _control:feathers.controls.LayoutGroup;
    }
}


