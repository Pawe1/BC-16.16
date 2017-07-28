//function getLogger
package org.as3commons.logging.api 
{
    import org.as3commons.logging.util.*;
    
    public function getLogger(arg1:*=null, arg2:String=null):org.as3commons.logging.api.ILogger
    {
        if (arg1 && !(arg1 is String)) 
        {
            arg1 = org.as3commons.logging.util.toLogName(arg1);
        }
        return org.as3commons.logging.api.LOGGER_FACTORY.getNamedLogger(arg1, arg2);
    }
}


