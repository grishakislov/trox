package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.animation.BaseAnimation;
import ru.norobots.trox.animation.ErythrocyteAnimation;
import ru.norobots.trox.animation.LoopAnimation;
import ru.norobots.trox.view.BaseView;

public class Erythrocyte extends BaseView {

    private var innerParticleAnim:BaseView;

    public function Erythrocyte(visual:DisplayObject) {
        super(visual);
        innerParticleAnim = new BaseView(getVisual().getChildByName("particle_anim"));
        innerParticleAnim.play(new LoopAnimation());
        getVisual().alpha = 0.5;
    }

    override public function play(animation:BaseAnimation = null):void {
        super.play(animation);
    }

    public function randomizePosition():void {
        getVisual().gotoAndStop(Math.floor(Math.random() * getVisual().totalFrames));
    }

    public function playDelayed(delayMillis:uint):void {
//        if (animation != null) {
//            animation.stop();
//        }
        if (delayMillis == 0) {
            onTimerComplete(null);
        } else {
            trace ("Mimimillis: " + delayMillis);
            var timer:Timer = new Timer(delayMillis, 1);
            timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
            timer.start();
        }
    }

    public function moveFrontDelayed():void {
        var timer:Timer = new Timer(getDelay(), 1);
        timer.addEventListener(TimerEvent.TIMER, onFrontTimerComplete);
        timer.start();
    }

    public function moveBackDelayed():void {
        var timer:Timer = new Timer(getDelay(), 1);
        timer.addEventListener(TimerEvent.TIMER, onBackTimerComplete);
        timer.start();
    }

    private function getDelay():uint {
        return Math.random() * 2000;
    }

    private function getAnimation():ErythrocyteAnimation {
        return ErythrocyteAnimation(animation);
    }

    private function onTimerComplete(event:TimerEvent):void {
//        if (animation != null) {
//            animation.clear();
//        }
        var anim:ErythrocyteAnimation = new ErythrocyteAnimation();
        anim.addMovie(getVisual());
        play(anim);
    }

    private function onFrontTimerComplete(event:TimerEvent):void {
        getAnimation().moveFront();
    }

    private function onBackTimerComplete(event:TimerEvent):void {
        if (getAnimation() != null) { //debug case only
            getAnimation().moveBack();
        } else {
            !1;
        }
    }
}
}
