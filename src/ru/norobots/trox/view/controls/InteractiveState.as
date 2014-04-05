package ru.norobots.trox.view.controls {
public class InteractiveState {

    public static const IDLE:InteractiveState = new InteractiveState("idle");
    public static const ACTIVE:InteractiveState = new InteractiveState("active");

    private var name:String;

    public function InteractiveState(name:String) {
    }
}
}
