// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract productCatalog{
    struct product{
        uint id;
        string name;
        uint price;
    }

    mapping(uint => product) private products;

    function addProduct(uint id, string memory name, uint price) public {
        products[id] = product(id,name,price);
    }

    function updateProductPrice(uint id, uint price) public {
        products[id].price = price;
    }

    function getProduct(uint id) public view returns(uint,string memory,uint) {
        return (products[id].id,products[id].name,products[id].price);
    }
}