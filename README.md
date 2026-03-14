# AuctionAnalyzer

AuctionAnalyzer es una app iOS nativa (SwiftUI + MVVM) enfocada en analizar vehículos de subasta usando un número de lote y, opcionalmente, un PDF de CARFAX para enriquecer la precisión del reporte.

## ¿Qué hace la app?

- Muestra una pantalla de bienvenida (splash) con transición automática.
- Solicita aceptación de términos y condiciones.
- Permite ingresar un número de lote para generar un análisis inicial con OpenAI.
- Permite importar un PDF de CARFAX (Archivos/iCloud) usando `fileImporter` y extraer texto con `PDFKit`.
- Genera análisis avanzado basado en el CARFAX.
- Calcula una estimación financiera MVP:
  - Puja máxima recomendada
  - Precio estimado de venta privada
  - Costo de reparación
  - Fees de subasta
  - Transporte
  - Reserva de riesgo
  - Margen potencial
- Guarda historial local en `UserDefaults`.
- Permite compartir el reporte con `UIActivityViewController`.

## Arquitectura

Estructura por capas con MVVM y separación por carpetas:

- `App`: ruteo y tema global.
- `Models`: entidades de dominio y modelos `Codable`.
- `ViewModels`: estado y lógica de presentación.
- `Services`: integración OpenAI, extracción PDF, cálculos, historial y compartir.
- `Views`: UI SwiftUI por módulo.
- `Resources`: assets.

## Cómo correrla en Xcode

1. Abre Xcode y crea un proyecto iOS App (SwiftUI) llamado **AuctionAnalyzer**.
2. Cierra Xcode.
3. Copia el contenido de la carpeta `AuctionAnalyzer/` de este repositorio dentro del proyecto recién creado, reemplazando archivos si aplica.
4. Vuelve a abrir el `.xcodeproj`.
5. Verifica que los archivos estén agregados al target principal.
6. Ejecuta en simulador iPhone (por ejemplo, iPhone 15).

> Nota: este repositorio entrega toda la base de código lista para integrarse en un proyecto Xcode iOS.

## Dónde configurar la API key

Archivo:

- `AuctionAnalyzer/Services/OpenAIService.swift`

Busca la línea:

```swift
private let apiKey = "CONFIGURA_AQUI_TU_API_KEY"
```

Reemplázala por tu clave para pruebas locales.

⚠️ Importante: en producción no guardes la API key dentro de la app. Debe usarse un backend seguro.

## Limitaciones del MVP

- El cálculo financiero usa una heurística inicial (no integra precios reales de mercado ni APIs externas).
- No existe autenticación de usuario.
- El historial se guarda localmente en el dispositivo (`UserDefaults`), sin sincronización en la nube.
- No hay parsing semántico profundo del PDF más allá de extracción de texto.
- La calidad del análisis depende del texto disponible y de la respuesta del modelo.

## Mejoras futuras sugeridas

- Backend seguro para OpenAI y gestión de secretos.
- Integración con fuentes externas de valuación y piezas.
- Perfil de riesgo configurable por usuario.
- Soporte offline parcial con cola de análisis pendientes.
- Exportación del reporte en PDF propio.
- Pruebas unitarias/UI tests y métricas de observabilidad.
