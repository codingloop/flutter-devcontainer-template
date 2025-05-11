#!/bin/bash
set -e

# Read options
BUILD_TOOLS_VERSIONS=${BUILDTOOLSVERSIONS:-""} # Comma-separated list of versions
PLATFORM_VERSIONS=${PLATFORMVERSIONS:-""}      # Comma-separated list of versions
NDK_VERSIONS=${NDKVERSIONS:-""}                # Comma-separated list of versions
ANDROID_HOME=${ANDROID_HOME:-"/opt/android-sdk"}

echo "Installing Android SDK components..."
mkdir -p $ANDROID_HOME/cmdline-tools
if [ ! -d "$ANDROID_HOME/cmdline-tools/latest" ]; then
    echo "Android SDK command-line tools not found. Installing..."
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/cmdline.zip
    unzip -q /tmp/cmdline.zip -d $ANDROID_HOME/cmdline-tools
    mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest
    rm /tmp/cmdline.zip
else
    echo "Android SDK command-line tools already installed. Skipping..."
fi

# Install multiple platform versions
if [ -n "$PLATFORM_VERSIONS" ]; then
    IFS=',' read -ra PLATFORM_ARRAY <<< "$PLATFORM_VERSIONS"
    for VERSION in "${PLATFORM_ARRAY[@]}"; do
        echo "Installing platform version: $VERSION..."
        $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;$VERSION"
    done
else
    echo "No platform versions specified. Skipping..."
fi

# Install multiple build-tools versions
if [ -n "$BUILD_TOOLS_VERSIONS" ]; then
    IFS=',' read -ra BUILD_TOOLS_ARRAY <<< "$BUILD_TOOLS_VERSIONS"
    for VERSION in "${BUILD_TOOLS_ARRAY[@]}"; do
        echo "Installing build-tools version: $VERSION..."
        $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "build-tools;$VERSION"
    done
else
    echo "No build-tools versions specified. Skipping..."
fi

# Install multiple NDK versions
if [ -n "$NDK_VERSIONS" ]; then
    IFS=',' read -ra NDK_ARRAY <<< "$NDK_VERSIONS"
    for VERSION in "${NDK_ARRAY[@]}"; do
        echo "Installing NDK version: $VERSION..."
        $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "ndk;$VERSION"
    done
else
    echo "No NDK versions specified. Skipping..."
fi

# Set permissions
chown -R dev:dev $ANDROID_HOME

echo "Android SDK setup complete!"