package ru.norobots.trox.controller {
import ru.norobots.trox.view.PlainViewModel;

public class GameController extends AbstractController {

    public function GameController(view:PlainViewModel) {
        super(view);
        view.appView.clear();
        view.appView.attachGame();
        var phase1:PhaseOneController = new PhaseOneController(view);
        phase1.addCompleteCallback(onPhaseOneComplete);
    }

    private function onPhaseOneComplete():void {
        var phase2:PhaseTwoController = new PhaseTwoController(view);
        phase2.addCompleteCallback(onPhaseTwoComplete);
    }

    private function onPhaseTwoComplete():void {
        view.appView.clear();
        view.appView.attachEnd();
        view.appView.getEnd().getReplayButton().addCallback(resetGame);
    }

    private function resetGame():void {
        view.appView.clear();
        view.blister.reset();
        view.tube.reset();
        view.tumor.reset();
        view.particles.reset();
        view.vein.reset();
        view.cure.stop();
        view.cure.getVisual().gotoAndStop(1);
        view.appView.getEnd().getReplayButton().setUsed(false);
        view.appView.attachGame();
        var phase1:PhaseOneController = new PhaseOneController(view);
        phase1.addCompleteCallback(onPhaseOneComplete);
    }
}
}
