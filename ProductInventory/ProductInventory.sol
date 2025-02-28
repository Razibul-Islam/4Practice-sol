// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProductIndevtory {
    struct ProductDetails {
        string name;
        uint256 quantity;
        uint256 price;
        bool exit;
    }

    mapping(uint256 => ProductDetails) private details;

    uint256[] productsID;

    modifier duplicateId(uint256 id) {
        require(!details[id].exit, "This product is already added");
        _;
    }

    event addedProduct(
        uint256 id,
        string name,
        uint256 quantity,
        uint256 price
    );

    function addProduct(
        uint256 id,
        string memory name,
        uint256 quantity,
        uint256 price
    ) public duplicateId(id) {
        details[id] = ProductDetails(name, quantity, price, true);
        productsID.push(id);
        emit addedProduct(id, name, quantity, price);
    }

    function updateStok(uint256 id, uint256 newQuantity) public {
        details[id].quantity += newQuantity;
    }

    function getProduct(uint256 id)
        public
        view
        returns (
            string memory name,
            uint256 quantity,
            uint256 price
        )
    {
        require(details[id].exit, "This product is not available");
        ProductDetails storage pr = details[id];
        return (pr.name, pr.quantity, pr.price);
    }
}
