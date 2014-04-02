package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.Assert;
import ru.norobots.trox.GameSettings;
import ru.norobots.trox.animation.LoopAnimation;

public class ErythrocyteLayer {

    private var currentStep:uint = 1;
    private var visual:MovieClip;
    private static const TOTAL_PARTICLES:uint = 32;
    private var particles:Vector.<Erythrocyte> = new Vector.<Erythrocyte>();

    private var numVisibleParticles:uint = 0;

    public function ErythrocyteLayer(visual:DisplayObject) {
        Assert.notNull(visual);
        this.visual = MovieClip(visual);
        initializeChildren();
        initializeAnimation();
    }

    private function initializeAnimation():void {
        var numParticles = getParticlesNumByStep();
        var currentParticle:Erythrocyte;
        for (var i:int = 0; i < numParticles; i++) {
            currentParticle = particles[i];
            currentParticle.setVisible(true);
            currentParticle.randomizePosition();
            currentParticle.play(new LoopAnimation());
            numVisibleParticles++;
        }
    }

    private function getParticlesNumByStep():uint {
        return particles.length / GameSettings.VEIN_STEPS * currentStep;
    }

    private function initializeChildren():void {
        var current:Erythrocyte;
        for (var i:int = 1; i <= TOTAL_PARTICLES; i++) {
            current = new Erythrocyte(visual.getChildByName("e" + i));
            current.setVisible(false);
            particles.push(current);
        }
    }

    public function setStep(step:uint):void {
        trace("Step " + step);
        currentStep = step;
    }
}
}
