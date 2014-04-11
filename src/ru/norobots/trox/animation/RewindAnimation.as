package ru.norobots.trox.animation {
import flash.display.MovieClip;

import ru.norobots.trox.Ticker;

public class RewindAnimation extends BaseAnimation {

    private var skip:uint;
    private var skipped:uint;

    public function RewindAnimation(skipFrames:uint = 0) {
        this.skip = skipFrames;
    }

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
            if (skip > 0) {
                if (skipped >= skip) {
                    skipped = 0;
                    movies[i].gotoAndStop(getCurrentFrame());
                }
                skipped++;
                !1;
            } else {
                movies[i].gotoAndStop(getCurrentFrame());
            }
        }

        if (movies[0].currentFrame == 1) {
            stop();
            onComplete();
        }
    }

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];
        if (movie.currentFrame == 1) {
            Ticker.removeTickListener(onTick);
            return movie.currentFrame;
            onComplete();
        }
        return movie.currentFrame - 1;
    }
}
}
