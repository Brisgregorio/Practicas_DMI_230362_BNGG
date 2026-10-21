package com.example.tok_tik

import android.content.ComponentName
import android.content.Context
import android.content.pm.PackageManager

/** Configures the seasonal launcher alias while retaining MainActivity as the only target. */
class DateChangeReceiver {
    companion object {
        val aliases = listOf(
            "com.example.tok_tik.MainActivityNormal",
            "com.example.tok_tik.MainActivityHalloween",
            "com.example.tok_tik.MainActivityNavidad",
            "com.example.tok_tik.MainActivityValentine"
        )

        /** Returns true only after exactly one requested launcher alias is enabled. */
        fun updateAppIcon(context: Context, targetSeason: String): Boolean {
            val targetAlias = when (targetSeason.lowercase()) {
                "normal" -> "com.example.tok_tik.MainActivityNormal"
                "halloween" -> "com.example.tok_tik.MainActivityHalloween"
                "navidad" -> "com.example.tok_tik.MainActivityNavidad"
                "valentine" -> "com.example.tok_tik.MainActivityValentine"
                else -> throw IllegalArgumentException("Tema no reconocido: $targetSeason")
            }

            val packageManager = context.packageManager
            val previousStates = aliases.associateWith { alias ->
                packageManager.getComponentEnabledSetting(ComponentName(context, alias))
            }

            try {
                // Enable first so the package always has a launch entry during the transition.
                packageManager.setComponentEnabledSetting(
                    ComponentName(context, targetAlias),
                    PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                    PackageManager.DONT_KILL_APP
                )
                aliases.filter { it != targetAlias }.forEach { alias ->
                    packageManager.setComponentEnabledSetting(
                        ComponentName(context, alias),
                        PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                        PackageManager.DONT_KILL_APP
                    )
                }
                return true
            } catch (error: Exception) {
                // Roll back partial updates to avoid leaving multiple launcher entries enabled.
                previousStates.forEach { (alias, state) ->
                    try {
                        packageManager.setComponentEnabledSetting(
                            ComponentName(context, alias),
                            state,
                            PackageManager.DONT_KILL_APP
                        )
                    } catch (_: Exception) {
                        // Keep the original error; Flutter reports the operation as failed.
                    }
                }
                throw error
            }
        }
    }
}
