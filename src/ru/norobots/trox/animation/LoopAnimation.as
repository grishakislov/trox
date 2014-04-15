package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class LoopAnimation extends BaseAnimation {

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
            movies[i].gotoAndStop(getCurrentFrame());
        }
    }

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];
        if (movie.currentFrame == movie.totalFrames) {
            return 1;
        }
        return movie.currentFrame + 1;
    }

    override public function addMovie(movie:MovieClip):void {
        super.addMovie(movie);
        for (var i:int = 1; i <= movie.totalFrames; i++) {
            movie.gotoAndStop(movie.currentFrame + 1);
        }
        movie.gotoAndStop(1);
    }
}
}
