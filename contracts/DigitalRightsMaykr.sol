// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "erc721a/contracts/ERC721A.sol";

contract DigitalRightsMaykr is ERC721A {
    /** @dev Functions To Implement:
     * mint NFT - our NFT will represent certificate
     * (minting unrestricted)
     * (NFT minter will be immediately it's owner)
     
     * transfer of certificates (maybe include marketplace in second contract)

     * created NFT's database to trace copyrights existance (getters like totalSupply, description of token Id etc.)
    */

    // NFT Structs
    struct Certificate {
        string s_tokenIdToURI;
        uint256 s_tokenIdToExpirationTime;
    }

    // NFT Mappings
    mapping(uint256 => Certificate) private certs;

    // NFT Events
    event NFT_Minted(address indexed owner, string uri, uint256 indexed id);

    constructor() ERC721A("Digital Rights Maykr", "DRM") {}

    /** @dev Add expiration time of certificate */
    function mintNFT(string memory createdTokenURI) external {
        // Assigning 0 to first tokenId created
        uint256 newTokenId = totalSupply();
        Certificate storage cert = certs[newTokenId];

        // Minting NFT (Certificate)
        _mint(msg.sender, 1);

        // Assigning new tokenId to given tokenURI and to owner
        cert.s_tokenIdToURI = createdTokenURI;

        // Emiting all data associated with created NFT
        emit NFT_Minted(msg.sender, cert.s_tokenIdToURI, newTokenId);
    }

    // Assigning correct tokenURI per tokenId to function from ERC721A
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        Certificate storage cert = certs[tokenId];
        return cert.s_tokenIdToURI;
    }

    // Renew your certificate
    function renewCertificate(uint256 tokenId) external {}

    // Communicate with certificates owners
    function sendMessage(address to, string memory yourMessage) external {}
}
