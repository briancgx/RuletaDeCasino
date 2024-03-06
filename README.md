# Ruleta De Casino

Este es mi segundo proyecto utilizando Bash Scripting, diseñado para simular una estrategia de apuestas en la ruleta de casino. El script incluye dos técnicas de apuestas: Martingala e Inverse Labouchere.

![image](https://github.com/briancgx/RuletaDeCasino/assets/118696146/b2dda4cc-69d2-4643-adb1-220354432079)

## Instalación
Para utilizar la Ruleta de Casino, primero debes clonar el repositorio a tu máquina local utilizando el siguiente comando:
```bash
git clone https://github.com/briancgx/RuletaDeCasino.git
```
Asegúrate de tener Git instalado en tu sistema para poder ejecutar el comando de clonación.

## Ejecución
Una vez clonado el repositorio, navega al directorio del script y dale permisos de ejecución al archivo .sh:
```bash
  cd RuletaDeCasino
  chmod +x ruleta.sh
```
Para ejecutar el script, utiliza el siguiente comando:
```bash
  ./ruleta.sh -m <dinero> -t <técnica>
```

## Uso
El script ofrece dos técnicas de apuestas:

Martingala: Una estrategia de duplicación de apuestas.
Inverse Labouchere: Una estrategia basada en una secuencia de números.
Puedes seleccionar la técnica y definir el monto de la apuesta usando las siguientes opciones:

-m - <dinero>: Especifica el monto de dinero para apostar.
-t - <técnica>: Selecciona la técnica de apuestas (martingala / inverseLabrouchere).
-h - Muestra este panel de ayuda.
