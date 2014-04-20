package ru.norobots.trox.animation {
import flash.display.MovieClip;

import ru.norobots.trox.Callback;

import ru.norobots.trox.Ticker;

public class BaseAnimation {

    protected var millisElapsed:uint = 0;
    protected var completeCallback:Function;
    private var frameHandler:Function;
    private var handleFrame:int;
    protected var movies:Vector.<MovieClip> = new Vector.<MovieClip>();

    public function addCompleteCallback(callback:Function):void {
        completeCallback = callback;
    }

    public function addMovie(movie:MovieClip):void {
        if (movies.indexOf(movie) == -1) {
            movies.push(movie);
        }
    }

    public function run():void {
        Ticker.addTickListener(onTick);
    }

    public function stop():void {
        Ticker.removeTickListener(onTick);
    }

    public function clear():void {
        movies = new Vector.<MovieClip>();
        Ticker.removeTickListener(onTick);
    }

    public function resume():void {
        Ticker.addTickListener(onTick);
    }

    public function onComplete():void {
        Callback.fire(completeCallback);
    }

    protected function onTick(dt:uint):void {
        millisElapsed += dt;
        if (movies[0].currentFrame == handleFrame) {
            Callback.fire(frameHandler);
        }
    }

    protected function getCurrentFrame():uint {
        return 0;
    }

    public final function addFrameHandler(frame:uint, callback:Function):void {
        handleFrame = frame;
        frameHandler = callback;
    }

    public final function removeFrameHandler():void {
        handleFrame = -1;
        frameHandler = null;
    }
}
}
