package com.facebook.internal;

import com.facebook.FacebookException;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class CollectionMapper {

    public interface OnErrorListener {
        void onError(FacebookException facebookException);
    }

    public interface OnMapperCompleteListener extends OnErrorListener {
        void onComplete();
    }

    final class C02341 implements OnMapperCompleteListener {
        final /* synthetic */ Mutable val$didReturnError;
        final /* synthetic */ OnMapperCompleteListener val$onMapperCompleteListener;
        final /* synthetic */ Mutable val$pendingJobCount;

        C02341(Mutable mutable, Mutable mutable2, OnMapperCompleteListener onMapperCompleteListener) {
            this.val$didReturnError = mutable;
            this.val$pendingJobCount = mutable2;
            this.val$onMapperCompleteListener = onMapperCompleteListener;
        }

        public final void onComplete() {
            if (!((Boolean) this.val$didReturnError.value).booleanValue()) {
                Mutable mutable = this.val$pendingJobCount;
                Integer valueOf = Integer.valueOf(((Integer) this.val$pendingJobCount.value).intValue() - 1);
                mutable.value = valueOf;
                if (valueOf.intValue() == 0) {
                    this.val$onMapperCompleteListener.onComplete();
                }
            }
        }

        public final void onError(FacebookException facebookException) {
            if (!((Boolean) this.val$didReturnError.value).booleanValue()) {
                this.val$didReturnError.value = Boolean.valueOf(true);
                this.val$onMapperCompleteListener.onError(facebookException);
            }
        }
    }

    public interface OnMapValueCompleteListener extends OnErrorListener {
        void onComplete(Object obj);
    }

    final class C02352 implements OnMapValueCompleteListener {
        final /* synthetic */ Collection val$collection;
        final /* synthetic */ OnMapperCompleteListener val$jobCompleteListener;
        final /* synthetic */ Object val$key;

        C02352(Collection collection, Object obj, OnMapperCompleteListener onMapperCompleteListener) {
            this.val$collection = collection;
            this.val$key = obj;
            this.val$jobCompleteListener = onMapperCompleteListener;
        }

        public final void onComplete(Object obj) {
            this.val$collection.set(this.val$key, obj, this.val$jobCompleteListener);
            this.val$jobCompleteListener.onComplete();
        }

        public final void onError(FacebookException facebookException) {
            this.val$jobCompleteListener.onError(facebookException);
        }
    }

    public interface Collection<T> {
        Object get(T t);

        Iterator<T> keyIterator();

        void set(T t, Object obj, OnErrorListener onErrorListener);
    }

    public interface ValueMapper {
        void mapValue(Object obj, OnMapValueCompleteListener onMapValueCompleteListener);
    }

    private CollectionMapper() {
    }

    public static <T> void iterate(Collection<T> collection, ValueMapper valueMapper, OnMapperCompleteListener onMapperCompleteListener) {
        Mutable mutable = new Mutable(Boolean.valueOf(false));
        Mutable mutable2 = new Mutable(Integer.valueOf(1));
        OnMapperCompleteListener c02341 = new C02341(mutable, mutable2, onMapperCompleteListener);
        Iterator keyIterator = collection.keyIterator();
        List linkedList = new LinkedList();
        while (keyIterator.hasNext()) {
            linkedList.add(keyIterator.next());
        }
        for (Object next : linkedList) {
            Object obj = collection.get(next);
            OnMapValueCompleteListener c02352 = new C02352(collection, next, c02341);
            Object next2 = mutable2.value;
            mutable2.value = Integer.valueOf(((Integer) mutable2.value).intValue() + 1);
            valueMapper.mapValue(obj, c02352);
        }
        c02341.onComplete();
    }
}
