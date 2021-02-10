## Installeer de nodige software voor Onderzoekstechnieken

## Installeer eerst de Chocolatey package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Installeer software:

# Algemeen bruikbare applicaties, niet specifiek voor Onderzoekstechnieken
# De volgende applicaties zijn wellicht al geïnstalleerd. Verwijder het
# commentaarteken (#) als je ze toch wil laten installeren door het script

#choco install -y vscode     # Visual Studio Code (optioneel)
#choco install -y git        # Git client, Git Bash
#choco install -y gitkraken  # Git GUI (optioneel)
choco install -y firacode       # Lettertype met ligaturen voor code-editors
choco install -y activeperl     # Dependency voor de latexmk compiler

# Applicaties voor LaTeX
choco install -y miktex      # LaTeX distributie, compilers
choco install -y texstudio   # LaTeX IDE
choco install -y JabRef      # Bibliografische databank

# Applicaties voor R
choco install -y r.project   # De R programmeertaal
choco install -y r.studio    # IDE voor R
