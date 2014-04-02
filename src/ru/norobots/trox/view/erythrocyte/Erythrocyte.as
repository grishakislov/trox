package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.animation.BaseAnimation;

import ru.norobots.trox.animation.LoopAnimation;

import ru.norobots.trox.view.BaseView;

public class Erythrocyte extends BaseView {

    private var settings:ParticleSettings;

    public function Erythrocyte(visual:DisplayObject, settings:ParticleSettings) {
        super(visual);
        this.settings = settings;
    }

    public function randomizePosition():void {
        visual.gotoAndStop(Math.floor(Math.random() * visual.totalFrames));
    }

    public function playDelayed(delayMillis:uint):void {
        if (animation != null) {
            animation.stop();
        }
        var timer:Timer = new Timer(delayMillis, 1);
        timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
        timer.start();
    }

    private function onTimerComplete(event:TimerEvent):void {
        play(new LoopAnimation());
    }
}
}
