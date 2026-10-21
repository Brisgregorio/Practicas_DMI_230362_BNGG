package com.example.tok_tik

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.toktik/app_icon"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "changeIcon" -> {
                    val season = call.argument<String>("season") ?: "normal"
                    try {
                        val changed = DateChangeReceiver.updateAppIcon(applicationContext, season)
                        result.success(changed)
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
