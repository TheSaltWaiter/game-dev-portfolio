# Game-Development-Portfolio

Dieses Repository enthält ausgewählte Screenshots, Code-Beispiele und kurze Erklärungen aus meinen persönlichen Game-Development-Projekten.

Mein aktuelles Hauptprojekt ist **Knight's Mash**, ein 2D-Arena-Survivor / Roguelite, das mit **Godot 4** entwickelt wird.

Das vollständige Projekt-Repository ist privat, da sich das Spiel noch in Entwicklung befindet. Dieses Portfolio enthält ausgewählte Inhalte, die meine Arbeit, meinen Lernprozess und meine Programmierpraxis zeigen.

## Hauptprojekt: Knight's Mash

**Engine:** Godot 4
**Programmiersprache:** GDScript
**Genre:** 2D-Arena-Survivor / Roguelite

Knight's Mash umfasst unter anderem:

* Spielerbewegung und Kampfsysteme
* Gegner-Spawning
* Tilemap-basierte Arena-Maps
* Waffen- und Upgrade-Systeme
* UI- und Menüsysteme
* Balancing und Polishing
* Pixel-Art und visuelle Effekte

## Ausgewählte Systeme

### Tilemap-basiertes Gegner-Spawning

Ich habe ein älteres, radiusbasiertes Gegner-Spawning-System durch einen Tilemap-basierten Ansatz ersetzt.

Der Map-Root sammelt gültige Zellen aus einer `TileMapLayer`, wandelt diese in Weltpositionen um und stellt sie dem Enemy Manager zur Verfügung. Dadurch können Gegner nur innerhalb gültiger Arena-Bereiche spawnen, statt versehentlich in Wänden oder außerhalb der spielbaren Fläche zu erscheinen.

Dieser Ansatz unterstützt komplexere Maps mit Räumen, Wegen und Hindernissen deutlich besser.

### UI und Menüs

Das Projekt enthält UI-Systeme für Spielerinformationen, Menüs, Upgrades und den allgemeinen Spielablauf.

### Waffen und Upgrades

Das Projekt verwendet verschiedene Spielerfähigkeiten und Upgrade-Logik, inspiriert von Arena-Survivor-Spielen.

## Technologien

* Godot 4
* GDScript
* GameMaker Language
* Python
* Git/GitHub
* Aseprite
