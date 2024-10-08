
    
    /* {
  "name": "Property #123",
  "description": "A lovely 2-bedroom apartment in New York.",
  "image": "https://example.com/images/property123.png",
  "attributes": {
    "location": "New York, NY",
    "size": "1000 sq ft",
    "valuation": "$500,000"
  }
}
*/ 

//nfts start from id=1

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PropertyNFT is ERC721, Ownable {
    uint256 public nextTokenId;
    mapping(uint256 => string) private _tokenURIs;
    IERC20 public usdc;

// Mapping of token ID to user address to their ownership share
mapping(uint256 => mapping(address => uint256)) public ownershipShares;
// Mapping of token ID to the total ownership sold
mapping(uint256 => uint256) public totalOwnershipSold;

event OwnershipPurchased(uint256 indexed tokenId, address indexed buyer, uint256 amount);
event OwnershipTransferred(uint256 indexed tokenId, address indexed from, address indexed to, uint256 amount);

    constructor() ERC721("PropertyToken", "PROP") {
        nextTokenId = 1;

    }   

    // Function to mint a new property NFT
    function mint(address to, string memory _tokenURI) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        nextTokenId++;
        return tokenId;
    }

    // Function to set the token URI
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

   
}

   