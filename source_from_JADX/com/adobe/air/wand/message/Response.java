package com.adobe.air.wand.message;

import com.adobe.air.wand.message.Message.Type;

public class Response extends Message {

    public static class Data extends com.adobe.air.wand.message.Message.Data {
        protected MessageDataObject mResult = null;

        public Data(MessageDataObject messageDataObject) {
            setResult(messageDataObject);
        }

        public Object getResult() {
            return this.mResult;
        }

        public void setResult(MessageDataObject messageDataObject) {
            this.mResult = messageDataObject;
        }
    }

    public static class Header extends com.adobe.air.wand.message.Message.Header {
        protected Status mStatus = null;
        protected String mTaskID = "";

        public Header(String str, String str2, long j, Status status) {
            super(str, Type.RESPONSE, j);
            this.mStatus = status;
            this.mTaskID = str2;
        }

        public Status getStatus() {
            return this.mStatus;
        }

        public void setStatus(Status status) {
            this.mStatus = status;
        }

        public String getTaskID() {
            return this.mTaskID;
        }

        public void setTaskID(String str) {
            this.mTaskID = str;
        }
    }

    public enum Status {
        SUCCESS("SUCCESS"),
        ERROR("ERROR");
        
        private final String mStatus;

        private Status(String str) {
            this.mStatus = str;
        }

        public String toString() {
            return this.mStatus;
        }
    }

    public Response(Header header, Data data) {
        super(header, data);
    }

    public Header getHeader() {
        return (Header) this.mHeader;
    }

    public Data getData() {
        return (Data) this.mData;
    }
}
