/*
 * =============================================================================
 *  LoadMatch Platform - C4 Model in Structurizr DSL
 *  Course 1ASI0729 Open Source Application Development - Group 5
 *
 *  One model, five views. Structurizr guarantees that an element declared
 *  once is the same element at every level, so traceability breaks between
 *  Level 1, Level 2 and Level 3 are impossible by construction.
 *
 *  APPLIED DECISIONS (see the DDD reconciliation document)
 *  -------------------------------------------------------
 *  D-01  There is no Administrator actor: document validation is performed
 *        automatically against the MTC registry.
 *  D-02  SUNAT is out of scope. The RUC is validated locally with its
 *        check digit inside the Ruc Value Object. The US53 receipt is a PDF
 *        with the fee breakdown, not an electronic tax invoice.
 *  D-03  External systems aligned with the Event Storming: MTC Registry,
 *        Mapbox, PayPal, Email Service and Object Storage.
 *  D-04  Ten domain components, one per bounded context.
 *  D-05  Matching is declared without an aggregate: Domain Service and
 *        read models.
 *  D-06  Incident is an internal entity of the Trip aggregate (US52).
 *        Cancellation by the carrier (US55) and delivery confirmation by
 *        the shipper (US56) also live in Trip Execution.
 * =============================================================================
 */

workspace "LoadMatch Platform" "B2B road freight transport brokerage platform in Peru." {

    model {

        # -------------------------------------------------------------------
        # Actors
        # -------------------------------------------------------------------
        shipper = person "Shipper" "Business owner, produce collector or logistics manager who needs to transport goods."
        carrier = person "Carrier" "Cargo vehicle owner or independent driver looking for freight opportunities."

        # -------------------------------------------------------------------
        # External systems
        # -------------------------------------------------------------------
        mtc = softwareSystem "MTC Registry" "Official system of Peru's Ministry of Transport and Communications used to validate license plates, SOAT and driver licenses." "External"
        mapbox = softwareSystem "Mapbox" "Geocoding, route and distance calculation service." "External"
        paypal = softwareSystem "PayPal" "Payment gateway for charging the shipper for the service and paying out the carrier." "External"
        storage = softwareSystem "Object Storage" "Object storage for carrier documents and evidence." "External"
        email = softwareSystem "Email Service" "SMTP/API service for transactional notifications and account verification." "External"

        # -------------------------------------------------------------------
        # Main system
        # -------------------------------------------------------------------
        loadmatch = softwareSystem "LoadMatch Platform" "B2B digital road freight transport brokerage platform. Centralizes load request publishing, matching, trip traceability, ratings and payments." {

            landing = container "Landing Page" "Static marketing and lead capture website. Public entry point to the product." "HTML5, CSS3, JavaScript" {
                lpSections = component "Content Sections" "Hero, value proposition per segment, how it works, vehicle types, pricing, testimonials, product and team videos, FAQ and footer." "Semantic HTML5, CSS3"
                lpNav = component "Navigation & Responsive Layout" "Navigation bar, mobile menu, smooth scrolling between sections and responsive breakpoints." "CSS3 Grid/Flexbox, JavaScript"
                lpCta = component "Call To Action" "Sign-up buttons that send the visitor to the application according to their segment." "JavaScript"
                lpForm = component "Lead Capture Form" "Contact form with client-side validation. Sends the lead to the backend and shows a confirmation or error." "JavaScript, Fetch API"
                lpSeo = component "SEO & Meta Tags" "Title, description, social tags and structured data for search engine indexing." "Meta tags, Open Graph, JSON-LD"
                lpI18n = component "Language Switcher" "Switches the landing page content between Spanish and English." "JavaScript"
            }

            spa = container "Single Page Application" "Transactional web application with dashboards, catalogs and operations boards for shippers and carriers." "Angular 22, TypeScript" {
                spaShell = component "App Shell & Routing" "Root layout, toolbar, sidebar and navigation. Lazy-loads the feature modules according to the route and role." "Angular Router, Angular Material"
                spaGuards = component "Auth Guard & JWT Interceptor" "Blocks routes by role, attaches the Bearer token to every outgoing request and signs the user out on a 401." "CanActivate, HttpInterceptor"
                spaShared = component "Shared Kernel" "BaseService with the common HTTP operations, shared models and assemblers, reusable UI components and internationalization." "Angular Services, Angular Material"

                spaAuth = component "Authentication" "Sign-up and sign-in forms. Stores the token and exposes the session state to the rest of the application. (EP01)" "Angular - BC iam"
                spaProfile = component "Profile Management" "Creation and editing of the Shipper or Carrier profile, RUC and contact details. (EP01)" "Angular - BC profiles"
                spaFleet = component "Fleet" "Registration and listing of vehicles, license plates and vehicle type. (EP01)" "Angular - BC fleet"
                spaDocs = component "Documents" "Upload of driver licenses, SOAT and vehicle registration cards, and lookup of their automatic validation status. (EP01)" "Angular - BC documents"
                spaFreight = component "Freight Publishing" "Load publishing form and the shipper's load request board. (EP02)" "Angular - BC freight-publishing"
                spaSearch = component "Freight Search & Map" "Search for compatible loads with map display and filters by distance, weight and vehicle type. (EP03)" "Angular, Mapbox GL JS"
                spaTrip = component "Trip Execution" "Trip tracking, status changes, delivery confirmation, cancellation, incident reporting and history timeline. (EP04, US55)" "Angular - BC trip-execution"
                spaPay = component "Payments" "Tokenized checkout, PDF receipt download and payout lookup. No card data is ever sent to our own backend. (EP08)" "Angular, PayPal SDK"
                spaRate = component "Rating" "Mutual rating at trip close and display of shipper and carrier reputation. (EP05)" "Angular - BC rating"
            }

            api = container "Backend REST API" "Exposes the versioned REST API. Holds the business rules, the domain bounded contexts and the orchestration of external integrations." "Java 17, Spring Boot 3" {

                # --- Cross-cutting ---
                apiSecurity = component "Security & JWT" "Authenticates every request, validates the token signature and resolves the role for per-endpoint authorization." "Spring Security 6"
                apiEvents = component "Domain Event Publisher" "Decouples the bounded contexts by publishing and routing in-process domain events." "Spring ApplicationEventPublisher"
                apiNotify = component "Notification" "Domain event subscriber. Stores the in-app notification (US43) and sends the transactional email. Aggregate: Notification." "Spring Boot @Async"

                # --- One component per bounded context ---
                apiIam = component "Identity & Access" "Sign-up, authentication and account lifecycle. Aggregate: User. (EP01)" "Spring Boot - BC iam"
                apiProfiles = component "Profiles" "Shipper and Carrier profiles, RUC and accumulated reputation. Aggregates: Shipper, Carrier. (EP01)" "Spring Boot - BC profiles"
                apiFleet = component "Fleet Management" "Vehicles, license plates, vehicle types and load capacities. Aggregates: Vehicle, VehicleType. (EP01)" "Spring Boot - BC fleet"
                apiDocs = component "Document Validation" "Upload, expiration and automatic validation of driver licenses, SOAT and registration cards. Aggregates: Document, DocumentType. (EP01, US19)" "Spring Boot - BC documents"
                apiFreight = component "Freight Publishing" "Publishing, editing, cancellation and urgent republishing of load requests. Aggregate: LoadRequest. (EP02)" "Spring Boot - BC freight-publishing"
                apiMatching = component "Matching & Search" "Proximity search, filtering and assignment of compatible load requests. No aggregate: Domain Service and read models. (EP03)" "Spring Boot - BC matching"
                apiTrip = component "Trip Execution" "Trip lifecycle, delivery confirmation, cancellation and incidents. Aggregate: Trip (internal entities TripStatusHistory and Incident). (EP04, US55)" "Spring Boot - BC trip-execution"
                apiPayment = component "Payment Management" "Charging the shipper, platform fee, carrier payout and PDF receipt. Aggregate: Payment. (EP08)" "Spring Boot - BC payment"
                apiRating = component "Rating" "Post-trip mutual rating and recalculation of shipper and carrier reputation. Aggregate: Rating. (EP05)" "Spring Boot - BC rating"
                apiContact = component "Contact & Leads" "Contact forms and leads coming from the landing page. Aggregate: ContactMessage." "Spring Boot - BC contact"
            }

            db = container "Relational Database" "Transactional storage for users, profiles, fleet, documents, load requests, trips, payments and notifications. The PostGIS extension supports the matching proximity queries." "PostgreSQL 16 + PostGIS" "Database"
        }

        # -------------------------------------------------------------------
        # Relationships - actors to containers
        # -------------------------------------------------------------------
        shipper -> landing "Visits to learn about the value proposition and sign up" "HTTPS"
        carrier -> landing "Visits to join the carrier network" "HTTPS"
        shipper -> spaShell "Manages load requests, tracks shipments, rates and pays" "HTTPS"
        carrier -> spaShell "Registers fleet and documents, accepts trips and updates statuses" "HTTPS"

        # -------------------------------------------------------------------
        # Relationships - Landing Page
        # -------------------------------------------------------------------
        lpNav -> lpSections "Controls scrolling and visibility of"
        lpI18n -> lpSections "Swaps the text content of"
        lpSeo -> lpSections "Describes for search engines the content of"
        lpCta -> spaShell "Redirects to sign-up in" "HTTPS"
        lpForm -> apiContact "POST /api/v1/contact-messages" "JSON/HTTPS"

        # -------------------------------------------------------------------
        # Relationships - Single Page Application
        # -------------------------------------------------------------------
        spaGuards -> spaShell "Protects the routes and signs the requests of" "in-process"
        spaAuth -> spaGuards "Hands over the token obtained at sign-in" "in-process"
        spaShell -> spaShared "Reuses HTTP services, models and components from" "in-process"

        spaShell -> spaAuth "Lazy-loads" "lazy loading"
        spaShell -> spaProfile "Lazy-loads" "lazy loading"
        spaShell -> spaFleet "Lazy-loads" "lazy loading"
        spaShell -> spaDocs "Lazy-loads" "lazy loading"
        spaShell -> spaFreight "Lazy-loads" "lazy loading"
        spaShell -> spaSearch "Lazy-loads" "lazy loading"
        spaShell -> spaTrip "Lazy-loads" "lazy loading"
        spaShell -> spaPay "Lazy-loads" "lazy loading"
        spaShell -> spaRate "Lazy-loads" "lazy loading"

        # -------------------------------------------------------------------
        # Relationships - SPA to Backend
        # -------------------------------------------------------------------
        spaGuards -> apiSecurity "Every authenticated request goes through the filter" "Bearer JWT"
        spaAuth -> apiIam "POST /api/v1/auth/sign-in and sign-up" "JSON/HTTPS"
        spaProfile -> apiProfiles "GET and PUT /api/v1/shippers and /carriers" "JSON/HTTPS"
        spaFleet -> apiFleet "POST and GET /api/v1/vehicles" "JSON/HTTPS"
        spaDocs -> apiDocs "POST and GET /api/v1/documents" "multipart/form-data"
        spaFreight -> apiFreight "POST and GET /api/v1/load-requests" "JSON/HTTPS"
        spaSearch -> apiMatching "GET /api/v1/load-requests/nearby" "JSON/HTTPS"
        spaTrip -> apiTrip "PATCH /api/v1/trips/{id}/status, POST /incidents" "JSON/HTTPS"
        spaPay -> apiPayment "POST /api/v1/payments" "JSON/HTTPS"
        spaRate -> apiRating "POST /api/v1/ratings" "JSON/HTTPS"

        # -------------------------------------------------------------------
        # Internal Backend relationships
        # -------------------------------------------------------------------
        apiSecurity -> apiIam "Validates the tokens issued by" "in-process"
        apiFreight -> apiMatching "Exposes the load requests listed on the market" "in-process"

        apiIam -> apiEvents "Publishes UserRegistered" "in-process"
        apiDocs -> apiEvents "Publishes DocumentationApproved and ValidationRejected" "in-process"
        apiTrip -> apiEvents "Publishes TripCompleted, DeliveryDisputed, TripCancelledByCarrier and IncidentReported" "in-process"
        apiPayment -> apiEvents "Publishes PaymentSucceeded" "in-process"
        apiRating -> apiEvents "Publishes RatingRegistered" "in-process"

        apiEvents -> apiProfiles "Enables the carrier, recalculates reputations and records late cancellations" "in-process"
        apiEvents -> apiFreight "Republishes the cancelled load request as urgent" "in-process"
        apiEvents -> apiPayment "Triggers the charge when the trip is completed" "in-process"
        apiEvents -> apiNotify "Delivers the subscribed events to" "in-process"

        # -------------------------------------------------------------------
        # Persistence
        # Each bounded context includes its own Spring Data JPA repositories
        # -------------------------------------------------------------------
        apiIam -> db "Persists and retrieves its Aggregate Roots" "JDBC / Spring Data JPA"
        apiProfiles -> db "Persists and retrieves its Aggregate Roots" "JDBC / Spring Data JPA"
        apiFleet -> db "Persists and retrieves its Aggregate Roots" "JDBC / Spring Data JPA"
        apiDocs -> db "Persists and retrieves its Aggregate Roots" "JDBC / Spring Data JPA"
        apiFreight -> db "Persists and retrieves its Aggregate Roots" "JDBC / Spring Data JPA"
        apiMatching -> db "Runs proximity queries (ST_DWithin)" "JDBC / PostGIS"
        apiTrip -> db "Persists and retrieves its Aggregate Roots" "JDBC / Spring Data JPA"
        apiPayment -> db "Persists and retrieves its Aggregate Roots" "JDBC / Spring Data JPA"
        apiRating -> db "Persists and retrieves its Aggregate Roots" "JDBC / Spring Data JPA"
        apiContact -> db "Persists contact messages" "JDBC / Spring Data JPA"
        apiNotify -> db "Persists each user's notifications" "JDBC / Spring Data JPA"

        # -------------------------------------------------------------------
        # External integrations
        # Each arrow represents the context's own anti-corruption layer
        # -------------------------------------------------------------------
        apiFleet -> mtc "Validates license plate and SOAT validity" "REST/HTTPS - ACL"
        apiDocs -> mtc "Validates driver license" "REST/HTTPS - ACL"
        apiDocs -> storage "Uploads the file and obtains the signed URL" "HTTPS - ACL"
        apiTrip -> storage "Stores the incident evidence photo" "HTTPS - ACL"
        apiFreight -> mapbox "Geocodes origin and destination and calculates the distance" "REST/HTTPS - ACL"
        apiMatching -> mapbox "Calculates the distance from the carrier to the load" "REST/HTTPS - ACL"
        apiTrip -> mapbox "Gets the route to the destination" "REST/HTTPS - ACL"
        apiPayment -> paypal "Executes charge, fee and payout using tokens" "REST/HTTPS - ACL"
        apiNotify -> email "Requests the email delivery" "SMTP/API - ACL"

        # -------------------------------------------------------------------
        # Notifications back to the actors
        # -------------------------------------------------------------------
        email -> shipper "Notifies trip confirmations and payment receipts" "Email"
        email -> carrier "Notifies compatible loads and validation results" "Email"
    }

    views {

        systemContext loadmatch "C4L1Context" "System Context diagram of the LoadMatch platform." {
            include *
            autolayout lr
        }

        container loadmatch "C4L2Containers" "Container diagram of the LoadMatch architecture." {
            include *
            autolayout tb
        }

        component api "C4L3aBackend" "Component diagram of the Backend REST API container." {
            include *
            autolayout tb
        }

        component spa "C4L3bSPA" "Component diagram of the Single Page Application container." {
            include *
            autolayout tb
        }

        component landing "C4L3cLanding" "Component diagram of the Landing Page container." {
            include *
            autolayout tb
        }

        styles {
            element "Person" {
                shape Person
                background #0b4f8a
                color #ffffff
                fontSize 22
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "External" {
                background #8a8a8a
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Database" {
                shape Cylinder
                background #438dd5
                color #ffffff
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            relationship "Relationship" {
                dashed false
                fontSize 20
            }
        }
    }
}
