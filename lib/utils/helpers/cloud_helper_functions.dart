import 'package:flutter/cupertino.dart';

import '../popups/shimmers/vertical_product_shimmer.dart';

class CloudHelperFunctions {
  // Cloud helper functions to check the state of a single database record
  // Return the widget based on the state of snapshot
  // If data is still loading, return a progress indicator
  // If data is not found, return 'No Data Found' announcement
  // If snapshot state get error, return an error announcement
  // Otherwise, return null

  static Widget? checkSingleStateRecord<T>(AsyncSnapshot<T> snapshot) {
    // --- Check states of FutureBuilder snapshot
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: VerticalProductShimmer());
    }
    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }
    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong!'));
    }
    return null;
  }

  // Cloud helper functions to check the state of multiple (list) database records
  // Return the widget based on the state of snapshot
  // If data is still loading, return a progress indicator
  // If data is not found, return 'No Data Found' announcement
  // If snapshot state get error, return an error announcement
  // Otherwise, return null
  static Widget? checkMultipleStateRecord<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: VerticalProductShimmer());
    }
    if (!snapshot.hasData || snapshot.data == null) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found!'));
    }
    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong!'));
    }
    return null;
  }

  // --- Create a reference with an initial file path, name and retrieve download URL

}