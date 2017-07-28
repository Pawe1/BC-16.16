package com.adobe.air.wand.message;

import com.adobe.air.wand.message.Message.Type;

public class Request extends Message {

    public static class Data extends com.adobe.air.wand.message.Message.Data {
        MessageDataArray mArguments = null;

        public Data(MessageDataArray messageDataArray) {
            setArguments(messageDataArray);
        }

        public MessageDataArray getArguments() {
            return this.mArguments;
        }

        public void setArguments(MessageDataArray messageDataArray) {
            this.mArguments = messageDataArray;
        }
    }

    public static class Header extends com.adobe.air.wand.message.Message.Header {
        protected String mTaskID = "";

        public Header(String str, String str2, long j) {
            super(str, Type.REQUEST, j);
            this.mTaskID = str2;
        }

        public String getTaskID() {
            return this.mTaskID;
        }

        public void setTaskID(String str) {
            this.mTaskID = str;
        }
    }

    public Request(Header header, Data data) {
        super(header, data);
    }

    public Header getHeader() {
        return (Header) this.mHeader;
    }

    public Data getData() {
        return (Data) this.mData;
    }
}
