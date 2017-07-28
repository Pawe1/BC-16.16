//class RatingEditor
package frontend.components.menuList.editors 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.menuList.editors.base.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class RatingEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function RatingEditor()
        {
            this.editor = new feathers.controls.LayoutGroup();
            super();
            orientation = ORIENTATION_INLINE;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            frontend.components.menuList.editors.RatingEditor.drawContent(rawValue as int, this.editor, this.onRatingChanged);
            this.editor.width = editorWidth - 2 * padding;
            this.editor.height = minItemHeight;
            return this.editor;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            super.saveValue();
            return;
        }

        internal function onRatingChanged(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=(arg1.currentTarget as frontend.components.TextureImage).data as int;
            if (rawValue == 1 && loc1 == 1) 
            {
                rawValue = 0;
            }
            else 
            {
                rawValue = loc1;
            }
            frontend.components.menuList.editors.RatingEditor.drawContent(rawValue as int, this.editor, this.onRatingChanged);
            return;
        }

        public static function drawContent(arg1:int, arg2:feathers.controls.LayoutGroup=null, arg3:Function=null):starling.display.DisplayObject
        {
            var loc3:*=0;
            var loc5:*=null;
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = frontend.components.menuList.editors.base.EditorBase.gap;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            var loc2:*=arg2;
            if (loc2) 
            {
                loc2.removeChildren(0, -1, true);
            }
            else 
            {
                loc2 = new feathers.controls.LayoutGroup();
            }
            loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc2.layout = loc1;
            var loc4:*=5;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc5 = new frontend.components.TextureImage();
                loc5.touchGroup = true;
                loc5.data = loc3 + 1;
                loc5.textureName = arg1 >= loc5.data ? frontend.Textures.iconstarredsmall : frontend.Textures.iconstarredsmallempty;
                if (arg3 != null) 
                {
                    loc5.addEventListener(starling.events.TouchEvent.TOUCH, arg3);
                }
                loc2.addChild(loc5);
                ++loc3;
            }
            return loc2;
        }

        internal var editor:feathers.controls.LayoutGroup;
    }
}


