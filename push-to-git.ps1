# Script to push project to Git
# This will use your Git Credential Manager

Write-Host "🔍 Checking Git configuration..." -ForegroundColor Cyan

# Check if remote exists
$remote = git remote -v
if ([string]::IsNullOrEmpty($remote)) {
    Write-Host ""
    Write-Host "⚠️  No remote repository configured." -ForegroundColor Yellow
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
        exit 1
    }
    
    Write-Host ""
    Write-Host "🔗 Adding remote repository..." -ForegroundColor Cyan
    git remote add origin $repoUrl
    Write-Host "✅ Remote added: $repoUrl" -ForegroundColor Green
} else {
    Write-Host "✅ Remote repository found:" -ForegroundColor Green
    git remote -v
}

Write-Host ""
Write-Host "📝 Checking for uncommitted changes..." -ForegroundColor Cyan
$status = git status --porcelain
if ($status) {
    Write-Host "⚠️  You have uncommitted changes:" -ForegroundColor Yellow
    git status --short
    Write-Host ""
    $commit = Read-Host "Do you want to commit these changes? (y/n)"
    if ($commit -eq 'y' -or $commit -eq 'Y') {
        $message = Read-Host "Enter commit message (or press Enter for default)"
        if ([string]::IsNullOrEmpty($message)) {
            $message = "Update project files"
        }
        git add .
        git commit -m $message
        Write-Host "✅ Changes committed" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "📤 Pushing to remote repository..." -ForegroundColor Cyan
Write-Host "   (Git Credential Manager will prompt for credentials if needed)" -ForegroundColor Gray
Write-Host ""

# Check current branch
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
    Write-Host "❌ Push failed. Please check:" -ForegroundColor Red
    Write-Host "   1. Your credentials in Git Credential Manager" -ForegroundColor Yellow
    Write-Host "   2. Repository URL is correct" -ForegroundColor Yellow
    Write-Host "   3. You have push permissions" -ForegroundColor Yellow
}

