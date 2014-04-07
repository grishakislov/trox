package ru.norobots.trox.view {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.animation.BaseAnimation;
import ru.norobots.trox.animation.VeinExpandAnimation;
import ru.norobots.trox.view.cure.CureLayer;
import ru.norobots.trox.view.erythrocyte.ErythrocyteLayer;
import ru.norobots.trox.view.tumor.TumorLayer;
import ru.norobots.trox.view.valve.ValveLayer;

public class Vein extends BaseView {

    private var vein:RasterizedMovieClip;
    private var particles:ErythrocyteLayer;
    private var cureLayer:CureLayer;
    private var valveLayer:ValveLayer;
    private var tumorLayer:TumorLayer;

    public function Vein(visual:DisplayObject) {
        super(initializeChildren(MovieClip(visual)));
    }

    private function initializeChildren(mc:MovieClip):MovieClip {
        vein = new RasterizedMovieClip(MovieClip(mc.getChildByName("vein")));

//        Tools.saveRC(vein);

        initializeValveLayer(mc);
        initializeTumorLayer(mc);
        particles = new ErythrocyteLayer(mc.getChildByName("particles"));
        cureLayer = new CureLayer(mc.getChildByName("cure"));
        return vein;
    }

    public function expand():BaseAnimation {
        var anim:BaseAnimation = new VeinExpandAnimation();
        anim.addCompleteCallback(onCurrentAnimationCompleted);
        anim.addMovie(vein);
        anim.addMovie(MovieClip(valveLayer.getLayer()));
        anim.addMovie(MovieClip(tumorLayer.getLayer()));
        anim.run();
        return anim;
    }

    public function shrink():void {

    }

    private function onCurrentAnimationCompleted():void {

    }

    private function initializeValveLayer(mc:MovieClip):void {
        valveLayer = new ValveLayer(mc.getChildByName("valves"));
    }

    private function initializeTumorLayer(mc:MovieClip):void {
        tumorLayer = new TumorLayer(mc.getChildByName("tumor"));
    }

    public function getParticles():ErythrocyteLayer {
        return particles;
    }


    public function getValveLayer():ValveLayer {
        return valveLayer;
    }

    public function getTumorLayer():TumorLayer {
        return tumorLayer;
    }

    public function getCureLayer():CureLayer {
        return cureLayer;
    }

    public function getVein():RasterizedMovieClip {
        return vein;
    }


}
}
