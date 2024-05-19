/*
Q4 - Assume all method calls work fine. Fix the memory leak issue in below method

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}
*/



/*
player remains unused and allocated if the program fails to load any player. In case the load fails, we should delete player to free up the memory.
*/
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool createNewPlayer = false;
    if (!player) {
        player = new Player(nullptr);
        createNewPlayer = true;
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete(player);
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if(createNewPlayer){
            delete(player);
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
    //Regardless of whether the player is still online or not, if we created a new instance of player using new Player(), we should free the memory as the player will not be referenced from that memory once we go out of scope.
    if(createNewPlayer){
        delete(player)
    }
}
