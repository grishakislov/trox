package ru.norobots.trox.view.tumor {
import flash.display.DisplayObject;

import ru.norobots.trox.Assert;

public class TumorLayer {

    public function TumorLayer() {
    }

    public function addTumor(tumor:DisplayObject):void {
        Assert.notNull(tumor);
    }

}
}
