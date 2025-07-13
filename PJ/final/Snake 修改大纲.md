# Snake 修改大纲

* ==PDF限制任务==
* ==加速操作 ---> 增大单位时间移动距离==
* ==吃donut才加速，可以加速的次数和吃掉donut个数相同（每次加速3s）（不能增加长度）占比5%==
* ==吃掉炸弹身体会被炸毁4；如果当前身体长度小于4，则游戏结束 占比 5%==
* ==apple score=1 占比25%；pear score=2 占比17%；peach score=3 占比13%；strawberry score=4 占比10%；avocado score=5 占比5%==
* ==bad-mushroom score=0 占比10%；bad-potato score=0 占比10%；==
* ==击杀操作 ---> 检测头部是否触碰身体（取消自身触碰）==
* ==随运动掉血（变短）==
* ==炸弹 ---> 躲避，炸毁部分身体==
* ==变长的同时变粗==
* ==双端口操作 ---> 光标移动SnackMouse and 键盘移动SnackeKeyboard（作为两个延伸类，Snack为其基类）==
* ==蛇随机出现，切换不同颜色：==
  * head_1 first_body 0xc6ffffff second_body 0x57FFFEff
  * head_2 first_body 0xFF9B9DFF second_body 0xFF5758FF
  * head_3 first_body 0x5acb89ff second_body 0x197841ff
  * head_4 first_body 0x\#f3d9c7ff second_body 0xF1B186ff
* ==关闭音乐==
* ==模式切换==



## ==模式==

* 点击开始后，显示一个模式选择页面 ModeScreen，页面有三个按钮，分别是“经典模式”、“对战模式”、“无敌模式”。
* 页面背景图片目录为 Pic/Mode_background.png
*  三个按钮对应的sprite图片目录分别为：
  * 经典模式  Pic/classic_button.png；
  * 对战模式  Pic/battle_button.png；
  * 无敌模式  Pic/invinc_button.png 。

* 三个按钮水平排列在画面正中央，点击后可切换对应模式。
  * 经典模式 
    * 当前程序现有设置与功能即为经典模式
    * 该模式游戏运行时音乐播放为：Music/classic.wav

  * 对战模式 ---> Speed
    * 画面中会出现两条蛇，蛇的style随机，但保证两条蛇的style不相同
    * 游戏开始时，玩家一控制的蛇在出现在画面左侧，玩家二控制的蛇出现在画面右侧
    * 玩家一通过WASD或上下左右键操控蛇的移动，玩家二通过鼠标操控蛇的移动。对应玩家一的加速键为空格，玩家二的加速键为鼠标右键
    * 玩家一和玩家二共享一个Grid地图，其中所有的水果、炸弹、甜甜圈都共享。
    * 所有的吃水果、炸弹、甜甜圈、加速、触碰身体死亡等功能都与现在程序相同。
    * 特别地，增加 “蛇头触碰另一条蛇的身体也会死亡（蛇头对应的玩家死万）"
    * 画面上方的“得分：”换为“玩家一： ” “玩家二： ”，水平排列在正中央，垂直高度与现在相同，分别记录不同玩家的得分
    * 画面左上方的“加速甜甜圈：”换为 “玩家一甜甜圈： ” “玩家二甜甜圈： ” 垂直排列在画面左上角，水平位置和现在相同，分别记录不同玩家的speedUpCount_
    * 游戏结束条件为 “任一玩家死亡”
    * 游戏结束后同样跳转到GameOver界面，同时界面显示的“总分： “替换为”玩家一： “ ”玩家二： “，同样水平展示在同一个垂直高度
    * 该模式游戏运行时音乐播放为：Music/Speed.wav

  * 无敌模式 
    * 该模式基本都与经典模式相同，只更改有关炸弹、身体长度自动缩小、得分自动减少、触碰自身死亡的相关设计
    * 关掉身体长度自动减少、得分自动减小设计设计，即身体长度、半径、得分不随运动时间改变
    * 吃炸弹之后，得分不会减少，也不会增加，身体长度不会减少也不会增加
    * 蛇头触碰到自己的蛇身不会死亡
    * 其他功能都与经典模式相同
    * 该模式游戏运行时音乐播放为：Music/invinc.wav




```cpp
//snakemouse.cpp
#include "element/Snake.h"
#include "Game.h"
#include "screen/GameOverScreen.h"

namespace sfSnake {

const int Snake::InitialSize = 5;

Snake::Snake()
    : hitSelf_(false),
      speedup_(false),
      direction_(Direction(0, -1)),
      nodeRadius_(Game::GlobalVideoMode.width / 100.0f),
      tailOverlap_(0u),
      bodyNode(nodeRadius_),
      score_(InitialSize)
{
    initNodes();

    // 加载头部贴图
    headTexture.loadFromFile("assets/image/snakeHeadImage.png");
    headTexture.setSmooth(true);
    sf::Vector2u TextureSize = headTexture.getSize();
    float headScale = nodeRadius_ / TextureSize.y * 2.6f;
    headSprite.setTexture(headTexture);
    headSprite.setScale(headScale, headScale);
    headSprite.setOrigin(TextureSize.x / 2.f, TextureSize.y / 2.f);

    // 加载音效
    pickupBuffer_.loadFromFile("assets/sounds/pickup.wav");
    pickupSound_.setBuffer(pickupBuffer_);
    pickupSound_.setVolume(30);

    dieBuffer_.loadFromFile("assets/sounds/die.wav");
    dieSound_.setBuffer(dieBuffer_);
    dieSound_.setVolume(50);
}

void Snake::initNodes()
{
    path_.push_back(SnakePathNode(
        Game::GlobalVideoMode.width / 2.0f,
        Game::GlobalVideoMode.height / 2.0f));
    for (int i = 1; i <= 10 * InitialSize; i++)
    {
        path_.push_back(SnakePathNode(
            Game::GlobalVideoMode.width / 2.0f -
                direction_.x * i * nodeRadius_ / 5.0,
            Game::GlobalVideoMode.height / 2.0f -
                direction_.y * i * nodeRadius_ / 5.0));
    }
}

void Snake::handleInput(sf::RenderWindow &window)
{
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up) ||
        sf::Keyboard::isKeyPressed(sf::Keyboard::W))
        direction_ = Direction(0, -1);
    else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down) ||
             sf::Keyboard::isKeyPressed(sf::Keyboard::S))
        direction_ = Direction(0, 1);
    else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left) ||
             sf::Keyboard::isKeyPressed(sf::Keyboard::A))
        direction_ = Direction(-1, 0);
    else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right) ||
             sf::Keyboard::isKeyPressed(sf::Keyboard::D))
        direction_ = Direction(1, 0);

    // 鼠标控制
    if (!Game::mouseButtonLocked)
    {
        if (sf::Mouse::isButtonPressed(sf::Mouse::Left) ||
            sf::Mouse::isButtonPressed(sf::Mouse::Right))
        {
            sf::Vector2i mousePosition = sf::Mouse::getPosition(window);
            sf::Vector2f headPos = toWindow(path_.front());
            direction_ = static_cast<sf::Vector2f>(mousePosition) - headPos;
            float length = std::sqrt(direction_.x * direction_.x + direction_.y * direction_.y);
            direction_ /= length;
        }
    }

    speedup_ = sf::Keyboard::isKeyPressed(sf::Keyboard::Space);
}

void Snake::update(sf::Time delta)
{
    move();
    static int count = 0;
    if (++count >= 40)
    {
        checkOutOfWindow();
        count -= 40;
    }
    checkSelfCollisions();
}

void Snake::checkFruitCollisions(std::deque<Fruit> &fruits)
{
    auto toRemove = fruits.end();
    SnakePathNode headNode = path_.front();
    sf::Vector2f headPos = toWindow(headNode);

    for (auto it = fruits.begin(); it != fruits.end(); ++it)
    {
        float distance = std::sqrt(
            std::pow(headPos.x - it->shape_.getPosition().x, 2) +
            std::pow(headPos.y - it->shape_.getPosition().y, 2));
            
        if (distance < nodeRadius_ + it->shape_.getRadius())
            toRemove = it;
    }

    if (toRemove != fruits.end())
    {
        pickupSound_.play();
        grow(toRemove->score_);
        fruits.erase(toRemove);
    }
}

void Snake::grow(int score)
{
    tailOverlap_ += score * 10;
    score_ += score;
}

void Snake::move()
{
    SnakePathNode &headNode = path_.front();
    int times = speedup_ ? 2 : 1;
    for (int i = 1; i <= times; i++)
    {
        path_.push_front(SnakePathNode(
            headNode.x + direction_.x * i * nodeRadius_ / 5.0,
            headNode.y + direction_.y * i * nodeRadius_ / 5.0));
        if (tailOverlap_)
            tailOverlap_--;
        else
            path_.pop_back();
    }
}

void Snake::render(sf::RenderWindow& window)
{
    // 渲染蛇头
    sf::Vector2f headPos = toWindow(path_.front());
    float angle = std::atan2(direction_.x, -direction_.y) * 180 / 3.14159265359f;
    headSprite.setPosition(headPos);
    headSprite.setRotation(angle);
    window.draw(headSprite);

    // 渲染蛇身
    for (size_t i = 1; i < path_.size(); i += 5) {
        if (i + 1 < path_.size()) {
            sf::Vector2f pos = toWindow(path_[i]);
            sf::Vector2f nextPos = toWindow(path_[i + 1]);
            float angle = std::atan2(nextPos.x - pos.x, -(nextPos.y - pos.y)) * 180 / 3.14159265359f;
            bodyNode.render(window, pos, angle);
        }
    }
}

void Snake::checkSelfCollisions()
{
    SnakePathNode head = toWindow(path_.front());
    int count = 0;

    for (auto i = path_.begin(); i != path_.end(); ++i, ++count)
    {
        if (count >= 30 && 
            std::sqrt(std::pow(head.x - toWindow(*i).x, 2) + 
                     std::pow(head.y - toWindow(*i).y, 2)) < 2.0f * nodeRadius_)
        {
            dieSound_.play();
            sf::sleep(sf::seconds(dieBuffer_.getDuration().asSeconds()));
            hitSelf_ = true;
            break;
        }
    }
}

void Snake::checkOutOfWindow()
{
    auto inWindow = [](SnakePathNode &node) -> bool
    {
        return node.x >= 0 &&
               node.x <= Game::GlobalVideoMode.width &&
               node.y >= 0 &&
               node.y <= Game::GlobalVideoMode.height;
    };

    bool outOfWindow = true;
    for (const auto &node : path_)
    {
        if (inWindow(node))
        {
            outOfWindow = false;
            break;
        }
    }

    if (outOfWindow)
    {
        SnakePathNode &tail = path_.back();
        if (tail.x < 0)
            for (auto &node : path_)
                node.x += Game::GlobalVideoMode.width;
        else if (tail.x > Game::GlobalVideoMode.width)
            for (auto &node : path_)
                node.x -= Game::GlobalVideoMode.width;
        else if (tail.y < 0)
            for (auto &node : path_)
                node.y += Game::GlobalVideoMode.height;
        else if (tail.y > Game::GlobalVideoMode.height)
            for (auto &node : path_)
                node.y -= Game::GlobalVideoMode.height;
    }
}

SnakePathNode Snake::toWindow(SnakePathNode node)
{
    while (node.x < 0)
        node.x += Game::GlobalVideoMode.width;
    while (node.x > Game::GlobalVideoMode.width)
        node.x -= Game::GlobalVideoMode.width;
    while (node.y < 0)
        node.y += Game::GlobalVideoMode.height;
    while (node.y > Game::GlobalVideoMode.height)
        node.y -= Game::GlobalVideoMode.height;
    return node;
}

unsigned Snake::getScore() const
{
    return score_;
}

bool Snake::hitSelf() const
{
    return hitSelf_;
}

} // namespace sfSnake
```

![3414a5f3a5acb497c6ef887e687d284](C:\Users\LENOVO\Documents\WeChat Files\wxid_hk333tei9oqm22\FileStorage\Temp\3414a5f3a5acb497c6ef887e687d284.jpg)

