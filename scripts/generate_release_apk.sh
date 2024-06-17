flutter build apk --release  --target-platform android-arm --no-tree-shake-icons --no-shrink
flutter build apk --release  --target-platform android-arm  --no-shrink
flutter build apk --obfuscate --split-debug-info=./build/info --target-platform=android-arm

#last time this work
flutter build apk --release  --no-tree-shake-icons --no-shrink
