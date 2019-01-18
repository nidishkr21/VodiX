pragma solidity ^0.5.0;

import './CrowdsaleControl.sol';


/**
 Simple Token based on OpenZeppelin token contract
 */
contract Controller is CrowdsaleControl {

    /**
    * @dev Constructor that gives msg.sender all of existing tokens.
    */
    constructor (address _satellite, address _dataCentreAddr) public
        CrowdsaleControl(_satellite, _dataCentreAddr)
    {

    }

    // Owner Functions
    function setContracts(address _satellite, address _dataCentreAddr) public onlyAdmins whenPaused(msg.sender) {
        dataCentreAddr = _dataCentreAddr;
        satellite = _satellite;
    }

    function kill(address payable _newController) public onlyAdmins whenPaused(msg.sender) {
        if (dataCentreAddr != address(0)) { 
            Ownable(dataCentreAddr).transferOwnership(msg.sender); 
        }

        if (satellite != address(0)) { 
            Ownable(satellite).transferOwnership(msg.sender); 
        }

        selfdestruct(_newController);
    }

}