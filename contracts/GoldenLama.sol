// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract GoldenLama {

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
        uint256 timestampOfDrink;
        uint256 timestampOfGoldenColor;
        uint256 timestampOfSmartWatch;
        uint256 timestampOfSmartphone;
        uint256 timestampOfYacht;
        bool allItemsBought;
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

    uint32 private constant SAND_DAILY_PROFIT = 1181;
    uint32 private constant SKY_DAILY_PROFIT = 2396;
    uint32 private constant SEA_DAILY_PROFIT = 3600;
    uint32 private constant CLOUD_DAILY_PROFIT = 4870;
    uint32 private constant SUN_DAILY_PROFIT = 6180;
    uint32 private constant GULL_DAILY_PROFIT = 7489;
    uint32 private constant PALM_DAILY_PROFIT = 8792;
    uint32 private constant COCONUTS_DAILY_PROFIT = 10069;
    uint32 private constant GOLD_FISH_DAILY_PROFIT = 11618;
    uint32 private constant CRAB_DAILY_PROFIT = 13782;
    uint32 private constant SHELLS_DAILY_PROFIT = 14896;
    uint32 private constant COLORED_STONES_DAILY_PROFIT = 17075;
    uint32 private constant SAND_CASTEL_DAILY_PROFIT = 19288;
    uint32 private constant CHAISE_LOUNGE_DAILY_PROFIT = 21519;
    uint32 private constant TOWEL_DAILY_PROFIT = 26052;
    uint32 private constant SUNSCREEN_DAILY_PROFIT = 34707;
    uint32 private constant BASKET_DAILY_PROFIT = 43715;
    uint32 private constant UMBRELLA_DAILY_PROFIT = 54860;
    uint32 private constant BOA_DAILY_PROFIT = 65919;
    uint32 private constant SUNGLASSES_DAILY_PROFIT = 77639;
    uint32 private constant BASEBALL_CAP_DAILY_PROFIT = 88888;
    uint32 private constant SWIMSUIT_TOP_DAILY_PROFIT = 111482;
    uint32 private constant SWIMSUIT_BRIEFS_DAILY_PROFIT = 146100;
    uint32 private constant CROCS_DAILY_PROFIT = 179856;
    uint32 private constant FLAMINGO_RING_DAILY_PROFIT = 227790;
    uint32 private constant DRINK_DAILY_PROFIT = 273660;
    uint32 private constant GOLDEN_COLOR_DAILY_PROFIT = 343249;
    uint32 private constant SMART_WATCH_DAILY_PROFIT = 413602;
    uint32 private constant SMARTPHONE_DAILY_PROFIT = 533271;
    uint32 private constant YACHT_DAILY_PROFIT = 705384;

    uint64 private constant PRICE_OF_COCKTAIL = 30000000000000;
    uint64 private constant PRICE_OF_COIN = 300000000000;

    address public owner;
    uint256 public usersCount;
    uint256 public startTimestamp;
    uint32[30] public prices;
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

    modifier onlyAdmin(){
        require(isAdmin[msg.sender] || msg.sender == owner, "GoldenLama:: This function can be called only by admins");
        _;
    }

    constructor(uint32[30] memory _prices) {
        owner = msg.sender;
        startTimestamp = block.timestamp;
        usersCount = 1;
        _setPrices(_prices);
    }

    receive() external payable {}

    fallback() external payable {}

    function setAdminStatus(address _admin, bool _status) external onlyAdmin{
        isAdmin[_admin] = _status;
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
        require(_count > prices[0], "GoldenLama:: Cocktails count to buy should be greater than 600!");
        require((msg.sender).balance >= msg.value, "GoldenLama:: Insufficient user balance!");
        require(msg.value >= (_count * PRICE_OF_COCKTAIL), "GoldenLama:: Insufficient funds for buying cocktails!");
        uint256 amountToReturn = msg.value - (_count * PRICE_OF_COCKTAIL); 
        uint256 amountToTransfer = msg.value - amountToReturn;

        if(userInfo[msg.sender].userId == 0) {
            userInfo[msg.sender].userId = usersCount;
            idToHisAddress[usersCount] = msg.sender;
            ++usersCount;
        }

        if(amountToReturn > 0) {
            payable(msg.sender).transfer(amountToReturn);
        }
        payable(owner).transfer(amountToTransfer / 10);
        payable(address(this)).transfer(amountToTransfer * 9 / 10);

        userInfo[msg.sender].balanceOfCocktail += _count;

        address referrer = addressToHisReferrer[msg.sender];
        if(referrer != address(0)) {
            uint256 countOfCoctails = amountToTransfer * 7 / 1000 / PRICE_OF_COCKTAIL;
            uint256 countOfCoins = amountToTransfer * 3 / 1000 / PRICE_OF_COIN;
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
        uint256 amountToTransfer = _count * PRICE_OF_COIN;
        // payable(msg.sender).transfer(amountToTransfer); 

        (bool sent,) = payable(msg.sender).call{value:amountToTransfer}("");
        require(sent , "GoldenLama:: not sent!");
    }

    function purchaselevelOneItem(uint8 _itemType) external {
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 1 item!");
        
        LevelOneItemInfo storage userItems = levelOneItemInfo[msg.sender];
        _validatelevelOneItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];

        require(userItems.allItemsBought == false, "GoldenLama:: Item already purchased!");
        require(
            (_itemType == 0) || // Sand is always allowed
            (_itemType == 1 && userItems.timestampOfSand > 0) || // Sky requires Sand
            (_itemType == 2 && userItems.timestampOfSand > 0 && userItems.timestampOfSky > 0) || // Sea requires Sand and Sky
            (_itemType == 3 && userItems.timestampOfSand > 0 && userItems.timestampOfSky > 0 && userItems.timestampOfSea > 0) || // Cloud requires Sand, Sky, and Sea
            (_itemType == 4 && userItems.timestampOfSand > 0 && userItems.timestampOfSky > 0 && userItems.timestampOfSea > 0 && userItems.timestampOfCloud > 0) || // Sun requires Sand, Sky, Sea, and Cloud
            (_itemType == 5 && userItems.timestampOfSand > 0 && userItems.timestampOfSky > 0 && userItems.timestampOfSea > 0 && userItems.timestampOfCloud > 0 && userItems.timestampOfSun > 0) , // Gull requires Sand, Sky, Sea, Cloud and Sun
            "GoldenLama:: You must buy the previous items!"
        );

        // Update the corresponding timestamp
        if (_itemType == 0) {
            userItems.timestampOfSand = block.timestamp;
        } else if (_itemType == 1) {
            userItems.timestampOfSky = block.timestamp;
        } else if (_itemType == 2) {
            userItems.timestampOfSea = block.timestamp;
        } else if (_itemType == 3) {
            userItems.timestampOfCloud = block.timestamp;
        } else if (_itemType == 4) {
            userItems.timestampOfSun = block.timestamp;
        } else {
            userItems.timestampOfGull = block.timestamp;
            userItems.allItemsBought = true;
        }

        emit LevelOneItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelTwoItem(uint8 _itemType) external {
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 2 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the first line!");
        
        LevelTwoItemInfo storage userItems = levelTwoItemInfo[msg.sender];
        _validatelevelTwoItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];

        require(userItems.allItemsBought == false, "GoldenLama:: Item already purchased!");
        require(
            (_itemType == 6) || // Palm is always allowed
            (_itemType == 7 && userItems.timestampOfPalm > 0) || // Coconut requires Palm
            (_itemType == 8 && userItems.timestampOfPalm > 0 && userItems.timestampOfCoconuts > 0) || // Fish requires Coconut and Palm
            (_itemType == 9 && userItems.timestampOfPalm > 0 && userItems.timestampOfCoconuts > 0 && userItems.timestampOfGoldFish > 0) || // Crab requires Palm, Coconut and Fish
            (_itemType == 10 && userItems.timestampOfPalm > 0 && userItems.timestampOfCoconuts > 0 && userItems.timestampOfGoldFish > 0 && userItems.timestampOfCrab > 0) || // Shells requires Palm, Coconut, Fish and Crab
            (_itemType == 11 && userItems.timestampOfPalm > 0 && userItems.timestampOfCoconuts > 0 && userItems.timestampOfGoldFish > 0 && userItems.timestampOfCrab > 0 && userItems.timestampOfShells > 0), // Stones requires Palm, Coconut, Fish, Crab and Shells
            "GoldenLama:: You must buy the previous items!"
        );

        // Update the corresponding timestamp
        if (_itemType == 6) {
            userItems.timestampOfPalm = block.timestamp;
        } else if (_itemType == 7) {
            userItems.timestampOfCoconuts = block.timestamp;
        } else if (_itemType == 8) {
            userItems.timestampOfGoldFish = block.timestamp;
        } else if (_itemType == 9) {
            userItems.timestampOfCrab = block.timestamp;
        } else if (_itemType == 10) {
            userItems.timestampOfShells = block.timestamp;
        } else {
            userItems.timestampOfColoredStones = block.timestamp;
            userItems.allItemsBought = true;
        }

        emit LevelTwoItemPurchased(msg.sender, _itemType, block.timestamp);

    }

    function purchaselevelThreeItem(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 11 days, "GoldenLama:: Third line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 3 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous lines!");      
        
        LevelThreeItemInfo storage userItems = levelThreeItemInfo[msg.sender];
        _validatelevelThreeItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];

        require(userItems.allItemsBought == false, "GoldenLama:: Item already purchased!");
        require(
            (_itemType == 12) || // Sand castel is always allowed
            (_itemType == 13 && userItems.timestampOfSandCastel > 0) || // Chaise Lounge requires Sand Castel
            (_itemType == 14 && userItems.timestampOfSandCastel > 0 && userItems.timestampOfChaiseLounge > 0) || // Towel requires Sand Castel and Chaise Lounge 
            (_itemType == 15 && userItems.timestampOfSandCastel > 0 && userItems.timestampOfChaiseLounge > 0 && userItems.timestampOfTowel > 0) || // Sunscreen requires Sand Castel, Chaise Lounge and Towel
            (_itemType == 16 && userItems.timestampOfSandCastel > 0 && userItems.timestampOfChaiseLounge > 0 && userItems.timestampOfTowel > 0 && userItems.timestampOfSuncreen > 0) || // Basket requires Sand Castel, Chaise Lounge, Towel and Sunscreen
            (_itemType == 17 && userItems.timestampOfSandCastel > 0 && userItems.timestampOfChaiseLounge > 0 && userItems.timestampOfTowel > 0 && userItems.timestampOfSuncreen > 0 && userItems.timestampOfBasket > 0), // Umbrella requires Sand Castel, Chaise Lounge, Towel, Sunscreen and Basket 
            "GoldenLama:: You must buy the previous items!"
        );
        
        // Update the corresponding timestamp
        if (_itemType == 12) {
            userItems.timestampOfSandCastel = block.timestamp;
        } else if (_itemType == 13) {
            userItems.timestampOfChaiseLounge = block.timestamp;
        } else if (_itemType == 14) {
            userItems.timestampOfTowel = block.timestamp;
        } else if (_itemType == 15) {
            userItems.timestampOfSuncreen = block.timestamp;
        } else if (_itemType == 16) {
            userItems.timestampOfBasket = block.timestamp;
        } else {
            userItems.timestampOfUmbrella = block.timestamp;
            userItems.allItemsBought = true;
        }
        
        emit LevelThreeItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelFourItem(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 21 days, "GoldenLama:: Fourth line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 4 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true && levelThreeItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous lines!");      

        LevelFourItemInfo storage userItems = levelFourItemInfo[msg.sender];
        _validatelevelFourItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];

        require(userItems.allItemsBought == false, "GoldenLama:: Item already purchased!");
        require(
            (_itemType == 18) || // Boa is always allowed
            (_itemType == 19 && userItems.timestampOfBoa > 0) || // Sunglasses requires Boa
            (_itemType == 20 && userItems.timestampOfBoa > 0 && userItems.timestampOfSunglasses > 0) || // Baseball Cap requires Boa and Sunglasses 
            (_itemType == 21 && userItems.timestampOfBoa > 0 && userItems.timestampOfSunglasses > 0 && userItems.timestampOfBaseballCap > 0) || // Swimsuit Top requires Boa, Sunglasses and Baseball Cap
            (_itemType == 22 && userItems.timestampOfBoa > 0 && userItems.timestampOfSunglasses > 0 && userItems.timestampOfBaseballCap > 0 && userItems.timestampOfSwimsuitTop > 0) || // Swimsuit Briefs requires Boa, Sunglasses, Baseball Cap and Swimsuit Top
            (_itemType == 23 && userItems.timestampOfBoa > 0 && userItems.timestampOfSunglasses > 0 && userItems.timestampOfBaseballCap > 0 && userItems.timestampOfSwimsuitTop > 0 && userItems.timestampOfSwimsuitBriefs > 0), // Crocs requires Boa, Sunglasses, Baseball Cap, Swimsuit Top and Swimsuit Briefs 
            "GoldenLama:: You must buy the previous items!"
        );

        // Update the corresponding timestamp
        if (_itemType == 18) {
            userItems.timestampOfBoa = block.timestamp;
        } else if (_itemType == 19) {
            userItems.timestampOfSunglasses = block.timestamp;
        } else if (_itemType == 20) {
            userItems.timestampOfBaseballCap = block.timestamp;
        } else if (_itemType == 21) {
            userItems.timestampOfSwimsuitTop = block.timestamp;
        } else if (_itemType == 22) {
            userItems.timestampOfSwimsuitBriefs = block.timestamp;
        } else {
            userItems.timestampOfCrocs = block.timestamp;
            userItems.allItemsBought = true;
        }

        emit LevelFourItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function purchaselevelFiveItem(uint8 _itemType) external {
        require(block.timestamp > startTimestamp + 41 days, "GoldenLama:: Fifth line items are not available yet!");
        require(userInfo[msg.sender].balanceOfCocktail >= prices[_itemType], "GoldenLama:: Insufficient balance for buying Level 5 item!");
        require(levelOneItemInfo[msg.sender].allItemsBought == true && levelTwoItemInfo[msg.sender].allItemsBought == true && levelThreeItemInfo[msg.sender].allItemsBought == true && levelFourItemInfo[msg.sender].allItemsBought == true, "GoldenLama:: First you need to buy items in the previous lines!");
       
        LevelFiveItemInfo storage userItems = levelFiveItemInfo[msg.sender];
        _validatelevelFiveItemInfoTypes(_itemType);
        userInfo[msg.sender].balanceOfCocktail -= prices[_itemType];

        require(userItems.allItemsBought == false, "GoldenLama:: Item already purchased!");
        require(
            (_itemType == 24) || //  Flamingo Ring is always allowed
            (_itemType == 25 && userItems.timestampOfFlamingoRing > 0) || // Drink requires  Flamingo Ring
            (_itemType == 26 && userItems.timestampOfFlamingoRing > 0 && userItems.timestampOfDrink > 0) || // Golden Color Cap requires  Flamingo Ring and Drink 
            (_itemType == 27 && userItems.timestampOfFlamingoRing > 0 && userItems.timestampOfDrink > 0 && userItems.timestampOfGoldenColor > 0) || // Swimsuit Top requires  Flamingo Ring, Drink and Golden Color Cap
            (_itemType == 28 && userItems.timestampOfFlamingoRing > 0 && userItems.timestampOfDrink > 0 && userItems.timestampOfGoldenColor > 0 && userItems.timestampOfSmartWatch > 0) || // Smartphone requires  Flamingo Ring, Drink, Golden Color Cap and Swimsuit Top
            (_itemType == 29 && userItems.timestampOfFlamingoRing > 0 && userItems.timestampOfDrink > 0 && userItems.timestampOfGoldenColor > 0 && userItems.timestampOfSmartWatch > 0 && userItems.timestampOfSmartphone > 0), // Yacht requires  Flamingo Ring, Drink, Golden Color Cap, Swimsuit Top and Smartphone 
            "GoldenLama:: You must buy the previous items!"
        );

        // Update the corresponding timestamp
        if(_itemType == 24){
            userItems.timestampOfFlamingoRing = block.timestamp;
        } else if(_itemType == 25) {
            userItems.timestampOfDrink = block.timestamp;
        } else if(_itemType == 26) {
            userItems.timestampOfGoldenColor = block.timestamp;
        } else if(_itemType == 27) {
            userItems.timestampOfSmartWatch = block.timestamp;
        } else if(_itemType == 28) {
            userItems.timestampOfSmartphone = block.timestamp;
        } else {
            userItems.timestampOfYacht = block.timestamp;
            userItems.allItemsBought = true;
        }

        emit LevelFiveItemPurchased(msg.sender, _itemType, block.timestamp);
    }

    function claim() external {
        UserInfo storage user = userInfo[msg.sender];
        LevelOneItemInfo storage levelOneItems = levelOneItemInfo[msg.sender];
        LevelTwoItemInfo storage levelTwoItems = levelTwoItemInfo[msg.sender];
        LevelThreeItemInfo storage levelThreeItems = levelThreeItemInfo[msg.sender];
        LevelFourItemInfo storage levelFourItems = levelFourItemInfo[msg.sender];
        LevelFiveItemInfo storage levelFiveItems = levelFiveItemInfo[msg.sender];

        if(block.timestamp + 1 days > levelOneItems.timestampOfSand) {
            levelOneItems.timestampOfSand = block.timestamp;
            user.profitDept += SAND_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelOneItems.timestampOfSky) {
            levelOneItems.timestampOfSky = block.timestamp;
            user.profitDept += SKY_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelOneItems.timestampOfSea) {
            levelOneItems.timestampOfSea = block.timestamp;
            user.profitDept += SEA_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelOneItems.timestampOfCloud) {
            levelOneItems.timestampOfCloud = block.timestamp;
            user.profitDept += CLOUD_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelOneItems.timestampOfSun) {
            levelOneItems.timestampOfSun = block.timestamp;
            user.profitDept += SUN_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelOneItems.timestampOfGull) {
            levelOneItems.timestampOfGull = block.timestamp;
            user.profitDept += GULL_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelTwoItems.timestampOfPalm) {
            levelTwoItems.timestampOfPalm = block.timestamp;
            user.profitDept += PALM_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelTwoItems.timestampOfCoconuts) {
            levelTwoItems.timestampOfCoconuts = block.timestamp;
            user.profitDept += COCONUTS_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelTwoItems.timestampOfGoldFish) {
            levelTwoItems.timestampOfGoldFish = block.timestamp;
            user.profitDept += GOLD_FISH_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelTwoItems.timestampOfCrab) {
            levelTwoItems.timestampOfCrab = block.timestamp;
            user.profitDept += CRAB_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelTwoItems.timestampOfShells) {
            levelTwoItems.timestampOfShells = block.timestamp;
            user.profitDept += SHELLS_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelTwoItems.timestampOfColoredStones) {
            levelTwoItems.timestampOfColoredStones = block.timestamp;
            user.profitDept += COLORED_STONES_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItems.timestampOfSandCastel) {
            levelThreeItems.timestampOfSandCastel = block.timestamp;
            user.profitDept += SAND_CASTEL_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItems.timestampOfChaiseLounge) {
            levelThreeItems.timestampOfChaiseLounge = block.timestamp;
            user.profitDept += CHAISE_LOUNGE_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItems.timestampOfTowel) {
            levelThreeItems.timestampOfTowel = block.timestamp;
            user.profitDept += TOWEL_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItems.timestampOfSuncreen) {
            levelThreeItems.timestampOfSuncreen = block.timestamp;
            user.profitDept += SUNSCREEN_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItems.timestampOfBasket) {
            levelThreeItems.timestampOfBasket = block.timestamp;
            user.profitDept += BASKET_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelThreeItems.timestampOfUmbrella) {
            levelThreeItems.timestampOfUmbrella = block.timestamp;
            user.profitDept += UMBRELLA_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItems.timestampOfBoa) {
            levelFourItems.timestampOfBoa = block.timestamp;
            user.profitDept += BOA_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItems.timestampOfSunglasses) {
            levelFourItems.timestampOfSunglasses = block.timestamp;
            user.profitDept += SUNGLASSES_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItems.timestampOfBaseballCap) {
            levelFourItems.timestampOfBaseballCap = block.timestamp;
            user.profitDept += BASEBALL_CAP_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItems.timestampOfSwimsuitTop) {
            levelFourItems.timestampOfSwimsuitTop = block.timestamp;
            user.profitDept += SWIMSUIT_TOP_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItems.timestampOfSwimsuitBriefs) {
            levelFourItems.timestampOfSwimsuitBriefs = block.timestamp;
            user.profitDept += SWIMSUIT_BRIEFS_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFourItems.timestampOfCrocs) {
            levelFourItems.timestampOfCrocs = block.timestamp;
            user.profitDept += CROCS_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItems.timestampOfFlamingoRing) {
            levelFiveItems.timestampOfFlamingoRing = block.timestamp;
            user.profitDept += FLAMINGO_RING_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItems.timestampOfDrink) {
            levelFiveItems.timestampOfDrink = block.timestamp;
            user.profitDept += DRINK_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItems.timestampOfGoldenColor) {
            levelFiveItems.timestampOfGoldenColor = block.timestamp;
            user.profitDept += GOLDEN_COLOR_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItems.timestampOfSmartWatch) {
            levelFiveItems.timestampOfSmartWatch = block.timestamp;
            user.profitDept += SMART_WATCH_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItems.timestampOfSmartphone) {
            levelFiveItems.timestampOfSmartphone = block.timestamp;
            user.profitDept += SMARTPHONE_DAILY_PROFIT;
        }
        if(block.timestamp + 1 days > levelFiveItems.timestampOfYacht) {
            levelFiveItems.timestampOfYacht = block.timestamp;
            user.profitDept += YACHT_DAILY_PROFIT;
        }
    }

    function _setPrices(uint32[30] memory _prices) private {
        prices = _prices;
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