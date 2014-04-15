package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class ErythrocyteAnimation extends BaseAnimation {

    private var currentStep:uint = 1;
    private var hide:Boolean;
    private var innerAnim:MovieClip;

    private var icf:uint = 1;
    private var currentChance:Number = 0.0;
    private static const MIN_CHANCE:Number = 0.01;

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        var cf:uint;
        for (var i:int = 0; i < movies.length; i++) {
            cf = getCurrentFrame();

            movies[i].gotoAndStop(cf);

            if (innerAnim == null || innerAnim.parent == null) {
                innerAnim = MovieClip(movies[i].getChildByName("particle_anim"));
            }

            if (icf > innerAnim.totalFrames) {
                icf = 1;
            }

            innerAnim.gotoAndStop(icf);
            icf++;

        }
    }

    override protected function getCurrentFrame():uint {
        var movie:MovieClip = movies[0];

        if (hide) {
            if (movie.alpha > 0) {
                movie.alpha -= 0.005;
            }
        } else {
            if (movie.alpha < 0.5) {
                movie.alpha += 0.005;
            }
        }

        if (movie.currentFrame + getCurrentIncrement() > movie.totalFrames - 2) {
            return 1;
        }

        return movie.currentFrame + getCurrentIncrement();

    }

    private function getCurrentIncrement():int {
        var inc:uint = 7 - currentStep;

        var chance:Boolean = Math.random() < currentChance;

        if (currentChance < 1.0) {
            currentChance += 0.01;
        }

        if (chance) {
            return inc;
        } else {
            return inc + 1;
        }
    }

    public function setShowed(value:Boolean):void {
        hide = !value;
    }

    public function setStep(value:uint):void {
        currentChance = MIN_CHANCE;
        currentStep = value;
    }

    override public function addMovie(movie:MovieClip):void {
        super.addMovie(movie);
    }
}
}
