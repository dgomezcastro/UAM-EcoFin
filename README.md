# Economía y Finanzas Matemáticas
## Universidad Autónoma de Madrid

### [Guía Docente 2026-2027](https://secretaria-virtual.uam.es/doa/consultaPublica/look%5bconpub%5dMostrarPubGuiaDocAs?entradaPublica=true&idiomaPais=es.ES&_anoAcademico=2026&_codAsignatura=16461)

### [Descargar PDF de las notas](https://github.com/dgomezcastro/UAM-EcoFin/releases/latest/download/ecofin.pdf)

Las notas del curso están creadas con `typst` y las fuentes del documento y las figuras se encuentran en la carpeta [src](src).

### Distribución horaria del curso

Estas notas corresponde al curso impartido en 2026-2027 por David Gómez-Castro.

El curso consta de 15 semanas:
1. Introducción. El mercado financiero. <br> [Notebook: comprobando la log-normalidad en datos de mercado](pluto-notebooks/log-normality.jl)
1. Tipos de interés: interés compuesto, interés continuo, bono cupón-cero, fórmulas de amortización, TAE. 
    <br> [Notebook: amortización de una hipoteca](pluto-notebooks/mortgage.jl)
1. Activos y derivados, bonos, curva cupón-cero
1. Derivados: contrato a plazo, _swap_, opciones
1. El modelo binomial: carteras, arbitraje, opciones europeas. 
    <br> [Notebook: valor de carteras](pluto-notebooks/oneperiod-portfolio.jl) 
1. El modelo binomial: la medida de riesgo neutro
    <br> [Notebook: medidas libres de riesgo en el modelo trinomial](pluto-notebooks/trinomial-riskfreemeasure.jl)
1. El modelo matricial para un periodo de tiempo
1. Árboles binomiales: Carteras y arbitraje.
1. Árboles binomiales: medida libre de riesgo y opciones europeas. 
    <br> [Notebook: el valor de una _call_ europea](pluto-notebooks/binomial-tree-call.jl)
1. Árboles binomiales: opciones americanas
1. Paseos aleatorios y movimiento Browniano. 
    <br> [Notebook: estudio de paseos aleatorias](pluto-notebooks/random-walk-density.jl)
    <br> [Notebook: de paseos aleatorios a movimiento Browniano](pluto-notebooks/random-walk-limit.jl)
1. Cálculo de Itô
    <br> [Notebook: justificación visual de $(d W_t)^2=dt$](pluto-notebooks/brownian-dW-squared.jl)
    <br> [Notebook: comparación de las integrales de Itô y Stratonovich al integral $W_t d W_t$](pluto-notebooks/ito-v-stratonovich.jl)
1. Ecuaciones diferenciales estocásticas
    <br> [Notebook: el método numérico de Euler-Maruyama](pluto-notebooks/euler-maruyama.jl)
1. Black-Scholes: límite de árboles al continuo, opción europea, volatilidad implícita.
    <br> [Notebook: el precio de _calls_ europeas como límite del árbol binomial](pluto-notebooks/binomial-tree-call-limit.jl)
1. Carteras en tiempo continuo. 
    <br> [Notebook: comprobando la correlación en el mercado](pluto-notebooks/stock-correlation.jl)

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


Se puede crear una versión estática de los notebooks con 
```
julia -e "using PlutoSliderServer; PlutoSliderServer.export_directory(\".\", Export_output_dir=\"html/\")"
````
