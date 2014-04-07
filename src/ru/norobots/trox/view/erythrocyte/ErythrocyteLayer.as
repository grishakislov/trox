package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import ru.norobots.trox.Assert;
import ru.norobots.trox.GameSettings;

public class ErythrocyteLayer {

    private static const PARTICLES_IN_STEP:uint = 7;
    private static const TOTAL_PARTICLES:uint = GameSettings.VEIN_STEPS * PARTICLES_IN_STEP;
    private var layer:Sprite;
    private var currentStep:uint = 1;
    private var visual:MovieClip;
    private var particles:Vector.<Erythrocyte> = new Vector.<Erythrocyte>();
    private var numVisibleParticles:uint = 0;


    public function ErythrocyteLayer(visual:DisplayObject) {
        Assert.notNull(visual);
        this.visual = MovieClip(visual);
        layer = new Sprite();
        initializeChildren();
        initializeAnimation();

//        for (var i:int = 1; i <= GameSettings.VEIN_STEPS; i++) {
//            currentStep = i;
//            trace("Current step: " + i);
//            trace(getFirstParticleIndex());
//            trace(getLastParticleIndex());
//            trace("========================");
//            trace("");
//        }
    }

    public function setStep(step:uint):void {
        trace("Step " + step);
        currentStep = step;
        if (currentStep > 1) { //Because first step already initialized
            addParticles(getFirstParticleIndex(), getLastParticleIndex());
        }
    }

    public function moveBack():void {
        for (var i:int = 0; i < particles.length; i++) {
            particles[i].moveBackDelayed();
        }
    }

    public function moveFront():void {
        for (var i:int = 0; i < particles.length; i++) {
            particles[i].moveFrontDelayed();
        }
    }

    public function getLayer():DisplayObject {
        return layer;
    }

    protected function initializeChildren():void {
        var current:Erythrocyte;
        var currentBundle:MovieClip;
        for (var i:int = 1; i <= GameSettings.VEIN_STEPS; i++) {
            currentBundle = MovieClip(visual.getChildByName("particles" + i));
            for (var j:int = 0; j < PARTICLES_IN_STEP; j++) {
                var mc:DisplayObject = currentBundle.getChildByName("e" + j);
                trace("particles" + i + ":" + "e" + j);
                current = new Erythrocyte(mc);
                current.setVisible(false);
                particles.push(current);
                layer.addChild(mc);
            }
        }
    }

    protected function initializeAnimation():void {
        var numParticles = getParticlesNumByStep();
        var currentParticle:Erythrocyte;
        for (var i:int = 0; i <= numParticles; i++) {
            currentParticle = particles[i];
            currentParticle.setVisible(true);
            currentParticle.randomizePosition();
            currentParticle.playDelayed(0);
            numVisibleParticles++;
        }
    }

    private function getFirstParticleIndex():uint {
        if (currentStep == 1) {
            return 0;
        } else {
            return Math.floor(particles.length / GameSettings.VEIN_STEPS) * (currentStep - 1) + 1;
        }
    }

    private function getLastParticleIndex():uint {
        if (currentStep == GameSettings.VEIN_STEPS) {
            return particles.length - 1;
        } else {
            return Math.floor(particles.length / GameSettings.VEIN_STEPS) + getFirstParticleIndex() - 1;
        }
    }

    private function getParticlesNumByStep():uint {
        return particles.length / GameSettings.VEIN_STEPS * currentStep;
    }

    private function addParticles(firstParticleIndex:uint, lastParticleIndex:uint):void {
        trace("Step = " + currentStep + ", indexes = " + firstParticleIndex + " " + lastParticleIndex);
        var delayMillis:uint;
        for (var i:int = firstParticleIndex; i <= lastParticleIndex; i++) {
            particles[i].setVisible(true);
            delayMillis = Math.random() * (GameSettings.VEIN_STEP_SECONDS * 1000 / 2) + 500;
            particles[i].playDelayed(delayMillis);
        }
    }

}
}
