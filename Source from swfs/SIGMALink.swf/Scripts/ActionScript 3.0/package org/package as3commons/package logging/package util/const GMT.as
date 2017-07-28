//const GMT
package org.as3commons.logging.util 
{
    public const GMT:String=calculateGMT();
}


const calculateGMT:Function=function ():String
{
    var loc4:*=null;
    var loc1:*=new Date();
    var loc2:*=loc1.timezoneOffset;
    var loc3:*=loc2 / 60;
    if (loc2 <= 0) 
    {
        var loc5:*;
        loc4 = loc5 = "+";
        loc5;
        loc2 = loc5 = loc2 * -1;
        loc5;
        loc3 = loc5 = loc3 * -1;
        loc5;
    }
    else 
    {
        loc4 = loc5 = "-";
        loc5;
    }
    loc3 = loc5 = Math.floor(loc3);
    loc5;
    loc2 = loc5 = loc2 - loc3 * 60;
    loc5;
    return "GMT" + loc4 + (loc3 < 10 ? "0" + loc3 : loc3) + (loc2 < 10 ? "0" + loc2 : loc2);
}

