//class SportprofilesFavsetItemFunctionItemRenderer
package frontend.screen.mydevices.sportprofiles.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    
    public class SportprofilesFavsetItemFunctionItemRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function SportprofilesFavsetItemFunctionItemRenderer()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            padding = 20 * SIGMALink.scaleFactor;
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._selectImage = new frontend.components.TextureImage();
            this._selectImage.textureName = frontend.Textures.pfeilmitbg;
            this._selectImage.touchable = false;
            this._selectImage.layoutData = new feathers.layout.AnchorLayoutData(NaN, padding, NaN, NaN, NaN, 0);
            this._group.addChild(this._selectImage);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding, NaN, 0);
            this._group.addChild(this._name);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            this._name.text = this.functionListItem().favFunction.functionLabel;
            this._name.width = width - this._selectImage.width - 3 * padding;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        internal function functionListItem():frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem
        {
            if (data is frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem) 
            {
                return data as frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem;
            }
            return new frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem();
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _name:feathers.controls.Label;

        internal var _selectImage:frontend.components.TextureImage;
    }
}


