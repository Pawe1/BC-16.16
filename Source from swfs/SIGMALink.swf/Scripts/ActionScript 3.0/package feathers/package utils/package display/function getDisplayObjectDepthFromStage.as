//function getDisplayObjectDepthFromStage
package feathers.utils.display 
{
    import starling.display.*;
    
    public function getDisplayObjectDepthFromStage(arg1:starling.display.DisplayObject):int
    {
        if (!arg1.stage) 
        {
            return -1;
        }
        var loc1:*=0;
        while (arg1.parent) 
        {
            arg1 = arg1.parent;
            ++loc1;
        }
        return loc1;
    }
}


