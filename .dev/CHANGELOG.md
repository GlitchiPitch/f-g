# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## \[1.16.0] - 2026-01-22

### Added

* Complete shop system with ShopService for NPC/vendor interactions
* ShopUI component extending _BaseUI with shop interface and close functionality
* Static camera mode for shop interactions with tweened camera transitions
* Enhanced crafting UI methods for item management (addItemForCrafting, addItemForBrewing, resetCrafting)
* TOGGLE_SHOP client event for shop UI state management
* Shop camera positioning with CameraPart reference system

### Changed

* Refactored presentation event handlers to use table-based approach for better maintainability
* Simplified CameraController by replacing alchemy/craft specific methods with generic _setStaticCamera
* Enhanced event architecture with consolidated client event handling

### Technical

* Added shop service integration across client application layers
* Implemented shop UI animation system with tweened position transitions
* Added shop camera mode support in CameraController with CFrame-based positioning
* Enhanced UI architecture with new shop component registration
* Improved event handling performance with table-based event registration

## \[1.15.0] - 2026-01-22

### Added

* Reset crafting functionality with item return to inventory mechanics
* Enhanced UI item management with add/clear functionality in _CraftableUI
* Action button integration for crafting reset operations
* Event-driven crafting item management with client event broadcasting

### Changed

* Refactored _CraftableUI with improved item display and management methods
* Enhanced CraftService with resetCraft method for inventory restoration
* Improved event handling architecture with consolidated event registration
* Updated UseCases with resetCrafting functionality across client and server

### Technical

* Added RESET_CRAFTING remote event for server-client synchronization
* Implemented ADD_ITEM_FOR_CRAFTING and ADD_ITEM_FOR_BREWING client events
* Enhanced UI architecture with action button connection management
* Improved code quality by removing debug warning statements

## \[1.14.9] - 2026-01-22

### Added

* Modular UI architecture with _BaseUI and _CraftableUI base classes
* AlchemyUI and CraftUI components extending _CraftableUI for specialized crafting interfaces
* Enhanced UI inheritance system for better code organization and reusability

### Changed

* Refactored InventoryUI and RecipeUI to inherit from _BaseUI base class
* Improved UI initialization system with integrated AlchemyUI and CraftUI components
* Enhanced UI architecture with proper inheritance patterns and shared functionality

### Technical

* Implemented class-based UI inheritance system with metatable-based inheritance
* Added UI mode management for inventory, alchemy, and crafting interactions
* Enhanced dependency injection with new UI component registrations
* Improved UI structure with dedicated base classes for different UI types

## \[1.14.8] - 2026-01-22

### Added

* RecipeUI component for displaying crafting recipes with ingredient visualization
* Enhanced weapon usage system with weapon data validation and dynamic damage calculation
* Potion drinking mechanics with inventory consumption and stat bonus application
* Food eating mechanics with health restoration and server-client synchronization
* Recipe reading client event system for UI recipe display
* Player bonus system for applying potion and food effects

### Changed

* Refactored weapon activation from toolActivated to useWeapon with weapon parameter
* Enhanced ActionService with weapon repository integration for damage calculation
* Updated remote event system to support weapon usage, potion drinking, and food consumption
* Improved AlchemyService with potion consumption and bonus application logic

### Technical

* Added USE_WEAPON, DRINK_POTION, READ_RECIPE, and EAT_FOOD remote events
* Implemented weapon validation system ensuring only equipped weapons can be used
* Enhanced player entity with addBonus method for effect application
* Added comprehensive type definitions for new consumption mechanics

## \[1.14.7] - 2026-01-22

* Comprehensive weapon crafting recipes with material requirements and skill prerequisites
* Potion crafting recipes for Health, Mana, Stamina, and Speed potions
* Recipe assets for all craftable weapons and potions (Club, RustySword, AssassinDagger, etc.)
* Wood material asset and crafting data for basic weapon crafting
* Advanced weapon recipes with gem requirements (Ruby, Sapphire, Emerald, Crystal, Obsidian)

### Changed

* Enhanced weapon data structure with integrated crafting recipes for all weapons
* Improved CraftService spawn point positioning for better item placement
* Refactored EnemyService to use enemyRepository for better data management
* Expanded item assets module with comprehensive recipe asset references

### Fixed

* CraftService item positioning bug (IngredientSpawnPoint → CraftItemSpawnPoint)

### Technical

* Added crafting recipe validation system with exact material count requirements
* Implemented weapon-specific crafting recipes with progressive difficulty scaling
* Enhanced asset management with recipe model references for crafting UI
* Improved enemy service initialization with repository-based data access

## \[1.14.6] - 2026-01-22

### Added

* Comprehensive weapon crafting system with recipes, stat requirements, and skill prerequisites
* Extensive item data system with crafting materials (Iron, Steel, Gold, gems, stones, etc.)
* Alchemy ingredients system with mushrooms, flowers, and natural resources (PurpleFlower, RedMushroom, BlueMushroom, Chamomile, PurpleMushroom)
* CraftService implementation for client and server with recipe validation and item management
* New remote events for crafting mechanics (CRAFT_ITEM, ADD_ITEM_FOR_CRAFTING)
* Enhanced weapon data with crafting recipes, damage types, and bonus effects
* One-handed and two-handed weapon categories with progressive difficulty scaling

### Changed

* Enhanced repository architecture to support specialized crafting item management
* Expanded Shared Data modules with comprehensive weapon and item definitions
* Updated constants with new crafting remote events and client event handling
* Improved item asset organization with dedicated Items module integration

### Technical

* Implemented exact-match recipe validation system for weapon crafting
* Added weapon requirement system with stats (strength, dexterity) and skill prerequisites
* Enhanced dependency injection with CraftService integration across client and server layers
* Added comprehensive weapon asset management with model references and pricing
* Implemented item counting and validation for crafting recipes
* Added weapon bonus system for special effects (orcSlayer, etc.)

## \[1.14.5] - 2026-01-21

### Added

* Specialized repository architecture with EnemyRepository, ItemRepository, and PotionRepository
* Player entity inventory management methods (getInventory, addItemToInventory, removeItemFromInventory)
* Enhanced InventoryUI with toggle functionality and inventory button integration
* Improved item interaction system with tooltips and better click handling
* Enhanced alchemy recipe validation with exact match checking

### Changed

* Refactored repository infrastructure from generic ItemsRepository to specialized repositories
* Enhanced Player entity with comprehensive inventory management capabilities
* Improved isAlive() validation with HumanoidRootPart check
* AlchemyService refactored to use PotionRepository for better separation of concerns
* InventoryUI restructured to use MainUI container with dedicated Inventory frame
* Enhanced InventoryUI item interaction with mode-based click handlers
* Improved cache system with better object management

### Removed

* ItemsRepository (replaced with specialized ItemRepository, EnemyRepository, and PotionRepository)

### Technical

* Implemented repository pattern specialization for better code organization
* Enhanced dependency injection with new repository registrations
* Improved inventory management architecture with entity-level methods
* Added tooltip system for better item identification in InventoryUI
* Enhanced alchemy recipe matching with exact ingredient count validation
* Improved UI structure with MainUI container for better organization

## \[1.14.4] - 2026-01-20

### Added

* Loot system foundation with LootController and LootService for enemy drop mechanics
* Item assets system with PurpleFlower, RedMushroom, BlueMushroom, Chamomile, and PurpleMushroom
* Shared Cache system for temporary object management and storage
* CRAFT_ITEM remote event constant for crafting system integration
* Enhanced InventoryUI with crafting mode support and item management

### Changed

* Shared Assets module expanded with Items module integration
* InventoryUI enhanced with craft mode functionality and service integration
* Server Application updated with CRAFT_ITEM event handling
* Client and Server UseCases expanded with crafting system support
* Shared Data enhanced with comprehensive item definitions and models

### Technical

* Added loot point setup system in LootService with cache management
* Implemented object caching with add/remove/get methods for temporary storage
* Enhanced InventoryUI architecture with mode-based item interaction logic
* Added event-driven crafting system with remote event synchronization
* Expanded item data structure with health bonuses and pricing for new item types

## \[1.14.3] - 2026-01-20

### Added

* CraftService for comprehensive crafting mechanics and item management
* Shared Cache system for object management and temporary storage
* Enhanced CameraController with alchemy and crafting camera modes
* TOGGLE_CRAFT client event constant for crafting UI management
* TargetController blocking functionality for interaction control

### Changed

* CameraController enhanced with tweened camera transitions for different interaction modes
* TargetController improved with state blocking for UI interactions
* Client services layer expanded with CraftService integration
* Shared infrastructure enhanced with Cache system integration

### Technical

* Added camera mode system with "standard", "alchemy", "craft", and "isometric" modes
* Implemented tweened camera transitions using TweenService for smooth UX
* Added object caching system for temporary item management
* Enhanced target update blocking for seamless UI interaction states

## \[1.14.2] - 2026-01-20

### Added

* Complete equipment system with item equipping and unequipping mechanics
* EQUIP_ITEM remote event for client-server equipment synchronization
* Enhanced AlchemyService with proper initialization and item management methods
* InventoryUI mode switching system for inventory, alchemy, and crafting modes
* Improved InventoryUI with better item management and visual feedback

### Changed

* ActionService enhanced with AlchemyService integration for alchemy interactions
* InventoryUI refactored with streamlined item handling and connection management
* Client UseCases expanded with equipItem functionality
* Server UseCases enhanced with comprehensive equipment management

### Technical

* Added equipment state tracking in InventoryUI with equipped item highlighting
* Implemented event-driven equipment system with remote event synchronization
* Enhanced dependency injection with AlchemyService integration in ActionService
* Improved InventoryUI architecture with mode-based item interaction logic

## \[1.14.1] - 2026-01-20

### Added

* SoundService for comprehensive audio management and sound playback
* CLIENT_EVENTS constants for UI toggle functionality (inventory, alchemy, action button, death screen)
* ATTRIBUTES constants for interact type management
* isAlive() method to Player entity for health and character state checking

### Changed

* Camera zoom increased from 100 to 140 for better visibility
* Occlusion transparency increased from 0.5 to 0.8 for improved visual clarity

### Technical

* Enhanced shared services layer with SoundService integration
* Improved player entity with health validation methods
* Expanded constants structure with client event and attribute definitions

## \[1.14.0] - 2026-01-20

### Added

* Brew potion use case with BREW_POTION remote event for alchemy mechanics
* Action button toggle functionality in UI presentation layer
* Event-driven action button management in target controller

### Changed

* Refactored TargetController with streamlined crosshair targeting logic
* Simplified target detection by removing complex UI billboard management
* Improved raycast-based target acquisition with better distance validation
* Enhanced enemy service initialization by moving spawn logic to dedicated method
* Cleaned up constants structure with simplified TAGS section
* Updated client use cases dependency injection resolution

### Removed

* Complex target view toggle methods (_toogleTargetView, _getTargetsInRange, _isTargetInView)
* Redundant INTERACT_OBJECT_TYPES constants (replaced with simplified TAGS)

### Technical

* Added potion brewing remote event constant for future alchemy system integration
* Streamlined target controller architecture for improved performance
* Enhanced client presentation layer with action button event handling

## \[1.13.0] - 2026-01-20

### Added

* AlchemyService for potion brewing mechanics in client and server application services
* Comprehensive weapons data system with one-handed and two-handed weapon templates
* Items data system with food items (Apple, Meat, Banana, Ham, Rice, Fish)
* Potions data system foundation with Health, Mana, Stamina, and Speed potions
* Shared Repositories infrastructure layer with WeaponRepository and ItemsRepository
* Enums directory structure for game constants and enumerations
* Lighting assets meta configuration for world-based lighting systems

### Changed

* Enhanced Shared Infrastructure layer with repositories initialization
* Refactored server initialization to remove player event handlers (moved to services layer)
* Updated Shared Data module to include Weapons, Items, and Potions data
* Enhanced PlayerService architecture with shared base class for better maintainability

### Technical

* Added base PlayerService class with common methods for entity management and world tracking
* Implemented comprehensive weapon data structure with damage, requirements, and pricing
* Added food item data with health restoration bonuses and pricing
* Enhanced dependency injection with new repository registrations
* Improved server architecture with cleaner service initialization

## \[1.12.0] - 2026-01-19

### Added

* AlchemyService for potion brewing mechanics in server application services
* Shared PlayerService base class for code reuse between client and server PlayerServices
* Comprehensive weapons data system with one-handed and two-handed weapon templates
* Items data system with food items (Apple, Meat, Banana, Ham, Rice, Fish)
* Potions data system foundation for future alchemy mechanics
* Shared Repositories infrastructure layer with WeaponRepository and ItemsRepository
* Enums directory structure for game constants and enumerations
* Lighting assets meta configuration for world-based lighting systems

### Changed

* Enhanced Shared Infrastructure layer with repositories initialization
* Refactored server initialization to remove player event handlers (moved to services layer)
* Updated Shared Data module to include Weapons, Items, and Potions data
* Enhanced PlayerService architecture with shared base class for better maintainability

### Technical

* Added base PlayerService class with common methods for entity management and world tracking
* Implemented comprehensive weapon data structure with damage, requirements, and pricing
* Added food item data with health restoration bonuses
* Enhanced dependency injection with new repository registrations
* Improved server architecture with cleaner service initialization

## \[1.11.0] - 2026-01-19

### Added

* Enemy spawning system integration with world management
* Automatic enemy spawning in World1 using spawn points
* Enemies assets module for organized enemy model management
* EnemyService registration in server application Services layer

### Changed

* Updated enemy data templates to use ReplicatedStorage assets instead of ServerStorage
* Enhanced Shared/Assets with Enemies module integration
* Updated sourcemap.json with Enemies assets inclusion

### Technical

* Implemented world-based enemy spawn point system
* Enhanced asset management architecture with enemy models
* Updated enemy initialization to automatically spawn enemies on server startup

## \[1.10.0] - 2026-01-19

### Added

* Complete enemy AI system with behavior tree architecture
* Enemy entity with spawning, attacking, death handling, and respawn mechanics
* EnemyController for managing enemy updates and lifecycle
* EnemyService for comprehensive enemy management and coordination
* Multiple enemy templates: Dummy, Orc, StrongOrc, Goblin, GoblinCommander with unique stats
* Behavior tree modules: Attack, CanSeePlayer, MoveTo, FaceTarget, Idle, Sequence, Selector
* Enemy attack animations and damage mechanics with cooldown systems
* Enemy sight range and attack range detection systems
* Automatic enemy respawning with configurable respawn times

### Changed

* Refactored enemy handling from Handlers layer to Controllers/Services architecture
* Enhanced server application architecture with EnemyController integration
* Updated shared domain entities with Enemy entity class
* Modified ToolService for enemy system compatibility
* Updated server controllers initialization for enemy management

### Removed

* Server/Application/Handlers/EnemyHandler.luau (migrated to EnemyController)
* Server/Application/Handlers/init.luau (Handlers layer removed)

### Technical

* Added behavior tree framework for complex enemy AI decision-making
* Implemented enemy state management with model spawning and destruction
* Added enemy folder management in workspace for organized enemy placement
* Enhanced dependency injection with enemy service and controller registrations
* Added comprehensive enemy data templates with health, speed, damage, and range stats

## \[1.9.0] - 2026-01-19

### Added

* Complete inventory management system with InventoryUI component
* Player inventory toggle functionality (E key)
* Real-time inventory refresh when items are equipped/unequipped
* Enemy data templates for combat system (Dummy, Orc, StrongOrc, Goblin, etc.)
* Event-driven inventory system integration

### Changed

* InputService enhanced with inventory key handling
* PlayerService integrated with inventory refresh events
* ActionService updated with weapon damage mechanics comments
* Shared Config expanded with inventory key binding
* UI Presentation layer enhanced with inventory management

### Technical

* Added InventoryUI class for comprehensive inventory management
* Implemented event-based inventory toggle and refresh system
* Added enemy data structure for future combat mechanics
* Enhanced client-side event bus with inventory events
* Integrated inventory system with character item monitoring

## \[1.8.1] - 2026-01-19

### Added

* Dynamic lighting system with world-based lighting modes (Butchery and Hell worlds)
* LightingService for automatic lighting transitions based on player world state
* Two-handed weapon animations (TwoHandedIdle, TwoHandednSlash1-4)
* Block animation for defensive combat mechanics
* Enhanced animation management with stopAllAnimations method

### Changed

* ToolService unified weapon activation logic for both one-handed and two-handed weapons
* AnimationService enhanced with two-handed weapon support and block animations
* Client application integrated with LightingService for real-time lighting updates
* Server Application architecture restored with Handlers layer
* Shared Assets structure expanded with Lighting asset management

### Fixed

* Typo correction in ToolService ("First TIme" → "First Time")

### Technical

* Added Lighting assets directory with world-specific lighting configurations
* Implemented dynamic lighting mode switching on player world transitions
* Enhanced weapon animation system with type-based animation prefixes
* Added comprehensive animation track management for combat states

## \[1.8.0] - 2026-01-19

### Added

* World-based camera system with automatic switching between default and isometric cameras
* Player data persistence system with PLAYER_UPDATED remote events for real-time synchronization
* Client repository infrastructure for player entity management and data caching
* Enhanced player entity with data serialization methods (fromData, getData, addVars, getVars)
* Camera controller setDefaultCamera method for dynamic camera mode switching

### Changed

* CameraController enhanced with world-based camera logic (Butchery world uses default camera, others use isometric)
* PlayerService now integrates with client repositories and handles player data updates
* Application layer extended with PLAYER_UPDATED event handling for client-side synchronization
* Client Infrastructure layer expanded with repositories for better data management architecture

### Technical

* Added PLAYER_UPDATED remote event constant for client-server data synchronization
* Implemented client-side player entity caching and world-based camera switching
* Enhanced dependency injection with client repository integration
* Added comprehensive type definitions for client repository components

## \[1.7.0] - 2026-01-19

### Added

* Comprehensive death handling system with world-based player transitions
* Death screen UI with smooth fade animations
* PLAYER_DIED remote event for client-server death notifications
* Enhanced character management in client controllers (CameraController, SprintController)
* Hunter-specific death mechanics with "Butchery" world destination

### Changed

* HuntingController significantly simplified - removed complex hunter AI, spawning, and targeting logic
* Hunting now toggles on/off every 5 seconds instead of continuous real-time updates
* Player death now routes hunters to "Butchery" world and regular players to "Hell" world
* Enhanced client PlayerService with controller coordination on character addition

### Removed

* Hunter AI update loops and targeting algorithms from HuntingController
* Real-time hunter spawning and despawning mechanics
* Complex hunter movement and attack distance calculations

### Technical

* Added death event broadcasting with player data serialization
* Implemented character anchoring on death to prevent physics issues
* Enhanced controller lifecycle management with onCharacterAdded methods
* Streamlined hunting system architecture for simpler gameplay mechanics

## \[1.6.0] - 2026-01-19

### Added

* World management system with player world tracking and assignment
* Enhanced teleportation mechanics with world-based teleport setup
* Player character parenting system for lobby and world separation
* Death handling system that moves players to "Hell" world on death
* Improved hunter AI with more frequent updates (0.1s intervals)
* Farmer entity animation support (Run and Idle animations)
* Enhanced detection distance system for hunter targeting

### Changed

* HuntingController update frequency increased from 0.3s to 0.1s for smoother AI
* Farmer attack distance increased from 10 to 20 units
* TeleportService now handles world transitions and character parenting
* PlayerService enhanced with character management and death event handling
* Spawn hunter interval reduced from 10 to 5 seconds for more dynamic gameplay

### Technical

* Added setCurrentWorld/getCurrentWorld methods to Player entity
* Implemented world-based character parenting in PlayerService
* Enhanced TeleportService with world name parameters and player entity integration
* Added animation loading and state management to Farmer entity
* Improved hunter detection logic with configurable detection distance

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
