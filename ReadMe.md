# Flutter Dev Container

Reusable development environment for Flutter + Android SDK + Firebase CLI using Docker and VS Code devcontainers.

## How to Use

### 1. Build and Publish to GitHub Container Registry
Push to `main` to build and publish the Docker image:

```bash
git push origin main
```

### 2. Use in Your Flutter Projects
In your project’s `.devcontainer/devcontainer.json`, reference the image:

```json
{
  "name": "my-flutter-project",
  "image": "ghcr.io/YOUR_GITHUB_USERNAME/flutter-devcontainer:latest",
  "workspaceFolder": "/workspace",
  ...
}
```

## Included Tools
- Flutter SDK
- Android SDK + NDK
- Firebase CLI
- Node.js
- OpenJDK 17