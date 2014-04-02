package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class TranslationAnimation extends BaseAnimation {

    private var forward:Boolean = true;

    override public function start(movie:MovieClip):void {
        super.start(movie);
        run();
    }

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        movie.gotoAndStop(getCurrentFrame());
    }

    override protected function getCurrentFrame():uint {
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
