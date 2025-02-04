// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

// modules
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {OwnableUnset} from "./custom/OwnableUnset.sol";
import {ERC725YCore} from "./ERC725YCore.sol";

/**
 * @title Deployable implementation with `constructor` of ERC725Y, a generic data key/value store.
 * @author Fabian Vogelsteller <fabian@lukso.network>
 * @dev ERC725Y provides the ability to set arbitrary data key/value pairs that can be changed over time.
 * It is intended to standardise certain data key/value pairs to allow automated read and writes from/to the contract storage.
 */
contract ERC725Y is ERC725YCore {
    /**
     * @notice Deploying an ERC725Y smart contract and setting address `initialOwner` as the contract owner.
     * @dev Deploy a new ERC725Y contract with the provided `initialOwner` as the contract {owner}.
     * @param initialOwner the owner of the contract.
     *
     * @custom:requirements
     * - `initialOwner` CANNOT be the zero address.
     */
    constructor(address initialOwner) payable {
        require(
            initialOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        OwnableUnset._setOwner(initialOwner);
    }
}
