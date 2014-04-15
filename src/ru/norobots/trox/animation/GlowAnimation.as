package ru.norobots.trox.animation {
import flash.display.MovieClip;

public class GlowAnimation extends BaseAnimation {

    private var showFlag:Boolean = false;

    override protected function onTick(dt:uint):void {
        super.onTick(dt);
        var movie:MovieClip = movies[0];
        for (var i:int = 0; i < movies.length; i++) {
            if (showFlag && movie.alpha < 1.0) {
                movie.alpha += 0.1;
            }

            if (!showFlag && movie.alpha > 0.0) {
                movie.alpha -= 0.1;
            }
        }
    }

    public function show():void {
        showFlag = true;
    }

    public function hide():void {
        showFlag = false;
    }

}
}
