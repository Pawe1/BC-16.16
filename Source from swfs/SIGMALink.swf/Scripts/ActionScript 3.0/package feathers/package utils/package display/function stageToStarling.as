//function stageToStarling
package feathers.utils.display 
{
    import starling.core.*;
    import starling.display.*;
    
    public function stageToStarling(arg1:starling.display.Stage):starling.core.Starling
    {
        var loc1:*=null;
        var loc2:*=0;
        var loc3:*=starling.core.Starling.all;
        for each (loc1 in loc3) 
        {
            if (loc1.stage !== arg1) 
            {
                continue;
            }
            return loc1;
        }
        return null;
    }
}


