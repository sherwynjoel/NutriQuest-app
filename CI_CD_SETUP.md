# CI/CD Setup Guide for NutriQuest

## 🚀 GitHub Actions Workflows

### 1. Flutter CI/CD (`/.github/workflows/flutter.yml`)

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` branch

**Jobs:**
1. **Test Job**:
   - Runs on Ubuntu latest
   - Sets up Java 11 and Flutter 3.16.0
   - Installs dependencies
   - Runs unit tests
   - Runs integration tests
   - Analyzes code
   - Checks formatting

2. **Build Job**:
   - Depends on test job
   - Builds web version
   - Builds APK
   - Uploads APK as artifact

3. **Deploy Job**:
   - Depends on build job
   - Only runs on `main` branch
   - Deploys to Firebase Hosting

### 2. Firebase Deploy (`/.github/workflows/firebase.yml`)

**Triggers:**
- Push to `main` branch
- Manual workflow dispatch

**Features:**
- Sets up Node.js 18 and Flutter 3.16.0
- Installs dependencies
- Builds web version
- Installs Firebase CLI
- Deploys to Firebase

## 🐳 Docker Configuration

### 1. Dockerfile
- **Base Image**: `cirrusci/flutter:3.16.0`
- **Build Process**: 
  - Copy pubspec files
  - Install dependencies
  - Copy source code
  - Build web version
- **Serving**: Uses nginx:alpine
- **Port**: 80

### 2. docker-compose.yml
- **Production Service**: `nutriquest-app` on port 3000
- **Development Service**: `nutriquest-dev` on port 3001
- **Environment Variables**: NODE_ENV
- **Volumes**: Development volume mounting

### 3. nginx.conf
- **Client-side routing**: Handles SPA routing
- **Static asset caching**: 1 year cache for assets
- **Security headers**: X-Frame-Options, X-Content-Type-Options, etc.
- **Gzip compression**: Reduces file sizes

## 🔧 Setup Instructions

### 1. GitHub Actions Setup

1. **Create GitHub Repository**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/nutriquest-app.git
   git push -u origin main
   ```

2. **Set up Secrets**:
   - Go to GitHub Repository → Settings → Secrets and variables → Actions
   - Add the following secrets:
     - `FIREBASE_TOKEN`: Firebase deployment token
     - `FIREBASE_SERVICE_ACCOUNT`: Firebase service account JSON

3. **Firebase Token Setup**:
   ```bash
   firebase login:ci
   # Copy the token and add it to GitHub secrets
   ```

### 2. Docker Setup

1. **Build Docker Image**:
   ```bash
   docker build -t nutriquest-app .
   ```

2. **Run with Docker Compose**:
   ```bash
   # Production
   docker-compose up nutriquest-app
   
   # Development
   docker-compose up nutriquest-dev
   ```

3. **Access the App**:
   - Production: http://localhost:3000
   - Development: http://localhost:3001

### 3. Firebase Setup

1. **Install Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:
   ```bash
   firebase login
   ```

3. **Initialize Firebase**:
   ```bash
   firebase init
   ```

4. **Deploy**:
   ```bash
   firebase deploy
   ```

## 🔐 Security Configuration

### 1. GitHub Secrets
- **FIREBASE_TOKEN**: Firebase deployment token
- **FIREBASE_SERVICE_ACCOUNT**: Service account JSON
- **GITHUB_TOKEN**: Automatically provided

### 2. Firebase Security
- **Firestore Rules**: Already configured
- **Storage Rules**: Already configured
- **Authentication**: Google Sign-In enabled

### 3. Docker Security
- **Non-root user**: Use nginx user
- **Security headers**: Configured in nginx.conf
- **HTTPS**: Configure for production

## 📊 Monitoring and Logs

### 1. GitHub Actions
- **Workflow runs**: View in Actions tab
- **Logs**: Available in workflow runs
- **Artifacts**: APK files available for download

### 2. Firebase
- **Hosting**: View deployment status
- **Analytics**: User engagement metrics
- **Crashlytics**: Error tracking

### 3. Docker
- **Container logs**: `docker-compose logs`
- **Health checks**: Monitor container health
- **Resource usage**: Monitor CPU and memory

## 🚨 Troubleshooting

### Common Issues

1. **Build Failures**:
   - Check Flutter version compatibility
   - Verify dependencies in pubspec.yaml
   - Check for linting errors

2. **Deployment Failures**:
   - Verify Firebase token
   - Check Firebase project configuration
   - Ensure proper permissions

3. **Docker Issues**:
   - Check Docker daemon is running
   - Verify port availability
   - Check container logs

### Solutions

1. **Clean and Rebuild**:
   ```bash
   flutter clean
   flutter pub get
   flutter build web --release
   ```

2. **Docker Cleanup**:
   ```bash
   docker-compose down
   docker system prune -a
   docker-compose up --build
   ```

3. **Firebase Reset**:
   ```bash
   firebase logout
   firebase login
   firebase deploy
   ```

## 🎯 Best Practices

### 1. Development Workflow
- Use feature branches
- Create pull requests
- Run tests before merging
- Use semantic versioning

### 2. Deployment Strategy
- Use staging environment
- Test before production
- Monitor deployment status
- Rollback if needed

### 3. Security
- Keep secrets secure
- Use environment variables
- Regular security updates
- Monitor access logs

---
**Your NutriQuest app now has a complete CI/CD pipeline! 🎉**
