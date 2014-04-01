package ru.norobots.trox.view {
import flash.display.DisplayObject;

import ru.norobots.trox.view.erythrocyte.ErythrocyteLayer;
import ru.norobots.trox.view.tumor.TumorLayer;
import ru.norobots.trox.view.valve.ValveLayer;

public class Vein extends ViewBase {

    private var particles:ErythrocyteLayer;
    private var valveLayer:ValveLayer;
    private var tumorLayer:TumorLayer;

    public function Vein(visual:DisplayObject) {
        super(visual);
        initializeChildren();
    }

    private function initializeChildren():void {
        initializeValveLayer();
        initializeTumorLayer();
        particles = new ErythrocyteLayer(visual.getChildByName("particles"));
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
        for (var i:int = 1; i <= NUM_TUMORS; i++) {
            tumorLayer.addTumor(visual.getChildByName("tumor" + i));
        }
    }


}
}
