FROM mcr.microsoft.com/windows/nanoserver:ltsc2022


COPY bun.exe /bun.exe

CMD ["C:\\bun.exe"]

EXPOSE 3000