//class Textures
package frontend 
{
    import core.general.*;
    import core.sport.*;
    import flash.utils.*;
    
    public class Textures extends Object
    {
        public function Textures()
        {
            super();
            return;
        }

        
        {
            sportTextures = new flash.utils.Dictionary();
            sportTexturesBig = new flash.utils.Dictionary();
            unitTextures = new flash.utils.Dictionary();
        }

        public static function init():void
        {
            sportTextures[core.sport.Sport.ACTIVITY_TRACKER] = sportTypeAct;
            sportTextures[core.sport.Sport.BMX] = sportTypeBmx;
            sportTextures[core.sport.Sport.CYCLECROSS] = sportTypeCyx;
            sportTextures[core.sport.Sport.CYCLING] = sportTypeCyc;
            sportTextures[core.sport.Sport.EBIKE] = sportTypeEbi;
            sportTextures[core.sport.Sport.ENDURO] = sportTypeEdo;
            sportTextures[core.sport.Sport.FITNESS] = sportTypeFit;
            sportTextures[core.sport.Sport.GOLF] = sportTypeGlf;
            sportTextures[core.sport.Sport.HIKING] = sportTypeHik;
            sportTextures[core.sport.Sport.INDOOR_CYCLING] = sportTypeIcy;
            sportTextures[core.sport.Sport.INLINE_SKATES] = sportTypeIls;
            sportTextures[core.sport.Sport.MOUNTAINBIKE] = sportTypeMtb;
            sportTextures[core.sport.Sport.OTHER] = sportTypeOth;
            sportTextures[core.sport.Sport.RACING_BYCICLE] = sportTypeRcb;
            sportTextures[core.sport.Sport.RUNNING] = sportTypeRun;
            sportTextures[core.sport.Sport.SKI] = sportTypeSki;
            sportTextures[core.sport.Sport.SNOWBOARDING] = sportTypeSnb;
            sportTextures[core.sport.Sport.SWIMMING] = sportTypeSwm;
            sportTextures[core.sport.Sport.TREADMILL] = sportTypeTrm;
            sportTextures[core.sport.Sport.TRIATHLON] = sportTypeTri;
            sportTextures[core.sport.Sport.WALKING] = sportTypeWlk;
            sportTexturesBig[core.sport.Sport.ACTIVITY_TRACKER] = sportTypeBigAct;
            sportTexturesBig[core.sport.Sport.BMX] = sportTypeBigBmx;
            sportTexturesBig[core.sport.Sport.CYCLECROSS] = sportTypeBigCyx;
            sportTexturesBig[core.sport.Sport.CYCLING] = sportTypeBigCyc;
            sportTexturesBig[core.sport.Sport.EBIKE] = sportTypeBigEbi;
            sportTexturesBig[core.sport.Sport.ENDURO] = sportTypeBigEdo;
            sportTexturesBig[core.sport.Sport.FITNESS] = sportTypeBigFit;
            sportTexturesBig[core.sport.Sport.GOLF] = sportTypeBigGlf;
            sportTexturesBig[core.sport.Sport.HIKING] = sportTypeBigHik;
            sportTexturesBig[core.sport.Sport.INDOOR_CYCLING] = sportTypeBigIcy;
            sportTexturesBig[core.sport.Sport.INLINE_SKATES] = sportTypeBigIls;
            sportTexturesBig[core.sport.Sport.MOUNTAINBIKE] = sportTypeBigMtb;
            sportTexturesBig[core.sport.Sport.OTHER] = sportTypeBigOth;
            sportTexturesBig[core.sport.Sport.RACING_BYCICLE] = sportTypeBigRcb;
            sportTexturesBig[core.sport.Sport.RUNNING] = sportTypeBigRun;
            sportTexturesBig[core.sport.Sport.SKI] = sportTypeBigSki;
            sportTexturesBig[core.sport.Sport.SNOWBOARDING] = sportTypeBigSnb;
            sportTexturesBig[core.sport.Sport.SWIMMING] = sportTypeBigSwm;
            sportTexturesBig[core.sport.Sport.TREADMILL] = sportTypeBigTrm;
            sportTexturesBig[core.sport.Sport.TRIATHLON] = sportTypeBigTri;
            sportTexturesBig[core.sport.Sport.WALKING] = sportTypeBigWlk;
            unitTextures[core.general.UnitType.BC1009] = device_bc1009;
            unitTextures[core.general.UnitType.BC1009STS] = device_bc1009sts;
            unitTextures[core.general.UnitType.BC1212] = device_bc1212;
            unitTextures[core.general.UnitType.BC1212STS] = device_bc1212sts;
            unitTextures[core.general.UnitType.BC1412] = device_bc1412;
            unitTextures[core.general.UnitType.BC1416] = device_bc1416;
            unitTextures[core.general.UnitType.BC1416STS] = device_bc1416sts;
            unitTextures[core.general.UnitType.BC1609] = device_bc1609;
            unitTextures[core.general.UnitType.BC1609STS] = device_bc1609sts;
            unitTextures[core.general.UnitType.BC1612] = device_bc1612;
            unitTextures[core.general.UnitType.BC1612STS] = device_bc1612sts;
            unitTextures[core.general.UnitType.BC1616] = device_bc1616;
            unitTextures[core.general.UnitType.BC1616STS] = device_bc1616sts;
            unitTextures[core.general.UnitType.BC1909HR] = device_bc1909hr;
            unitTextures[core.general.UnitType.BC2209MHR] = device_bc2209mhr;
            unitTextures[core.general.UnitType.BC2316STS] = device_bc2316sts;
            unitTextures[core.general.UnitType.BC509] = device_bc509;
            unitTextures[core.general.UnitType.BC512] = device_bc512;
            unitTextures[core.general.UnitType.BC516] = device_bc516;
            unitTextures[core.general.UnitType.BC716] = device_bc716;
            unitTextures[core.general.UnitType.BC716ATS] = device_bc716ats;
            unitTextures[core.general.UnitType.BC812] = device_bc812;
            unitTextures[core.general.UnitType.BC812W] = device_bc812ats;
            unitTextures[core.general.UnitType.BC916] = device_bc916;
            unitTextures[core.general.UnitType.BC916ATS] = device_bc916ats;
            unitTextures[core.general.UnitType.PC2814] = device_rcmove;
            unitTextures[core.general.UnitType.RC1209] = device_rc1209;
            unitTextures[core.general.UnitType.RC1411] = device_rc1411;
            unitTextures[core.general.UnitType.ROX100] = device_rox100gps;
            unitTextures[core.general.UnitType.ROX110] = device_roxgps110;
            unitTextures[core.general.UnitType.ROX50] = device_rox50;
            unitTextures[core.general.UnitType.ROX60] = device_rox60;
            unitTextures[core.general.UnitType.ROX70] = device_roxgps70;
            unitTextures[core.general.UnitType.ROX8] = device_rox8;
            unitTextures[core.general.UnitType.ROX80] = device_rox80;
            unitTextures[core.general.UnitType.ROX81] = device_rox81;
            unitTextures[core.general.UnitType.ROX9] = device_rox9;
            unitTextures[core.general.UnitType.ROX90] = device_rox90;
            unitTextures[core.general.UnitType.ROX91] = device_rox91;
            unitTextures[core.general.UnitType.GPS10] = device_gps10;
            unitTextures[core.general.UnitType.BC416] = device_pure1;
            unitTextures[core.general.UnitType.BC416ATS] = device_pure1ats;
            return;
        }

        public static function getUnitTexture(arg1:core.general.UnitType):String
        {
            if (arg1 == null) 
            {
                return device_unknown;
            }
            if (unitTextures[arg1]) 
            {
                return unitTextures[arg1];
            }
            return device_unknown;
        }

        public static function sportTextureByKeyName(arg1:String, arg2:Boolean=false):String
        {
            var loc1:*="";
            if (arg2) 
            {
                if (sportTextures.hasOwnProperty(arg1)) 
                {
                    loc1 = sportTextures[arg1];
                }
            }
            else if (sportTexturesBig.hasOwnProperty(arg1)) 
            {
                loc1 = sportTexturesBig[arg1];
            }
            return loc1;
        }

        public static const addiconwhite:String="addiconwhite";

        public static const aktivitaeten:String="aktivitaeten";

        public static const appIcon:String="appIcon";

        public static const arrowRight:String="arrowRight";

        public static const attentionbig:String="attentionbig";

        public static const autoLapBubble:String="autolapbubble";

        public static const averagedownhillsmall:String="averagedownhillsmall";

        public static const averageiconmini:String="averageiconmini";

        public static const averageuphillsmall:String="averageuphillsmall";

        public static const backbutton:String="backbutton";

        public static const bergab:String="bergab";

        public static const bergauf:String="bergauf";

        public static const bergaufab:String="bergaufab";

        public static const bgCloud:String="bgCloud";

        public static const bgDashboard:String="bgDashboard";

        public static const bgDatabaseUpdate:String="bgDatabaseUpate";

        public static const bigok:String="bigok";

        public static const cadenceicon:String="cadenceicon";

        public static const calendericon:String="calendericon";

        public static const closeicon:String="closeicon";

        public static const closeiconred:String="closeiconred";

        public static const cloudViewShape:String="cloudViewShape";

        public static const cloudiconred:String="cloudiconred";

        public static const cloudiconwhite:String="cloudiconwhite";

        public static const connectble:String="connectble";

        public static const connectds:String="connectds";

        public static const connectnfc:String="connectnfc";

        public static const connectnfcds:String="connectnfcds";

        public static const connectnfcusb:String="connectnfcusb";

        public static const connectred:String="connectred";

        public static const connectusb:String="connectusb";

        public static const connectusbble:String="connectusbble";

        public static const connectwhite:String="connectwhite";

        public static const dashboard:String="dashboard";

        public static const dashboardbigactivity:String="activityIcon";

        public static const dashboardbigadddevice:String="dashboardbigadddevice";

        public static const dashboardbigdevices:String="dashboardbigdevices";

        public static const dashboardbigimport:String="dashboardbigimport";

        public static const dashboardbigstatistik:String="dashboardbigstatistik";

        public static const dashboardbigtopvalues:String="dashboardbigtopvalues";

        public static const dashboardbigtracks:String="dashboardbigtracks";

        public static const dashboardsmallcount:String="dashboardsmallcount";

        public static const dashboardsmalldistance:String="dashboardsmalldistance";

        public static const dashboardsmallkcal:String="dashboardsmallkcal";

        public static const dashboardsmalltime:String="dashboardsmalltime";

        public static const device_bc1009:String="bc1009";

        public static const device_bc1009sts:String="bc1009sts";

        public static const device_bc1212:String="bc1212";

        public static const device_bc1212sts:String="bc1212sts";

        public static const device_bc1412:String="bc1412";

        public static const device_bc1416:String="bc1416";

        public static const device_bc1416sts:String="bc1416sts";

        public static const device_bc1609:String="bc1609";

        public static const device_bc1609sts:String="bc1609sts";

        public static const device_bc1612:String="bc1612";

        public static const device_bc1612sts:String="bc1612sts";

        public static const device_bc1616:String="bc1616";

        public static const device_bc1616sts:String="bc1616sts";

        public static const device_bc1909hr:String="bc1909hr";

        public static const device_bc2209mhr:String="bc2209mhr";

        public static const device_bc2316sts:String="bc2316sts";

        public static const device_bc509:String="bc509";

        public static const device_bc512:String="bc512";

        public static const device_bc516:String="bc516";

        public static const device_bc716:String="bc716";

        public static const device_bc716ats:String="bc716ats";

        public static const device_bc812:String="bc812";

        public static const device_bc812ats:String="bc812ats";

        public static const device_bc916:String="bc916";

        public static const device_bc916ats:String="bc916ats";

        public static const device_gps10:String="gps10";

        public static const device_pure1:String="pure1";

        public static const device_pure1ats:String="pure1ats";

        public static const device_rc1209:String="rc1209";

        public static const device_rc1411:String="rc1411";

        public static const device_rcmove:String="rcmove";

        public static const device_rox100gps:String="rox100gps";

        public static const device_rox50:String="rox50";

        public static const device_rox60:String="rox60";

        public static const device_rox8:String="rox8";

        public static const device_rox80:String="rox80";

        public static const device_rox81:String="rox81";

        public static const device_rox9:String="rox9";

        public static const device_rox90:String="rox90";

        public static const device_rox91:String="rox91";

        public static const device_roxgps110:String="roxgps110";

        public static const device_roxgps70:String="roxgps70";

        public static const device_unknown:String="unknown";

        public static const devicesettingsiconred:String="devicesettingsiconred";

        public static const devicesred:String="devicesred";

        public static const deviceswhite:String="deviceswhite";

        public static const downloadbutton:String="downloadbutton";

        public static const downloadiconred:String="downloadiconred";

        public static const editbutton:String="editbutton";

        public static const focusTrackButton:String="focusTrackButton";

        public static const fuelicon:String="fuelicon";

        public static const ghostIcon:String="ghostIcon";

        public static const graphicon:String="graphicon";

        public static const hakenicongreen:String="hakenicongreen";

        public static const heartrateicon:String="heartrateicon";

        public static const hohenmeter:String="hohenmeter";

        public static const icondown:String="icondown";

        public static const iconstarblacksmall:String="iconstarblacksmall";

        public static const iconstarredsmall:String="iconstarredsmall";

        public static const iconstarredsmallempty:String="iconstarredsmallempty";

        public static const iconup:String="iconup";

        public static const infoIcon:String="InfoIcon";

        public static const infoLayerArrow:String="infoLayerArrow";

        public static const infoLayerBackground:String="infoLayerBackground";

        public static const infobuttonred:String="infobuttonred";

        public static const kcal:String="kcal";

        public static const kleinerpfeil:String="kleinerpfeil";

        public static const laengstezeit:String="laengstezeit";

        public static const lefticon:String="lefticon";

        public static const lefticonDisabled:String="lefticonDisabled";

        public static const linkIconWhite:String="linkIconWhite";

        public static const linkiconsmall:String="linkiconsmall";

        public static const locationSearchIcon:String="locationSearchIcon";

        public static const lockbutton:String="lockbutton";

        public static const logoutIcon:String="logoutIcon";

        public static const lupe:String="lupe";

        public static const lupe_white:String="lupe_white";

        public static const mapLayerButton:String="mapLayerButton";

        public static const mapPointEditIcon:String="mapPointEditIcon";

        public static const mapicon:String="mapicon";

        public static const maplapbubble:String="maplapbubble";

        public static const mapsicon:String="mapsicon";

        public static const mapsred:String="mapsred";

        public static const mapstarticon:String="mapstarticon";

        public static const mapstopicon:String="mapstopicon";

        public static const markerPopUpBackground:String="MarkerPopUpBackground";

        public static const menubutton:String="menubutton";

        public static const networkiconred:String="networkiconred";

        public static const noimage:String="noimage";

        public static const pageindicatorNormal:String="pageindicatorNormal";

        public static const pageindicatorSelected:String="pageindicatorSelected";

        public static const pfeilmitbg:String="pfeilmitbg";

        public static const pfeilrechts:String="pfeilrechts";

        public static const phaseDistanceIcon:String="phaseDistanceIcon";

        public static const phaseHeartrateIcon:String="phaseHeartrateIcon";

        public static const phaseTimeIcon:String="phaseTimeIcon";

        public static const phasenicon:String="phasenicon";

        public static const playbuttonbig:String="playbuttonbig";

        public static const pointNaviEditIcon:String="pointNaviEditIcon";

        public static const pointNavigationIcon:String="pointNavigationIcon";

        public static const powericon:String="powericon";

        public static const profileicon:String="profileicon";

        public static const profileiconred:String="profileiconred";

        public static const reloadicon:String="reloadicon";

        public static const righticon:String="righticon";

        public static const righticonDisabled:String="righticonDisabled";

        public static const satellitIcon:String="satellitIcon";

        public static const saveiconwhite:String="saveiconwhite";

        public static const searchEditorIcon:String="SearchEditorIcon";

        public static const settingsiconred:String="settingsiconred";

        public static const settingsiconwhite:String="settingsiconwhite";

        public static const shareFacebook:String="shareFacebook";

        public static const shareFacebookGrey:String="shareFacebookGrey";

        public static const shareStrava:String="shareStrava";

        public static const shareStravaGrey:String="shareStravaGrey";

        public static const shareTrainingPeaks:String="shareTrainingPeaks";

        public static const shareTrainingPeaksGrey:String="shareTrainingPeaksGrey";

        public static const shareTwitter:String="shareTwitter";

        public static const shareTwitterGrey:String="shareTwitterGrey";

        public static const shareTwoPeak:String="shareTwoPeak";

        public static const shareTwoPeakGrey:String="shareTwoPeakGrey";

        public static const sharedicon:String="sharedicon";

        public static const shareicon:String="shareicon";

        public static const shareiconred:String="shareiconred";

        public static const shoeiconred:String="shoeiconred";

        public static const sigmacloudlogo:String="sigmacloudlogo";

        public static const sigmacloudwhite:String="sigmacloudwhite";

        public static const sigmagermanylogowhite:String="sigmagermanylogowhite";

        public static const sigmaminiiconwhite:String="sigmaminiiconwhite";

        public static const sleepScreenIcon:String="sleepScreenIcon";

        public static const sortbutton:String="sortbutton";

        public static const sportTypeAct:String="sportTypeAct";

        public static const sportTypeBigAct:String="sportTypeBigAct";

        public static const sportTypeBigBmx:String="sportTypeBigBmx";

        public static const sportTypeBigCyc:String="sportTypeBigCyc";

        public static const sportTypeBigCyx:String="sportTypeBigCyx";

        public static const IconSpeed:String="IconSpeed";

        public static const sportTypeBigEdo:String="sportTypeBigEdo";

        public static const sportTypeBigFit:String="sportTypeBigFit";

        public static const sportTypeBigGlf:String="sportTypeBigGlf";

        public static const sportTypeBigHik:String="sportTypeBigHik";

        public static const sportTypeBigIcy:String="sportTypeBigIcy";

        public static const sportTypeBigIls:String="sportTypeBigIls";

        public static const sportTypeBigMtb:String="sportTypeBigMtb";

        public static const sportTypeBigOth:String="sportTypeBigOth";

        public static const sportTypeBigRcb:String="sportTypeBigRcb";

        public static const sportTypeBigRun:String="sportTypeBigRun";

        public static const sportTypeBigSki:String="sportTypeBigSki";

        public static const sportTypeBigSnb:String="sportTypeBigSnb";

        public static const sportTypeBigSwm:String="sportTypeBigSwm";

        public static const sportTypeBigTri:String="sportTypeBigTri";

        public static const sportTypeBigTrm:String="sportTypeBigTrm";

        public static const sportTypeBigWlk:String="sportTypeBigWlk";

        public static const sportTypeBmx:String="sportTypeBmx";

        public static const sportTypeCyc:String="sportTypeCyc";

        public static const sportTypeCyx:String="sportTypeCyx";

        public static const sportTypeEbi:String="sportTypeEbi";

        public static const sportTypeEdo:String="sportTypeEdo";

        public static const sportTypeFit:String="sportTypeFit";

        public static const sportTypeGlf:String="sportTypeGlf";

        public static const sportTypeHik:String="sportTypeHik";

        public static const sportTypeIcy:String="sportTypeIcy";

        public static const sportTypeIls:String="sportTypeIls";

        public static const sportTypeMtb:String="sportTypeMtb";

        public static const sportTypeOth:String="sportTypeOth";

        public static const sportTypeRcb:String="sportTypeRcb";

        public static const sportTypeRun:String="sportTypeRun";

        public static const sportTypeBigEbi:String="sportTypeBigEbi";

        public static const sportTypeSnb:String="sportTypeSnb";

        public static const sportTypeSwm:String="sportTypeSwm";

        public static const sportTypeTri:String="sportTypeTri";

        public static const sportTypeTrm:String="sportTypeTrm";

        public static const sportTypeWlk:String="sportTypeWlk";

        public static const sportprofileTemplate:String="sportprofileTemplate";

        public static const statsiconwhite:String="statsiconwhite";

        public static const strava:String="strava";

        public static const strecke:String="strecke";

        public static const streckesmall:String="streckesmall";

        public static const temperatureicon:String="temperatureicon";

        public static const toggleoff:String="toggleoff";

        public static const toggleon:String="toggleon";

        public static const topvaluesiconwhite:String="topvaluesiconwhite";

        public static const trackred:String="trackred";

        public static const trackwhite:String="trackwhite";

        public static const trainingsprogrammeiconred:String="activityIconSmall";

        public static const trashicon:String="trashicon";

        public static const uhr:String="uhr";

        public static const unlockbutton:String="unlockButton";

        public static const uploadicon:String="uploadButton";

        public static const uploadiconRed:String="uploadButtonRed";

        public static const values1icon:String="values1icon";

        public static const videoicon:String="videoicon";

        public static const videoiconwhite:String="videoiconwhite";

        public static const whiteshareicon:String="whiteshareicon";

        public static const InitialStartCircleBackground:String="InitialStartCircleBackground";

        public static const InitialStartCircleForeground:String="InitialStartCircleForeground";

        public static const InitialStartRectBackground:String="InitialStartRectBackground";

        public static const sportTypeSki:String="sportTypeSki";

        public static var unitTextures:flash.utils.Dictionary;

        public static var sportTextures:flash.utils.Dictionary;

        public static var sportTexturesBig:flash.utils.Dictionary;
    }
}


