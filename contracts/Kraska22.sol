// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OwnableDelegateProxy {}

contract ProxyRegistry {
    mapping(address => OwnableDelegateProxy) public proxies;
}

/// @custom:security-contact support@kraska.uk
contract Kraska22 is ERC721, ERC721Enumerable, ERC721Burnable, Ownable {
    using Strings for uint256;

    string private _contractURI;
    string private _baseTokenURI;
    address private _proxyRegistryAddress;

    constructor(
        string memory name_,
        string memory symbol_,
        string memory contractURI_,
        string memory baseTokenURI_,
        address proxyRegistryAddress_
    ) ERC721(name_, symbol_) {
        _contractURI = contractURI_;
        _baseTokenURI = baseTokenURI_;
        _proxyRegistryAddress = proxyRegistryAddress_;
    }

    function contractURI() public view returns (string memory) {
        return _contractURI;
    }

    function setContractURI(string memory contractURI_) public onlyOwner {
        _contractURI = contractURI_;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function baseTokenURI() public view returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseTokenURI(string memory baseTokenURI_) public onlyOwner {
        _baseTokenURI = baseTokenURI_;
    }

    function setProxyRegistryAddress(address proxyRegistryAddress_)
        public
        onlyOwner
    {
        _proxyRegistryAddress = proxyRegistryAddress_;
    }

    function proxyRegistryAddress() public view returns (address) {
        return _proxyRegistryAddress;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
                : "";
    }

    function safeMint(address to, uint256[] memory tokenIds)
        external
        onlyOwner
    {
        require(tokenIds.length > 0, "tokenIds not specified");
        for (uint256 i = 0; i < tokenIds.length; i++) {
            _safeMint(to, tokenIds[i]);
        }
    }

    function isApprovedForAll(address owner, address operator)
        public
        view
        override
        returns (bool)
    {
        ProxyRegistry proxyRegistry = ProxyRegistry(_proxyRegistryAddress);
        if (address(proxyRegistry.proxies(owner)) == operator) {
            return true;
        }

        return super.isApprovedForAll(owner, operator);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
