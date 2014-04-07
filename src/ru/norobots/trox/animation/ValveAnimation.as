package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class ValveAnimation extends BaseAnimation {

    /*   1                      21
     *   healthy loop           ill loop
     *                          21              25            37
     *                          to ill          ill drift     to healthy
     *
     */

    private static const HEALTHY_FIRST:uint = 1;
    private static const HEALTHY_LAST:uint = 20;
    private static const ILL_FIRST:uint = 25;
    private static const ILL_LAST:uint = 36;
    private static const ILL_TO_HEALTH_T_FIRST:uint = 37;
    private static const ILL_TO_HEALTH_T_LAST:uint = 40;
    private static const HEALTH_TO_ILL_T_FIRST:uint = 21;
    private static const HEALTH_TO_ILL_T_LAST:uint = 24;

    private var ill:Boolean = false; //double-stated

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        for (var i:int = 0; i < movies.length; i++) {
            var cf:uint = getCurrentFrame();
            movies[i].gotoAndStop(cf);
//            movies[i].gotoAndStop(getCurrentFrame());
        }
    }

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];


        if (ill) {
            if (isInTransition()) {
                if (movie.currentFrame == HEALTH_TO_ILL_T_LAST) {
                    return ILL_FIRST;
                }
                return increment();
            } else {
                if (movie.currentFrame == ILL_LAST) {
                    return ILL_FIRST;
                }
                return increment();
            }
        } else {
            if (isInTransition()) {
                if (movie.currentFrame == ILL_TO_HEALTH_T_LAST) {
                    return HEALTHY_FIRST;
                }
                return increment();
            } else {
                if (movie.currentFrame == HEALTHY_LAST) {
                    return HEALTHY_FIRST;
                }
                return increment();
            }

        }
        return 0;
    }

    private function increment():uint {
        return movies[0].currentFrame + 1;
    }

    private function isInTransition():Boolean {
        var movie:MovieClip = movies[0];
        if (ill) {
            return checkIn(movie.currentFrame, HEALTH_TO_ILL_T_FIRST, HEALTH_TO_ILL_T_LAST);
        } else {
            return checkIn(movie.currentFrame, ILL_TO_HEALTH_T_FIRST, ILL_TO_HEALTH_T_LAST);
        }
    }

    private function checkIn(currentFrame:uint, firstFrame:uint, lastFrame:uint):Boolean {
        return currentFrame >= firstFrame && currentFrame <= lastFrame;
    }

    public function setIll():void {
        ill = true;
        movies[0].gotoAndStop(HEALTH_TO_ILL_T_FIRST);
    }

    public function setHealthy():void {
        ill = false;
        movies[0].gotoAndStop(ILL_TO_HEALTH_T_FIRST);
    }
}
}
