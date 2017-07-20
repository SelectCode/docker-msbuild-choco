FROM microsoft/windowsservercore

LABEL maintainer florian.baader@selectcode.de; \
LABEL lastupdate 2017-20-07; \
LABEL author SelectCode UG (haftungsbeschränkt); \
LABEL homepage https://www.selectcode.de; \
LABEL description Microsoft .NET Build Tools v15 with nuget.; \
LABEL license Public Domain; \
LABEL comment based on alexellisio/msbuild:12.0;

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#Set PATH variable
RUN $env:PATH = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\;' + $env:PATH; \
[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine);

#Makes it possible to download chocolatey
RUN Set-ExecutionPolicy Bypass;

RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));

#Allow installing without asking
RUN choco feature enable -n allowGlobalConfirmation;

#Install Build Tools
RUN choco install microsoft-build-tools nuget.commandline sysinternals -y;
