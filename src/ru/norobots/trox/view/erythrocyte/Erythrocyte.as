package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;

import ru.norobots.trox.view.BaseView;

public class Erythrocyte extends BaseView {

    public function Erythrocyte(visual:DisplayObject) {
        super(visual);
    }

    public function randomizePosition():void {
        visual.gotoAndStop(Math.floor(Math.random() * visual.totalFrames));
    }
}
}
