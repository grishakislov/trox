package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class ErythrocyteAnimation extends BaseAnimation {

    private static const NORMAL_SKIP:uint = 8;
    private static const BACK_SKIP:int = -4;

    private var back:Boolean;
    private var keepLoop:Boolean;
    private var currentIncrement:Number = NORMAL_SKIP;

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
            movies[i].gotoAndStop(getCurrentFrame());
        }
    }

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];
        if (back) {
            if (movie.currentFrame == 1 && !keepLoop) {
                return movie.totalFrames;
            }
        } else {
            if (movie.currentFrame == movie.totalFrames) {
                return 1;
            }
        }

        return increment();
    }

    public function moveBack():void {
        back = true;
    }

    public function moveFront():void {
        trace("Front!");
        back = false;
    }

    private function increment():uint {
        var movie:MovieClip = movies[0];
        if (back) {
            if (currentIncrement > BACK_SKIP) {
                keepLoop = true;
                currentIncrement -= (currentIncrement - BACK_SKIP) / 100;
            } else {
                keepLoop = false;
            }
            return movie.currentFrame + Math.round(currentIncrement);
        } else {
            if (currentIncrement < NORMAL_SKIP) {
                keepLoop = true;
                currentIncrement += (NORMAL_SKIP - currentIncrement) / 100;
            } else {
                keepLoop = false;
            }

            return movie.currentFrame + Math.round(currentIncrement);
        }
        return 0;
    }


}
}
