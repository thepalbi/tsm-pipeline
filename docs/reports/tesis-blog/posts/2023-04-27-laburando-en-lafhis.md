---
title: laburando-en-lafhis
description: ""
date: 2023-04-27T20:24:33.802Z
preview: ""
draft: true
tags: []
categories: []
---

El largo del cannonical rep (la representacion usada para los sinks descubiertos) es muy importante, ya que la misma indica que tan especifico o generalizado puede estar un descubrimiento. En el pipeline esto es controlado por el siguiente parametro:

https://github.com/thepalbi/tsm-pipeline/blob/tesis/ql/tsm/NodeRepresentation.qll#L26

Ver el mail de diego con resultados obtenidos para cada max depth en los cannonical reps.
Segun algunas notas tambien afecta la cantidad de reps descubiertos, creo que es porque al permitir mas largos, el universo de reps crece.

Descubri que calculando los scores a mano da algo mejor, revisar bien que hace scikit learn por detras y ver si eso esta mal, o lo que yo hago esta mal. Escribir un poco sobre que significa recall y precision, porque medirlos, y un diagrama de venn con mis conjuntos.