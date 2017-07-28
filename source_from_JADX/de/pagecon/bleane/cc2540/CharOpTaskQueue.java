package de.pagecon.bleane.cc2540;

import java.util.LinkedList;
import java.util.List;

public class CharOpTaskQueue {
    private List<CharOpTask> tasks = new LinkedList();

    public synchronized void queueTask(CharOpTask task) {
        this.tasks.add(task);
    }

    public synchronized void dequeueTask() {
        if (this.tasks.size() > 0) {
            this.tasks.remove(0);
        }
    }

    public synchronized CharOpTask getTask() {
        CharOpTask charOpTask;
        if (this.tasks.size() > 0) {
            charOpTask = (CharOpTask) this.tasks.get(0);
        } else {
            charOpTask = null;
        }
        return charOpTask;
    }

    public synchronized void clear() {
        this.tasks.clear();
    }

    public synchronized void clearTasksOfDevice(BleDevice device) {
        for (int i = this.tasks.size() - 1; i >= 0; i--) {
            if (device == ((CharOpTask) this.tasks.get(i)).device) {
                this.tasks.remove(i);
            }
        }
    }
}
