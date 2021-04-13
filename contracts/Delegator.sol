pragma solidity ^0.8.0;


import "./Core/interface/IJobManager.sol";


contract Delegator {
    address public delegate;
    address public owner = msg.sender;
    IJobManager public jobManager;


    // function Delegator(IController _controller, bytes32 _controllerLookupName) public {
    //     controller = _controller;
    //     controllerLookupName = _controllerLookupName;
    // }

    function getJob(
        uint256 id
    ) 
        external
        view
        returns(
            string memory url,
            string memory selector,
            string memory name,
            bool repeat,
            uint256 result
        )
    {
        return jobManager.getJob(id);
    }

    function upgradeDelegate(address newDelegateAddress) public {
        require(msg.sender == owner, "caller is not the owner");
        delegate = newDelegateAddress;
        jobManager = IJobManager(newDelegateAddress);
    }

    function getResult(uint256 id) public view returns(uint256) {
        return jobManager.getResult(id);
    }


    //
    // function() external payable {
    //     // Do nothing if we haven't properly set up the delegator to delegate calls
    //     if (delegate == 0x0000000000000000000000000000000000000000) {
    //         return;
    //     }
    //
    //     // Get the delegation target contract
    //     address _target = delegate;
    //
    //     assembly {
    //         //0x40 is the address where the next free memory slot is stored in Solidity
    //         let _calldataMemoryOffset := mload(0x40)
    //         // new "memory end" including padding. The bitwise operations here ensure we get rounded up to the nearest 32 byte boundary
    //         let _size := and(add(calldatasize, 0x1f), not(0x1f))
    //         // Update the pointer at 0x40 to point at new free memory location so any theoretical allocation doesn't stomp our memory in this call
    //         mstore(0x40, add(_calldataMemoryOffset, _size))
    //         // Copy method signature and parameters of this call into memory
    //         calldatacopy(_calldataMemoryOffset, 0x0, calldatasize)
    //         // Call the actual method via delegation
    //         let _retval := delegatecall(gas, _target, _calldataMemoryOffset, calldatasize, 0, 0)
    //         switch _retval
    //         case 0 {
    //             // 0 == it threw, so we revert
    //             revert(0,0)
    //         } default {
    //             // If the call succeeded return the return data from the delegate call
    //             let _returndataMemoryOffset := mload(0x40)
    //             // Update the pointer at 0x40 again to point at new free memory location so any theoretical allocation doesn't stomp our memory in this call
    //             mstore(0x40, add(_returndataMemoryOffset, returndatasize))
    //             returndatacopy(_returndataMemoryOffset, 0x0, returndatasize)
    //             return(_returndataMemoryOffset, returndatasize)
    //         }
    //     }
    // }
}
