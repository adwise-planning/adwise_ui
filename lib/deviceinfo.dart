import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final battery = Battery();
    final networkInfo = NetworkInfo();
    final packageInfo = await PackageInfo.fromPlatform();

    // ScreenSize       string `json:"screen_size"`
    // Resolution       string `json:"resolution"`
    // Camera           string `json:"camera"`
    // Sensors          string `json:"sensors"`
    // Ports            string `json:"ports"`
    // Dimensions       string `json:"dimensions"`
    // Weight           string `json:"weight"`
    // Color            string `json:"color"`
    // Material         string `json:"material"`
    // PowerSource      string `json:"power_source"`
    // SignalStrength   int    `json:"signal_strength"`
    // NetworkProvider  string `json:"network_provider"`
    // PlanType         string `json:"plan_type"`
    // SubscriptionEnd  string `json:"subscription_end"`
    // Status           string `json:"status"`
    // LastSeen         string `json:"last_seen"`
    // Location         string `json:"location"`
    // Owner            string `json:"owner"`
    // CreatedAt        string `json:"created_at"`
    // UpdatedAt        string `json:"updated_at"`
    // UsageTime        string `json:"usage_time"`
    // Notes            string `json:"notes"`

    String deviceId = "Unknown";
    String name = "Unknown";
    String deviceType = "Unknown";
    String manufacturer = "Unknown";
    String model = "Unknown";
    String osVersion = "Unknown";
    String serialNumber = "Unknown";
    String hardwareVersion = "Unknown";
    String processor = "Unknown";
    int memory = 0;
    int storageCapacity = 0;
    String ip = "Unknown";
    String macAddress = "Unknown";
    String connectivityType = "Unknown";
    int batteryLevel = 0;
    
    try {
      if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      name = androidInfo.device;
      manufacturer = androidInfo.manufacturer;
      model = androidInfo.model;
      osVersion = "Android ${androidInfo.version.release}";
      serialNumber = androidInfo.serialNumber ?? "Unknown";
      hardwareVersion = androidInfo.hardware;
      memory = androidInfo.systemFeatures.length; // Example for memory
      } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "Unknown";
      name = iosInfo.name;
      manufacturer = "Apple";
      model = iosInfo.utsname.machine;
      osVersion = iosInfo.systemVersion;
      serialNumber = "N/A"; // Serial numbers are restricted on iOS
      hardwareVersion = iosInfo.systemName;
      } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      name = windowsInfo.computerName ?? "Windows PC";
      osVersion = windowsInfo.productName ?? "Unknown Windows Version";
      manufacturer = "Microsoft";
      deviceType = "Desktop";
      } else if (Platform.isMacOS) {
      final macInfo = await deviceInfo.macOsInfo;
      name = macInfo.computerName ?? "Mac Device";
      osVersion = macInfo.osRelease ?? "Unknown macOS Version";
      manufacturer = "Apple";
      model = macInfo.model ?? "Unknown Mac Model";
      deviceType = "Desktop";
      } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfo.linuxInfo;
      name = linuxInfo.name ?? "Linux Device";
      osVersion = linuxInfo.version ?? "Unknown Linux Version";
      manufacturer = "Unknown";
      model = linuxInfo.id ?? "Unknown Linux Model";
      deviceType = "Desktop";
      } else {
      deviceType = "Unknown"; // For platforms like embedded systems or web
      }
    } catch (e) {
      // Handle error
      print("Failed to get device info: $e");
    }

    // Battery Info
    // Fetch battery level (if available on the platform)
    try {
      batteryLevel = await battery.batteryLevel;
    } catch (e) {
      batteryLevel = -1; // Indicate battery info is not available
    }

    // Network Info
    ip = await networkInfo.getWifiIP() ?? "Unknown";
    macAddress = await networkInfo.getWifiBSSID() ?? "Unknown";

    return {
      'device_id': deviceId,
      'name': name,
      'type': Platform.operatingSystem,
      'manufacturer': manufacturer,
      'model': model,
      'serial_number': serialNumber,
      'imei': Platform.isAndroid ? deviceId : "N/A",
      'firmware': osVersion,
      'hardware_version': hardwareVersion,
      'software_version': packageInfo.version,
      'operating_system': osVersion,
      'processor': processor,
      'memory': memory,
      'storage_capacity': storageCapacity,
      'battery_level': batteryLevel,
      'ip_address': ip,
      'mac_address': macAddress,
      'connectivity_type': connectivityType,
      'status': "Active",
      'last_seen': DateTime.now().toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }
}
