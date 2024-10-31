package com.example.final_movie

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeScreenWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_layout)

            // Retrieve title from SharedPreferences and set it in the TextView
            val title: String = widgetData.getString("api_title", "Title not found") ?:
            "Title not found"
            views.setTextViewText(R.id.tv_title, "Title: $title")



            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}