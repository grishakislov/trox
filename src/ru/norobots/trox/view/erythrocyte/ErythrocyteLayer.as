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

    private var settings:ParticleSettings;

    private var numVisibleParticles:uint = 0;

    public function ErythrocyteLayer(visual:DisplayObject) {
        Assert.notNull(visual);
        this.visual = MovieClip(visual);
        initializeChildren();
        initializeAnimation();

        for (var i:int = 1; i <= GameSettings.VEIN_STEPS; i++) {
            currentStep = i;
            trace("Current step: " + i);
            trace(getFirstParticleIndex());
            trace(getLastParticleIndex());
            trace("========================");
        }
        !1;
    }

    private function initializeChildren():void {
        var current:Erythrocyte;
        settings = new ParticleSettings();
        for (var i:int = 1; i <= TOTAL_PARTICLES; i++) {
            current = new Erythrocyte(visual.getChildByName("e" + i), settings);
            current.setVisible(false);
            particles.push(current);
        }
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
            delayMillis = Math.random() * 500 + 200;
            particles[i].playDelayed(counter * delayMillis); //TODO:
            counter++;
        }
    }
}
}
