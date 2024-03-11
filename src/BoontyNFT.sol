// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//import "@openzeppelin/contracts/access/Ownable.sol"; 
//import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol"; 
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

import "../node_modules/@openzeppelin/contracts/access/Ownable.sol"; 
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; 
import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol"; 



/// @title A simulator for Boonty NFT rewards
/// @author Stellan WEA
/// @notice You can use this contract for minting NFT or obtaining other rewards depending on the user loyalty score.

contract BoontyNFT is ERC721URIStorage, Ownable {
    
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    address[] exclusivePartyMembers;
    mapping(address => uint256) private loyaltyScore;

    constructor() Ownable(msg.sender) ERC721("NFT Reward Boonty", "NRB") {}
    
    /// @dev mints a token
    /// @notice creates an NFT on the testnest
    /// @param _to determines the NFT's owner address 
    /// @param _tokenId the token identifier 
    /// @param _uri the token reference towards a ressource
    function mint ( address _to,
                    uint256 _tokenId, 
                    string calldata _uri 
                  ) external onlyOwner {
        _mint(_to, _tokenId);
        _setTokenURI(_tokenId, _uri);
        
    }
    
    /// @dev general function for the user to request a reward among several options, the token id is a random number between 0 and 1000
    /// @notice enables to select which type of reward the user wants to access
    /// @param _to determines the NFT's owner address 
    /// @param rewardType the name of the reward wished
    function requestReward(address _to, string memory rewardType) public {
        // Increase the loyalty score of the requester 
        loyaltyScore[_to] += 1;
        // Grant acces to multiple types of rewards in accordance to the user loyalty score
        if (keccak256(abi.encodePacked((rewardType))) == keccak256(abi.encodePacked(("NFT")))) {
            uint256 tokenNumber = 0;
            tokenNumber = uint (keccak256(abi.encodePacked (msg.sender, block.timestamp, tokenNumber)))%1000;
            _mint(msg.sender, tokenNumber);
        } else if (keccak256(abi.encodePacked((rewardType))) == keccak256(abi.encodePacked(("Party")))){
            obtainPartyAcces(_to);
        } else {
            obtainGoodies(_to);
        }

    }
    
    /// @dev adds the user to the member of the party
    /// @notice grants access to ta party by releasing the date and a special invitation
    /// @param _to determines the NFT's owner address 
    /// @return a message indicating the party information to the user 
    function obtainPartyAcces(address _to) public returns (string memory)  {
        
        if (loyaltyScore[_to] > 10) {
            exclusivePartyMembers.push(msg.sender);
            return "A exclusive party will take place the 23rd of March but keep it secret. We will keep you in touch...";
        } else {
            return "You don't have yet access to this reward";
        }
    }

    /// @dev declares to the user how obtaining goodies
    /// @notice Gives more information on the goodies
    /// @param _to determines the NFT's owner address  
    /// @return a message indicating how to obtain goodies
    function obtainGoodies(address _to) public view returns (string memory) {
        if (loyaltyScore[_to] > 5) {
            return "New goodies are available especially for you, log in to our website to find more";
        } else {
            return "You don't have yet access to this reward";
        }
    }
}