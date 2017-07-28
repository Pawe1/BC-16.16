package de.pagecon.bleane.cc2540;

import java.util.ArrayList;

public class TS_StringList {
    private ArrayList<String> strings = new ArrayList();

    public synchronized void clear() {
        this.strings.clear();
    }

    public synchronized int getSize() {
        return this.strings.size();
    }

    public synchronized void add(String s) {
        this.strings.add(s);
    }

    public synchronized String getString(int i) {
        return (String) this.strings.get(i);
    }
}
