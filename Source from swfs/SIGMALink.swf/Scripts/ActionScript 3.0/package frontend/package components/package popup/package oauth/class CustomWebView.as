//class CustomWebView
package frontend.components.popup.oauth 
{
    import feathers.controls.*;
    import flash.geom.*;
    import flash.media.*;
    
    public class CustomWebView extends feathers.controls.WebView
    {
        public function CustomWebView()
        {
            super();
            createStageWebView();
            return;
        }

        public function getStageWebView():Object
        {
            return stageWebView;
        }

        public function setViewPort(arg1:feathers.controls.LayoutGroup):void
        {
            setSize(arg1.width, arg1.height);
            (this.getStageWebView() as flash.media.StageWebView).viewPort = new flash.geom.Rectangle(arg1.x, arg1.y, arg1.width, arg1.height);
            return;
        }
    }
}


