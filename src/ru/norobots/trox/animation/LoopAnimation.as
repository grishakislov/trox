package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class LoopAnimation extends BaseAnimation {


    override public function start(movie:MovieClip):void {
        super.start(movie);
        run();
    }

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        movie.gotoAndStop(getCurrentFrame());
    }

    override protected function getCurrentFrame():uint {
        if (movie.currentFrame == movie.totalFrames) {
            return 1;
        }
        return movie.currentFrame + 1;
    }
}
}
