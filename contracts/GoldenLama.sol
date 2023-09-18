// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract GoldenLama {

    struct ItemInfo {
        uint256 purchaseType;
        uint256 price;
        uint256 dailyProfit;
    }
    
    struct LevelOneItems {
        uint256 countOfSand;
        uint256 countOfSky;
        uint256 countOfSea;
        uint256 countOfCloud;
        uint256 countOfSun;
        uint256 countOfGull;
        bool allItemsBought;
    }

    struct LevelTwoItems {
        uint256 countOfPalm;
        uint256 countOfCoconuts;
        uint256 countOfGoldFish;
        uint256 countOfCrab;
        uint256 countOfShells;
        uint256 countOfColoredStones;
        bool allItemsBought;
    }
    
    struct LevelThreeItems {
        uint256 countOfSandCastel;
        uint256 countOfChaiseLounge;
        uint256 countOfTowel;
        uint256 countOfSuncreen;
        uint256 countOfBasket;
        uint256 countOfUmbrella;
        bool allItemsBought;
    }
    
    struct LevelFourItems {
        uint256 countOfBoa;
        uint256 countOfSunglasses;
        uint256 countOfBaseballCap;
        uint256 countOfSwimsuitTop;
        uint256 countOfSwimsuitBriefs;
        uint256 countOfCrocs;
        bool allItemsBought;
    }
    
    struct LevelFiveItems {
        uint256 countOfFlamingoRing;
        uint256 countOfCoctail;
        uint256 countOfGoldenColor;
        uint256 countOfSmartWatch;
        uint256 countOfSmartphone;
        uint256 countOfYacht;
    }

    struct UserInfo {
        uint256 userId;
        uint256 refId;
        uint256 dateOfEntry;
        uint256 profitDept;
        uint256 balanceOfCocktail;
        uint256 balanceOfCoin;
    }

    uint8 private constant SAND_PURCHASE_TYPE = 0;
    uint8 private constant SKY_PURCHASE_TYPE = 1;
    uint8 private constant SEA_PURCHASE_TYPE = 2;
    uint8 private constant CLOUD_PURCHASE_TYPE = 3;
    uint8 private constant SUN_PURCHASE_TYPE = 4;
    uint8 private constant GULL_PURCHASE_TYPE = 5;
    uint8 private constant PALM_PURCHASE_TYPE = 6;
    uint8 private constant COCONUTS_PURCHASE_TYPE = 7;
    uint8 private constant GOLD_FISH_PURCHASE_TYPE = 8;
    uint8 private constant CRAB_PURCHASE_TYPE = 9;
    uint8 private constant SHELLS_PURCHASE_TYPE = 10;
    uint8 private constant COLORED_STONES_PURCHASE_TYPE = 11;
    uint8 private constant SAND_CASTEL_PURCHASE_TYPE = 12;
    uint8 private constant CHAISE_LOUNGE_PURCHASE_TYPE = 13;
    uint8 private constant SUNSCREEN_PURCHASE_TYPE = 14;
    uint8 private constant BASKET_PURCHASE_TYPE = 15;
    uint8 private constant TOWEL_PURCHASE_TYPE = 16;
    uint8 private constant UMBRELLA_PURCHASE_TYPE = 17;
    uint8 private constant BOA_PURCHASE_TYPE = 18;
    uint8 private constant SUNGLASSES_PURCHASE_TYPE = 19;
    uint8 private constant BASEBALL_CAP_PURCHASE_TYPE = 20;
    uint8 private constant SWIMSUIT_TOP_PURCHASE_TYPE = 21;
    uint8 private constant SWIMSUIT_BRIEFS_PURCHASE_TYPE = 22;
    uint8 private constant CROCS_PURCHASE_TYPE = 23;
    uint8 private constant FLAMINGO_RING_PURCHASE_TYPE = 24;
    uint8 private constant COCKTAIL_PURCHASE_TYPE = 25;
    uint8 private constant GOLDEN_COLOR_PURCHASE_TYPE = 26;
    uint8 private constant SMART_WATCH_PURCHASE_TYPE = 27;
    uint8 private constant SMARTPHONE_PURCHASE_TYPE = 28;
    uint8 private constant YACHT_PURCHASE_TYPE = 29;
    uint8 private constant REFERRER_PROCENT_OF_COCKTAILS = 7;
    uint8 private constant REFERRER_PROCENT_OF_COIN = 7;

    ItemInfo[30] public itemInfo;
    uint256 public usersCount;
    address bankAddress;
    address owner;
    uint256 public priceOfCocktail;
    uint256 public priceOfCoins;
    uint256 public priceOfGoldenCoin;
    uint256 public startTimestamp;
    mapping(address => UserInfo) userInfo;
    mapping(address => LevelOneItems) levelOneItems;
    mapping(address => LevelTwoItems) levelTwoItems;
    mapping(address => LevelThreeItems) levelThreeItems;
    mapping(address => LevelFourItems) levelFourItems;
    mapping(address => LevelFiveItems) levelFiveItems;
    mapping(address => address) public addressToHisReferrer; // Referrer is higher in the tree
    mapping(uint256 => address) public idToHisAddress; // ID is for referral system, user can invite other users by his id
    mapping(address => bool) public isAdmin;

    //events
    event BankAddressSet(address indexed wallet, uint256 indexed timestamp);
    event CocktailBought(address indexed buyer, uint256 indexed count, uint256 indexed timestamp);
    event CocktailSwap(address indexed user, uint256 indexed count, uint256 indexed timestamp);
    event ReferralsCountBonus(address indexed user, uint256 indexed bonusAmount, uint256 indexed timestamp);
    event BoughtTicketsCountBonus(address indexed user, uint256 indexed bonusAmount, uint256 indexed timestamp);
    event SoldTicketsCountBonus(address indexed user, uint256 indexed bonusAmount, uint256 indexed timestamp);
    event TicketNumberSet(uint256 indexed ticketNumber, uint256 indexed timestamp);
    event TicketPriceSet(uint256 indexed ticketPrice, uint256 indexed timestamp);
    event MonthlyJackpotAddressSet(address indexed monthlyJackpot, uint256 indexed timestamp);
    event TicketNFTAddressSet(address indexed NFTAddress, uint256 indexed timestamp);
    event StableCoinAddressSet(address indexed NFTAddress, uint256 indexed timestamp);
    event NewCycleStarted(address indexed caller, uint256 cycleCount, uint256 indexed timestamp);
    event WinnersRewarded(address indexed caller, uint256 indexed timestamp);
    event MonthlyJackpotExecuted(address indexed winner, uint256 indexed newJackpotStartingTime);

    modifier onlyOwner {
        require(msg.sender == owner, "GoldenLama:: Caller is not the owner!");
        _;
    }

    modifier onlyAdmin(){
        require(isAdmin[msg.sender] || msg.sender == owner, "GoldenLama:: This function can be called only by admins");
        _;
    }

    constructor() {
        owner = msg.sender;
        startTimestamp = block.timestamp;
        usersCount = 1;
    }

    receive() external payable {}

    fallback() external payable {}

    function addUserToMlm(address _user, uint256 _refId) external onlyAdmin {
        require(!(addressToHisReferrer[_user] != address(0) && idToHisAddress[_refId] != addressToHisReferrer[_user]),"GoldenLama:: your referrer is already set and it is another user"); //checking refid
        require(_refId < usersCount, "GoldenLama:: Please provide right ID!");

        userInfo[_user].refId = _refId;
        userInfo[_user].userId = usersCount;
        idToHisAddress[usersCount] = _user;
        ++usersCount;
        address referrer = idToHisAddress[_refId];
        addressToHisReferrer[_user] = referrer;
    }

    function setBankAddress(address _bankAddress) external onlyOwner {
        bankAddress = _bankAddress;
        emit BankAddressSet(_bankAddress, block.timestamp);
    }

    function buyCocktail(uint256 _count) external payable {
        require(_count > 0, "GoldenLama:: Cocktails count to buy should be greater than 0!");
        require((msg.sender).balance >= msg.value, "GoldenLama:: Insufficient user balance!");
        require(msg.value >= (_count * priceOfCocktail), "GoldenLama:: Insufficient funds for buying cocktails!");
        uint256 amountToReturn = msg.value - (_count * priceOfCocktail); 
        uint256 amountToTransfer = msg.value - amountToReturn;

        if(amountToReturn > 0) {
            payable(msg.sender).transfer(amountToReturn);
        }
        payable(owner).transfer(amountToTransfer / 10);
        payable(bankAddress).transfer(amountToTransfer * 9 / 10);

        userInfo[msg.sender].balanceOfCocktail += _count;

        if(addressToHisReferrer[msg.sender] != address(0)) {
            uint256 countOfCoctails = amountToTransfer * 7 / 1000;
            uint256 countOfCoins = amountToTransfer * 3 / 1000;

        }

        emit CocktailBought(msg.sender, _count, block.timestamp);
    }

    function swapCocktailsWithCoins(uint256 _count) external {
        require(_count > 0,"GoldenLama:: Cocktails count to exchange should be greater than 0!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count, "GoldenLama:: Insufficient balance of cocktails!");
        userInfo[msg.sender].balanceOfCocktail -= _count;
        userInfo[msg.sender].balanceOfCoin += _count * 100;
        emit CocktailSwap(msg.sender, _count, block.timestamp);
    }

    // this function is not working as I want
    function sellCois(uint256 _count) external {
        require(userInfo[msg.sender].balanceOfCoin >= _count, "GoldenLama:: Insufficient balance of cocktails!");
        userInfo[msg.sender].balanceOfCoin -= _count;
        uint256 amountToTransfer = _count * priceOfCoins;
        payable(msg.sender).transfer(amountToTransfer); 
    }

    /**
    * @notice Function - setAdminStatus
    * @dev Sets Admin status.
    * @param _admin Address of Admin.
    * @param _status Boolean variable for enabling or disabling Admin.
    * @dev Only the contract owner can execute this function.
    */
    function setAdminStatus(address _admin, bool _status) external onlyOwner{
        isAdmin[_admin] = _status;
    }

    function setItems(ItemInfo[30] calldata _items) external onlyOwner {
        itemInfo = _items;
    }

    function purchaseLevelOneItems(uint8 _itemType, uint256 _count) external {
        require(_count > 0, "GoldenLama:: You cann't buy 0 item!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count * itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        _validateLevelOneItemsTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= _count * itemInfo[_itemType].price;

        if(_itemType == 0){
            levelOneItems[msg.sender].countOfSand += _count;
        } else if(_itemType == 1) {
            require(levelOneItems[msg.sender].countOfSand > 0, "GoldenLama:: You must buy the previous one!");
            levelOneItems[msg.sender].countOfSky += _count;
        } else if(_itemType == 2) {
            require(levelOneItems[msg.sender].countOfSand > 0 && levelOneItems[msg.sender].countOfSky > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItems[msg.sender].countOfSea += _count;
        } else if(_itemType == 3) {
            require(levelOneItems[msg.sender].countOfSand > 0 && levelOneItems[msg.sender].countOfSky > 0 && levelOneItems[msg.sender].countOfSea > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItems[msg.sender].countOfCloud += _count;
        } else if(_itemType == 4) {
            require(levelOneItems[msg.sender].countOfSand > 0 && levelOneItems[msg.sender].countOfSky > 0 && levelOneItems[msg.sender].countOfSea > 0 && levelOneItems[msg.sender].countOfCloud > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItems[msg.sender].countOfSun += _count;
        } else {
            require(levelOneItems[msg.sender].countOfSand > 0 && levelOneItems[msg.sender].countOfSky > 0 && levelOneItems[msg.sender].countOfSea > 0 && levelOneItems[msg.sender].countOfCloud > 0 && levelOneItems[msg.sender].countOfSun > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItems[msg.sender].countOfGull += _count;
            levelOneItems[msg.sender].allItemsBought = true;
        }
    }

    function purchaseLevelTwoItems(uint8 _itemType, uint256 _count) external {
        require(_count > 0, "GoldenLama:: You cann't buy 0 item!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count * itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        require(levelOneItems[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the first line!");
        _validateLevelTwoItemsTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= _count * itemInfo[_itemType].price;

        if(_itemType == 6){
            levelTwoItems[msg.sender].countOfPalm += _count;
        } else if(_itemType == 7) {
            require(levelTwoItems[msg.sender].countOfPalm > 0, "GoldenLama:: You must buy the previous one!");
            levelTwoItems[msg.sender].countOfCoconuts += _count;
        } else if(_itemType == 8) {
            require(levelTwoItems[msg.sender].countOfPalm > 0 && levelTwoItems[msg.sender].countOfCoconuts > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItems[msg.sender].countOfGoldFish += _count;
        } else if(_itemType == 9) {
            require(levelTwoItems[msg.sender].countOfPalm > 0 && levelTwoItems[msg.sender].countOfCoconuts > 0 && levelTwoItems[msg.sender].countOfGoldFish > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItems[msg.sender].countOfCrab += _count;
        } else if(_itemType == 10) {
            require(levelTwoItems[msg.sender].countOfPalm > 0 && levelTwoItems[msg.sender].countOfCoconuts > 0 && levelTwoItems[msg.sender].countOfGoldFish > 0 && levelTwoItems[msg.sender].countOfCrab > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItems[msg.sender].countOfShells += _count;
        } else {
            require(levelTwoItems[msg.sender].countOfPalm > 0 && levelTwoItems[msg.sender].countOfCoconuts > 0 && levelTwoItems[msg.sender].countOfGoldFish > 0 && levelTwoItems[msg.sender].countOfCrab > 0 && levelTwoItems[msg.sender].countOfShells > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItems[msg.sender].countOfColoredStones += _count;
            levelTwoItems[msg.sender].allItemsBought = true;
        }
    }

    function purchaseLevelThreeItems(uint8 _itemType, uint256 _count) external {
        require(block.timestamp > startTimestamp + 11 days, "GoldenLama:: Third line items are not available yet!");
        require(_count > 0, "GoldenLama:: You cann't buy 0 item!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count * itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        require(levelOneItems[msg.sender].allItemsBought == true && levelTwoItems[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");      
        _validateLevelThreeItemsTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= _count * itemInfo[_itemType].price;

        if(_itemType == 12){
            levelThreeItems[msg.sender].countOfSandCastel += _count;
        } else if(_itemType == 13) {
            require(levelThreeItems[msg.sender].countOfSandCastel > 0, "GoldenLama:: You must buy the previous one!");
            levelThreeItems[msg.sender].countOfChaiseLounge += _count;
        } else if(_itemType == 14) {
            require(levelThreeItems[msg.sender].countOfSandCastel > 0 && levelThreeItems[msg.sender].countOfChaiseLounge > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItems[msg.sender].countOfTowel += _count;
        } else if(_itemType == 15) {
            require(levelThreeItems[msg.sender].countOfSandCastel > 0 && levelThreeItems[msg.sender].countOfChaiseLounge > 0 && levelThreeItems[msg.sender].countOfTowel > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItems[msg.sender].countOfSuncreen += _count;
        } else if(_itemType == 16) {
            require(levelThreeItems[msg.sender].countOfSandCastel > 0 && levelThreeItems[msg.sender].countOfChaiseLounge > 0 && levelThreeItems[msg.sender].countOfTowel > 0 && levelThreeItems[msg.sender].countOfSuncreen > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItems[msg.sender].countOfBasket += _count;
        } else {
            require(levelThreeItems[msg.sender].countOfSandCastel > 0 && levelThreeItems[msg.sender].countOfChaiseLounge > 0 && levelThreeItems[msg.sender].countOfTowel > 0 && levelThreeItems[msg.sender].countOfSuncreen > 0 && levelThreeItems[msg.sender].countOfBasket > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItems[msg.sender].countOfUmbrella += _count;
            levelThreeItems[msg.sender].allItemsBought = true;
        }
    }

    function purchaseLevelFourItems(uint8 _itemType, uint256 _count) external {
        require(block.timestamp > startTimestamp + 21 days, "GoldenLama:: Fourth line items are not available yet!");
        require(_count > 0, "GoldenLama:: You cann't buy 0 item!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count * itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        require(levelOneItems[msg.sender].allItemsBought == true && levelTwoItems[msg.sender].allItemsBought == true && levelThreeItems[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");      
        _validateLevelFourItemsTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= _count * itemInfo[_itemType].price;

        if(_itemType == 18){
            levelFourItems[msg.sender].countOfBoa += _count;
        } else if(_itemType == 19) {
            require(levelFourItems[msg.sender].countOfBoa > 0, "GoldenLama:: You must buy the previous one!");
            levelFourItems[msg.sender].countOfSunglasses += _count;
        } else if(_itemType == 20) {
            require(levelFourItems[msg.sender].countOfBoa > 0 && levelFourItems[msg.sender].countOfSunglasses > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItems[msg.sender].countOfBaseballCap += _count;
        } else if(_itemType == 21) {
            require(levelFourItems[msg.sender].countOfBoa > 0 && levelFourItems[msg.sender].countOfSunglasses > 0 && levelFourItems[msg.sender].countOfBaseballCap > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItems[msg.sender].countOfSwimsuitTop += _count;
        } else if(_itemType == 22) {
            require(levelFourItems[msg.sender].countOfBoa > 0 && levelFourItems[msg.sender].countOfSunglasses > 0 && levelFourItems[msg.sender].countOfBaseballCap > 0 && levelFourItems[msg.sender].countOfSwimsuitTop > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItems[msg.sender].countOfSwimsuitBriefs += _count;
        } else {
            require(levelFourItems[msg.sender].countOfBoa > 0 && levelFourItems[msg.sender].countOfSunglasses > 0 && levelFourItems[msg.sender].countOfBaseballCap > 0 && levelFourItems[msg.sender].countOfSwimsuitTop > 0 && levelFourItems[msg.sender].countOfSwimsuitBriefs > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItems[msg.sender].countOfCrocs += _count;
            levelFourItems[msg.sender].allItemsBought = true;
        }
    }

    function purchaseLevelFiveItems(uint8 _itemType, uint256 _count) external {
        require(block.timestamp > startTimestamp + 41 days, "GoldenLama:: Fifth line items are not available yet!");
        require(_count > 0, "GoldenLama:: You cann't buy 0 item!");
        require(userInfo[msg.sender].balanceOfCocktail >= _count * itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        require(levelOneItems[msg.sender].allItemsBought == true && levelTwoItems[msg.sender].allItemsBought == true && levelThreeItems[msg.sender].allItemsBought == true && levelFourItems[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");
        _validateLevelFiveItemsTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= _count * itemInfo[_itemType].price;

        if(_itemType == 24){
            levelFiveItems[msg.sender].countOfFlamingoRing += _count;
        } else if(_itemType == 25) {
            require(levelFiveItems[msg.sender].countOfFlamingoRing > 0, "GoldenLama:: You must buy the previous one!");
            levelFiveItems[msg.sender].countOfCoctail += _count;
        } else if(_itemType == 26) {
            require(levelFiveItems[msg.sender].countOfFlamingoRing > 0 && levelFiveItems[msg.sender].countOfCoctail > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItems[msg.sender].countOfGoldenColor += _count;
        } else if(_itemType == 27) {
            require(levelFiveItems[msg.sender].countOfFlamingoRing > 0 && levelFiveItems[msg.sender].countOfCoctail > 0 && levelFiveItems[msg.sender].countOfGoldenColor > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItems[msg.sender].countOfSmartWatch += _count;
        } else if(_itemType == 28) {
            require(levelFiveItems[msg.sender].countOfFlamingoRing > 0 && levelFiveItems[msg.sender].countOfCoctail > 0 && levelFiveItems[msg.sender].countOfGoldenColor > 0 && levelFiveItems[msg.sender].countOfSmartWatch > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItems[msg.sender].countOfSmartphone += _count;
        } else {
            require(levelFiveItems[msg.sender].countOfFlamingoRing > 0 && levelFiveItems[msg.sender].countOfCoctail > 0 && levelFiveItems[msg.sender].countOfGoldenColor > 0 && levelFiveItems[msg.sender].countOfSmartWatch > 0 && levelFiveItems[msg.sender].countOfSmartphone > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItems[msg.sender].countOfYacht += _count;
        }
    }

    function _validateLevelOneItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == SAND_PURCHASE_TYPE || 
            _itemType == SEA_PURCHASE_TYPE || 
            _itemType == SKY_PURCHASE_TYPE ||
            _itemType == CLOUD_PURCHASE_TYPE ||
            _itemType == SUN_PURCHASE_TYPE ||
            _itemType == GULL_PURCHASE_TYPE
        );
    }
    
    function _validateLevelTwoItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == PALM_PURCHASE_TYPE || 
            _itemType == COCONUTS_PURCHASE_TYPE || 
            _itemType == GOLD_FISH_PURCHASE_TYPE ||
            _itemType == CRAB_PURCHASE_TYPE ||
            _itemType == SHELLS_PURCHASE_TYPE ||
            _itemType == COLORED_STONES_PURCHASE_TYPE
        );
    }

    function _validateLevelThreeItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == SAND_CASTEL_PURCHASE_TYPE || 
            _itemType == CHAISE_LOUNGE_PURCHASE_TYPE || 
            _itemType == TOWEL_PURCHASE_TYPE ||
            _itemType == SUNSCREEN_PURCHASE_TYPE ||
            _itemType == BASKET_PURCHASE_TYPE ||
            _itemType == UMBRELLA_PURCHASE_TYPE
        );
    }

    function _validateLevelFourItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == BOA_PURCHASE_TYPE || 
            _itemType == SUNGLASSES_PURCHASE_TYPE || 
            _itemType == BASEBALL_CAP_PURCHASE_TYPE ||
            _itemType == SWIMSUIT_TOP_PURCHASE_TYPE ||
            _itemType == SWIMSUIT_BRIEFS_PURCHASE_TYPE ||
            _itemType == CROCS_PURCHASE_TYPE
        );
    }

    function _validateLevelFiveItemsTypes(uint8 _itemType) private pure {
        require(
            _itemType == FLAMINGO_RING_PURCHASE_TYPE || 
            _itemType == COCKTAIL_PURCHASE_TYPE || 
            _itemType == GOLDEN_COLOR_PURCHASE_TYPE ||
            _itemType == SMART_WATCH_PURCHASE_TYPE ||
            _itemType == SMARTPHONE_PURCHASE_TYPE ||
            _itemType == YACHT_PURCHASE_TYPE
        );
    }

    function _transferFrom(address _from, address _to, uint256 _amount) private {
        require(_from.balance > _amount, "GoldenLama:: Insufficient amount for tgransfer!");
        require(_amount > 0, "GoldenLama:: Amount should be more than 0!");
        require(_to != address(0), "GoldenLama:: Transfer to 0 address!");
        _from.balance -= _amount;
        _to.balance += _amount;
    }


    // function collectMoney() public {
    //     address user = msg.sender;
    //     syncTower(user);
    //     towers[user].hrs = 0;
    //     towers[user].money += towers[user].money2;
    //     towers[user].money2 = 0;
    // }
}