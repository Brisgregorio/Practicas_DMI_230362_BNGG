package com.example.tok_tik

import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.toktik/app_icon"
    private var pendingSeason: String? = null

    private val timeChangeReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val season = DateChangeReceiver.calculateSeason()
            val current = getCurrentAppIcon()
            if (current != season.lowercase()) {
                pendingSeason = season
            }
        }
    }

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        val isDebug = (applicationInfo.flags and android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE) != 0
        if (isDebug) {
            try {
                val normalComponent = ComponentName(applicationContext, "com.example.tok_tik.MainActivityNormal")
                if (packageManager.getComponentEnabledSetting(normalComponent) != PackageManager.COMPONENT_ENABLED_STATE_ENABLED) {
                    packageManager.setComponentEnabledSetting(
                        normalComponent,
                        PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                        PackageManager.DONT_KILL_APP
                    )
                }
            } catch (_: Exception) {}
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        try {
            val filter = IntentFilter().apply {
                addAction(Intent.ACTION_DATE_CHANGED)
                addAction(Intent.ACTION_TIME_CHANGED)
                addAction(Intent.ACTION_TIMEZONE_CHANGED)
            }
            registerReceiver(timeChangeReceiver, filter)
        } catch (_: Exception) {}

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "changeIcon" -> {
                    val season = call.argument<String>("season") ?: "normal"
                    val immediate = call.argument<Boolean>("immediate") ?: false
                    
                    val current = getCurrentAppIcon()
                    if (current != season.lowercase()) {
                        if (immediate) {
                            DateChangeReceiver.updateAppIcon(applicationContext, season)
                        } else {
                            // Guardar para aplicar en onStop (cuando el usuario minimiza/sale de la app)
                            // Esto evita que Android mate la app de forma forzosa frente al usuario en el arranque
                            pendingSeason = season
                        }
                    }
                    result.success(true)
                }
                "getCurrentIcon" -> {
                    result.success(getCurrentAppIcon())
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onStop() {
        super.onStop()
        // Cuando el usuario sale a la pantalla de inicio o cambia de app, se aplica el nuevo icono sin interrumpir
        pendingSeason?.let { season ->
            DateChangeReceiver.updateAppIcon(applicationContext, season)
            pendingSeason = null
        }
    }

    override fun onDestroy() {
        try {
            unregisterReceiver(timeChangeReceiver)
        } catch (_: Exception) {}

        pendingSeason?.let { season ->
            DateChangeReceiver.updateAppIcon(applicationContext, season)
            pendingSeason = null
        }
        super.onDestroy()
    }

    private fun getCurrentAppIcon(): String {
        val pm = applicationContext.packageManager
        for (alias in DateChangeReceiver.aliases) {
            val component = ComponentName(applicationContext, alias)
            if (pm.getComponentEnabledSetting(component) == PackageManager.COMPONENT_ENABLED_STATE_ENABLED) {
                return when {
                    alias.contains("Halloween") -> "halloween"
                    alias.contains("Navidad") -> "navidad"
                    alias.contains("Valentine") -> "valentine"
                    else -> "normal"
                }
            }
        }
        return "normal"
    }
}
