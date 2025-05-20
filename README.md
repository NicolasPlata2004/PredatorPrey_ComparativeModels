# 🐦 Modelos Presa–Depredador: Chochín vs Lotka–Volterra

Este repositorio compara y analiza dos enfoques de modelado ecológico:

1. 🧮 El modelo clásico de Lotka–Volterra (presa-depredador con dinámica cíclica).
2. 🦴 Un modelo realista aplicado a la extinción del chochín de Stephens (Traversia lyalli), causado por la introducción de gatos domésticos en la isla Stephens en 1894.

Incluye simulaciones en MATLAB, visualización interactiva con sliders, análisis de linealización (LTI vs no lineal), y distintos escenarios de intervención.

---

## 📁 Archivos principales

| Archivo                                | Descripción                                                                 |
|----------------------------------------|-----------------------------------------------------------------------------|
| `comparar_modelos.m`                  | Compara el modelo de Lotka–Volterra clásico vs. el modelo chochín-gato.   |
| `comparar_modelos_Predator.m`         | Variante donde ambos modelos tienen depredador dinámico.                   |
| `comparar_modelos_interactivos.m`     | Interfaz comparativa con sliders para ambos modelos.                       |
| `chochin_interactivo.m`              | Simulación interactiva del modelo del chochín con sliders (`r`, `α`, `z`, `T`). |
| `respuesta_escalon_gatos_interactivo.m`| Respuesta del modelo del chochín a un escalón en número de gatos.          |
| `veinte_gatos_XvsT.m`                 | Simula el caso de 20 gatos: colapso acelerado de la población.             |
| `veinte_gatos_nl_vs_lti.m`            | Compara el modelo no lineal con su linealización alrededor del equilibrio. |
| `llegada_gato.m`                      | Simula la llegada repentina de un gato durante la simulación.              |
| `unificado.m`                         | Modelo compacto con múltiples escenarios configurables.                    |

---

## ⚙️ Requisitos

- MATLAB R2016 o posterior
- No se requieren toolboxes adicionales
- Para simulaciones interactivas, se recomienda ejecutar desde el entorno gráfico de MATLAB

---

## 🧪 ¿Qué se puede explorar?

- Dinámica clásica (Lotka–Volterra) con oscilaciones sostenidas entre especies.
- El impacto de un depredador externo (el gato) en un modelo con crecimiento logístico.
- Condiciones que llevan a la extinción de una especie cuando α·z ≥ r.
- Cómo aplicar la linealización de un sistema no lineal y comparar su respuesta frente al sistema completo.
- Simulaciones interactivas para explorar múltiples valores de parámetros ecológicos (tasa de crecimiento, presión de depredación, número de gatos, etc.).

---

## 📖 Contexto real

El chochín de Stephens (Traversia lyalli) fue una especie endémica de Nueva Zelanda, extinta en 1894 tras la introducción de un único gato doméstico (“Tibbles”) en la isla. Este caso se ha convertido en un ejemplo emblemático del impacto ecológico de especies invasoras.

---

## ✍️ Autor

Proyecto desarrollado por Nicolas Plata Molano, Edward Alejandro Moreno, Sebastian Ramiro Pedroza  
Universidad / Curso: Señales y Sistemas 2 – 2025  
Tema: Modelado ecológico, análisis de estabilidad, linealización y control aplicado

---

## 🖼️ Inspiración

> “Un solo gato puede cambiar toda una isla.”  
Este proyecto busca unir conceptos de ingeniería de control con problemáticas reales de conservación ecológica.

## 🖼️ Canva

> https://www.canva.com/design/DAGn1ySkvd4/BS3sxiwagC14QW5bmyyphA/edit?utm_content=DAGn1ySkvd4&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton




