# Preserve the android.window.BackEvent class
-keep class android.window.BackEvent {
    *;
}

# Preserve the FlutterView class and its methods
-keep class io.flutter.view.FlutterView {
    *;
}

# Preserve annotations
-keepattributes *Annotation*

# Preserve public classes, interfaces, and enums
-keep public class * {
    public protected *;
}

# Preserve public methods in public classes
-keepclassmembers public class * {
    public *;
}

# Preserve public fields in public classes
-keepclassmembers public class * {
    public *;
}

# Preserve classes with specific annotations
-keep @interface * {
    *;
}