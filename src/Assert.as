package {
public class Assert {

    public static function notNull(value:Object) {
        if (value == null) {
            throw new ArgumentError("Value can't be null!");
        }
    }
}
}
