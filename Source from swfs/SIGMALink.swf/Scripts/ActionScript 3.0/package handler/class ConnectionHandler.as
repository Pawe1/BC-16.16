//class ConnectionHandler
package handler 
{
    import de.pagecon.ane.networkInfo.*;
    import frontend.components.popup.*;
    import utils.*;
    
    public class ConnectionHandler extends Object
    {
        public function ConnectionHandler()
        {
            super();
            return;
        }

        public static function checkNoInternetPopUp():Boolean
        {
            var loc1:*=null;
            if (!de.pagecon.ane.networkInfo.AirNetworkInfo.networkInfo.isConnected()) 
            {
                loc1 = new frontend.components.popup.InfoPopUp(true, false, onInfoPopUpOk);
                loc1.headline = utils.LanguageManager.getString("INFOPOPUP.NOINTERNET_HEADLINE");
                loc1.text = utils.LanguageManager.getString("INFOPOPUP.NOINTERNET_TEXT");
                loc1.show(true, true, true, true);
                return false;
            }
            return true;
        }

        internal static function onInfoPopUpOk(arg1:frontend.components.popup.InfoPopUp):void
        {
            arg1.close();
            return;
        }
    }
}


