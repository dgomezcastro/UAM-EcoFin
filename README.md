# Economía y Finanzas Matemáticas
## Universidad Autónoma de Madrid

### [Descargar PDF de las notas](https://github.com/dgomezcastro/UAM-EcoFin/releases/latest/download/ecofin.pdf)

Las notas del curso están creadas con `typst` y las fuentes del documento y las figuras se encuentran en la carpeta [src](src).

### Distribución horaria del curso

Estas notas corresponde al curso impartido en 2026-2027 por David Gómez-Castro.

El curso consta de 16 semanas:
1. Introducción. El mercado financiero. <br> [Notebook](pluto-notebooks/log-normality.jl)
1. Tipos de interés: interés compuesto, interés continuo, bono cupón-cero, fórmulas de amortización, TAE. <br> [Notebook](pluto-notebooks/mortgage.jl)
1. Activos y derivados, bonos, curva cupón-cero
1. Derivados: contrato a plazo, _swap_, opciones
1. El modelo binomial: carteras, arbitraje, opciones europeas. <br> [Notebook](pluto-notebooks/oneperiod-portfolio.jl) 
1. El modelo binomial: la medida de riesgo neutro
1. El modelo matricial para un periodo de tiempo
1. Árboles binomiales: Carteras y arbitraje.
1. Árboles binomiales: medida libre de riesgo y opciones europeas. <br> [Notebook](pluto-notebooks/binomial-tree-call.jl)
1. Árboles binomiales: opciones americanas
1. Paseos aleatorios y movimiento Browniano. <br> [Notebook 1](pluto-notebooks/random-walk-density.jl) y [Notebook 2](pluto-notebooks/random-walk-limit.jl)
1. Cálculo de Itô I
1. Cálculo de Itô II
1. Límite de árboles al continuo: Black-Scholes. <br> [Notebook](pluto-notebooks/binomial-tree-call-limit.jl)
1. Black-Scholes: opción europea. Volatilidad implícita
1. Carteras en tiempo continuo. <br> [Notebook](pluto-notebooks/stock-correlation.jl)

### Uso de los notebooks

Los notebooks del curso sirven para ilustrar algunos de los conceptos presentados. Están creados con `julia` y `Pluto.jl`. 
Cada notebook es un sólo archivo `.jl` (autocontenido) que puede descargar haciendo click en el link correspondiente y luego en el botón "Download raw".

Los notebooks se presentarán y explicarán en clase, pero es fácil descargarlos para experimentar en casa.

Para instalar `julia` y `Pluto.jl` (sólo es necesario hacerlo una vez):
1. Instalar `julia`: https://julialang.org/downloads/
1. Instalar `Pluto.jl`. En una terminal escribir
    ```
    julia -e "using Pkg; Pkg.add(\"Pluto\")"
    ```

Una vez instalado, podemos ejecutar `Pluto.jl` tantas veces como queramos para 
- Ejecutar `Pluto.jl`: En una terminal escribir
    ```
    julia -e "using Pluto; Pluto.run()"
    ```
    Esto abrirá un navegador con la interfaz gráfica de Pluto. Ahí podemos seleccionar el notebook que queramos de los que tenemos descargados.
