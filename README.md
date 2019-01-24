# Global Gayme Jammers - Setup e Orientação :-)

Oi gente! Eu preparei algumas coisinhas pra facilitar o desenvolvimento!

## Engine

[Amulet](http://www.amulet.xyz/)

- Versão: 1.7.1
- [Documentação](http://www.amulet.xyz/doc)
- [Editor Web](http://www.amulet.xyz/editor)

### Instalação no Windows

Baixe e instale a partir do link abaixo:

https://github.com/ianmaclarty/amulet/releases/download/v1.17.1/amulet-v1.17.1-windows.exe

Ao executar, é possível que o Windows reclame da origem do arquivo com uma janela "O Windows protegeu o computador". Clicando em "Mais informações" ele vai adicionar um botão "Executar assim mesmo" na popup.

![](https://support.airtable.com/hc/en-us/article_attachments/210713088/image__39_.png)

Na janelinha que abre do instalador, haverão duas caixinhas pra marcar. Uma falando de PATH, outra de "Associate .lua files with Amulet". Marquem essa segunda caixinha também.

Pronto! Deve estar certinho! :-)

### Instalação no Mac OS X

Baixe o pacote a partir do link abaixo:

https://github.com/ianmaclarty/amulet/releases/download/v1.17.1/amulet-v1.17.1-osx.pkg

Ao tentar abrir o pacote, o Mac irá resmungar.

Será necessário abrir as "Preferências" e selecionar a área de "Segurança & Privacidade" e clicar no botão "Abrir mesmo assim" ou "Open Anyway", tal como no screenshot abaixo:

![](https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Ftrendblog.net%2Fwp-content%2Fuploads%2F2015%2F03%2FScreenshot-2015-03-11-21.11.17.png&f=1)

## Sprites

Todos os arquivos de imagem devem ser em formato .png, colocados numa pastinha com o nome que fizer sentido pro sprite.

Eu deixei um exemplinho na pasta `assets/sample` :-)

Para testar animações e configurar o tempo dos frames, crie um arquivo .json com o nome da sua animação, conforme o exemplo `assets/sample/blink.json` disponível nessa mesma pasta ou conforme o exemplo abaixo:

    {
        "loop": false,
        "frames": [
        {
            "source": "nome_do_arquivo_1",
            "time": 0.5
        },
        {
            "source": "nome_do_arquivo_2",
            "time": 0.2
        }
        ]
    }

Como todas as imagens devem ser .png, num precisa colocar a extensão, a engine sabe completar sozinha :-)
`

### Visualizador

![Sprite viewer screenshot](https://raw.githubusercontent.com/ThaisRobba/global_game_jam_2019/master/docs/sprite_viwer.png)

**Windows**

Basta clicar duas vezes no arquivo "sprite_viewer.lua" e clicar o botão da animação que você quer rodar :-)

**Mac**

No caso de Mac é necessário executá-lo com linha de comando:

    amulet sprite_viewer.lua

**Visualizando modificações**

Se quiser recarregar para ver modificações de timing e afins basta apertar F5 e selecionar a animação.
