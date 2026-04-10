# **⚔️ Adventure Simulator: Chronicle Engine**

Um simulador de aventura baseado em texto e lógica procedural, desenvolvido em **Lua**, com foco rigoroso em **Programação Orientada a Objetos (POO)**, estruturas de dados dinâmicas e **anotações de tipagem** para garantir robustez e escalabilidade.

## **🚀 Sobre o Projeto**

O *Chronicle Engine* não é apenas um jogo, mas um framework para simulação de narrativas interativas. O projeto foi construído para demonstrar como a linguagem Lua pode lidar com sistemas complexos através de abstrações bem definidas e gerenciamento eficiente de estado.

## **🏗️ Arquitetura e Estrutura de Dados**

O "coração" do simulador utiliza uma combinação de estruturas versáteis para gerenciar o mundo:

* **Grafo de Cenas (Scene Graph):** As localidades do mundo são nós em um grafo, permitindo conexões complexas e navegação não linear.  
* **Fila de Eventos Prioritária:** Gerencia eventos temporais e reações do ambiente baseadas em ticks do simulador.  
* **Árvore de Diálogos Dinâmica:** Implementada para suportar ramificações baseadas em atributos do jogador (checks de perícia).  
* **Component System (ECS-lite):** Entidades (NPCs, Itens) são construídas via composição para evitar hierarquias de herança excessivamente profundas.

## **🛠️ Tecnologias e Paradigmas**

### **Programação Orientada a Objetos (POO)**

Utilizamos o paradigma de classes para encapsular comportamentos:

* **Herança:** Para especialização de tipos (ex: Equipable herda de Item).  
* **Polimorfismo:** Métodos como on\_interact() comportam-se de forma única dependendo do objeto.  
* **Interfaces (Via Mixins):** Para comportamentos transversais como Flammable ou Heavy.

### **Bibliotecas de Terceiros**

Para elevar o nível da aplicação, integramos:

* [**Middleclass**](https://github.com/kikito/middleclass)**:** Fornece uma infraestrutura de classes robusta para Lua.  
* [**Lume**](https://github.com/rxi/lume)**:** Coleção de funções utilitárias para manipulação de tabelas e filtragem de dados.  
* [**Inspect**](https://github.com/kikito/inspect.lua)**:** Essencial para a depuração das complexas tabelas de estado no console.

### **Tipagem e Segurança**

Embora Lua seja dinamicamente tipada, este projeto utiliza as convenções de **Luau / Teal** ou anotações de comentários para análise estática:

\---@class Character  
\---@field name string  
\---@field health number  
\---@field inventory table\<integer, Item\>  
local Character \= class('Character')

\---@param item Item  
\---@return boolean success  
function Character:take\_item(item)  
    \-- Lógica de inserção  
end

## **📦 Instalação e Execução**

1. Certifique-se de ter o **Lua 5.3+** instalado.  
2. Clone o repositório:  
   git clone \[https://github.com/seu-usuario/adventure-simulator.git\](https://github.com/seu-usuario/adventure-simulator.git)

3. Instale as dependências (se estiver usando o LuaRocks):  
   luarocks install middleclass  
   luarocks install lume

4. Execute o simulador:  
   lua main.lua

## **🗺️ Roadmap de Desenvolvimento**

* \[x\] Estrutura base de Classes e Mixins.  
* \[x\] Sistema de Inventário com limite de peso.  
* \[ \] Implementação de sistema de combate por turnos.  
* \[ \] Persistência de dados em JSON/SQLite.  
* \[ \] Interface gráfica simples via LÖVE2D.

Desenvolvido por \[Seu Nome\] \- Focado em engenharia de software aplicada a jogos.