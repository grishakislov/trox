package ru.norobots.trox.view.tumor {
import flash.display.DisplayObject;

import ru.norobots.trox.Assert;

public class TumorLayer {

    private var tumors:Vector.<Tumor> = new Vector.<Tumor>();
    private var currentStep:uint = 0;

    public function TumorLayer() {
    }

    public function addTumor(tumor:DisplayObject):void {
        Assert.notNull(tumor);
        tumors.push(new Tumor(tumor));
    }

    public function setStep(step:uint):void {
        currentStep = step;
    }
}
}
