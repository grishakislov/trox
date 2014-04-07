package ru.norobots.trox.view.cure {
import flash.display.DisplayObject;
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.GameSettings;
import ru.norobots.trox.animation.CureAnimation;
import ru.norobots.trox.animation.OnceAnimation;
import ru.norobots.trox.view.BaseView;

public class Cure extends BaseView {

    public function Cure(visual:DisplayObject) {
        super(visual);
    }

    public function playDelayed():void {
        var delayMillis:uint = Math.random() * (GameSettings.VEIN_STEP_SECONDS * 1000 / 2) + 500;
        var timer:Timer = new Timer(delayMillis, 1);
        timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
        timer.start();
    }

    private function onTimerComplete(event:TimerEvent):void {
        play(new CureAnimation());
    }
}
}
