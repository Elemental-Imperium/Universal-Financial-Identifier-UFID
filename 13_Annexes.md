# Annexes

This section includes additional resources and examples for implementing and understanding UFID. The annexes provide specific UFID examples, a detailed bitfield specification for capability codes, and code samples for generating, encoding, and validating UFIDs in Python.

---

## Annex A: Additional UFID Examples

Below are examples of UFIDs for various types of financial accounts, illustrating how the UFID structure adapts to different institutions, transaction capabilities, and account identifiers.

### Example 1: Bank Account with SWIFT and RTGS Capabilities

`V1-CA-20-K8p4r2-B6y9-5X`

- **Country Code**: CA (Canada)
- **Institution Code**: 20 (Bank)
- **Capabilities**: SWIFT Send/Receive, RTGS Send/Receive
- **Account Identifier**: Hashed and encoded bank account number
- **Checksum**: 5X

---

### Example 2: Digital Wallet with Multi-Asset Capability

`V1-DE-45-M9z7p3-C8k2-7Q`

- **Country Code**: DE (Germany)
- **Institution Code**: 45 (Digital Wallet Provider)
- **Capabilities**: Blockchain Send/Receive, SEPA Send/Receive
- **Account Identifier**: Hashed blockchain address
- **Checksum**: 7Q

---

### Example 3: Crypto Exchange Account (EVM-Compatible Blockchain)

`V1-US-56-Q9m4p6-D3f2-2Z`

- **Country Code**: US (United States)
- **Institution Code**: 56 (Crypto Exchange)
- **Capabilities**: EVM-Compatible Blockchain Send/Receive, Stablecoin Transfers
- **Account Identifier**: Hashed crypto wallet address
- **Checksum**: 2Z

---

## Annex B: Bitfield Specification for Capability Codes

The Capability Code in UFID uses a bitfield encoding structure to represent transaction types and directions. Each bit within the bitfield corresponds to a specific transaction capability. Below is a sample bitfield mapping.

| Bit Position | Capability                  | Direction | Description                                  |
|--------------|-----------------------------|-----------|----------------------------------------------|
| Bit 0        | ACH                         | Send      | Authorized to send ACH transfers             |
| Bit 1        | ACH                         | Receive   | Authorized to receive ACH transfers          |
| Bit 2        | SWIFT                       | Send      | Authorized for outgoing SWIFT messages       |
| Bit 3        | SWIFT                       | Receive   | Authorized for incoming SWIFT messages       |
| Bit 4        | Blockchain (EVM-Compatible) | Send      | Authorized to send transactions on EVM chains|
| Bit 5        | Blockchain (EVM-Compatible) | Receive   | Authorized to receive transactions on EVM    |
| Bit 6        | RTGS                        | Send      | Authorized for RTGS (Real-Time Gross Settlement)|
| Bit 7        | RTGS                        | Receive   | Authorized to receive RTGS payments          |
| Bit 8        | SEPA                        | Send      | Authorized to send SEPA transactions         |
| Bit 9        | SEPA                        | Receive   | Authorized to receive SEPA transactions      |
| Bit 10       | Fedwire                     | Both      | Authorized for both send and receive on Fedwire|
| Bit 11       | Stablecoin Transfer         | Send      | Authorized to send stablecoins               |
| Bit 12       | Stablecoin Transfer         | Receive   | Authorized to receive stablecoins            |
| ...          | ...                         | ...       | ...                                          |

### Bitfield Encoding Example

- **Capabilities**: ACH Send, SWIFT Receive, Blockchain Send
- **Bitfield Representation**: `101010000000`
- **Hashed and Encoded Capability Code**: `XZ8p4f`

---

## Annex C: Code Samples

This annex provides Python code samples to help developers implement UFID generation, encoding, and validation. The examples include encoding methods for the Capability Code, Account Identifier, and Checksum, along with validation functions.

### Python Code for UFID Generation

```python
#### Python Code for UFID Generation

```python
import hashlib
import base58

class UFIDGenerator:
    def __init__(self, version, country_code, institution_code, account_number, capabilities):
        self.version = version
        self.country_code = country_code
        self.institution_code = institution_code
        self.account_number = account_number
        self.capabilities = capabilities

    def generate_bitfield(self):
        bitfield = 0
        for capability, position in self.capabilities.items():
            bitfield |= (1 << position)
        return bitfield

    def encode_capability_code(self):
        bitfield = self.generate_bitfield()
        bitfield_str = f"{bitfield:012b}"  # Format as binary string
        hashed = hashlib.sha256(bitfield_str.encode()).hexdigest()
        return base58.b58encode(hashed[:8].encode()).decode()

    def encode_account_identifier(self):
        hashed = hashlib.sha256((self.account_number + self.institution_code).encode()).hexdigest()
        return base58.b58encode(hashed[:8].encode()).decode()

    def generate_checksum(self, ufid_without_checksum):
        ascii_sum = sum(ord(c) for c in ufid_without_checksum)
        return base58.b58encode(str(ascii_sum % 97).encode()).decode()[:2]

    def generate_ufid(self):
        capability_code = self.encode_capability_code()
        account_id = self.encode_account_identifier()
        ufid_without_checksum = f"{self.version}-{self.country_code}-{self.institution_code}-{capability_code}-{account_id}"
        checksum = self.generate_checksum(ufid_without_checksum)
        return f"{ufid_without_checksum}-{checksum}"

# Example usage:
version = "V1"
country_code = "US"
institution_code = "12"
account_number = "1234567890123456789"
capabilities = {"ACH Send": 0, "SWIFT Receive": 3, "Blockchain Send": 4}

ufid_gen = UFIDGenerator(version, country_code, institution_code, account_number, capabilities)
print("Generated UFID:", ufid_gen.generate_ufid())
```

## Python Code for UFID Validation

```python
def validate_checksum(ufid):
    *components, provided_checksum = ufid.rsplit("-", 1)
    ufid_without_checksum = "-".join(components)
    ascii_sum = sum(ord(c) for c in ufid_without_checksum)
    calculated_checksum = base58.b58encode(str(ascii_sum % 97).encode()).decode()[:2]
    return calculated_checksum == provided_checksum

# Validation Example:
ufid = "V1-US-12-XZ8p4f-H9d3-3Y"
is_valid = validate_checksum(ufid)
print("UFID is valid:", is_valid)
```
