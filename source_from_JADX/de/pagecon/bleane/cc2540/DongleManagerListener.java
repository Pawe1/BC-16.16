package de.pagecon.bleane.cc2540;

import de.pagecon.bleane.extension.ManagerListener;

public interface DongleManagerListener extends ManagerListener {
    void bleEnabledStateChanged(boolean z);
}
