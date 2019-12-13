## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
-ignorewarnings

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

#-keep class com.kakao.** { *; }
#-keepattributes Signature
#-keepclassmembers class * {
#  public static <fields>;
#  public *;
#}
#-dontwarn android.support.v4.**,org.slf4j.**,com.google.android.gms.**