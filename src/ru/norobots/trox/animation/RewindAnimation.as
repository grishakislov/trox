package ru.norobots.trox.animation {
import flash.display.MovieClip;

import ru.norobots.trox.Ticker;

public class RewindAnimation extends BaseAnimation {

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
            movies[i].gotoAndStop(getCurrentFrame());
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
