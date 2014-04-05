package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class FrontToBackAnimation extends BaseAnimation {

    private static const MAX_FRAMES_SKIP:uint = 10;

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
            movies[i].gotoAndStop(getCurrentFrame());
        }
    }

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];
        if (movie.currentFrame == movie.totalFrames - 1) {
            return 1;
        }
        return movie.currentFrame + 1;
    }
}
}
