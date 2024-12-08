package com.example.leviosa

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.mediapipe.tasks.core.BaseOptions
import com.google.mediapipe.tasks.vision.gesturerecognizer.GestureRecognizer
import com.google.mediapipe.tasks.vision.core.RunningMode
import com.google.mediapipe.framework.image.BitmapImageBuilder




class MainActivity: FlutterActivity() {
    private val CHANNEL = "kotlin"
    private var gestureRecognizer: GestureRecognizer? = null

    private val baseOptionBuilder = BaseOptions.builder().setModelAssetPath("model.task")


    private fun setup() {
        val baseOptions = baseOptionBuilder.build()
        val optionsBuilder = GestureRecognizer.GestureRecognizerOptions.builder()
            .setBaseOptions(baseOptions)
            .setMinHandDetectionConfidence(0.5F)
            .setMinTrackingConfidence(0.5F)
            .setMinHandPresenceConfidence(0.5F)
            .setRunningMode(RunningMode.IMAGE)
        optionsBuilder.build()
        val options = optionsBuilder.build()
        gestureRecognizer =
            GestureRecognizer.createFromOptions(context, options)

    }





    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setup()
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                // Handle Flutter method calls
                when (call.method) {
                    "predict" -> {
                        val imageBytes = call.arguments as ByteArray
                        val prediction = recognize(imageBytes)
                        result.success(prediction) // Send message back to Flutter
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun byteArrayToBitmap(byteArray: ByteArray): Bitmap? {
        return BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
    }

    private fun recognize(imageBytes: ByteArray): String {
        val image = byteArrayToBitmap(imageBytes)
        val mpImage = BitmapImageBuilder(image).build()
        val result = gestureRecognizer?.recognize(mpImage)
        return result?.gestures().toString()
    }
}
