# Game Development Portfolio

This repository contains selected screenshots, code samples, and short explanations from my personal game development projects.

My main current project is **Knight's Mash**, a 2D arena-survivor / roguelite game developed in **Godot 4**.

The full project repository is private because the game is still in development. This portfolio contains selected material that shows my work, learning process, and programming practice.

## Main project: Knight's Mash

**Engine:** Godot 4  
**Language:** GDScript  
**Genre:** 2D Arena-Survivor / Roguelite  

Knight's Mash focuses on:

- player movement and combat
- enemy spawning
- tilemap-based arena maps
- weapon and upgrade systems
- UI and menu systems
- balancing and polish
- pixel art and visual effects

## Selected systems

### Map-based enemy spawning

I replaced an older radius-based enemy spawn system with a tilemap-based approach.

The map root collects valid cells from a `TileMapLayer`, converts them into world positions, and the enemy manager uses those positions to spawn enemies only inside valid arena areas.

This helped support more complex maps with rooms, pathways, and walls.

### UI and menus

The project includes UI for player information, menus, upgrades, and general game flow.

### Weapons and upgrades

The project uses different player abilities and upgrade logic inspired by arena-survivor games.

## Technologies

- Godot 4
- GDScript
- GameMaker Language
- Python
- Git/GitHub
- Aseprite
