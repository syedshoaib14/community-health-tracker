# Script to install Node.js 18 LTS using nvm
# Run this after restarting PowerShell

Write-Host "🔍 Checking nvm installation..." -ForegroundColor Cyan

# Check if nvm is available
try {
    $nvmVersion = nvm version
    Write-Host "✅ nvm is installed: $nvmVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ nvm is not available. Please:" -ForegroundColor Red
    Write-Host "   1. Complete the nvm installer" -ForegroundColor Yellow
    Write-Host "   2. Restart PowerShell (close and reopen)" -ForegroundColor Yellow
    Write-Host "   3. Run this script again" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "📋 Checking available Node.js versions..." -ForegroundColor Cyan
nvm list available | Select-Object -First 10

Write-Host ""
Write-Host "📥 Installing Node.js 18.20.0 (LTS - compatible with this project)..." -ForegroundColor Cyan
nvm install 18.20.0

Write-Host ""
Write-Host "✅ Setting Node.js 18.20.0 as active version..." -ForegroundColor Cyan
nvm use 18.20.0

Write-Host ""
Write-Host "✅ Verification:" -ForegroundColor Green
node --version
npm --version

Write-Host ""
Write-Host "🎉 Node.js installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Next steps:" -ForegroundColor Cyan
Write-Host "   cd json-server && npm install && npm start" -ForegroundColor Yellow
Write-Host "   cd frontend && npm install && npm run dev" -ForegroundColor Yellow

