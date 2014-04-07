package ru.norobots.trox.view {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.norobots.trox.animation.BaseAnimation;
import ru.norobots.trox.animation.TranslationAnimation;

public class RasterizedMovieClip extends MovieClip {

    protected var visual:MovieClip;
    private var frames:Vector.<RasterizedFrame>;

    protected var animation:BaseAnimation;

    private var container:Bitmap;

    private var replaceChildren:Boolean;

    public function RasterizedMovieClip(visual:MovieClip, replaceChildren:Boolean = false) {
        this.visual = visual;
        this.replaceChildren = replaceChildren;
        frames = new Vector.<RasterizedFrame>(visual.totalFrames);
        rasterize();

        if (replaceChildren) {
            visual.removeChildren();
            for (var i:int = 1; i <= visual.totalFrames; i++) {
                visual.gotoAndStop(i);
                visual.removeChildren();
                var spr:Bitmap = new Bitmap();
                visual.addChild(spr);
                spr.bitmapData = frames[i - 1].frame;
                spr.x = frames[i - 1].position.x;
                spr.y = frames[i - 1].position.y;
            }
            visual.gotoAndStop(1);
        } else {
            container = new Bitmap();
            container.smoothing = true;
            addChild(container);
        }

        gotoAndStop(1);

    }

    public function playWithAnimation(animation:BaseAnimation = null):void {
        if (animation == null) {
            this.animation = new TranslationAnimation();
        } else {
            this.animation = animation;
        }
        this.animation.run();
    }

    override public function gotoAndStop(frame:Object, scene:String = null):void {
        visual.gotoAndStop(frame, scene);
        if (!replaceChildren) {
            var frameData:RasterizedFrame = frames[visual.currentFrame - 1];
            container.bitmapData = null;
            container.bitmapData = frameData.frame;
            container.x = frameData.position.x;
            container.y = frameData.position.y;
        }
    }

    private function rasterize():void {
        for (var i:int = 1; i <= visual.totalFrames; i++) {
            visual.gotoAndStop(i);
            frames[i - 1] = process(visual);
            var frameBitmap:Bitmap = new Bitmap(frames[i - 1].frame);
            frameBitmap.x = frames[i - 1].position.x;
            frameBitmap.x = frames[i - 1].position.y;
        }
    }

    public static function process(frame:MovieClip):RasterizedFrame {
        var m:Matrix = new Matrix();

        var r:Rectangle;

        r = frame.getBounds(frame.parent);
        //TODO: ?

//        correctRectangle(r);

        m.translate(-r.x, -r.y);

        if (r.width == 0) {
            r.height = r.width = 1;
        }

        var bmd:BitmapData = new BitmapData(Math.ceil(r.width), Math.ceil(r.height), true, 0);
        bmd.draw(frame, m, null, null, null, true);

        var position:Point = new Point();
        position.x = r.x;
        position.y = r.y;

        var result:RasterizedFrame = new RasterizedFrame();
        result.frame = bmd;
        result.position = position;
        return result;
    }

    private static function correctRectangle(rect:Rectangle):void {
        rect.left = Math.floor(rect.left);
        rect.top = Math.floor(rect.top);
        rect.bottom = Math.ceil(rect.bottom);
        rect.right = Math.ceil(rect.right);
    }

    override public function get currentFrame():int {
        return visual.currentFrame;
    }

    override public function get totalFrames():int {
        return visual.totalFrames;
    }

    public function setVisible(value:Boolean):void {
        visual.visible = value;
    }

    public function getFrames():Vector.<RasterizedFrame> {
        return frames;
    }
}
}
