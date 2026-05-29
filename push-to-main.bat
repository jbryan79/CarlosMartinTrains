@echo off
setlocal
cd /d D:\Dev\CarlosMartinTrains

echo.
echo ================================================
echo  Step 1: Install git-filter-repo (via Python)
echo ================================================
pip install git-filter-repo -q 2>nul
if %ERRORLEVEL% NEQ 0 py -3 -m pip install git-filter-repo -q
echo Done.

echo.
echo ================================================
echo  Step 2: Remove large files from all history
echo    - output_audio.wav        (81 MB)
echo    - 2026-05-25 14-43-48.mp4 (716 MB)
echo ================================================
python -m git_filter_repo --path "output_audio.wav" --path "2026-05-25 14-43-48.mp4" --invert-paths --force 2>nul
if %ERRORLEVEL% NEQ 0 py -3 -m git_filter_repo --path "output_audio.wav" --path "2026-05-25 14-43-48.mp4" --invert-paths --force
echo Done.

echo.
echo ================================================
echo  Step 3: Restore remote and push
echo ================================================
git remote add origin https://github.com/jbryan79/CarlosMartinTrains.git 2>nul
git remote set-url origin https://github.com/jbryan79/CarlosMartinTrains.git
git config user.name "James Bryan"
git config user.email "jamesbryan@gmail.com"
git push origin main --force

if %ERRORLEVEL% == 0 (
    echo.
    echo ================================================
    echo  SUCCESS - 5 commits live on main
    echo  Netlify auto-deploys in ~1-2 minutes
    echo ================================================
) else (
    echo.
    echo  Push failed. Check the error above.
)
echo.
pause
