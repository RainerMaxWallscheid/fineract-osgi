# language: en
@arc42-15 @adr-022 @adr-021 @runtime-osgi-lifecycle @quality-Q-EXT-2
Feature: Charge Catalog OSGi service (optional presence)
  As an operator of modular Fineract
  I want the Charge Catalog port available via the OSGi Service Registry when charge-impl is installed
  So that foreign BCs resolve fee definitions without coupling to charge domain entities

  # Architecture: docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md (Step 6 / 9)
  # Decisions: ADR-022 (api/impl/test + Service Registry), ADR-021 (Module API only)

  Background:
    Given the application can run under Equinox with Spring remaining inside charge-impl
    And inter-bundle access uses the OSGi Service Registry only (no Karaf Features)

  Scenario: ChargeDefinitionPort is registered when charge-impl is active
    Given the bundle "org.apache.fineract.charge.impl" is installed and started
    And Spring has created a ChargeDefinitionPort bean
    When the OSGi BundleContext of charge-impl is available
    Then a service of type ChargeDefinitionPort is present in the Service Registry
    And the service property "provider" is "fineract-charge-impl"

  Scenario: Boot path without OSGi still wires catalog services
    Given the application starts as plain Spring Boot without OSGi framework classes
    When charge catalog REST or platform services are invoked
    Then ChargeDefinitionPort and charge platform services are available via Spring
    And ChargeOsgiServiceRegistrar does not fail startup

  @manual
  Scenario: Stopping charge-impl unbinds the catalog port
    Given ChargeDefinitionPort is registered from charge-impl
    When the charge-impl bundle is stopped
    Then ChargeDefinitionPort is no longer obtainable from the Service Registry
    And consumers that required the service fail closed or use an explicit fallback
      # Full loan/savings retarget (Step 8 residual) should not leave hard dependencies on charge-impl types
