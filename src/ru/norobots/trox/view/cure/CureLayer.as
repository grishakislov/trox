package ru.norobots.trox.view.cure {
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import ru.norobots.trox.Assert;

public class CureLayer {

    private var visual:MovieClip;
    private var particles:Vector.<Cure> = new Vector.<Cure>();
    private var layer:Sprite;

    public function CureLayer(visual:DisplayObject) {
        Assert.notNull(visual);
        this.visual = MovieClip(visual);
        layer = new Sprite();
        initializeChildren();
        initializeAnimation();
    }

    public function play():void {
        for (var i:int = 0; i < particles.length; i++) {
            particles[i].playDelayed();
        }
    }

    public function getLayer():Sprite {
        return layer;
    }

    protected function initializeChildren():void {
        var current:Cure;
        for (var i:int = 0; i < 7; i++) {
            var mc:DisplayObject = visual.getChildByName("c" + i);
            current = new Cure(mc);
            particles.push(current);
            layer.addChild(mc);
        }
    }

    protected function initializeAnimation():void {
        var currentParticle:Cure;
        for (var i:int = 0; i < particles.length; i++) {
            currentParticle = particles[i];
            currentParticle.setVisible(true);

        }
    }
}
}
