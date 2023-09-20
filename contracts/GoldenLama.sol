// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract GoldenLama {

    struct ItemInfo {
        uint256 purchaseType;
        uint256 price;
        uint256 dailyProfit;
    }

    struct UserInfo {
        uint256 userId;
        uint256 refId;
        uint256 profitDept;
        uint256 balanceOfCocktail;
        uint256 balanceOfCoin;
    }
    
    struct LevelOneItemInfo {
        uint256 timestampOfSand;
        uint256 timestampOfSky;
        uint256 timestampOfSea;
        uint256 timestampOfCloud;
        uint256 timestampOfSun;
        uint256 timestampOfGull;
        bool allItemsBought;
    }

    struct LevelTwoItemInfo {
        uint256 timestampOfPalm;
        uint256 timestampOfCoconuts;
        uint256 timestampOfGoldFish;
        uint256 timestampOfCrab;
        uint256 timestampOfShells;
        uint256 timestampOfColoredStones;
        bool allItemsBought;
    }
    
    struct LevelThreeItemInfo {
        uint256 timestampOfSandCastel;
        uint256 timestampOfChaiseLounge;
        uint256 timestampOfTowel;
        uint256 timestampOfSuncreen;
        uint256 timestampOfBasket;
        uint256 timestampOfUmbrella;
        bool allItemsBought;    
    }
    
    struct LevelFourItemInfo {
        uint256 timestampOfBoa;
        uint256 timestampOfSunglasses;
        uint256 timestampOfBaseballCap;
        uint256 timestampOfSwimsuitTop;
        uint256 timestampOfSwimsuitBriefs;
        uint256 timestampOfCrocs;
        bool allItemsBought;
    }
    
    struct LevelFiveItemInfo {
        uint256 timestampOfFlamingoRing;
        uint256 timestampOfCoctail;
        uint256 timestampOfGoldenColor;
        uint256 timestampOfSmartWatch;
        uint256 timestampOfSmartphone;
        uint256 timestampOfYacht;
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
    uint8 private constant TOWEL_PURCHASE_TYPE = 14;
    uint8 private constant SUNSCREEN_PURCHASE_TYPE = 15;
    uint8 private constant BASKET_PURCHASE_TYPE = 16;
    uint8 private constant UMBRELLA_PURCHASE_TYPE = 17;
    uint8 private constant BOA_PURCHASE_TYPE = 18;
    uint8 private constant SUNGLASSES_PURCHASE_TYPE = 19;
    uint8 private constant BASEBALL_CAP_PURCHASE_TYPE = 20;
    uint8 private constant SWIMSUIT_TOP_PURCHASE_TYPE = 21;
    uint8 private constant SWIMSUIT_BRIEFS_PURCHASE_TYPE = 22;
    uint8 private constant CROCS_PURCHASE_TYPE = 23;
    uint8 private constant FLAMINGO_RING_PURCHASE_TYPE = 24;
    uint8 private constant DRINK_PURCHASE_TYPE = 25;
    uint8 private constant GOLDEN_COLOR_PURCHASE_TYPE = 26;
    uint8 private constant SMART_WATCH_PURCHASE_TYPE = 27;
    uint8 private constant SMARTPHONE_PURCHASE_TYPE = 28;
    uint8 private constant YACHT_PURCHASE_TYPE = 29;

    address public owner;
    uint256 public usersCount;
    uint256 public priceOfCocktail;
    uint256 public priceOfCoins;
    uint256 public priceOfGoldenCoin;
    uint256 public startTimestamp;
    ItemInfo[30] public itemInfo;
    mapping(address => LevelOneItemInfo) public levelOneItemInfo;
    mapping(address => LevelTwoItemInfo) public levelTwoItemInfo;
    mapping(address => LevelThreeItemInfo) public levelThreeItemInfo;
    mapping(address => LevelFourItemInfo) public levelFourItemInfo;
    mapping(address => LevelFiveItemInfo) public levelFiveItemInfo;
    mapping(address => address) public addressToHisReferrer; 
    mapping(uint256 => address) public idToHisAddress; 
    mapping(address => UserInfo) public userInfo;
    mapping(address => bool) public isAdmin;

    //events
    event CocktailBought(address indexed buyer, uint256 indexed count, uint256 indexed timestamp);
    event CocktailSwap(address indexed user, uint256 indexed count, uint256 indexed timestamp);
    event LevelOneItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    event LevelTwoItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    event LevelThreeItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    event LevelFourItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    event LevelFiveItemPurchased(address indexed user, uint256 indexed typeOfItem, uint256 indexed timestamp);
    
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

    function setAdminStatus(address _admin, bool _status) external onlyOwner{
        isAdmin[_admin] = _status;
    }

    function setItems(ItemInfo[30] calldata _items) external onlyOwner {
        itemInfo = _items;
    }

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

    function buyCocktail(uint256 _count) external payable {
        require(_count > itemInfo[SAND_PURCHASE_TYPE].price, "GoldenLama:: Cocktails count to buy should be greater than 600!");
        require((msg.sender).balance >= msg.value, "GoldenLama:: Insufficient user balance!");
        require(msg.value >= (_count * priceOfCocktail), "GoldenLama:: Insufficient funds for buying cocktails!");
        uint256 amountToReturn = msg.value - (_count * priceOfCocktail); 
        uint256 amountToTransfer = msg.value - amountToReturn;

        if(amountToReturn > 0) {
            payable(msg.sender).transfer(amountToReturn);
        }
        payable(owner).transfer(amountToTransfer / 10);
        payable(address(this)).transfer(amountToTransfer * 9 / 10);

        userInfo[msg.sender].balanceOfCocktail += _count;

        address referrer = addressToHisReferrer[msg.sender];
        if(referrer != address(0)) {
            uint256 countOfCoctails = amountToTransfer * 7 / 1000 / priceOfCocktail;
            uint256 countOfCoins = amountToTransfer * 3 / 1000 / priceOfCoins;
            userInfo[referrer].balanceOfCocktail += countOfCoctails;
            userInfo[referrer].balanceOfCoin += countOfCoins;
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

    function sellCois(uint256 _count) external {
        require(userInfo[msg.sender].balanceOfCoin >= _count, "GoldenLama:: Insufficient balance of cocktails!");
        userInfo[msg.sender].balanceOfCoin -= _count;
        uint256 amountToTransfer = _count * priceOfCoins;
        // payable(msg.sender).transfer(amountToTransfer); 

        (bool sent,) = payable(msg.sender).call{value:amountToTransfer}("");
        require(sent , "GoldenLama:: not sent!"); 
    }

    function purchaselevelOneItemInfo(uint8 _itemType) external {
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        _validatelevelOneItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;

        if(_itemType == 0){
            levelOneItemInfo[msg.sender].timestampOfSand = block.timestamp;
        } else if(_itemType == 1) {
            require(levelOneItemInfo[msg.sender].timestampOfSand > 0, "GoldenLama:: You must buy the previous one!");
            levelOneItemInfo[msg.sender].timestampOfSky = block.timestamp;
        } else if(_itemType == 2) {
            require(levelOneItemInfo[msg.sender].timestampOfSand > 0 && levelOneItemInfo[msg.sender].timestampOfSky > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItemInfo[msg.sender].timestampOfSea = block.timestamp;
        } else if(_itemType == 3) {
            require(levelOneItemInfo[msg.sender].timestampOfSand > 0 && levelOneItemInfo[msg.sender].timestampOfSky > 0 && levelOneItemInfo[msg.sender].timestampOfSea > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItemInfo[msg.sender].timestampOfCloud = block.timestamp;
        } else if(_itemType == 4) {
            require(levelOneItemInfo[msg.sender].timestampOfSand > 0 && levelOneItemInfo[msg.sender].timestampOfSky > 0 && levelOneItemInfo[msg.sender].timestampOfSea > 0 && levelOneItemInfo[msg.sender].timestampOfCloud > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItemInfo[msg.sender].timestampOfSun = block.timestamp;
        } else {
            require(levelOneItemInfo[msg.sender].timestampOfSand > 0 && levelOneItemInfo[msg.sender].timestampOfSky > 0 && levelOneItemInfo[msg.sender].timestampOfSea > 0 && levelOneItemInfo[msg.sender].timestampOfCloud > 0 && levelOneItemInfo[msg.sender].timestampOfSun > 0, "GoldenLama:: You must buy the previous items!");
            levelOneItemInfo[msg.sender].timestampOfGull = block.timestamp;
            levelOneItemInfo[msg.sender].allItemsBought = true;
        }

        emit LevelOneItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelTwoItemInfo(uint8 _itemType) external {
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the first line!");
        _validatelevelTwoItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;

        if(_itemType == 6){
            levelTwoItemInfo[msg.sender].timestampOfPalm = block.timestamp;
        } else if(_itemType == 7) {
            require(levelTwoItemInfo[msg.sender].timestampOfPalm > 0, "GoldenLama:: You must buy the previous one!");
            levelTwoItemInfo[msg.sender].timestampOfCoconuts = block.timestamp;
        } else if(_itemType == 8) {
            require(levelTwoItemInfo[msg.sender].timestampOfPalm > 0 && levelTwoItemInfo[msg.sender].timestampOfCoconuts > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItemInfo[msg.sender].timestampOfGoldFish = block.timestamp;
        } else if(_itemType == 9) {
            require(levelTwoItemInfo[msg.sender].timestampOfPalm > 0 && levelTwoItemInfo[msg.sender].timestampOfCoconuts > 0 && levelTwoItemInfo[msg.sender].timestampOfGoldFish > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItemInfo[msg.sender].timestampOfCrab = block.timestamp;
        } else if(_itemType == 10) {
            require(levelTwoItemInfo[msg.sender].timestampOfPalm > 0 && levelTwoItemInfo[msg.sender].timestampOfCoconuts > 0 && levelTwoItemInfo[msg.sender].timestampOfGoldFish > 0 && levelTwoItemInfo[msg.sender].timestampOfCrab > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItemInfo[msg.sender].timestampOfShells = block.timestamp;
        } else {
            require(levelTwoItemInfo[msg.sender].timestampOfPalm > 0 && levelTwoItemInfo[msg.sender].timestampOfCoconuts > 0 && levelTwoItemInfo[msg.sender].timestampOfGoldFish > 0 && levelTwoItemInfo[msg.sender].timestampOfCrab > 0 && levelTwoItemInfo[msg.sender].timestampOfShells > 0, "GoldenLama:: You must buy the previous items!");
            levelTwoItemInfo[msg.sender].timestampOfColoredStones = block.timestamp;
            levelTwoItemInfo[msg.sender].allItemsBought = true;
        }

        emit LevelTwoItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelThreeItemInfo(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 11 days, "GoldenLama:: Third line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");      
        _validatelevelThreeItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;

        if(_itemType == 12){
            levelThreeItemInfo[msg.sender].timestampOfSandCastel = block.timestamp;
        } else if(_itemType == 13) {
            require(levelThreeItemInfo[msg.sender].timestampOfSandCastel > 0, "GoldenLama:: You must buy the previous one!");
            levelThreeItemInfo[msg.sender].timestampOfChaiseLounge = block.timestamp;
        } else if(_itemType == 14) {
            require(levelThreeItemInfo[msg.sender].timestampOfSandCastel > 0 && levelThreeItemInfo[msg.sender].timestampOfChaiseLounge > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItemInfo[msg.sender].timestampOfTowel = block.timestamp;
        } else if(_itemType == 15) {
            require(levelThreeItemInfo[msg.sender].timestampOfSandCastel > 0 && levelThreeItemInfo[msg.sender].timestampOfChaiseLounge > 0 && levelThreeItemInfo[msg.sender].timestampOfTowel > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItemInfo[msg.sender].timestampOfSuncreen = block.timestamp;
        } else if(_itemType == 16) {
            require(levelThreeItemInfo[msg.sender].timestampOfSandCastel > 0 && levelThreeItemInfo[msg.sender].timestampOfChaiseLounge > 0 && levelThreeItemInfo[msg.sender].timestampOfTowel > 0 && levelThreeItemInfo[msg.sender].timestampOfSuncreen > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItemInfo[msg.sender].timestampOfBasket = block.timestamp;
        } else {
            require(levelThreeItemInfo[msg.sender].timestampOfSandCastel > 0 && levelThreeItemInfo[msg.sender].timestampOfChaiseLounge > 0 && levelThreeItemInfo[msg.sender].timestampOfTowel > 0 && levelThreeItemInfo[msg.sender].timestampOfSuncreen > 0 && levelThreeItemInfo[msg.sender].timestampOfBasket > 0, "GoldenLama:: You must buy the previous items!");
            levelThreeItemInfo[msg.sender].timestampOfUmbrella = block.timestamp;
            levelThreeItemInfo[msg.sender].allItemsBought = true;
        }
        
        emit LevelThreeItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelFourItemInfo(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 21 days, "GoldenLama:: Fourth line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true && levelThreeItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");      
        _validatelevelFourItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;

        if(_itemType == 18){
            levelFourItemInfo[msg.sender].timestampOfBoa = block.timestamp;
        } else if(_itemType == 19) {
            require(levelFourItemInfo[msg.sender].timestampOfBoa > 0, "GoldenLama:: You must buy the previous one!");
            levelFourItemInfo[msg.sender].timestampOfSunglasses = block.timestamp;
        } else if(_itemType == 20) {
            require(levelFourItemInfo[msg.sender].timestampOfBoa > 0 && levelFourItemInfo[msg.sender].timestampOfSunglasses > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItemInfo[msg.sender].timestampOfBaseballCap = block.timestamp;
        } else if(_itemType == 21) {
            require(levelFourItemInfo[msg.sender].timestampOfBoa > 0 && levelFourItemInfo[msg.sender].timestampOfSunglasses > 0 && levelFourItemInfo[msg.sender].timestampOfBaseballCap > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItemInfo[msg.sender].timestampOfSwimsuitTop = block.timestamp;
        } else if(_itemType == 22) {
            require(levelFourItemInfo[msg.sender].timestampOfBoa > 0 && levelFourItemInfo[msg.sender].timestampOfSunglasses > 0 && levelFourItemInfo[msg.sender].timestampOfBaseballCap > 0 && levelFourItemInfo[msg.sender].timestampOfSwimsuitTop > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItemInfo[msg.sender].timestampOfSwimsuitBriefs = block.timestamp;
        } else {
            require(levelFourItemInfo[msg.sender].timestampOfBoa > 0 && levelFourItemInfo[msg.sender].timestampOfSunglasses > 0 && levelFourItemInfo[msg.sender].timestampOfBaseballCap > 0 && levelFourItemInfo[msg.sender].timestampOfSwimsuitTop > 0 && levelFourItemInfo[msg.sender].timestampOfSwimsuitBriefs > 0, "GoldenLama:: You must buy the previous items!");
            levelFourItemInfo[msg.sender].timestampOfCrocs = block.timestamp;
            levelFourItemInfo[msg.sender].allItemsBought = true;
        }

        emit LevelFourItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelFiveItemInfo(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 41 days, "GoldenLama:: Fifth line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= itemInfo[_itemType].price, "GoldenLama:: Insufficient balance for buyind Level 1 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true && levelThreeItemInfo[msg.sender].allItemsBought == true && levelFourItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous line!");
        _validatelevelFiveItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= itemInfo[_itemType].price;

        if(_itemType == 24){
            levelFiveItemInfo[msg.sender].timestampOfFlamingoRing = block.timestamp;
        } else if(_itemType == 25) {
            require(levelFiveItemInfo[msg.sender].timestampOfFlamingoRing > 0, "GoldenLama:: You must buy the previous one!");
            levelFiveItemInfo[msg.sender].timestampOfCoctail = block.timestamp;
        } else if(_itemType == 26) {
            require(levelFiveItemInfo[msg.sender].timestampOfFlamingoRing > 0 && levelFiveItemInfo[msg.sender].timestampOfCoctail > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItemInfo[msg.sender].timestampOfGoldenColor = block.timestamp;
        } else if(_itemType == 27) {
            require(levelFiveItemInfo[msg.sender].timestampOfFlamingoRing > 0 && levelFiveItemInfo[msg.sender].timestampOfCoctail > 0 && levelFiveItemInfo[msg.sender].timestampOfGoldenColor > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItemInfo[msg.sender].timestampOfSmartWatch = block.timestamp;
        } else if(_itemType == 28) {
            require(levelFiveItemInfo[msg.sender].timestampOfFlamingoRing > 0 && levelFiveItemInfo[msg.sender].timestampOfCoctail > 0 && levelFiveItemInfo[msg.sender].timestampOfGoldenColor > 0 && levelFiveItemInfo[msg.sender].timestampOfSmartWatch > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItemInfo[msg.sender].timestampOfSmartphone = block.timestamp;
        } else {
            require(levelFiveItemInfo[msg.sender].timestampOfFlamingoRing > 0 && levelFiveItemInfo[msg.sender].timestampOfCoctail > 0 && levelFiveItemInfo[msg.sender].timestampOfGoldenColor > 0 && levelFiveItemInfo[msg.sender].timestampOfSmartWatch > 0 && levelFiveItemInfo[msg.sender].timestampOfSmartphone > 0, "GoldenLama:: You must buy the previous items!");
            levelFiveItemInfo[msg.sender].timestampOfYacht = block.timestamp;
        }

        emit LevelFiveItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function claim() external {
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfSand) {
            userInfo[msg.sender].profitDept += itemInfo[SAND_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfSky) {
            userInfo[msg.sender].profitDept += itemInfo[SKY_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfSea) {
            userInfo[msg.sender].profitDept += itemInfo[SEA_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfCloud) {
            userInfo[msg.sender].profitDept += itemInfo[CLOUD_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfSun) {
            userInfo[msg.sender].profitDept += itemInfo[SUN_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelOneItemInfo[msg.sender].timestampOfGull) {
            userInfo[msg.sender].profitDept += itemInfo[GULL_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfPalm) {
            userInfo[msg.sender].profitDept += itemInfo[PALM_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfCoconuts) {
            userInfo[msg.sender].profitDept += itemInfo[COCONUTS_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfGoldFish) {
            userInfo[msg.sender].profitDept += itemInfo[GOLD_FISH_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfCrab) {
            userInfo[msg.sender].profitDept += itemInfo[CRAB_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfShells) {
            userInfo[msg.sender].profitDept += itemInfo[SHELLS_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelTwoItemInfo[msg.sender].timestampOfColoredStones) {
            userInfo[msg.sender].profitDept += itemInfo[COLORED_STONES_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfSandCastel) {
            userInfo[msg.sender].profitDept += itemInfo[SAND_CASTEL_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfChaiseLounge) {
            userInfo[msg.sender].profitDept += itemInfo[CHAISE_LOUNGE_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfTowel) {
            userInfo[msg.sender].profitDept += itemInfo[TOWEL_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfSuncreen) {
            userInfo[msg.sender].profitDept += itemInfo[SUNSCREEN_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfBasket) {
            userInfo[msg.sender].profitDept += itemInfo[BASKET_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelThreeItemInfo[msg.sender].timestampOfUmbrella) {
            userInfo[msg.sender].profitDept += itemInfo[UMBRELLA_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfBoa) {
            userInfo[msg.sender].profitDept += itemInfo[BOA_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSunglasses) {
            userInfo[msg.sender].profitDept += itemInfo[SUNGLASSES_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfBaseballCap) {
            userInfo[msg.sender].profitDept += itemInfo[BASEBALL_CAP_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSwimsuitTop) {
            userInfo[msg.sender].profitDept += itemInfo[SWIMSUIT_TOP_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfSwimsuitBriefs) {
            userInfo[msg.sender].profitDept += itemInfo[SWIMSUIT_BRIEFS_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFourItemInfo[msg.sender].timestampOfCrocs) {
            userInfo[msg.sender].profitDept += itemInfo[CROCS_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfFlamingoRing) {
            userInfo[msg.sender].profitDept += itemInfo[FLAMINGO_RING_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfCoctail) {
            userInfo[msg.sender].profitDept += itemInfo[DRINK_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfGoldenColor) {
            userInfo[msg.sender].profitDept += itemInfo[GOLDEN_COLOR_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfSmartWatch) {
            userInfo[msg.sender].profitDept += itemInfo[SMART_WATCH_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfSmartphone) {
            userInfo[msg.sender].profitDept += itemInfo[SMARTPHONE_PURCHASE_TYPE].dailyProfit;
        }
        if(block.timestamp + 1 days > levelFiveItemInfo[msg.sender].timestampOfYacht) {
            userInfo[msg.sender].profitDept += itemInfo[YACHT_PURCHASE_TYPE].dailyProfit;
        }
    }

    function _validatelevelOneItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == SAND_PURCHASE_TYPE || 
            _itemType == SEA_PURCHASE_TYPE || 
            _itemType == SKY_PURCHASE_TYPE ||
            _itemType == CLOUD_PURCHASE_TYPE ||
            _itemType == SUN_PURCHASE_TYPE ||
            _itemType == GULL_PURCHASE_TYPE
        );
    }
    
    function _validatelevelTwoItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == PALM_PURCHASE_TYPE || 
            _itemType == COCONUTS_PURCHASE_TYPE || 
            _itemType == GOLD_FISH_PURCHASE_TYPE ||
            _itemType == CRAB_PURCHASE_TYPE ||
            _itemType == SHELLS_PURCHASE_TYPE ||
            _itemType == COLORED_STONES_PURCHASE_TYPE
        );
    }

    function _validatelevelThreeItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == SAND_CASTEL_PURCHASE_TYPE || 
            _itemType == CHAISE_LOUNGE_PURCHASE_TYPE || 
            _itemType == TOWEL_PURCHASE_TYPE ||
            _itemType == SUNSCREEN_PURCHASE_TYPE ||
            _itemType == BASKET_PURCHASE_TYPE ||
            _itemType == UMBRELLA_PURCHASE_TYPE
        );
    }

    function _validatelevelFourItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == BOA_PURCHASE_TYPE || 
            _itemType == SUNGLASSES_PURCHASE_TYPE || 
            _itemType == BASEBALL_CAP_PURCHASE_TYPE ||
            _itemType == SWIMSUIT_TOP_PURCHASE_TYPE ||
            _itemType == SWIMSUIT_BRIEFS_PURCHASE_TYPE ||
            _itemType == CROCS_PURCHASE_TYPE
        );
    }

    function _validatelevelFiveItemInfoTypes(uint8 _itemType) private pure {
        require(
            _itemType == FLAMINGO_RING_PURCHASE_TYPE || 
            _itemType == DRINK_PURCHASE_TYPE || 
            _itemType == GOLDEN_COLOR_PURCHASE_TYPE ||
            _itemType == SMART_WATCH_PURCHASE_TYPE ||
            _itemType == SMARTPHONE_PURCHASE_TYPE ||
            _itemType == YACHT_PURCHASE_TYPE
        );
    }
}