package ru.norobots.trox.animation {
import flash.display.MovieClip;


public class LoopAnimation extends BaseAnimation {

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
//            trace("Pre:" + movies[0].currentFrame);
            movies[i].gotoAndStop(getCurrentFrame());
//            trace("Post:" + movies[0].currentFrame);
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
