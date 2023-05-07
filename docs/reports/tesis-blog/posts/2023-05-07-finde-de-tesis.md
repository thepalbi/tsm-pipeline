---
title: finde-de-tesis
description: ""
date: 2023-05-07T22:59:48.227Z
preview: ""
draft: true
tags: []
categories: []
---

Luego de haber corrido un experiment más o menos grande, 200 dbs de NoSQL, y obetener nuevamente 0 true positives, hay que arrancar a revisar el código.
Revisando el step de data generation, encontré que en su momento diego había realizado el siguiente [commit](https://github.com/thepalbi/tsm-pipeline/commit/99eb3cf46cf5a8c1596c85e4f1ada129960e56e0), que desacopla la generación de los known source, sinks y sanitizers, del a generación del propgraph. De esta forma se puede:
- Con worse libs generar los known *
- Con la última versión de las libs, construir el propagation graph

**pregunta para diego:** No se si yo borré esto, o no llegue a utilizarlo porque branchee antes. Valía la pena?
