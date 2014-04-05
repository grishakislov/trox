package ru.norobots.trox.animation {
import flash.display.MovieClip;

import ru.norobots.trox.Ticker;

public class BaseAnimation {

    protected var millis:uint;
    protected var millisElapsed:uint = 0;
    protected var completeCallback:Function;
    protected var movies:Vector.<MovieClip> = new Vector.<MovieClip>();

    public function addCompleteCallback(callback:Function):void {
        completeCallback = callback;
    }

    public function addMovie(movie:MovieClip):void {
        movies.push(movie);
    }

    public function run():void {
        Ticker.addTickListener(onTick);
    }

    public function stop():void {
        Ticker.removeTickListener(onTick);
    }

    public function resume():void {
        Ticker.addTickListener(onTick);
    }

    protected function onTick(dt:uint):void {
        millisElapsed += dt;
    }

    public function onComplete():void {
        if (completeCallback != null) {
            completeCallback();
        }
    }

    protected function getCurrentFrame():uint {
        return 0;
    }

}
}
