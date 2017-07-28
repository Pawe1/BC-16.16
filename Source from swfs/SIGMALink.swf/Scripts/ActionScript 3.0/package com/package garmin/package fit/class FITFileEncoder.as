//class FITFileEncoder
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    
    public class FITFileEncoder extends flash.events.EventDispatcher implements com.garmin.fit.MesgListener, com.garmin.fit.MesgDefinitionListener
    {
        public function FITFileEncoder(arg1:flash.filesystem.File=null)
        {
            lastMesgDefinition = new __AS3__.vec.Vector.<com.garmin.fit.MesgDefinition>(16, false);
            super(null);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (arg1 != null) 
            {
                open(arg1);
            }
            return;
        }

        public function open(arg1:flash.filesystem.File):void
        {
            var loc1:*=null;
            var loc2:*=null;
            try 
            {
                if (arg1.exists) 
                {
                    arg1.deleteFile();
                }
                this.file = arg1;
                writeFileHeader();
            }
            catch (e:flash.errors.IOError)
            {
                loc1 = "IOError - The directory does not exist, or the directory could not be deleted. On Windows, you cannot delete a directory that contains a file that is open.";
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1800000, "FitEncoding: " + e.message));
            }
            catch (e:SecurityError)
            {
                loc2 = "SecurityError - The application does not have the necessary permissions to delete the directory.";
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1800000, "FitEncoding: " + e.message));
            }
            return;
        }

        internal function writeFileHeader():void
        {
            var loc4:*=0;
            if (file == null) 
            {
                throw new com.garmin.fit.FitRuntimeException("File not open.");
            }
            stream = new flash.filesystem.FileStream();
            stream.open(file, "update");
            var loc3:*=file.size - 14;
            var loc1:*=0;
            var loc2:*=0;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            loc4 = 0;
            while (loc4 < 14 - 2) 
            {
            };
            stream.writeByte(loc2 & 255);
            stream.writeByte(loc2 >> 8 & 255);
            return;
        }

        public function onMesg(arg1:*):void
        {
            write(arg1 as com.garmin.fit.Mesg);
            return;
        }

        public function onMesgDefinition(arg1:*):void
        {
            write(arg1 as com.garmin.fit.MesgDefinition);
            return;
        }

        public function write(arg1:*):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=undefined;
            if (arg1 is com.garmin.fit.MesgDefinition) 
            {
                loc1 = arg1 as com.garmin.fit.MesgDefinition;
                if (file == null) 
                {
                    throw new com.garmin.fit.FitRuntimeException("File not open.");
                }
                loc1.write(stream);
                lastMesgDefinition[loc1.localNum] = loc1;
            }
            else if (arg1 is com.garmin.fit.Mesg) 
            {
                loc3 = arg1 as com.garmin.fit.Mesg;
                if (file == null) 
                {
                    throw new com.garmin.fit.FitRuntimeException("File not open.");
                }
                if (lastMesgDefinition[loc3.localNum] == null || !lastMesgDefinition[loc3.localNum].supports(loc3)) 
                {
                    write(new com.garmin.fit.MesgDefinition(loc3));
                }
                loc3.write(stream, lastMesgDefinition[loc3.localNum]);
            }
            else if (arg1 is __AS3__.vec.Vector.<com.garmin.fit.Mesg>) 
            {
                loc2 = arg1 as __AS3__.vec.Vector.<com.garmin.fit.Mesg>;
                var loc6:*=0;
                var loc5:*=loc2;
                for each (var loc4:* in loc5) 
                {
                    write(loc4);
                }
            }
            else 
            {
                throw new com.garmin.fit.FitRuntimeException("Portierungsfehler");
            }
            return;
        }

        public function close():void
        {
            if (file == null) 
            {
                throw new com.garmin.fit.FitRuntimeException("File not open.");
            }
            stream.close();
            writeFileHeader();
            stream.close();
            var loc1:*=0;
            stream = new flash.filesystem.FileStream();
            stream.open(file, "update");
            while (stream.bytesAvailable > 0) 
            {
                loc1 = com.garmin.fit.CRC.get16(loc1, stream.readByte());
            }
            stream.writeByte(loc1 & 255);
            stream.writeByte(loc1 >> 8 & 255);
            this.stream.close();
            this.file = null;
            return;
        }

        internal var lastMesgDefinition:__AS3__.vec.Vector.<com.garmin.fit.MesgDefinition>;

        internal var file:flash.filesystem.File;

        internal var stream:flash.filesystem.FileStream;
    }
}


