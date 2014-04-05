package ru.norobots.trox.animation {
public class SlowValveAnimation extends TranslationAnimation {

    private static const FRAMES_TO_SKIP:uint = 3;
    private var framesSkipped:uint = 0;

    override protected function onTick(dt:uint):void {
        framesSkipped++;
        if (framesSkipped >= FRAMES_TO_SKIP) {
            framesSkipped = 0;
            super.onTick(dt);
        }
    }
}
}
