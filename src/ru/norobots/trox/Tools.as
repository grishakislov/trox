package ru.norobots.trox {
import deng.fzip.FZip;

import flash.display.BitmapData;
import flash.net.FileReference;
import flash.utils.ByteArray;

import mx.graphics.codec.PNGEncoder;

import ru.norobots.trox.view.RasterizedFrame;
import ru.norobots.trox.view.RasterizedMovieClip;

public class Tools {

    public static function saveRC(clip:RasterizedMovieClip):void {
        var frames:Vector.<RasterizedFrame> = clip.getFrames();
        var result:Vector.<BitmapData> = new Vector.<BitmapData>();

        for (var i:int = 0; i < frames.length; i++) {
            result.push(frames[i].frame.clone());
        }

        var zip:FZip = new FZip();
        var encoder:PNGEncoder = new PNGEncoder();
        var currentPNG:ByteArray;
        for (var i:int = 0; i < result.length; i++) {

            currentPNG = encoder.encode(result[i]);
            zip.addFile("f" + i + ".png", currentPNG);
        }

                var fr:FileReference = new FileReference();
        var zipByteArray = new ByteArray();
        zip.serialize(zipByteArray);

        fr.save(zipByteArray, "frames.zip");

    }
}
}
