package ru.norobots.trox.view.valve {
import flash.display.DisplayObject;

import ru.norobots.trox.animation.SlowValveAnimation;

import ru.norobots.trox.view.BaseView;

public class Valve extends BaseView {

    /*   1                      21
     *   healthy loop           ill loop
     *                          21              25            37
     *                          to ill          ill drift     to healthy
     *
     */

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
