package com.example.tok_tik

import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import java.util.Calendar

class DateChangeReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action
        if (action == Intent.ACTION_DATE_CHANGED ||
            action == Intent.ACTION_TIME_CHANGED ||
            action == Intent.ACTION_TIMEZONE_CHANGED ||
            action == Intent.ACTION_BOOT_COMPLETED) {

            val season = calculateSeason()
            updateAppIcon(context, season)
        }
    }

    companion object {
        val aliases = listOf(
            "com.example.tok_tik.MainActivityNormal",
            "com.example.tok_tik.MainActivityHalloween",
            "com.example.tok_tik.MainActivityNavidad",
            "com.example.tok_tik.MainActivityValentine"
        )

        fun calculateSeason(): String {
            val calendar = Calendar.getInstance()
            val month = calendar.get(Calendar.MONTH) + 1 // 1-12
            val day = calendar.get(Calendar.DAY_OF_MONTH)

            return when {
                month == 2 -> "valentine"
                month == 10 || (month == 11 && day <= 3) -> "halloween"
                month == 12 || (month == 1 && day <= 6) -> "navidad"
                else -> "normal"
            }
        }

        fun updateAppIcon(context: Context, targetSeason: String): Boolean {
            val targetAlias = when (targetSeason.lowercase()) {
                "halloween" -> "com.example.tok_tik.MainActivityHalloween"
                "navidad", "christmas" -> "com.example.tok_tik.MainActivityNavidad"
                "valentine", "san_valentin" -> "com.example.tok_tik.MainActivityValentine"
                else -> "com.example.tok_tik.MainActivityNormal"
            }

            val pm = context.packageManager
            var hasChanged = false

            // 1. Primero habilitar el alias objetivo para asegurar que siempre haya un punto de entrada activo
            val targetComponent = ComponentName(context, targetAlias)
            if (pm.getComponentEnabledSetting(targetComponent) != PackageManager.COMPONENT_ENABLED_STATE_ENABLED) {
                pm.setComponentEnabledSetting(
                    targetComponent,
                    PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                    PackageManager.DONT_KILL_APP
                )
                hasChanged = true
            }

            // 2. Deshabilitar los demás aliases
            val isDebug = (context.applicationInfo.flags and android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE) != 0
            for (alias in aliases) {
                if (alias != targetAlias) {
                    // En modo DEBUG evitamos deshabilitar MainActivityNormal para que el CLI de Flutter
                    // pueda siempre arrancar la aplicación sin que falle con 'Error type 3: Activity does not exist'
                    if (isDebug && alias == "com.example.tok_tik.MainActivityNormal") {
                        continue
                    }
                    val component = ComponentName(context, alias)
                    if (pm.getComponentEnabledSetting(component) != PackageManager.COMPONENT_ENABLED_STATE_DISABLED) {
                        pm.setComponentEnabledSetting(
                            component,
                            PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                            PackageManager.DONT_KILL_APP
                        )
                        hasChanged = true
                    }
                }
            }
            return hasChanged
        }
    }
}
