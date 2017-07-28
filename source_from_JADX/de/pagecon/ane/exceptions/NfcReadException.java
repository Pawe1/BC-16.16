package de.pagecon.ane.exceptions;

public class NfcReadException extends Exception {
    private static final long serialVersionUID = 27121983;
    public int blocksRead;
    public byte[] readResult;

    public NfcReadException() {
        this.blocksRead = 0;
        this.readResult = new byte[0];
    }

    public NfcReadException(String detailMessage) {
        super(detailMessage);
        this.blocksRead = 0;
        this.readResult = new byte[0];
    }

    public NfcReadException(String message, Throwable cause) {
        super(message, cause);
        this.blocksRead = 0;
        this.readResult = new byte[0];
    }

    public NfcReadException(Throwable cause) {
        String str;
        if (cause == null) {
            str = null;
        } else {
            str = cause.toString();
        }
        super(str, cause);
        this.blocksRead = 0;
        this.readResult = new byte[0];
    }

    public String toString() {
        return new StringBuilder(String.valueOf(new StringBuilder(String.valueOf("[NfcReadException] ++++++++++++++++" + "\n ::: blocksRead: " + this.blocksRead)).append("\n ::: readResult.length: ").append(this.readResult.length).toString())).append("\n ::: errormessage: ").append(getMessage()).toString();
    }
}
