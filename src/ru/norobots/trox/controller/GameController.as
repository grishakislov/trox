package ru.norobots.trox.controller {
import ru.norobots.trox.view.PlainViewModel;

public class GameController extends AbstractController {

    public function GameController(view:PlainViewModel) {
        super(view);

        var phase1:PhaseOneController = new PhaseOneController(view);
        phase1.addCompleteCallback(onPhaseOneComplete);
    }

    private function onPhaseOneComplete():void {
        var phase2:PhaseTwoController = new PhaseTwoController(view);
        phase2.addCompleteCallback(onPhaseOneComplete);
    }
}
}
