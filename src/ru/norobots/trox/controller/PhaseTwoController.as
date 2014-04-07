package ru.norobots.trox.controller {
import ru.norobots.trox.view.PlainViewModel;

public class PhaseTwoController {

    private var view:PlainViewModel;
    private var completeCallback:Function;

    public function PhaseTwoController(view:PlainViewModel) {
        this.view = view;
        view.tumor.lock();
        view.valves.setIll();
        view.particles.moveBack();
    }

    private function onComplete():void {
        if (completeCallback != null) {
            completeCallback();
        }
    }

    public function addCompleteCallback(callback:Function):void {
        completeCallback = callback;
    }

}
}
