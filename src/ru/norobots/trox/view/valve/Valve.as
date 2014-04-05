package ru.norobots.trox.view.valve {
import flash.display.DisplayObject;

import ru.norobots.trox.animation.SlowValveAnimation;

import ru.norobots.trox.view.BaseView;

public class Valve extends BaseView {

    public function Valve(visual:DisplayObject) {
        super(visual);
        play();
    }

    public function speedDown():void {
        stop();
        play(new SlowValveAnimation());
    }

}
}
