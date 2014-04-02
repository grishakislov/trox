package ru.norobots.trox.animation {
import flash.display.MovieClip;

import ru.norobots.trox.GameSettings;

public class VeinExpandAnimation extends BaseAnimation {

    private var startFrame:uint;
    private var endFrame:uint;

    private var phase1TargetFrame:uint;
    private var phase2TargetFrame:uint;

    private var phase1:Boolean = true;
    private var phase2:Boolean = false;

    override public function start(movie:MovieClip):void {
        super.start(movie);
        startFrame = movie.currentFrame;
        var animationFrames:uint = movie.totalFrames / GameSettings.VEIN_STEPS;
        endFrame = startFrame + animationFrames;

        phase2TargetFrame = Math.round(movie.totalFrames / 6) + movie.currentFrame;
        phase1TargetFrame = phase2TargetFrame + Math.round(movie.totalFrames / 6) / 2;
        run();
    }

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        movie.gotoAndStop(getCurrentFrame());
    }

    private const EASE:uint = 2;
    private var phase1FrameIncrement:uint = 1;
    private var phase2FrameDecrement:Number = (phase1TargetFrame - phase2TargetFrame) / EASE;

    override protected function getCurrentFrame():uint {
        var result:Number;

        if (phase1) {
            result = movie.currentFrame + phase1FrameIncrement;
            phase1FrameIncrement += phase1FrameIncrement * EASE;
            if (result > phase1TargetFrame) {
                phase1 = false;
                phase2 = true;
                return phase1TargetFrame;
            }
            return result;
        } else if (phase2) {
            result = movie.currentFrame - phase2FrameDecrement;
            phase2FrameDecrement /= EASE;
            if (phase2FrameDecrement < 1) {
                phase2FrameDecrement = 1;
            }
            if (result < phase2TargetFrame) {
                phase2 = false;
                return phase2TargetFrame;
            }
            return result;
        }
        stop();
        onComplete();
        return phase2TargetFrame;
    }


}
}
