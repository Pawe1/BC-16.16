//class ActivityPhaseListGroup
package frontend.screen.activities.tabs.phases 
{
    import backend.utils.*;
    import core.general.*;
    import core.marker.*;
    import debug.*;
    import frontend.*;
    
    public class ActivityPhaseListGroup extends Object
    {
        public function ActivityPhaseListGroup()
        {
            this.children = new Array();
            super();
            return;
        }

        public function addItem(arg1:core.marker.Marker):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (arg1) 
            {
                loc2 = this.children.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if ((this.children[loc1] as core.marker.Marker).markerId == arg1.markerId) 
                    {
                        return;
                    }
                    ++loc1;
                }
                this.children.push(arg1);
                debug.Debug.debug(arg1.type);
                if (arg1.type == core.general.MarkerType.INTERVAL_PHASE) 
                {
                    return;
                }
                this.footer = new frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter();
                if (arg1.plannedDistanceDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseDistanceIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(arg1.plannedDistance));
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringDistance;
                }
                else if (arg1.plannedRecoveryDistanceDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseDistanceIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(arg1.plannedRecoveryDistance));
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringDistance;
                }
                else if (arg1.plannedTimeDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseTimeIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.timeFormatterHHMMSST.format(arg1.plannedTime);
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringTimeHours;
                }
                else if (arg1.plannedRecoveryTimeDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseTimeIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.timeFormatterHHMMSST.format(arg1.plannedRecoveryTime);
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringTimeHours;
                }
                else 
                {
                    this.footer.plan1Icon = "";
                    this.footer.plan1Value = "--:--";
                    this.footer.plan1Unit = "";
                }
                loc3 = "";
                if (arg1.plannedLowerLimitDefined || arg1.plannedUpperLimitDefined) 
                {
                    if (arg1.plannedLowerLimitDefined) 
                    {
                        loc3 = loc3 + arg1.plannedLowerLimit.toString();
                    }
                    if (arg1.plannedUpperLimitDefined) 
                    {
                        loc3 = loc3 + (loc3.length != 0 ? "-" + arg1.plannedUpperLimit.toString() : arg1.plannedUpperLimit.toString());
                    }
                }
                else 
                {
                    if (arg1.plannedRecoveryLowerLimitDefined) 
                    {
                        loc3 = loc3 + arg1.plannedRecoveryLowerLimit.toString();
                    }
                    if (arg1.plannedRecoveryUpperLimitDefined) 
                    {
                        loc3 = loc3 + (loc3.length != 0 ? "-" + arg1.plannedRecoveryUpperLimit.toString() : arg1.plannedRecoveryUpperLimit.toString());
                    }
                }
                if (loc3.length > 0) 
                {
                    this.footer.plan2Icon = frontend.Textures.phaseHeartrateIcon;
                    this.footer.plan2Value = loc3;
                }
            }
            return;
        }

        public var children:Array;

        public var footer:frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter;
    }
}


