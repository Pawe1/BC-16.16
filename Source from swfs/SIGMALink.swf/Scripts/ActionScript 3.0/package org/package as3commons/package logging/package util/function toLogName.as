//function toLogName
package org.as3commons.logging.util 
{
    import flash.utils.*;
    
    public function toLogName(arg1:*=null):String
    {
        if (arg1 == null) 
        {
            return arg1;
        }
        return flash.utils.getQualifiedClassName(arg1).replace("::", ".");
    }
}


