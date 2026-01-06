# Script to setup Git and push project
# This will configure Git and push to remote repository

Write-Host "🔧 Git Setup and Push Script" -ForegroundColor Cyan
Write-Host ""

# Check if git user is configured
$userName = git config --global user.name
$userEmail = git config --global user.email

if ([string]::IsNullOrEmpty($userName) -or [string]::IsNullOrEmpty($userEmail)) {
    Write-Host "⚠️  Git user identity not configured." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please provide your Git credentials:" -ForegroundColor Cyan
    
    if ([string]::IsNullOrEmpty($userName)) {
        $name = Read-Host "Enter your name"
        if (-not [string]::IsNullOrEmpty($name)) {
            git config --global user.name $name
            Write-Host "✅ Git user name set: $name" -ForegroundColor Green
        }
    }
    
    if ([string]::IsNullOrEmpty($userEmail)) {
        $email = Read-Host "Enter your email"
        if (-not [string]::IsNullOrEmpty($email)) {
            git config --global user.email $email
            Write-Host "✅ Git user email set: $email" -ForegroundColor Green
        }
    }
} else {
    Write-Host "✅ Git user configured:" -ForegroundColor Green
    Write-Host "   Name:  $userName" -ForegroundColor Gray
    Write-Host "   Email: $userEmail" -ForegroundColor Gray
}

Write-Host ""
Write-Host "📝 Committing changes..." -ForegroundColor Cyan
git add .
git commit -m "Initial commit: Community Health Tracker with React frontend and JSON Server backend"

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Commit failed. Please check the error above." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Changes committed" -ForegroundColor Green

Write-Host ""
Write-Host "🔗 Setting up remote repository..." -ForegroundColor Cyan

# Check if remote exists
$remote = git remote -v
if ([string]::IsNullOrEmpty($remote)) {
    Write-Host ""
    Write-Host "Please provide your Git repository URL:" -ForegroundColor Cyan
    Write-Host "   Examples:" -ForegroundColor Gray
    Write-Host "   - GitHub: https://github.com/username/repo-name.git" -ForegroundColor Gray
    Write-Host "   - GitHub SSH: git@github.com:username/repo-name.git" -ForegroundColor Gray
    Write-Host "   - GitLab: https://gitlab.com/username/repo-name.git" -ForegroundColor Gray
    Write-Host ""
    $repoUrl = Read-Host "Enter repository URL"
    
    if ([string]::IsNullOrEmpty($repoUrl)) {
        Write-Host "❌ No URL provided. Exiting." -ForegroundColor Red
        Write-Host ""
        Write-Host "💡 You can add remote later with:" -ForegroundColor Yellow
        Write-Host "   git remote add origin <your-repo-url>" -ForegroundColor Gray
        exit 1
    }
    
    git remote add origin $repoUrl
    Write-Host "✅ Remote added: $repoUrl" -ForegroundColor Green
} else {
    Write-Host "✅ Remote repository already configured:" -ForegroundColor Green
    git remote -v
}

Write-Host ""
Write-Host "📤 Pushing to remote repository..." -ForegroundColor Cyan
Write-Host "   (Git Credential Manager will prompt for credentials if needed)" -ForegroundColor Gray
Write-Host ""

# Get current branch
$branch = git branch --show-current
if ([string]::IsNullOrEmpty($branch)) {
    $branch = "master"
}

Write-Host "🚀 Pushing to origin/$branch..." -ForegroundColor Cyan
git push -u origin $branch

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Successfully pushed to remote repository!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📍 Repository URL:" -ForegroundColor Cyan
    git remote get-url origin
} else {
    Write-Host ""
    Write-Host "❌ Push failed. Common issues:" -ForegroundColor Red
    Write-Host "   1. Check your credentials in Git Credential Manager" -ForegroundColor Yellow
    Write-Host "   2. Verify repository URL is correct" -ForegroundColor Yellow
    Write-Host "   3. Ensure you have push permissions" -ForegroundColor Yellow
    Write-Host "   4. If repository doesn't exist, create it on GitHub/GitLab first" -ForegroundColor Yellow
}

