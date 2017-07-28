//class ITrackList
package core.units.interfaces 
{
    import init.interfaces.*;
    
    public dynamic interface ITrackList
    {
        function get loadedTracks():init.interfaces.IVectorList;

        function set loadedTracks(arg1:init.interfaces.IVectorList):void;

        function get trackList():init.interfaces.IVectorList;

        function set trackList(arg1:init.interfaces.IVectorList):void;
    }
}


