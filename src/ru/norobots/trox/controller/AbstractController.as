package ru.norobots.trox.controller {
import ru.norobots.trox.view.PlainViewModel;

public class AbstractController {

    protected var view:PlainViewModel;
    protected var completeCallback:Function;

    public function AbstractController(view:PlainViewModel) {
        this.view = view;
    }

    public function addCompleteCallback(callback:Function):void {
        this.completeCallback = callback;
    }

    public static function create(view:PlainViewModel, mode:ControllerMode):AbstractController {
        switch (mode) {
            case ControllerMode.INTRO:
                return new IntroController(view);
                break;
            case ControllerMode.GAME:
                return new GameController(view);
                break;
        }
        return null;
    }

    protected function stop():void {

    }
}
}
