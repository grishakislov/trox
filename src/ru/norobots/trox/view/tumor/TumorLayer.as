package ru.norobots.trox.view.tumor {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import ru.norobots.trox.Assert;
import ru.norobots.trox.GameSettings;

public class TumorLayer {

    private var layer:MovieClip;
    private var tumors:Vector.<Tumor> = new Vector.<Tumor>();
    private var currentStep:uint = 0;

    public function TumorLayer(layer:DisplayObject) {
        this.layer = MovieClip(layer);
        this.layer.gotoAndStop(1);
        initializeChildren();
    }

    private function initializeChildren():void {
        const NUM_TUMORS:uint = 14;
        var tumor:DisplayObject;
        for (var i:int = 1; i <= NUM_TUMORS; i++) {
            tumor = layer.getChildByName("tumor" + i);
            addTumor(tumor);
        }
        shuffle();
    }

    private function shuffle():void {
        var shuffledTumors:Vector.<Tumor> = new Vector.<Tumor>();
        var numTumors:uint = tumors.length;
        var index:uint;
        for (var i:int = 0; i < numTumors; i++) {
            index = (tumors.length - 1) * Math.random();
            shuffledTumors.push(tumors.splice(index, 1)[0]);
        }
        tumors = shuffledTumors;
    }

    public function addTumor(tumor:DisplayObject):void {
        Assert.notNull(tumor);
        var newTumor:Tumor = new Tumor(tumor);
        newTumor.setVisible(false);
        tumors.push(newTumor);
    }

    public function setStep(step:uint):void {
        currentStep = step;
        showNextTumors();
    }

    private function showNextTumors():void {
        updateSteps()
        for (var i:int = getFirstIndex(); i <= getLastIndex(); i++) {
            tumors[i].setVisible(true);
            tumors[i].showArrows();
            tumors[i].startTumor();
        }
    }

    private function updateSteps():void {
        for (var i:int = 0; i < tumors.length; i++) {
            tumors[i].setStep(currentStep);
        }
    }

    private var firstIndexesByStep:Array = [0,3,6,8, 11,13];
    private var lastIndexesByStep:Array =  [2,5,7,10,12,13];

    private function getFirstIndex():uint {
        return firstIndexesByStep[currentStep - 1];
    }

    private function getLastIndex():uint {
        return lastIndexesByStep[currentStep - 1];
    }


    public function getLayer():DisplayObject {
        return layer;
    }

    public function lock():void {
        for (var i:int = 0; i < tumors.length; i++) {
            tumors[i].lock();
        }
    }
}
}
