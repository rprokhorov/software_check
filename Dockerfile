FROM mcr.microsoft.com/powershell
#RUN python -m pip install requests && python -m pip install beautifulsoup4 && python -m pip install pymongo
#RUN python -m pip install os
WORKDIR /app
COPY keepass.ps1 /app
#COPY Check_FarManager.py /app
CMD ["pwsh", "keepass.ps1"]
#CMD ["python","Check_FarManager.py"]