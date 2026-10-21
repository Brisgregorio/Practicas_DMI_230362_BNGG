package com.example.tok_tik

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.toktik/app_icon"
    private var pendingSeason: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "changeIcon" -> {
                    val season = call.argument<String>("season") ?: "normal"
                    try {
                        // Android launchers may stop/recreate the app when an alias is
                        // disabled. Persist the choice in Flutter and switch aliases only
                        // after this activity leaves the foreground.
                        if (getCurrentAppIcon() != season.lowercase()) {
                            pendingSeason = season
                        }
                        result.success(true)
                    } catch (error: Exception) {
                        result.error("ICON_UPDATE_FAILED", error.message ?: "No se pudo actualizar el icono", null)
                    }
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
        applyPendingSeason()
    }

    override fun onDestroy() {
        applyPendingSeason()
        super.onDestroy()
    }

    private fun applyPendingSeason() {
        val season = pendingSeason ?: return
        pendingSeason = null
        try {
            DateChangeReceiver.updateAppIcon(applicationContext, season)
        } catch (error: Exception) {
            android.util.Log.e("TokTik", "No se pudo actualizar el icono de la app", error)
        }
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
