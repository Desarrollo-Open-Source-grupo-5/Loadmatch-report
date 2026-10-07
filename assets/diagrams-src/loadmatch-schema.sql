-- =============================================================================
--  LoadMatch Platform - PostgreSQL 16 relational schema
--  Section 4.8 of the report - Course 1ASI0729 - Group 5
--
--  One PostgreSQL schema per bounded context. The logical separation of
--  Domain-Driven Design is physically materialized in the database:
--  each context exclusively owns its tables.
--
--  CONVENTIONS
--  -----------
--  * UUID primary keys, matching the identity Value Objects of the
--    class model (UserId, VehicleId, ...).
--  * Value Objects embedded as prefixed columns, never as a separate
--    table (address_*, license_*, dim_*, rate_*, reputation_*).
--  * References between aggregates as a plain FK, without object navigation.
--  * Enumerations as VARCHAR with CHECK, never ordinals.
--  * Timestamps as TIMESTAMPTZ.
--
--  EXECUTION
--  ---------
--     psql -U postgres -d loadmatch -f loadmatch-schema.sql
--
--  The final PostGIS section is optional and commented out; enable it only
--  if the PostgreSQL image includes the extension (postgis/postgis).
-- =============================================================================

-- =============================================================================
--  SCHEMAS - one per bounded context
-- =============================================================================
DROP SCHEMA IF EXISTS iam, profiles, fleet, documents, freight, trip, payment, rating, contact, notification CASCADE;

CREATE SCHEMA iam;        COMMENT ON SCHEMA iam       IS 'Bounded Context: IAM - credentials and account lifecycle';
CREATE SCHEMA profiles;   COMMENT ON SCHEMA profiles  IS 'Bounded Context: Profiles - Shipper and Carrier profiles';
CREATE SCHEMA fleet;      COMMENT ON SCHEMA fleet     IS 'Bounded Context: Fleet - vehicles and vehicle types';
CREATE SCHEMA documents;  COMMENT ON SCHEMA documents IS 'Bounded Context: Document Validation - carrier documents';
CREATE SCHEMA freight;    COMMENT ON SCHEMA freight   IS 'Bounded Context: Freight Publishing - load requests';
CREATE SCHEMA trip;       COMMENT ON SCHEMA trip      IS 'Bounded Context: Trip Execution - trip execution and traceability';
CREATE SCHEMA payment;    COMMENT ON SCHEMA payment   IS 'Bounded Context: Payment - charge, platform fee and payout';
CREATE SCHEMA rating;     COMMENT ON SCHEMA rating    IS 'Bounded Context: Rating - post-trip rating';
CREATE SCHEMA contact;    COMMENT ON SCHEMA contact   IS 'Bounded Context: Contact - Landing Page leads';
CREATE SCHEMA notification; COMMENT ON SCHEMA notification IS 'Transversal component Notification - in-app notifications (US43)';

-- Matching has no schema of its own: it is a query context that operates
-- on freight and profiles through read ports.


-- =============================================================================
--  BOUNDED CONTEXT 1 - IAM
-- =============================================================================
CREATE TABLE iam.users (
    id                  UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    email               VARCHAR(255)    NOT NULL,
    password_hash       VARCHAR(255)    NOT NULL,
    role                VARCHAR(20)     NOT NULL,
    verified            BOOLEAN         NOT NULL DEFAULT FALSE,
    active              BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT now(),
    last_access_at      TIMESTAMPTZ,

    CONSTRAINT uq_user_email   UNIQUE (email),
    CONSTRAINT chk_user_role   CHECK (role IN ('SHIPPER', 'CARRIER')),
    CONSTRAINT chk_user_email  CHECK (email LIKE '%_@_%._%')
);

COMMENT ON TABLE  iam.users       IS 'Aggregate Root: User';
COMMENT ON COLUMN iam.users.role  IS 'Enum UserRole. Allows resolving JWT authorization without querying Profiles';

CREATE INDEX idx_user_email ON iam.users (email);

CREATE TABLE iam.password_reset_tokens (
    id              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID            NOT NULL,
    token_hash      VARCHAR(255)    NOT NULL,
    expires_at      TIMESTAMPTZ     NOT NULL,
    used            BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT uq_token_hash        UNIQUE (token_hash),
    CONSTRAINT fk_token_user        FOREIGN KEY (user_id) REFERENCES iam.users (id) ON DELETE CASCADE,
    CONSTRAINT chk_token_validity   CHECK (expires_at > created_at)
);

COMMENT ON TABLE iam.password_reset_tokens IS 'Internal entity PasswordResetToken of the User aggregate. Valid for 30 minutes (US30)';


-- =============================================================================
--  BOUNDED CONTEXT 2 - PROFILES
-- =============================================================================
CREATE TABLE profiles.shippers (
    id                      UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                 UUID            NOT NULL,
    ruc                     CHAR(11)        NOT NULL,
    business_name           VARCHAR(200)    NOT NULL,
    contact_name            VARCHAR(150),
    phone_number            VARCHAR(20)     NOT NULL,
    -- Value Object Address (embedded)
    address_street          VARCHAR(200)    NOT NULL,
    address_district        VARCHAR(100)    NOT NULL,
    address_province        VARCHAR(100),
    address_department      VARCHAR(100),
    -- Value Object Reputation (embedded)
    reputation_average              NUMERIC(3,2)    NOT NULL DEFAULT 0.00,
    reputation_total_ratings        INTEGER         NOT NULL DEFAULT 0,
    registered_at           TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT uq_shipper_user  UNIQUE (user_id),
    CONSTRAINT uq_shipper_ruc   UNIQUE (ruc),
    CONSTRAINT fk_shipper_user  FOREIGN KEY (user_id) REFERENCES iam.users (id),
    CONSTRAINT chk_shipper_ruc  CHECK (ruc ~ '^(10|15|17|20)[0-9]{9}$'),
    CONSTRAINT chk_shipper_reputation CHECK (reputation_average BETWEEN 0 AND 5),
    CONSTRAINT chk_shipper_ratings    CHECK (reputation_total_ratings >= 0)
);

COMMENT ON TABLE  profiles.shippers      IS 'Aggregate Root: Shipper';
COMMENT ON COLUMN profiles.shippers.reputation_average IS 'Value Object Reputation. Rating given by carriers (US51) and shown in the load detail (US40)';
COMMENT ON COLUMN profiles.shippers.ruc  IS 'Value Object Ruc. The CHECK validates the SUNAT prefix; the check digit is validated in the domain';

CREATE TABLE profiles.carriers (
    id                              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                         UUID            NOT NULL,
    first_names                     VARCHAR(100)    NOT NULL,
    last_names                      VARCHAR(100)    NOT NULL,
    dni                             CHAR(8)         NOT NULL,
    -- Value Object DriverLicense (embedded)
    license_number                  VARCHAR(20)     NOT NULL,
    license_category                VARCHAR(10)     NOT NULL,
    license_expiration              DATE            NOT NULL,
    phone_number                    VARCHAR(20)     NOT NULL,
    enablement_status               VARCHAR(20)     NOT NULL DEFAULT 'PENDING',
    -- Value Object Reputation (embedded)
    reputation_average              NUMERIC(3,2)    NOT NULL DEFAULT 0.00,
    reputation_total_ratings        INTEGER         NOT NULL DEFAULT 0,
    suspended_until                 TIMESTAMPTZ,
    suspension_reason               VARCHAR(300),
    registered_at                   TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT uq_carrier_user          UNIQUE (user_id),
    CONSTRAINT uq_carrier_dni           UNIQUE (dni),
    CONSTRAINT uq_carrier_license       UNIQUE (license_number),
    CONSTRAINT fk_carrier_user          FOREIGN KEY (user_id) REFERENCES iam.users (id),
    CONSTRAINT chk_carrier_dni          CHECK (dni ~ '^[0-9]{8}$'),
    CONSTRAINT chk_carrier_status       CHECK (enablement_status IN ('PENDING', 'ENABLED', 'SUSPENDED')),
    CONSTRAINT chk_carrier_reputation   CHECK (reputation_average BETWEEN 0 AND 5),
    CONSTRAINT chk_carrier_ratings      CHECK (reputation_total_ratings >= 0),
    CONSTRAINT chk_carrier_suspension   CHECK (suspended_until IS NULL OR suspension_reason IS NOT NULL)
);

COMMENT ON TABLE  profiles.carriers IS 'Aggregate Root: Carrier';
COMMENT ON COLUMN profiles.carriers.reputation_total_ratings IS 'Allows recalculating the average incrementally, without scanning rating.ratings';

COMMENT ON COLUMN profiles.carriers.suspended_until IS 'End of the 7-day suspension after 3 late cancellations within 30 days (US55)';

CREATE INDEX idx_carrier_status ON profiles.carriers (enablement_status);


-- =============================================================================
--  BOUNDED CONTEXT 3 - FLEET
-- =============================================================================
CREATE TABLE fleet.vehicle_types (
    id                  UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    name                VARCHAR(80)     NOT NULL,
    description         VARCHAR(300),
    max_weight_kg       NUMERIC(10,2)   NOT NULL,
    -- Value Object Dimensions (embedded)
    dim_max_length_m    NUMERIC(6,2)    NOT NULL,
    dim_max_width_m     NUMERIC(6,2)    NOT NULL,
    dim_max_height_m    NUMERIC(6,2)    NOT NULL,
    active              BOOLEAN         NOT NULL DEFAULT TRUE,

    CONSTRAINT uq_vehicle_type_name    UNIQUE (name),
    CONSTRAINT chk_vehicle_type_weight CHECK (max_weight_kg > 0),
    CONSTRAINT chk_vehicle_type_dim    CHECK (dim_max_length_m > 0 AND dim_max_width_m > 0 AND dim_max_height_m > 0)
);

COMMENT ON TABLE fleet.vehicle_types IS 'Aggregate Root: VehicleType. Catalog loaded as seed data';

CREATE TABLE fleet.vehicles (
    id                      UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    carrier_id              UUID            NOT NULL,
    vehicle_type_id         UUID            NOT NULL,
    license_plate           VARCHAR(10)     NOT NULL,
    brand                   VARCHAR(60),
    model                   VARCHAR(60),
    manufacture_year        SMALLINT,
    axle_count              SMALLINT,
    payload_kg              NUMERIC(10,2)   NOT NULL,
    gross_weight_kg         NUMERIC(10,2)   NOT NULL,
    -- Value Object Dimensions (embedded)
    dim_length_m            NUMERIC(6,2),
    dim_width_m             NUMERIC(6,2),
    dim_height_m            NUMERIC(6,2),
    mtc_validation_status   VARCHAR(20)     NOT NULL DEFAULT 'PENDING',
    mtc_validated_at        TIMESTAMPTZ,
    active                  BOOLEAN         NOT NULL DEFAULT TRUE,
    registered_at           TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT uq_vehicle_license_plate     UNIQUE (license_plate),
    CONSTRAINT fk_vehicle_carrier           FOREIGN KEY (carrier_id) REFERENCES profiles.carriers (id),
    CONSTRAINT fk_vehicle_type              FOREIGN KEY (vehicle_type_id) REFERENCES fleet.vehicle_types (id),
    CONSTRAINT chk_vehicle_mtc_status       CHECK (mtc_validation_status IN ('PENDING', 'VALIDATED', 'REJECTED')),
    CONSTRAINT chk_vehicle_year             CHECK (manufacture_year BETWEEN 1950 AND 2100),
    CONSTRAINT chk_vehicle_weights          CHECK (payload_kg > 0 AND gross_weight_kg >= payload_kg)
);

COMMENT ON TABLE  fleet.vehicles                       IS 'Aggregate Root: Vehicle';
COMMENT ON COLUMN fleet.vehicles.dim_height_m          IS 'Required by the Match my vehicle filter of section 4.2.4';
COMMENT ON COLUMN fleet.vehicles.mtc_validation_status IS 'Enum MtcValidationStatus. Distinguishes not validated from rejected, which a boolean cannot do';

CREATE INDEX idx_vehicle_carrier ON fleet.vehicles (carrier_id);
COMMENT ON COLUMN fleet.vehicles.active IS 'A deactivated vehicle is no longer considered in the load search (US33)';
CREATE INDEX idx_vehicle_type    ON fleet.vehicles (vehicle_type_id);


-- =============================================================================
--  BOUNDED CONTEXT 4 - DOCUMENT VALIDATION
-- =============================================================================
CREATE TABLE documents.document_types (
    id                      UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    name                    VARCHAR(80)     NOT NULL,
    description             VARCHAR(300),
    requires_expiration     BOOLEAN         NOT NULL DEFAULT TRUE,
    mandatory               BOOLEAN         NOT NULL DEFAULT TRUE,

    CONSTRAINT uq_document_type_name UNIQUE (name)
);

COMMENT ON TABLE documents.document_types IS 'Aggregate Root: DocumentType. Catalog loaded as seed data';

CREATE TABLE documents.documents (
    id                          UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    carrier_id                  UUID            NOT NULL,
    document_type_id            UUID            NOT NULL,
    file_url                    VARCHAR(500)    NOT NULL,
    validation_status           VARCHAR(20)     NOT NULL DEFAULT 'PENDING',
    -- Value Object RejectionReason (embedded)
    rejection_reason_code       VARCHAR(50),
    rejection_reason_description VARCHAR(300),
    issue_date                  DATE,
    expiration_date             DATE,
    uploaded_at                 TIMESTAMPTZ     NOT NULL DEFAULT now(),
    validated_at                TIMESTAMPTZ,

    CONSTRAINT fk_document_carrier     FOREIGN KEY (carrier_id) REFERENCES profiles.carriers (id),
    CONSTRAINT fk_document_type        FOREIGN KEY (document_type_id) REFERENCES documents.document_types (id),
    CONSTRAINT chk_document_status     CHECK (validation_status IN ('PENDING', 'IN_REVIEW', 'APPROVED', 'REJECTED', 'EXPIRED')),
    CONSTRAINT chk_document_rejection  CHECK (
        (validation_status = 'REJECTED' AND rejection_reason_code IS NOT NULL)
        OR (validation_status <> 'REJECTED')
    ),
    CONSTRAINT chk_document_dates      CHECK (expiration_date IS NULL OR issue_date IS NULL OR expiration_date > issue_date)
);

COMMENT ON TABLE  documents.documents                       IS 'Aggregate Root: Document';
COMMENT ON COLUMN documents.documents.rejection_reason_code IS 'Supports the RejectionReasonNotifiedToCarrier event from the Event Storming';

-- A carrier can only have ONE approved document per type,
-- but can retry after a rejection or an expiration.
CREATE UNIQUE INDEX uq_document_approved
    ON documents.documents (carrier_id, document_type_id)
    WHERE validation_status = 'APPROVED';

CREATE INDEX idx_document_carrier    ON documents.documents (carrier_id);
CREATE INDEX idx_document_expiration ON documents.documents (expiration_date) WHERE expiration_date IS NOT NULL;


-- =============================================================================
--  BOUNDED CONTEXT 5 - FREIGHT PUBLISHING  (Core)
-- =============================================================================
CREATE TABLE freight.load_requests (
    id                  UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    shipper_id          UUID            NOT NULL,
    vehicle_type_id     UUID            NOT NULL,
    -- Value Object Route > Location origin (embedded)
    origin_address      VARCHAR(200)    NOT NULL,
    origin_district     VARCHAR(100)    NOT NULL,
    origin_lat          NUMERIC(9,6)    NOT NULL,
    origin_lng          NUMERIC(9,6)    NOT NULL,
    -- Value Object Route > Location destination (embedded)
    destination_address VARCHAR(200)    NOT NULL,
    destination_district VARCHAR(100)   NOT NULL,
    destination_lat     NUMERIC(9,6)    NOT NULL,
    destination_lng     NUMERIC(9,6)    NOT NULL,
    distance_km         NUMERIC(8,2),
    weight_kg           NUMERIC(10,2)   NOT NULL,
    -- Value Object Dimensions (embedded)
    dim_length_m        NUMERIC(6,2)    NOT NULL,
    dim_width_m         NUMERIC(6,2)    NOT NULL,
    dim_height_m        NUMERIC(6,2)    NOT NULL,
    cargo_type          VARCHAR(120)    NOT NULL,
    -- Value Object Money (embedded)
    rate_amount         NUMERIC(10,2)   NOT NULL,
    rate_currency       CHAR(3)         NOT NULL DEFAULT 'PEN',
    status              VARCHAR(20)     NOT NULL DEFAULT 'DRAFT',
    pickup_at           TIMESTAMPTZ     NOT NULL,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT now(),
    published_at        TIMESTAMPTZ,
    urgent              BOOLEAN         NOT NULL DEFAULT FALSE,
    republished_at      TIMESTAMPTZ,
    cancellation_reason VARCHAR(300),

    CONSTRAINT fk_load_request_shipper      FOREIGN KEY (shipper_id)      REFERENCES profiles.shippers (id),
    CONSTRAINT fk_load_request_vehicle_type FOREIGN KEY (vehicle_type_id) REFERENCES fleet.vehicle_types (id),
    CONSTRAINT chk_load_request_status      CHECK (status IN ('DRAFT', 'PUBLISHED', 'ASSIGNED', 'IN_TRANSIT', 'DELIVERED', 'CANCELLED')),
    CONSTRAINT chk_load_request_weight      CHECK (weight_kg > 0),
    CONSTRAINT chk_load_request_dim         CHECK (dim_length_m > 0 AND dim_width_m > 0 AND dim_height_m > 0),
    CONSTRAINT chk_load_request_rate        CHECK (rate_amount > 0),
    CONSTRAINT chk_load_request_lat         CHECK (origin_lat BETWEEN -90 AND 90 AND destination_lat BETWEEN -90 AND 90),
    CONSTRAINT chk_load_request_lng         CHECK (origin_lng BETWEEN -180 AND 180 AND destination_lng BETWEEN -180 AND 180),
    CONSTRAINT chk_load_request_cancellation CHECK (
        (status = 'CANCELLED' AND cancellation_reason IS NOT NULL)
        OR (status <> 'CANCELLED')
    ),
    CONSTRAINT chk_load_request_urgent      CHECK (urgent = FALSE OR republished_at IS NOT NULL)
);

COMMENT ON TABLE  freight.load_requests             IS 'Aggregate Root: LoadRequest';
COMMENT ON COLUMN freight.load_requests.rate_amount IS 'Required by the Minimum rate filter of section 4.2.4';
COMMENT ON COLUMN freight.load_requests.cargo_type  IS 'Shown on the result cards described in section 4.2.4';
COMMENT ON COLUMN freight.load_requests.urgent      IS 'Load request republished after a late cancellation by the carrier (US55)';
COMMENT ON COLUMN freight.load_requests.status      IS 'IN_TRANSIT and DELIVERED are synchronized with Trip Execution events for the US37 filter';

CREATE INDEX idx_load_request_shipper   ON freight.load_requests (shipper_id);
CREATE INDEX idx_load_request_status    ON freight.load_requests (status);
CREATE INDEX idx_load_request_published ON freight.load_requests (origin_lat, origin_lng) WHERE status = 'PUBLISHED';


-- =============================================================================
--  BOUNDED CONTEXT 6 - MATCHING
--  No tables of its own. Queries freight.load_requests and
--  profiles.carriers through read ports.
-- =============================================================================


-- =============================================================================
--  BOUNDED CONTEXT 7 - TRIP EXECUTION  (Core)
-- =============================================================================
CREATE TABLE trip.trips (
    id                      UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    load_request_id         UUID            NOT NULL,
    shipper_id              UUID            NOT NULL,
    carrier_id              UUID            NOT NULL,
    vehicle_id              UUID            NOT NULL,
    status                  VARCHAR(30)     NOT NULL DEFAULT 'ASSIGNED',
    -- Value Object GpsLocation (embedded)
    location_lat            NUMERIC(9,6),
    location_lng            NUMERIC(9,6),
    location_recorded_at    TIMESTAMPTZ,
    assigned_at             TIMESTAMPTZ     NOT NULL DEFAULT now(),
    pickup_at               TIMESTAMPTZ,
    delivered_at            TIMESTAMPTZ,
    delivery_dispute_reason VARCHAR(500),
    confirmed_at            TIMESTAMPTZ,
    completed_at            TIMESTAMPTZ,
    cancellation_reason     VARCHAR(300),
    late_cancellation       BOOLEAN         NOT NULL DEFAULT FALSE,
    cancelled_at            TIMESTAMPTZ,

    CONSTRAINT fk_trip_load_request    FOREIGN KEY (load_request_id)  REFERENCES freight.load_requests (id),
    CONSTRAINT fk_trip_shipper         FOREIGN KEY (shipper_id)       REFERENCES profiles.shippers (id),
    CONSTRAINT fk_trip_carrier         FOREIGN KEY (carrier_id)       REFERENCES profiles.carriers (id),
    CONSTRAINT fk_trip_vehicle         FOREIGN KEY (vehicle_id)       REFERENCES fleet.vehicles (id),
    CONSTRAINT chk_trip_status         CHECK (status IN (
        'ASSIGNED', 'EN_ROUTE_TO_PICKUP', 'AT_PICKUP_POINT',
        'CARGO_PICKED_UP', 'IN_TRANSIT', 'DELAYED', 'DELIVERED',
        'DISPUTED', 'COMPLETED', 'CANCELLED')),
    CONSTRAINT chk_trip_cancellation   CHECK (
        (status = 'CANCELLED' AND cancellation_reason IS NOT NULL AND cancelled_at IS NOT NULL)
        OR (status <> 'CANCELLED')
    ),
    CONSTRAINT chk_trip_disputed       CHECK (
        (status = 'DISPUTED' AND delivery_dispute_reason IS NOT NULL)
        OR (status <> 'DISPUTED')
    )
);

COMMENT ON TABLE  trip.trips                      IS 'Aggregate Root: Trip. Separate from LoadRequest because it has its own lifecycle and invariants';

-- A load request has at most ONE active trip. If the carrier cancels
-- (US55), the load request is republished and another carrier creates a new trip.
CREATE UNIQUE INDEX uq_trip_active_load_request
    ON trip.trips (load_request_id)
    WHERE status <> 'CANCELLED';

-- Count of late cancellations in the last 30 days (US55).
CREATE INDEX idx_trip_late_cancellation
    ON trip.trips (carrier_id, cancelled_at)
    WHERE late_cancellation = TRUE;

CREATE INDEX idx_trip_carrier ON trip.trips (carrier_id);
CREATE INDEX idx_trip_shipper ON trip.trips (shipper_id);
CREATE INDEX idx_trip_status  ON trip.trips (status);

CREATE TABLE trip.trip_status_history (
    id              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    trip_id         UUID            NOT NULL,
    previous_status VARCHAR(30),
    new_status      VARCHAR(30)     NOT NULL,
    description     VARCHAR(300),
    registered_at   TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT fk_history_trip FOREIGN KEY (trip_id) REFERENCES trip.trips (id) ON DELETE CASCADE
);

COMMENT ON TABLE trip.trip_status_history IS 'Internal entity of the Trip aggregate. ON DELETE CASCADE because its lifecycle depends on the root';

CREATE INDEX idx_history_trip ON trip.trip_status_history (trip_id, registered_at);

CREATE TABLE trip.incidents (
    id              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    trip_id         UUID            NOT NULL,
    type            VARCHAR(30)     NOT NULL,
    description     VARCHAR(500),
    evidence_url    VARCHAR(500)    NOT NULL,
    reported_at     TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT fk_incident_trip    FOREIGN KEY (trip_id) REFERENCES trip.trips (id) ON DELETE CASCADE,
    CONSTRAINT chk_incident_type   CHECK (type IN ('ROAD_BLOCKAGE', 'MECHANICAL_FAILURE', 'ACCIDENT'))
);

COMMENT ON TABLE trip.incidents IS 'Internal entity Incident of the Trip aggregate (US52). The evidence photo lives in Object Storage';

CREATE INDEX idx_incident_trip ON trip.incidents (trip_id);


-- =============================================================================
--  BOUNDED CONTEXT 8 - PAYMENT
-- =============================================================================
CREATE TABLE payment.payments (
    id                      UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    trip_id                 UUID            NOT NULL,
    shipper_id              UUID            NOT NULL,
    carrier_id              UUID            NOT NULL,
    -- Value Object Money (embedded, three amounts)
    total_amount            NUMERIC(10,2)   NOT NULL,
    platform_fee            NUMERIC(10,2)   NOT NULL DEFAULT 0.00,
    payout_amount           NUMERIC(10,2)   NOT NULL DEFAULT 0.00,
    currency                CHAR(3)         NOT NULL DEFAULT 'PEN',
    method                  VARCHAR(20),
    status                  VARCHAR(20)     NOT NULL DEFAULT 'ENABLED',
    gateway_reference       VARCHAR(120),
    attempts                SMALLINT        NOT NULL DEFAULT 0,
    enabled_at              TIMESTAMPTZ     NOT NULL DEFAULT now(),
    processed_at            TIMESTAMPTZ,
    payout_status           VARCHAR(20)     NOT NULL DEFAULT 'PENDING',
    scheduled_deposit_date  DATE,
    transferred_at          TIMESTAMPTZ,

    CONSTRAINT uq_payment_trip          UNIQUE (trip_id),
    CONSTRAINT fk_payment_trip          FOREIGN KEY (trip_id)          REFERENCES trip.trips (id),
    CONSTRAINT fk_payment_shipper       FOREIGN KEY (shipper_id)       REFERENCES profiles.shippers (id),
    CONSTRAINT fk_payment_carrier       FOREIGN KEY (carrier_id)       REFERENCES profiles.carriers (id),
    CONSTRAINT chk_payment_status       CHECK (status IN ('ENABLED', 'PROCESSING', 'COMPLETED', 'REJECTED')),
    CONSTRAINT chk_payment_method       CHECK (method IS NULL OR method IN ('CARD', 'PAYPAL')),
    CONSTRAINT chk_payment_amounts      CHECK (total_amount > 0 AND platform_fee >= 0 AND payout_amount >= 0),
    CONSTRAINT chk_payment_split        CHECK (platform_fee + payout_amount <= total_amount),
    CONSTRAINT chk_payment_attempts     CHECK (attempts >= 0),
    CONSTRAINT chk_payment_completed    CHECK (
        (status = 'COMPLETED' AND gateway_reference IS NOT NULL AND processed_at IS NOT NULL)
        OR (status <> 'COMPLETED')
    ),
    CONSTRAINT chk_payment_payout       CHECK (payout_status IN ('PENDING', 'SCHEDULED', 'TRANSFERRED')),
    CONSTRAINT chk_payment_transfer     CHECK (
        (payout_status = 'TRANSFERRED' AND status = 'COMPLETED' AND transferred_at IS NOT NULL)
        OR (payout_status <> 'TRANSFERRED')
    )
);

COMMENT ON TABLE  payment.payments               IS 'Aggregate Root: Payment';
COMMENT ON COLUMN payment.payments.platform_fee  IS 'Fee retained by LoadMatch. Did not exist in the previous model';
COMMENT ON COLUMN payment.payments.payout_amount IS 'Amount transferred to the carrier';

CREATE INDEX idx_payment_shipper ON payment.payments (shipper_id);
CREATE INDEX idx_payment_carrier ON payment.payments (carrier_id);
COMMENT ON COLUMN payment.payments.scheduled_deposit_date IS 'Date of the deposit to the carrier shown in their wallet (US54)';

CREATE INDEX idx_payment_status  ON payment.payments (status);

CREATE TABLE payment.receipts (
    id              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    payment_id      UUID            NOT NULL,
    series          VARCHAR(4)      NOT NULL,
    number          INTEGER         NOT NULL,
    -- Value Object Money (embedded, breakdown)
    subtotal        NUMERIC(10,2)   NOT NULL,
    taxes           NUMERIC(10,2)   NOT NULL,
    total           NUMERIC(10,2)   NOT NULL,
    pdf_url         VARCHAR(500)    NOT NULL,
    issued_at       TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT uq_receipt_payment     UNIQUE (payment_id),
    CONSTRAINT uq_receipt_number      UNIQUE (series, number),
    CONSTRAINT fk_receipt_payment     FOREIGN KEY (payment_id) REFERENCES payment.payments (id) ON DELETE CASCADE,
    CONSTRAINT chk_receipt_amounts    CHECK (subtotal >= 0 AND taxes >= 0 AND total = subtotal + taxes)
);

COMMENT ON TABLE payment.receipts IS 'Internal entity Receipt of the Payment aggregate. PDF with the breakdown of fees and taxes (US53); no electronic invoicing with SUNAT (D-02)';


-- =============================================================================
--  BOUNDED CONTEXT 9 - RATING
-- =============================================================================
CREATE TABLE rating.ratings (
    id              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    trip_id         UUID            NOT NULL,
    rater_id        UUID            NOT NULL,
    ratee_id        UUID            NOT NULL,
    rater_type      VARCHAR(20)     NOT NULL,
    score           SMALLINT        NOT NULL,
    comment         VARCHAR(500),
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT uq_rating_rater      UNIQUE (trip_id, rater_id),
    CONSTRAINT fk_rating_trip       FOREIGN KEY (trip_id) REFERENCES trip.trips (id),
    CONSTRAINT chk_rating_type      CHECK (rater_type IN ('SHIPPER', 'CARRIER')),
    CONSTRAINT chk_rating_score     CHECK (score BETWEEN 1 AND 5),
    CONSTRAINT chk_rating_distinct  CHECK (rater_id <> ratee_id)
);

COMMENT ON TABLE  rating.ratings          IS 'Aggregate Root: Rating';
COMMENT ON COLUMN rating.ratings.rater_id IS 'Who rates. Without this field it is impossible to tell whether the shipper rates the carrier or the other way around';
COMMENT ON COLUMN rating.ratings.ratee_id IS 'Who is rated';
COMMENT ON CONSTRAINT uq_rating_rater ON rating.ratings IS 'Each participant rates only once per trip';

CREATE INDEX idx_rating_ratee ON rating.ratings (ratee_id);


-- =============================================================================
--  BOUNDED CONTEXT 10 - CONTACT
-- =============================================================================
CREATE TABLE contact.contact_messages (
    id              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    first_names     VARCHAR(100)    NOT NULL,
    last_names      VARCHAR(100),
    email           VARCHAR(255)    NOT NULL,
    phone_number    VARCHAR(20),
    lead_type       VARCHAR(20)     NOT NULL DEFAULT 'OTHER',
    message         VARCHAR(1000)   NOT NULL,
    attended        BOOLEAN         NOT NULL DEFAULT FALSE,
    sent_at         TIMESTAMPTZ     NOT NULL DEFAULT now(),
    attended_at     TIMESTAMPTZ,

    CONSTRAINT chk_message_type  CHECK (lead_type IN ('SHIPPER', 'CARRIER', 'OTHER')),
    CONSTRAINT chk_message_email CHECK (email LIKE '%_@_%._%')
);

COMMENT ON TABLE contact.contact_messages IS 'Aggregate Root: ContactMessage';

CREATE INDEX idx_message_pending ON contact.contact_messages (sent_at) WHERE attended = FALSE;


-- =============================================================================
--  TRANSVERSAL COMPONENT - NOTIFICATION  (not a bounded context)
-- =============================================================================
CREATE TABLE notification.notifications (
    id              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID            NOT NULL,
    type            VARCHAR(30)     NOT NULL,
    title           VARCHAR(120)    NOT NULL,
    message         VARCHAR(500)    NOT NULL,
    urgent          BOOLEAN         NOT NULL DEFAULT FALSE,
    is_read         BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT now(),
    read_at         TIMESTAMPTZ,

    CONSTRAINT fk_notification_user  FOREIGN KEY (user_id) REFERENCES iam.users (id),
    CONSTRAINT chk_notification_type CHECK (type IN (
        'LOAD_ACCEPTED', 'CARGO_PICKED_UP', 'CARGO_DELIVERED', 'DELIVERY_DISPUTED',
        'INCIDENT_REPORTED', 'TRIP_CANCELLED', 'PAYMENT_RECEIVED', 'DOCUMENT_VALIDATED')),
    CONSTRAINT chk_notification_read CHECK (is_read = FALSE OR read_at IS NOT NULL)
);

COMMENT ON TABLE notification.notifications IS 'Aggregate Root: Notification. In-app notifications (US43)';

-- Unread counter per user.
CREATE INDEX idx_notification_unread ON notification.notifications (user_id) WHERE is_read = FALSE;


-- =============================================================================
--  SEED DATA - catalogs
--  Per decision D-01, document validation is automatic and there is no
--  administrator, so the catalogs are loaded in the migration.
-- =============================================================================
INSERT INTO fleet.vehicle_types (name, description, max_weight_kg, dim_max_length_m, dim_max_width_m, dim_max_height_m) VALUES
    ('Van',               'Light vehicle for urban cargo',                        1500.00,  3.00, 1.80, 1.80),
    ('Light truck',       'Two-axle truck for regional distribution',             8000.00,  6.50, 2.40, 2.60),
    ('Medium truck',      'Three-axle truck for interprovincial cargo',          18000.00,  9.00, 2.55, 2.90),
    ('Trailer',           'Tractor with semi-trailer for heavy cargo',           32000.00, 13.50, 2.60, 3.00),
    ('Refrigerated van',  'Temperature-controlled unit for cold cargo',          12000.00,  7.50, 2.45, 2.60);

INSERT INTO documents.document_types (name, description, requires_expiration, mandatory) VALUES
    ('Driver license',               'Valid license in the corresponding category',  TRUE,  TRUE),
    ('SOAT',                         'Mandatory Traffic Accident Insurance',          TRUE,  TRUE),
    ('Vehicle registration card',    'Vehicle identification card',                   FALSE, TRUE),
    ('Technical inspection',         'Vehicle technical inspection certificate',      TRUE,  TRUE),
    ('MTC certificate',              'MTC vehicle authorization',                     TRUE,  FALSE);


-- =============================================================================
--  OPTIONAL EXTENSION - PostGIS
--  Enable only if the PostgreSQL image includes the extension. Adds derived
--  geographic columns and a GIST index that allows resolving the proximity
--  search with ST_DWithin instead of scanning the table.
--  Without PostGIS the system works the same: the prefilter uses the
--  idx_load_request_published index and the exact distance comes from Mapbox.
-- =============================================================================
-- CREATE EXTENSION IF NOT EXISTS postgis;
--
-- ALTER TABLE freight.load_requests
--     ADD COLUMN origin_geo geography(Point, 4326)
--     GENERATED ALWAYS AS (ST_SetSRID(ST_MakePoint(origin_lng::float8, origin_lat::float8), 4326)::geography) STORED;
--
-- CREATE INDEX idx_load_request_origin_geo
--     ON freight.load_requests USING GIST (origin_geo)
--     WHERE status = 'PUBLISHED';
--
-- Nearby loads query:
--   SELECT * FROM freight.load_requests
--    WHERE status = 'PUBLISHED'
--      AND ST_DWithin(origin_geo, ST_MakePoint(:lng, :lat)::geography, :radius_meters);
