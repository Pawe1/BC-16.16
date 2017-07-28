package de.pagecon.bleane.cc2540.usb;

public class VIDPIDPair {
    public int mPID;
    public int mVID;

    public VIDPIDPair(int vID, int pID) {
        this.mVID = vID;
        this.mPID = pID;
    }

    public String toString() {
        return "vID: " + this.mVID + " pID: " + this.mPID;
    }

    public int hashCode() {
        return ((this.mPID + 31) * 31) + this.mVID;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        VIDPIDPair other = (VIDPIDPair) obj;
        if (this.mPID != other.mPID) {
            return false;
        }
        if (this.mVID != other.mVID) {
            return false;
        }
        return true;
    }
}
