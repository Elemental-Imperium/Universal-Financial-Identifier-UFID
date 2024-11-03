# UFID Structure and Components

The UFID is structured to balance compactness, security, and functionality, ensuring compatibility across traditional financial systems and blockchain-based platforms.

## Example UFID Format

```text
V1-US-12-XZ8p4f-H9d3-3Y

Component Breakdown

1. **Version Control (V1)**
   - **Length**: 2 characters.
   - **Purpose**: Indicates the UFID version, supporting backward compatibility.
   - **Example**: "V1" for the initial version.

2. **Country Code (US)**
   - **Length**: 2 characters.
   - **Specification**: Uses ISO 3166-1 alpha-2 codes.
   - **Purpose**: Specifies the jurisdiction, making UFID globally recognizable.
   - **Example**: "US" for the United States, "GB" for the United Kingdom.

3. **Institution Code (12)**
   - **Length**: 2 characters.
   - **Specification**: Derived from BIC/SWIFT codes or a UFID-specific registry.
   - **Purpose**: Identifies the financial institution responsible for the account.
   - **Example**: "12" could represent a specific bank, while "34" might represent a digital wallet provider.

4. **Hashed Capability Code (XZ8p4f)**
   - **Length**: 6 characters.
   - **Encoding Method**: Bitfield encoding, followed by SHA-256 hashing and Base58 encoding.
   - **Purpose**: Encodes the account’s transaction capabilities in a secure, non-human-readable format.
   - **Example**: "XZ8p4f" could represent ACH Send, SWIFT Receive, and Blockchain Send capabilities.

5. **Account Identifier (H9d3)**
   - **Length**: 4 characters.
   - **Encoding Method**: SHA-256 hashed account number or blockchain address, salted and Base58 encoded.
   - **Purpose**: Provides a unique, secure representation of the account, ensuring privacy.
   - **Example**: "H9d3" might represent the hashed and encoded account number for privacy.

6. **Checksum (3Y)**
   - **Length**: 2 characters.
   - **Calculation Method**: Summing ASCII values of the UFID string (excluding the checksum) and applying modulo operations (e.g., MOD 97).
   - **Purpose**: Validates UFID structure to prevent tampering or errors.
   - **Example**: "3Y" would be appended as the checksum for a given UFID.
```
