package de.pagecon.bleane.nativ;

import de.pagecon.bleane.extension.ManagerListener;

public interface NativeManagerListener extends ManagerListener {
    void bleEnabledStateChanged(boolean z);
}
