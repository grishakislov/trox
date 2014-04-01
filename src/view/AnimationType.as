package view {
public class AnimationType {

    public static const LOOPED:AnimationType = new AnimationType("looped");
    public static const TRANSLATION:AnimationType = new AnimationType("translation");
    public static const ONCE:AnimationType = new AnimationType("once");
    public static const NONE:AnimationType = new AnimationType("none");

    private var type:String;

    public function AnimationType(type:String) {
        this.type = type;
    }

    public function getType():String {
        return type;
    }

    public function setType(value:String):void {
        type = value;
    }
}
}
