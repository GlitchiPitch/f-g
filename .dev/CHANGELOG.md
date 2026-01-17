# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
