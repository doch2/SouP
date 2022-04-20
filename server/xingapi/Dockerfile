FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN powershell (new-object System.Net.WebClient).Downloadfile('http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185', 'C:\jre-8u91-windows-x64.exe')
RUN powershell start-process -filepath C:\jre-8u91-windows-x64.exe -passthru -wait -argumentlist "/s,INSTALLDIR=c:\Java\jre1.8.0_91,/L,install64.log"
RUN del C:\jre-8u91-windows-x64.exe

RUN powershell (new-object System.Net.WebClient).Downloadfile('https://github.com/yalsooni/buycycle/releases/download/1.0.8/buycycle.zip', 'C:\buycycle.zip')
RUN powershell -Command "expand-archive -Path 'c:\buycycle.zip' -DestinationPath 'c:\'"
RUN del C:\buycycle.zip

COPY xingapi_library.zip .
RUN powershell -Command "expand-archive -Path 'c:\xingapi_library.zip' -DestinationPath 'c:\'"
RUN del C:\xingapi_library.zip

RUN del C:\buycycle\config\application.yaml
COPY application.yaml .\\buycycle\\config\\application.yaml

EXPOSE 7771


CMD [ "c:\\Java\\jre1.8.0_91\\bin\\java.exe", "-Djava.library.path=C:\\buycycle\\lib", "-jar", "C:\\buycycle\\lib\\buycycle-1.0.8.jar" ]