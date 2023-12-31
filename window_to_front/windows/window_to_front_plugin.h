// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_
#define FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace window_to_front {

class WindowToFrontPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WindowToFrontPlugin(flutter::PluginRegistrarWindows *registrar);

  virtual ~WindowToFrontPlugin();

  // Disallow copy and assign.
  WindowToFrontPlugin(const WindowToFrontPlugin&) = delete;
  WindowToFrontPlugin& operator=(const WindowToFrontPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

  // The registrar for this plugin, for accessing the window.
  flutter::PluginRegistrarWindows *registrar_;
};

}  // namespace window_to_front

#endif  // FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_