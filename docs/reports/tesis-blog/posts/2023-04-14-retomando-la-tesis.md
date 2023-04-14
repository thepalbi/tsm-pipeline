---
title: retomando la tesis
description: ""
date: 2023-04-14T23:21:39.018Z
preview: ""
draft: true
tags: []
categories: []
---

Retomando la tesis post viaje(s). El ultimo release de la CLI de CodeQL a la fecha es [v2.12.16](https://github.com/github/codeql-cli-binaries/releases/tag/v2.12.6), no creo estar tan atrasado ya que la que estaba usando como V0 es v2.10.5.

La idea es en vez de tener todo el boilerplate de una VM, usar la laptop Dell que tiene un buen proce y mucho disco (750GB) en un rigido no SSD, y 16GB de RAM. Por ahora, instalando todo, y voy a poner a bajar unas DBs a ver como anda. Directorios elgidos:

- Cache root: `/home/pablo/dbcache`, en el disco grande
- CLIs: `/home/pablo/clis`, en el disco grande
- tmp: La del sistema, que esta en el SSD

Para tener un resumen de las versiones usadas para cosas de CodeQL:
- Worse
  - Librerias: [este commit](https://github.com/github/codeql/commit/a1c38b78a9)
  - CLI: v2.5.2
- VO
  - CLI: v2.10.5