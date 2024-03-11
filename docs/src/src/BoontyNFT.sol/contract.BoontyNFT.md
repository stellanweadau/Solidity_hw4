# BoontyNFT
**Inherits:**
ERC721URIStorage, Ownable

**Author:**
Stellan WEA

You can use this contract for minting NFT or obtaining other rewards


## State Variables
### MINTER_ROLE

```solidity
bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
```


### exclusivePartyMembers

```solidity
address[] exclusivePartyMembers;
```


## Functions
### constructor


```solidity
constructor() Ownable(msg.sender) ERC721("NFT Reward Boonty", "NRB");
```

### mint

creates an NFT on the testnest

*mints a token*


```solidity
function mint(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_to`|`address`|enables to determind the receiver, the token identifier and the token reference towards a ressource|
|`_tokenId`|`uint256`||
|`_uri`|`string`||


### requestReward

enables to select which type of reward the user wants to access

*general function for the user to request a reward among several options, the token id is a random number between 0 and 1000*


```solidity
function requestReward(string memory rewardType) public;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`rewardType`|`string`|the name of the reward wished|


### obtainOffer

grants access to ta party by releasing the date and a special invitation

*adds the user to the member of the party*


```solidity
function obtainOffer() public returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|a message indicating the party information to the user|


### obtainGoodies

Gives more information on the goodies

*declares to the user how obtaining goodies*


```solidity
function obtainGoodies() public pure returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|a message indicating how to obtain goodies|


