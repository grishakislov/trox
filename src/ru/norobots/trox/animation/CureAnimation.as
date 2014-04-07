package ru.norobots.trox.animation {
import flash.display.MovieClip;

import ru.norobots.trox.Ticker;

public class CureAnimation extends OnceAnimation {

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];
        if (movie.currentFrame >= movie.totalFrames) {
            Ticker.removeTickListener(onTick);
            return movie.currentFrame;
            onComplete();
        }
        return movie.currentFrame + 2;
    }


}
}
