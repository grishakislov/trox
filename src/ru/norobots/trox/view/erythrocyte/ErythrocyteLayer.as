package ru.norobots.trox.view.erythrocyte {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import ru.norobots.trox.Assert;
import ru.norobots.trox.GameSettings;
import ru.norobots.trox.animation.LoopAnimation;

public class ErythrocyteLayer {

    private var currentStep:uint = 1;
    private var visual:MovieClip;
    private static const PARTICLES_IN_STEP:uint = 7;
    private static const TOTAL_PARTICLES:uint = GameSettings.VEIN_STEPS * PARTICLES_IN_STEP;
    private var particles:Vector.<Erythrocyte> = new Vector.<Erythrocyte>();

    private var settings:ParticleSettings;

    var layer:Sprite;

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

    private function initializeChildren():void {
        var current:Erythrocyte;
        var currentBundle:MovieClip;
        settings = new ParticleSettings();
        for (var i:int = 1; i <= GameSettings.VEIN_STEPS; i++) {
            currentBundle = MovieClip(visual.getChildByName("particles" + i));
            for (var j:int = 0; j < PARTICLES_IN_STEP; j++) {
                var mc:DisplayObject = currentBundle.getChildByName("e" + j);
                current = new Erythrocyte(mc, settings);
                current.setVisible(false);
                particles.push(current);
                layer.addChild(mc);
            }
        }
    }

    private function initializeAnimation():void {
        var numParticles = getParticlesNumByStep();
        var currentParticle:Erythrocyte;
        for (var i:int = 0; i < numParticles; i++) {
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

    public function setStep(step:uint):void {
        trace("Step " + step);
        currentStep = step;
        if (currentStep > 1) { //Because first step already initialized
            addParticles(getFirstParticleIndex(), getLastParticleIndex());
        }
    }

    private function addParticles(firstParticleIndex:uint, lastParticleIndex:uint):void {
        var counter:uint = 1;
        var delayMillis:uint;
        for (var i:int = firstParticleIndex; i <= lastParticleIndex; i++) {
            particles[i].setVisible(true);
            delayMillis = Math.random() * 800 + 200;
            particles[i].playDelayed(counter * delayMillis); //TODO:
//            particles[i].playParticleLooped();
            counter++;
        }
    }

    public function getLayer():DisplayObject {
        return layer;
    }

}
}
