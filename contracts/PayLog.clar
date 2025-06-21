;; Get block height
(define-read-only (get-block-height)
  (ok stacks-block-height))

(define-trait sip009-nft-trait
  (
    ;; Required SIP-009 NFT methods
    (get-last-token-id () (response uint uint))
    (get-owner (uint) (response (optional principal) uint))
    (transfer (uint principal principal) (response bool uint))
    (get-token-uri (uint) (response (optional (string-utf8 256)) uint))
  )
)

;; Trait implementation constants
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_NOT_FOUND (err u101))
(define-constant ERR_NON_TRANSFERABLE (err u102))

(define-data-var last-id uint u0)

;; Maps token-id -> owner
(define-map token-owners
  uint
  principal
)

;; Maps token-id -> receipt metadata
(define-map receipt-data
  uint
  {
    from: principal,
    to: principal,
    amount: uint,
    description: (string-ascii 80),
    timestamp: uint
  }
)

;; Maps token-id -> token URI (optional)
(define-map token-uris
  uint
  (string-utf8 256)
)

;; --------- Public Functions ---------
(define-public (mint-receipt (to principal) (amount uint) (description (string-ascii 80)) (uri (string-utf8 256)))
  (let (
    (id (+ (var-get last-id) u1))
    (timestamp (unwrap-panic (get-block-height)))
  )
    (begin
      (map-set token-owners id to)
      (map-set receipt-data id {
        from: tx-sender,
        to: to,
        amount: amount,
        description: description,
        timestamp: timestamp
      })
      (map-set token-uris id uri)
      (var-set last-id id)
      (ok id)
    )
  )
)

;; --------- SIP-009 Trait Functions ---------

(define-read-only (get-last-token-id)
  (ok (var-get last-id))
)

(define-read-only (get-owner (id uint))
  (match (map-get? token-owners id)
    owner (ok (some owner))
    ERR_NOT_FOUND
  )
)

(define-read-only (get-token-uri (id uint))
  (match (map-get? token-uris id)
    uri (ok (some uri))
    ERR_NOT_FOUND
  )
)

(define-public (transfer (id uint) (sender principal) (recipient principal))
  ;; Block transfers - soulbound NFT
  (err ERR_NON_TRANSFERABLE)
)

;; --------- Custom Read-Only View ---------

(define-read-only (get-receipt (id uint))
  (match (map-get? receipt-data id)
    data (ok data)
    ERR_NOT_FOUND
  )
)
