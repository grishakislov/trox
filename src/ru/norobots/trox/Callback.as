package ru.norobots.trox {
public class Callback {
    public static function fire(callback:Function = null) {
        if (callback != null) {
            callback();
        }
    }
}
}
