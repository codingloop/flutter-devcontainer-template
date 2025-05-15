# Dockerfile for reusable Flutter + Android SDK development container
FROM debian:stable-slim

# Install essential tools and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    git \
    unzip \
    zip \
    xz-utils \
    openjdk-17-jdk \
    build-essential \
    openssh-server \
    vim \
    sudo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash dev \
 && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set environment variables
ENV ANDROID_HOME=/opt/android-sdk
ENV FLUTTER_HOME=/opt/flutter
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$FLUTTER_HOME/bin:$JAVA_HOME/bin:$PATH

# Install Node.js & Firebase CLI
RUN wget -q https://nodejs.org/dist/v20.18.0/node-v20.18.0-linux-x64.tar.xz -O /tmp/node.tar.xz \
 && tar -C /usr/local --strip-components=1 -xJf /tmp/node.tar.xz \
 && rm /tmp/node.tar.xz \
 && npm install -g firebase-tools

# Install Android command line tools
RUN mkdir -p $ANDROID_HOME/cmdline-tools \
 && wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/cmdline.zip \
 && unzip -q /tmp/cmdline.zip -d $ANDROID_HOME/cmdline-tools \
 && mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest \
 && rm /tmp/cmdline.zip \
 && yes | sdkmanager --licenses \
 && sdkmanager \
     "platform-tools" \
     "platforms;android-34" \
     "build-tools;34.0.0" \
     "ndk;28.1.13356709" \
 && chown -R dev:dev $ANDROID_HOME \
 && mkdir /home/dev/.android \
 && chown -R dev:dev /home/dev/.android

# Install Flutter SDK
RUN wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.29.3-stable.tar.xz -O /tmp/flutter.tar.xz \
 && mkdir -p $FLUTTER_HOME \
 && tar -xJf /tmp/flutter.tar.xz -C $FLUTTER_HOME --strip-components=1 \
 && rm /tmp/flutter.tar.xz \
 && chown -R dev:dev $FLUTTER_HOME

USER dev

# Setup Flutter
RUN flutter config --no-analytics && flutter precache --android

WORKDIR /workspaces
CMD ["bash"]