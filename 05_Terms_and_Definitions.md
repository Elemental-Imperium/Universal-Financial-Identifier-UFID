# Terms and Definitions

To ensure consistency, the following terms are defined as they relate specifically to the UFID standard.

- **UFID (Universal Financial Identifier)**: A secure, non-human-readable identifier that uniquely represents an account across banking, payment, and digital asset platforms.

- **Capability Code**: An encoded segment within UFID that indicates the transaction types (e.g., ACH, SWIFT, SEPA, blockchain) and directions (send, receive, both, or none) allowed for an account.

- **Bitfield Encoding**: A method of encoding binary flags into a bitfield, where each bit corresponds to a specific transaction type associated with an account. This bitfield is hashed to create a secure representation of the account’s capabilities.

- **Checksum**: A calculated segment in the UFID that validates data integrity, preventing errors or tampering. The checksum is derived from the UFID string using ASCII summation and modulo operations.

- **Institution Code**: A unique identifier for financial institutions, derived from BIC/SWIFT or a dedicated UFID registry, ensuring consistency in identifying institutions.

- **Account Identifier**: A hashed and encoded segment that represents the specific account or blockchain address within the UFID, ensuring privacy and uniqueness.

- **Version Control**: A prefix within UFID that designates the version of the standard being used, allowing for backward compatibility and flexibility for future updates.
