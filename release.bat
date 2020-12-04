set REL_PATH=%~dp0

cd /d %REL_PATH%

::65001代表编码格式为utf-8
chcp 65001

call yarn build:release

set sourceDir=%REL_PATH%\dist
set targetDir=%REL_PATH%\..\cms测试\xxxx\

cd %targetDir%

git pull

for /f "delims=" %%A in ('dir /b /ad-h') do (
if /I not "%%A"==".git" rmdir /s /q "%%A"
)
for /f "delims=" %%A in ('dir /b /a-d-h') do (
del "%%A" /f /q 
)

xcopy %sourceDir% %targetDir% /s/e/c/y/h/r/i

git add . 
git commit -m "脚本发版提交记录"
git push

cd /d %REL_PATH%
pause
