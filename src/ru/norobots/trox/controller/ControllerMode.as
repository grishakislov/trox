package ru.norobots.trox.controller {
public class ControllerMode {

    public static const INTRO:ControllerMode = new ControllerMode("intro");
    public static const GAME:ControllerMode = new ControllerMode("game");

    private var mode:String;

    public function ControllerMode(mode:String) {
        this.mode = mode;
    }
}
}
