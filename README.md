
# Unruggable Protocol

The Unruggable Protocol uses a combination of unruggable contracts and decentralized governance to secure onchain data. The protocol's onchain policies govern the relationship of counterparties throughout the web3 ecosystem and are contained in books, which are governed by guardians to ensure policy integrity over time.

## Protocol Components

The Unruggable Protocol is composed of three key components: Books, Policies, and Guardians.

> ### Books
>
> A book is an onchain smart contract that contains a set of policies governing a specific aspect of the web3 ecosystem, such as domain name rentals, sports data, or macroeconomics data. Books are designed to be both useful as onchain smart contracts as well as legal and practical documents. Anyone can create a book, and the policies contained within the book are enforced by the guardians.

> ### Policies
>
> Policies are a set of rules that dictate how counter parties should interact with each other within the web3 ecosystem. These policies are contained within a book and are enforced by the guardians. Policies can be a combination of onchain and offchain instructions sets, where on a day-to-day basis, the onchain aspects secure the policies, while over the long term, the guardians following the offchain policies maintain the policies.

> ### Guardians
> 
> Guardians are responsible for ensuring the integrity of the policies contained within a book over long periods of time. They are responsible for maintaining the policies in a way that is consistent with the book's rules and are required to have the necessary credentials to do so. Guardians can be individuals, organizations, or DAOs, and they are selected by the creator of the book. The guardians have the authority to modify the policies contained within a book if they see fit, but their actions should be in line with the overall purpose of the book.


### Domain Name Rental Book Example 

A domain name rental price book is a good example of a book in the protocol. This book contains a policy that sets rental prices based on conditions such as the length and type of domain name (.com, .xyz, or .eth) in a fiat currency. The policy also includes a directive to maintain the value over time. Guardians are responsible for maintaining rental prices and ensuring policy compliance, and the book contains policies, signatures, and credentials of the guardians. Books are both onchain smart contracts and practical documents.

### Sports Data Book Example 

A sports data book could also be created, containing policies for player and game stats. A council of guardians would post the data according to the book's policies, allowing trusted sports data to be used in onchain applications.

## Open and Permissionless Protocol 

The Unruggable Protocol is an open and permissionless protocol that allows anyone to create a book. For example, a macroeconomics book could contain policies about GDP and inflation, stating where data would be sourced and how new sources could be used if previous sources become unavailable. Guardians would be responsible for maintaining the data, enabling offchain macroeconomic data to be put onchain in a trustworthy manner.

## Composable Protocol

The Unruggable Protocol is fully composable, with guardians that can be larger entities such as DAOs or multisig wallets. This allows for the highest possible decentralization in governing books. Policies can be a combination of onchain and offchain instructions, with onchain aspects securing policies day-to-day while guardians following offchain policies maintain policies over the long term.

## Oracle Risk

One persistent problem in the web3 economy is the issue of outdated, faulty, or malicious oracle data. It is not possible to completely rely on oracle data long-term. The Unruggable Protocol incorporates oracle data into a policy that can be used day-to-day in the same way as an oracle. However, if the oracle dies or is manipulated, a new oracle can be found or maliciously manipulated data can be blocked.

## Contracts

The Unruggable Protocol does not define a standard for policies. Smart contracts inherit the Unruggable.sol contract, which transforms any smart contract into a Book with pages and makes the smart contract ownable, following the OpenZeppelin standard.

The Unruggable Protocol specifies a set of pages with names written in capital letters and spaces, ensuring maximum readability.

The "Book" key is employed to store a single URI that points to a file hosting the book's content. Moreover, the "Cover," "Policies," "Guardians," and "Body" pages can also store a URI linking to decentralized storage. All other pages are used to store on-chain data, such as the introduction, sections, and guardians. This approach enables a combination of on-chain and off-chain storage to generate the book's content.


- "Book"
- "Cover"
- "Title Page"
- "Introduction"
- "Guardians"
- "Guardian 1"
- "Guardian 2"
- . . . 
- "Policies"
- "Policy 1"
- "Policy 2"
- . . .  
- "Body"
- "Section 1"
- "Section 2"
- . . .  
- "Back Cover"

## Immutable Records

In the context of books, it is possible to have editable or immutable pages on a per-page basis. Immutable pages are utilized to permanently record data on the blockchain. For instance, it is feasible to make all pages of a book immutable, except for the list of guardians, which may require occasional updates over time.

## ENS Integration

A Book can also serve as an ENS name resolver, which means that you can use it to resolve ENS records for domain names like domain-rental-book.ddao.eth. The pages of the Book are mapped to ENS text records, and the "Book" page is mapped to the ENS content record. Additionally, the ENS avatar record is mapped to the "Cover" page.

### Sample Contract

```
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<=0.9.0;

import {Unruggable} from "unruggable-protocol/Unruggable.sol";

contract BasicPricePolicy is Unruggable {

    uint256 public unitPrice;

    constructor(uint256 _unitPrice) {
        unitPrice = _unitPrice;
    }
    
    // Set the price
    function setPrice(uint256 _unitPrice) public onlyOwner {
        unitPrice = _unitPrice;
    }

    // Get the price with a quantity
    function getPrice(uint256 quantity) public view returns (uint256) {
        return unitPrice * quantity;
    }

}

```

## Security and Audits
Please note that the Unruggable Protocol is currently in development, and our team is working diligently to ensure its security. We recommend that you avoid using the smart contracts in a production environment until a security audit has been completed.

## Contributions
Unruggable Protocol is an open source project, and we welcome contributions, including raising issues on GitHub. For direct communication, please DM @nxt3d on Twitter. To contribute code, please fork the repository, create a feature branch (features/$BRANCH_NAME) or a bug fix branch (fix/$BRANCH_NAME), and submit a pull request against the branch. We appreciate your interest in contributing to the development of Unruggable Protocol!
