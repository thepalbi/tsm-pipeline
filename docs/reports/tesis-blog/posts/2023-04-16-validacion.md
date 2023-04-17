---
title: validacion
description: ""
date: 2023-04-16T21:56:02.512Z
preview: ""
draft: true
tags: []
categories: []
---

Para validar cuan bien anda el pipeline, podemos enmarcarlo como un problema de clasificacion binario, dados los resultados.

Explicar cual seria el modelo?

Primero, partimos de una serie de repositiorios (los cuales llamaremos DBs). Del total de DBs, tomaremos una porcion del mismo para entrenamiento, y otra para validacion. Esto nos permite que nuestro modelo no realice overfitting.

Luego, tomando el conjunto de dbs de entrenamiento, corremos el pipeline de entrenamiento produciendo una serie de resultados de potenciales sinks, llamado **boosted**. Podemos usar este para enriqueceer la query de deteccion de alertas **worse**.

Teniendo **worseBoosted** y **v0**, la cual consideramos como la *ground truth*, podemos pasar a la etapa de evaluacion. La misma consiste en, usando el conjunto de dbs de evaluacion, estimar un pountaje de que tan "buenos" son los resultados de boosted.

Para ello, buscamos resultados de las queries de deteccion de **worseBoosted** (WB) y **v0** sobre el mismo conjunto de dbs. De esta forma, podemos compararlos sabiendo que la verdad esta definida por la encontradas por v0.

Los posibles casos serian:
- Si una alerta esta en v0, y tambien en WB, entonces es un **true-positive**
- Si una alerta esta en v0, pero no en WB, entonces es un **false-negative**
- Si una alerta esta en WB, y no en v0, entonces es un **false-positive**
- **true-negative** implica que una alerta que cae en esta categoria, no deberia ser una alerta tanto para WB ni para v0, por ende, nunca seria parte del universo de alertas sobre el cual trabajamos, por lo que esta categoria no existe. Es esto un detractor para la forma de evaluacion?

De esta manera, si consideramos todas las alertas detectadas, y nos imaginamos que el pipeline construye un *clasificador* que dada una alerta predice si esta es correcta, o no, podemos pensarlo como un problema de clasificacion binaria.

## Resultados de hacer una corrida con `nosql_atm_top100`

```
WORSE
Score results: Precision: 0.1654. Recall: 0.3981. Accuracy: 0.1323
BOOSTED
Score results: Precision: 0.1654. Recall: 0.3981. Accuracy: 0.1323
```

El set generado por el entrenamiento no esta haciendo diferencia alguna! Las metricas parecen bien, asi que el problema esta en la fase de evaluacion o entrenamiento.


## Que significa cada metrica en nuestro problema?

- Precision: De las alarmas detectadas, cuales verdaderamente lo son
- Recall: De las alarmas que deberian haberse detectado, cuantas fueron detectadas
- Accuracy: Porcentaje de alarmas clasificadas correcamente.

Viendo las metricas de arriba, la mas indicada para usar como objectivo a mejorar en nuestra tecnica de evaluacion parece ser recall, ya que idealmente la tecnica generaria un boosted lo suficientemente bueno para elevar worse al nivel de v0.


## Referencias
- [Post sobre precission, recall y binary classification evaluation](https://www.linkedin.com/pulse/how-tell-your-model-does-well-binary-classification-confusion-au-vo)
