//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./zombieattack.sol";
import "./erc721.sol";

abstract contract ZombieOwnership is ZombieBattle, ERC721 {
    function balanceOf(address _owner)
        public
        view
        override
        returns (uint256 _balance)
    {
        return ownerZombieCount[_owner];
    }

    function ownerOf(uint256 _tokenId)
        public
        view
        override
        returns (address _owner)
    {
        return zombieToOwner[_tokenId];
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _tokenId
    ) private {
        ownerZombieCount[_to]++;
        ownerZombieCount[_from]--;
        zombieToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transfer(address _to, uint256 _tokenId)
        public
        override
        onlyOwnerOf(_tokenId)
    {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public override {}

    function takeOwnership(uint256 _tokenId) public override {}
}
