@echo off

set list[2]=vscode-extensions

for /l %%n in (0,1,2,3) do (
  docker volume create %list[%%n]%
)