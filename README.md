# APPLI DRIVE MOBILE

<div align="center">
  <img src="https://github.com/Victy0/appli_drive_mobile/blob/main/assets/images/logo.png?raw=true" alt="Logo" width="200">
</div>

Repositório referente a construção de um app simples utilizando flutter. 
Versão Atual: 0.0.0

**Em resumo:** O Appli Drive Mobile é um aplicativo inspirado na série animada Digimon Universe Appli Monsters, que tem o intuito de retratar e expandir as funcionalidades do Appli Drive utilizados pelos humanos durante a série.

Implementado por:
 - Victor Rodrigues Marques

# Requisitos

 - Flutter 3.22.2 ou superior

# Instalação do app

**Android**

 - Necessário habilitar para que o Android permita a instalação de APK por fontes desconhecidas.
 - APK: em breve...

# Instalação para desenvolvedores

**1** - Instalar SDK do Flutter e configurar IDE desejável:

 - [Documentação de instalação do Flutter](https://docs.flutter.dev/get-started/install)

**2** - Clonar o repositório:

    git clone ...

**3** - Instalar dependências:

    flutter pub get

**5** - Rodar o flutter:

    flutter run
 - [Documentação de comandos do Flutter](https://docs.flutter.dev/reference/flutter-cli)


#  Estrutura de diretórios

Pode-se destacar 5 principais diretórios:

:small_blue_diamond: **assets**: diretório com arquivos de imagens, áudios, json de termos de internacionalização e banco de dados usados pela aplicação. Subdivida nos diretórios 'images' (compreende as imagens utilizadas), 'langs' (compreende os jsons de internacionalização) e 'sounds' (compreende os áudios utilizados).

:small_blue_diamond: **interfaces**: diretório com templates de componentes de interfaces de navegação da aplicação. Subdividida nos diretórios 'components' (que possui componentes reutilizáveis por mais de uma interface) e 'pages' (as estruturas base das interfaces de navegação. Algumas por serem muito grande, foi criado para elas o diretório 'components' com componentes específicos utilizados somente por uma página).

:small_blue_diamond: **localizations**: diretório com arquivo de configuração de internacionalização da aplicação.

:small_blue_diamond: **models**: diretório com estruturas de dados referentes ao objetos manipulados pela aplicação.

:small_blue_diamond: **services**: diretório com serviços de áudio e acesso a banco de dados utilizados no ciclo de vida de operações da aplicação.

    |____assets
        |____images
        |____langs
        |____sounds
    |____lib
        |____interfaces
            |____components
            |____pages
                |____exemplo_page
                    |____components
        |____localizations
        |____models
        |____services
