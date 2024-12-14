// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {AggregatorV3Interface} from "contracts/interfaces/AggregatorV3interface.sol";

contract FundMe{
   
    uint256 public balance;
    uint256 public minimumUsd = 5;

    function fun() public payable{
  
            require(msg.value >= minimumUsd, "didn't send enought ETH");
        
    }

    function getPrice() public{
        //Adress 0x694AA1769357215DE4FAC081bf1f309aDC325306
    }

    function getConvertionPrice()public{}

    function getVersion() public view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();

    } 


    //function withdraw() public{}


}