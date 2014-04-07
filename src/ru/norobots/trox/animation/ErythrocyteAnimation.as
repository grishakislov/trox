package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class ErythrocyteAnimation extends BaseAnimation {

    private static const NORMAL_SKIP:uint = 4;
    private static const SLOW_SKIP:uint = 0;

    private var back:Boolean;

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
            movies[i].gotoAndStop(getCurrentFrame());
        }
    }

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];
        if (movie.currentFrame >= movie.totalFrames - 1) {
            return 1;
        }
        return increment();
    }

    private function increment():uint {
        var movie:MovieClip = movies[0];
        if (back) {

        } else {
            return movie.currentFrame + NORMAL_SKIP;
        }
        return 0;
    }


}
}
