package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class TranslationAnimation extends BaseAnimation {

    private var forward:Boolean = true;

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
            movies[i].gotoAndStop(getCurrentFrame());
        }
    }

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];
        if (movie.currentFrame <= 1) {
            forward = true;
        }

        if (movie.currentFrame >= movie.totalFrames) {
            forward = false;
        }

        var currentFrame:int = movie.currentFrame;
        var frame:int = forward ? currentFrame + 1 : currentFrame - 1;
        return frame;
    }
}
}
