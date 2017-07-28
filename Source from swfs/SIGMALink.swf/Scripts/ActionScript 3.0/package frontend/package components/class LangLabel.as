//class LangLabel
package frontend.components 
{
    import feathers.controls.*;
    import utils.*;
    
    public class LangLabel extends feathers.controls.Label
    {
        public function LangLabel()
        {
            super();
            return;
        }

        public override function set text(arg1:String):void
        {
            if (this.useLanguageManager) 
            {
                super.text = utils.LanguageManager.getString(arg1);
            }
            else 
            {
                super.text = arg1;
            }
            return;
        }

        public var useLanguageManager:Boolean=true;
    }
}


