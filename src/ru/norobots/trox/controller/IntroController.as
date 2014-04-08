package ru.norobots.trox.controller {
import flash.events.TimerEvent;
import flash.utils.Timer;

import ru.norobots.trox.GameSettings;

import ru.norobots.trox.view.PlainViewModel;

public class IntroController extends AbstractController {

    public function IntroController(view:PlainViewModel) {
        super(view);
        view.appView.clear();
        view.appView.attachIntro();
        view.intro.getPlayButton().addCallback(onPlayClicked);
    }

    private function onPlayClicked():void {
        onComplete();
    }

    private function onComplete():void {
        view.intro.setEnabled(false);
        AbstractController.create(view, ControllerMode.GAME);
    }
}
}
