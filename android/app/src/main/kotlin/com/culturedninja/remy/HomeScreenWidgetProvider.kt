package com.culturedninja.remy

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.os.AsyncTask
import android.widget.RemoteViews
import com.squareup.picasso.Picasso
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

            // Retrieve title and image URL from SharedPreferences
            val title: String = widgetData.getString("api_title", "Title not found") ?: "Title not found"
            val imageUrl: String = widgetData.getString("api_image_url", "") ?: ""

            views.setTextViewText(R.id.tv_title, title)

            if (imageUrl.isNotEmpty()) {
                ImageLoadTask(context, views, appWidgetManager, widgetId).execute(imageUrl)
            } else {
                views.setImageViewResource(R.id.iv_banner_image, R.drawable.placeholder_image)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        }
    }

    private class ImageLoadTask(
        val context: Context,
        val views: RemoteViews,
        val appWidgetManager: AppWidgetManager,
        val widgetId: Int
    ) : AsyncTask<String, Void, Bitmap?>() {

        override fun doInBackground(vararg params: String?): Bitmap? {
            return try {
                val url = params[0]
                Picasso.get().load(url).get()
            } catch (e: Exception) {
                e.printStackTrace()
                null
            }
        }

        override fun onPostExecute(result: Bitmap?) {
            if (result != null) {
                views.setImageViewBitmap(R.id.iv_banner_image, result)
            } else {
                views.setImageViewResource(R.id.iv_banner_image, R.drawable.placeholder_image)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
