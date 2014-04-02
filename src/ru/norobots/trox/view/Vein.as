package ru.norobots.trox.view {
import flash.display.DisplayObject;

import ru.norobots.trox.animation.BaseAnimation;
import ru.norobots.trox.animation.VeinExpandAnimation;
import ru.norobots.trox.view.erythrocyte.ErythrocyteLayer;
import ru.norobots.trox.view.tumor.TumorLayer;
import ru.norobots.trox.view.valve.ValveLayer;

public class Vein extends BaseView {

    private var particles:ErythrocyteLayer;
    private var valveLayer:ValveLayer;
    private var tumorLayer:TumorLayer;

    private var currentAnimation:BaseAnimation;

    public function Vein(visual:DisplayObject) {
        super(visual);
        initializeChildren();
    }

    private function initializeChildren():void {
        initializeValveLayer();
        initializeTumorLayer();
        particles = new ErythrocyteLayer(visual.getChildByName("particles"));
    }

    public function expand():BaseAnimation {
        var anim:BaseAnimation = new VeinExpandAnimation();
        anim.addCompleteCallback(onCurrentAnimationCompleted);
        play(anim);
        return anim;
    }

    public function shrink():void {

    }

    private function onCurrentAnimationCompleted():void {

    }

    private function initializeValveLayer():void {
        valveLayer = new ValveLayer();
        const NUM_VALVES:uint = 6;
        for (var i:int = 1; i <= NUM_VALVES; i++) {
            valveLayer.addValve(visual.getChildByName("valve" + i));
        }
    }

    private function initializeTumorLayer():void {
        tumorLayer = new TumorLayer();
        const NUM_TUMORS:uint = 6;
        var tumor:DisplayObject;
        for (var i:int = 1; i <= NUM_TUMORS; i++) {
            tumor = visual.getChildByName("tumor" + i);
            tumorLayer.addTumor(tumor);
        }
    }

    public function getParticles():ErythrocyteLayer {
        return particles;
    }


    public function getValveLayer():ValveLayer {
        return valveLayer;
    }

    public function getTumorLayer():TumorLayer {
        return tumorLayer;
    }
}
}
