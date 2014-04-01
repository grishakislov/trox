package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;

import ru.norobots.trox.Assert;

public class ErythrocyteLayer {

    public function ErythrocyteLayer(visual:DisplayObject) {
        Assert.notNull(visual);
        initializeChildren();
    }

    private function initializeChildren():void {

    }
}
}
