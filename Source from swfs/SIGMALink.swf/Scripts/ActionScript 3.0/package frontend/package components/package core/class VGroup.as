//class VGroup
package frontend.components.core 
{
    import feathers.layout.*;
    
    public class VGroup extends frontend.components.core.VHGroup
    {
        public function VGroup()
        {
            super();
            return;
        }

        protected override function initLayout():void
        {
            layout = new feathers.layout.VerticalLayout();
            return;
        }
    }
}


