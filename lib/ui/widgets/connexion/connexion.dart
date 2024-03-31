import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isDeviceConnected = false.obs;
  final RxBool isAlertSet = false.obs;
  late StreamSubscription subscription;

  @override 
  void onInit() {
    super.onInit();
    getConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus as void Function(List<ConnectivityResult> event)?);
  }


  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
      
      if (connectivityResult == ConnectivityResult.none) {
        showDialogBox();

        // Get.rawSnackbar(
        //   messageText: const Text(
        //     'PLEASE CONNECT TO THE INTERNET',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 14
        //     )
        //   ),
        //   isDismissible: false,
        //   duration: const Duration(days: 1),
        //   backgroundColor: Colors.red[400]!,
        //   icon : const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
        //   margin: EdgeInsets.zero,
        //   snackStyle: SnackStyle.GROUNDED
        // );
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
      }
  }

getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected.value =
            await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected.value && !isAlertSet.value) {
          showDialogBox();
          isAlertSet.value = true;
        }
      } as void Function(List<ConnectivityResult> event)?,
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: Get.overlayContext!,
        builder: (BuildContext context) => AlertDialog(
          elevation: 20,
          icon: Icon(Icons.signal_wifi_connected_no_internet_4),
          iconColor: Colors.red,
          title: const Text('Aucune Connexion Internet !', style: TextStyle(
            color: Colors.red,
            fontSize: 18,
          ),),
          content: const Text('Veuillez vérifier votre connexion internet.',style: TextStyle(
            fontSize: 15
          ),),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Get.back();
                isAlertSet.value = false;
                isDeviceConnected.value =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected.value && !isAlertSet.value) {
                  showDialogBox();
                  isAlertSet.value = true;
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}