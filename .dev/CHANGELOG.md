# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
