package com.leijendary.flutter.flutter_sample

import android.os.Bundle
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import java.awt.SystemColor.window

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(window, false)

        // Disable the Android splash screen fade out animation to avoid
        // a flicker before the similar frame is drawn in Flutter.
        installSplashScreen().setOnExitAnimationListener { it.remove() }

        super.onCreate(savedInstanceState)
    }
}
