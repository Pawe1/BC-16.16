//class IBackendInitializer
package init.interfaces 
{
    import core.user.interfaces.*;
    import utils.interfaces.*;
    
    public dynamic interface IBackendInitializer
    {
        function createDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter;

        function createAltitudeFormatter():utils.interfaces.ICustomFormatter;

        function createCaloriesFormatter():utils.interfaces.ICustomFormatterBase;

        function createDateFormatterMx():utils.interfaces.ICustomFormatter;

        function createDistanceFormatter():utils.interfaces.ICustomFormatter;

        function createHeartrateFormatter():utils.interfaces.ICustomFormatterBase;

        function createPowerFormatter():utils.interfaces.ICustomFormatterBase;

        function createSpeedFormatter():utils.interfaces.ICustomFormatter;

        function createSpeedTimeFormatter():utils.interfaces.ICustomTimeFormatter;

        function createTimeFormatterHHMM():utils.interfaces.ICustomTimeFormatter;

        function createTimeFormatter():utils.interfaces.ICustomTimeFormatter;

        function createCadenceFormatter():utils.interfaces.ICustomFormatterBase;

        function createInclineFormatter():utils.interfaces.ICustomFormatterBase;

        function createGhostDistanceDecoderFormatter():utils.interfaces.ICustomFormatterBase;

        function createVectorList(arg1:*=null):init.interfaces.IVectorList;

        function getSportHandler():init.interfaces.ISportHandler;

        function getUserhandler():core.user.interfaces.IUserHandler;
    }
}


