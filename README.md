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

## Configurando sprites

Todos os arquivos de imagem devem ser em formato .png

Para testar animações e configurar o tempo dos frames, crie um arquivo .json com o nome da sua animação, conforme o exemplo "sample.json" disponível nessa mesma pasta ou o exemplo abaixo:

    [
        {
            "source": "nome_do_arquivo"_1",
            "time": 0.5
        },
        {
            "source": "nome_do_arquivo"_2",
            "time": 0.2
        }
    ]

Daí basta clicar duas vezes no arquivo "animated_sprite.lua" e clicar o botão da animação que você quer rodar :-)

Se quiser recarregar, pode apertar F5 ou fechar e abrir novamente o arquivo.
