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
  - Librerias: [este commit](https://github.com/github/codeql/commit/3165babc887c1c1127f7f028493380ceca004b2e)
  - CLI: v2.10.5

## Recuperar info de las AMIs de AWS

Si necesito recuperar informacion de alguno de los volumenes que usaba en las instancias de AWS, puedo hacer lo siguiente ([fuente](https://aws.amazon.com/blogs/compute/recovering-files-from-an-amazon-ebs-volume-backup/)):

1. Crear un voumen del snapshot de `/tesis`, que es el `snap-0dd8156907da5c50f`, en la misma AZ que la instancia donde montarlo
2. Attachearlo a la instancia
3. Buscarlo con `lsblk`
4. Crear un dir donde montarlo
5. Montarlo con `sudo mount /dev/xvdf /tesis`

Luego, limpiar el volumen para que no me cobren.

## Como clonar un solo commit de github

```bash
# nuevo directorio en donde clonar
mkdir clone
cd clone
git init
git remote add origin git@github.com:github/codeql.git
git fetch origin commit
git checkout commit
```