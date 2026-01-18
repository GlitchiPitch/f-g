# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## \[1.5.0] - 2026-01-18

### Added

* Complete weapon system with ToolService for player weapon management
* Combo attack mechanics with sequential animation playback
* Day/night cycle system with DayNightController for game time management
* TeleportService with enhanced teleportation mechanics for lobby and world transitions
* Food asset system with multiple food types (Meat, Banana, Ham, Rice, Fish, Apple)
* Weapons asset system with one-handed and two-handed weapon categories
* Weapon animation support for one-handed and two-handed combat
* Tool state management with equipped/unequipped states
* Player teleportation mechanics with anti-spam protection

### Changed

* TeleportHandler migrated to TeleportService in Services layer architecture
* Handlers layer removed from Server Application architecture
* Enhanced asset management with modular Food and Weapons systems
* AnimationService updated with weapon-specific animation support
* PlayerService enhanced with weapon state management

### Removed

* Server/Application/Handlers/TeleportHandler.luau (migrated to TeleportService)
* Server/Application/Handlers/init.luau (Handlers layer removed)

### Technical

* Added weapon type detection and animation mapping
* Implemented combo attack timing system with reset mechanics
* Enhanced teleportation with world-based teleport setup
* Added asset cloning system for dynamic tool/weapon spawning
* Implemented day/night cycle with configurable parameters

## \[1.4.0] - 2026-01-18

### Added

* Player statistics system with level and seeds tracking
* Farmer entity for AI-controlled characters in hunting mechanics
* Enhanced hunting system with real-time hunter AI (0.3s update intervals)
* Hunter spawning/despawning mechanics with 10-second intervals
* Hunter targeting system that pursues closest players
* Hunter attack mechanics with distance-based behavior
* Level-based target bird selection system
* Handlers layer in Server Application architecture
* Managers layer with DeadlyGameManager containing multiple game modes
* Deadly game modes: DeadOrAlive, Tag, HideAndSeek, Bingo, Lamp
* TeleportHandler for player teleportation mechanics
* PlayerRepository:getPlayers() method for accessing all player entities

### Changed

* HuntingController now uses real-time updates instead of 10-second intervals
* HuntingService target selection now considers player levels for difficulty scaling
* CameraController transparency reduced from fully transparent (1.0) to semi-transparent (0.5)
* PlayerEntity enhanced with stats persistence and data serialization methods
* Server Application now includes Handlers and Managers layers

### Technical

* Added RenderStepped-based hunter AI updates
* Implemented player proximity detection for hunter targeting
* Enhanced dependency injection with new service and handler registrations
* Added comprehensive type definitions for Player stats and Farmer entity
* Improved hunting mechanics with state-based hunter management

## \[1.3.0] - 2026-01-17

### Added

* Complete movement and controls system with SprintController
* Stamina-based running mechanics with player stats integration
* Advanced targeting system with TargetController for crosshair-based selection
* InputService for comprehensive user input handling (main action, run key, second action)
* ActionService for state-based player actions (idle, weapon, NPC interactions)
* AnimationService with peck animation and animation track management
* Farming system with ServerFarmController and ClientFarmService
* Food spawning mechanics with 10-second intervals
* New animation assets (Peck, OneHandednSlash1, EquipOneHanded)
* Visual targeting feedback system with UI billboards and humanoid display

### Changed

* Enhanced client controllers architecture with SprintController and TargetController
* Expanded client services layer with ActionService, AnimationService, InputService, and FarmService
* Server controllers now include FarmController alongside HuntingController
* Improved player state management with targeting integration
* Enhanced dependency injection with new service registrations

### Technical

* Added RenderStepped-based controller updates for real-time targeting
* Implemented range-based target detection with line-of-sight raycasting
* Added event-driven action system with use case integration
* Enhanced animation loading and management system
* Added Heartbeat-based food spawning system

## \[1.2.0] - 2026-01-17

### Added

* Complete hunting game system with HuntingService and HuntingController
* Server Controllers layer architecture
* EventBus for client-side event communication
* UI notification system for hunting events
* Remote event broadcasting (fireAllClients method)
* Assets directory structure
* Random target bird selection system (Chicken, Turkey, Duck, etc.)
* Hunter model spawning/despawning mechanics

### Changed

* Enhanced RemoteEventService with broadcast capabilities
* Client Application and Presentation layers now handle hunting events
* Server Application architecture expanded with Controllers layer
* Improved type annotations across client and server applications

### Technical

* Added Heartbeat-based controller updates (10-second intervals)
* Implemented event-driven UI notifications with auto-cleanup
* Enhanced dependency injection with new service registrations
* Added comprehensive type definitions for hunting system components

## \[1.1.0] - 2026-01-17

### Added

* Controllers layer implementation with CameraController
* Third-person camera system with occlusion transparency
* Client PlayerService for character management
* Client Infrastructure layer setup
* Enhanced DI container with singleton registrations
* Automatic server initialization

### Changed

* Domain Entities refactored to class-based structure
* Client application architecture expanded with Controllers and Infrastructure layers
* Server initialization now automatic on module load

### Technical

* Added occlusion transparency handling for camera system
* Implemented RenderStepped camera updates
* Enhanced dependency injection setup

## \[1.0.0] - 2026-01-15

### Added

* Initial project structure with Clean Architecture implementation
* Client, Server, and Shared modules setup
* Domain layer with Player entity
* Infrastructure layer with DIContainer and RemoteEventService
* Repository pattern implementation (PlayerRepository)
* Service layer architecture (PlayerService)
* Use cases and commands structure

### Infrastructure

* Roblox project configuration (default.project.json)
* Luau linting configuration (selene.toml)
* Aftman tool management (aftman.toml)

### Documentation

* Development documentation structure (.dev/)
* TODO and CHANGELOG tracking system
