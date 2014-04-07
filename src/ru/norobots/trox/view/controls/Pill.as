package ru.norobots.trox.view.controls {
import flash.display.DisplayObject;

import ru.norobots.trox.view.BaseView;

public class Pill extends BaseView {

    private var used:Boolean;
    private var useMc:DisplayObject;

    public function Pill(visual:DisplayObject) {
        super(visual);
        useMc = getVisual().getChildByName("use")
    }

    public function alreadyUsed():Boolean {
        return used;
    }

    public function usePill():void {
        used = true;
        useMc.visible = false;
    }
}
}
