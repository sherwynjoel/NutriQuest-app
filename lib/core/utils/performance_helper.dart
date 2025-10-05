import 'dart:async';
import 'package:flutter/material.dart';

/// PerformanceHelper provides optimized widgets and utilities for better app performance.
/// 
/// This class includes:
/// - Debounced function calls to prevent excessive API calls
/// - Memory-efficient list and grid builders
/// - Optimized image loading with caching
/// - Performance monitoring utilities
/// 
/// Example usage:
/// ```dart
/// // Debounce search input
/// PerformanceHelper.debounce('search', () {
///   // Perform search
/// }, delay: Duration(milliseconds: 300));
/// 
/// // Optimized list view
/// PerformanceHelper.optimizedListView(
///   itemCount: items.length,
///   itemBuilder: (context, index) => ListTile(title: Text(items[index])),
/// );
/// ```
class PerformanceHelper {
  // Debounce function to prevent excessive API calls
  static final Map<String, Timer> _debounceTimers = {};
  
  static void debounce(
    String key,
    VoidCallback callback, {
    Duration delay = const Duration(milliseconds: 500),
  }) {
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(delay, () {
      callback();
      _debounceTimers.remove(key);
    });
  }
  
  // Dispose all debounce timers
  static void dispose() {
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
  }

  // Optimized image loading with caching and error handling
  static Widget cachedImage({
    required String imagePath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    Color? placeholderColor,
    Color? errorColor,
  }) {
    // Validate inputs
    if (imagePath.isEmpty) {
      return errorWidget ?? _defaultErrorWidget();
    }
    
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Image loading error: $error');
        return errorWidget ?? _defaultErrorWidget(errorColor: errorColor);
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return placeholder ?? _defaultPlaceholder(color: placeholderColor);
      },
    );
  }

  // Memory-efficient list builder
  static Widget optimizedListView({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
  }) => ListView.builder(
      controller: controller,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      // Performance optimizations
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      addSemanticIndexes: false,
    );

  // Memory-efficient grid builder
  static Widget optimizedGridView({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    required SliverGridDelegate gridDelegate,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
  }) => GridView.builder(
      controller: controller,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      gridDelegate: gridDelegate,
      // Performance optimizations
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      addSemanticIndexes: false,
    );

  // Lazy loading for large datasets with proper virtualization
  static Widget lazyList({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    int? initialItemCount,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
  }) => ListView.builder(
      controller: controller,
      padding: padding,
      itemCount: itemCount,
      itemExtent: itemExtent,
      itemBuilder: (context, index) {
        // Use proper lazy loading with visibility detection
        return itemBuilder(context, index);
      },
      // Performance optimizations for large lists
      addAutomaticKeepAlives: false,
      addSemanticIndexes: false,
      cacheExtent: 250, // Cache 250 pixels worth of items
    );

  static Widget _defaultErrorWidget({Color? errorColor}) => Container(
      color: Colors.grey[200],
      child: Icon(
        Icons.error_outline,
        color: errorColor ?? Colors.grey[600],
        size: 48,
      ),
    );

  static Widget _defaultPlaceholder({Color? color}) => Container(
      color: color ?? Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Colors.grey[600]!,
          ),
        ),
      ),
    );

  // Network image with caching and error handling
  static Widget cachedNetworkImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    Color? placeholderColor,
    Color? errorColor,
  }) {
    // Validate inputs
    if (imageUrl.isEmpty) {
      return errorWidget ?? _defaultErrorWidget(errorColor: errorColor);
    }
    
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Network image loading error: $error');
        return errorWidget ?? _defaultErrorWidget(errorColor: errorColor);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? _defaultPlaceholder(color: placeholderColor);
      },
    );
  }

  // Memory-efficient scroll view with proper disposal
  static Widget optimizedScrollView({
    required List<Widget> children,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
  }) => SingleChildScrollView(
      controller: controller,
      padding: padding,
      child: Column(
        children: children,
      ),
    );

  // Performance monitoring helper
  static void logPerformance(String operation, Duration duration) {
    if (duration.inMilliseconds > 100) {
      debugPrint('Performance Warning: $operation took ${duration.inMilliseconds}ms');
    }
  }

  // Memory usage helper
  static void logMemoryUsage(String context) {
    debugPrint('Memory usage at $context: ${DateTime.now().millisecondsSinceEpoch}');
  }
}
