// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
contract FundMe{
   
    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address funders => uint256 amountFunders) public addressToAmountFunded;

    function fun() public payable{
            //Allow users to send $
            // Have minimum $ sent 5$
            require(getConversionRate(msg.value) >= minimumUsd, "didn't send enought ETH");
            funders.push(msg.sender);
            addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        
    }

    function getPrice() public view returns (uint256){
        //Adress 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint256 ethAmount)public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() public view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();

    } 


    //function withdraw() public{}


}