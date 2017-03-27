# INSTAGRAM CLONE README
An Instagram clone using Rails. View more feature, roadmap at [Trello](https://trello.com/b/ePAo0rAo/instagram-clone).

## Usage
Recommend just see the [deployed version](http://ifournight-instagram-clone.herokuapp.com).

Use the test account:

```
User: ifournight@gmail.com
Password: password
```

You can clone the repo, and use command lines listed below to view this project:

```
cd REPO_PATH
bundle install
rails db:migrate
rails db:seed
rails server
```

If you don't have ruby and rails installed on your local machine, or you just don't want run it locally, just visit the [deployed version](http://ifournight-instagram-clone.herokuapp.com).

## Disclaimer
This project is only for personal exercise and Dev ability showcase. All designs, seed datas are copied from Instagram and won't be used for any commercial purposes.

## Feature list
Feature list change rapidly, see the lasted at [this card](https://trello.com/c/amX5StnK)
### Done
- Try to clone Instagram style
- User sign up, sign in, sign out, email confirmation, password recover, change, powered by [Devise](https://github.com/plataformatec/devise)
- Post feeds, user page, user follower/ followering page
- Follow user, like post
- Comment post
- Pictures uploaded to AWS S3 via CarrierWave
- Home page/ user page pagination (infinite-paging) using [Kaminari](https://github.com/kaminari/kaminari)
- 2 versions of locale: en/ zh-CH

### Not Done
- React/ Flux as front-end
- Async mailer
- Responsive design (Not done yet)
- Detailed post view (Not done yet)
- Post tags (Not done yet)
- User/ following Activity feeds
- Explore
- Search, maybe using [Elastic](https://www.elastic.co)?

## What I learn from this building this product
### Ruby and Rails
#### 进一步熟悉Rails
这是我第一次独立用Rails写项目，之前跟着教程写过两个Rails的项目，Rails Guide也都看过一遍了，但是这个项目还是让我学到了很多，对Rails有了进一步的熟悉，下面列举一些细节：

	* 简单Relation的ActiveModel设计(User, Post, Comment, Like, Follow)
	* 对Rails的MVC有了进一步的理解
	* Rails routes进一步学习，为了模拟Instagram的路由，写了很多非RESTFul风格的自定义routes
	* 对于要求用户登录这样的权限验证，利用Controller的Callback的继承机制来制定白名单
	* 	对Rails自带的helper运用更加娴熟，比如各种path_helper, view_helper (form_for, form_tag)
	* 即使我的User, Post引入Devise，CarrierWave的情况下，还是可以写Seed Data
	* 对Rails的生态圈进一步熟悉，知道了responder, http_accept_language, I18n等插件或Gem。
	* Rails安全相关入门
	* 学会了如何做国际化和本地化

#### 引入Rails插件
特别要提一下的是这次的Gem中用到了Devise。之前跟这[RailsTutorial](https://www.railstutorial.org)是实现过简易用户Authentic的，对其背后的一些安全问题有了一定的了解。这次在阅读Rails安全指南后，觉得就用户Authentic来说，需要涵盖到很多问题。

秉承着DRY原则，也因为是带着尽量按照一个成熟的商业项目来打磨这一目标，选择了引入Devise。

第一次使用了比较大型的Rails插件，在这个过程中，学习到了：
	* Devise是如何通过写`-able`的module的方式把各种功能引入到ActiveRecord里来的。
	* 文档再齐全，不如看源码和调试：
		* 对debugger越来越熟悉：`next`, `up`, `down`, `continue`, `break`，通过阅读源码来学习
		* 发现Devise的Test就是很好的文档，认同Test As Documents的观点，这一点在现在看的[Testing rails](http://testingrailsbook.com)也得到了证实。
		* 学习了不依赖fixtures，通过写Generator来动态生成测试数据。

### How to write CSS in 2017

项目中CSS的介绍：

1. 选择了[inuitCSS](https://github.com/inuitcss/inuitcss)这样不提供具体Components, 只提供基础搭建的Framework, 而没有选择象Bootstrap这样的UI Framework 。因为希望自己能够继续学习CSS。
2. 在[inuitCSS](https://github.com/inuitcss/inuitcss)的基础上，已CSSGuide, OOCSS为指导思路，BEM为命名规则，自己书写了全部样式。

收获和思考：

* 熟悉了 inuitCSS 以及任何一个CSS Framework都需要有的模块: setting, reset, normalize, utilities, layout等
* 理解了 inuitCSS 里为什么要设置`$global-font-size`, `$global-line-height`, `$global-spacing-unit`以及几个层级的Variant。这几个关键的变量决定了整个网页的排版。
* CSS在Appearance层面还是不错的，在Layout层面有太多糟粕了, 全面拥抱对现代Web App更友好的Flexbox
* 虽然有着Reusable, generable objects/ components这样OOCSS的思想为指导，且采用了BEM命名规则，在实际使用中，还是有些混乱，后来思考了一下原因：
	1. 光有理论，但是实践太少，面对一个设计/页面，抽象出一些高度重复使用的Objects的能力太差，比如看一眼就知道是一个 `menu`, `form—-vertical`, `navbar`; 还有一些明知道高度重复可用，就是不知道该怎么命名。
	2. 什么属性应该放在App specific component里，什么应该放在Reusable components里，非常的纠结。
* 因为用目前的这套思路，有的html标签有太多的class，再考虑到引入Responsive design后，`@media-query`只能写在CSS里，可能会尝试以后在自己的CSS Framework里，将所有Reusable Objects/ Components 同时也写成`@mixin`。在CSS端进行composite。

### TDD
这次没有采用TDD，甚至在写下当前版本的README时，Test的覆盖率根本不完全。
我希望自己能够以TDD的思路来开发产品，也不想为没有写Test推脱找接口。

不过认真分析了一下，最后Test这块缺失的原因主要是：

* 我给这个项目制定了比较严格的时间表，但在实际开发中，很多简单的功能所花费的实践都超过了我的预期，别说test，有一些之前规划的feature也没有实现。我选择了先把优先级更高的feature给完成。
* 写Test时我遇到了很多困难，很多时候一个功能实际上是完成了，但是Test本身有很多bug，就是pass不了，耗费了太多的开发时间，当然这是我本身的娴熟程度造成的。
* 很多时候我不知道该怎么写Test，虽然之前了2个教程[RailsTutorial](https://www.railstutorial.org)，[Agile Web development by Rails 5](https://pragprog.com/book/rails5/agile-web-development-with-rails-5)都有写Test。但因为没有专门着重笔墨去讲，我也只有**Unit Test**, **Functional Test**, **Integration Test**的概念。但是在写这个项目的时候，发现问题并不简单，比如我就产生了如下一些疑惑：
  * 不能严格的拆分每种Test的分工
  * Devise已经有Test了，那我的User需不需要写UnitTest, Functional Test?
  * 在controller test里到底该写到什么程度，应该验证Response中View的正确性嘛，验证到什么样的粒度？
  * 要写Integration Test, 比如infinite paging，就要引入一些用户输入模拟的Test gem, 比如capybara，需要很多的开发时间
  * 当前的feature我是第一次做，并不知道怎么实现，所以也没有写test的头绪，按照[Testing Rails](https://gumroad.com/l/testing-rails/?utm_campaign=announcement&utm_medium=blog&utm_source=giant-robots)的说法，这属于一个sparks。

针对这种情况，我已经开始学习Thoughtbot的[Testing Rails](https://gumroad.com/l/testing-rails/?utm_campaign=announcement&utm_medium=blog&utm_source=giant-robots)。可能会以TDD来重写这个项目。

### 重构

目前已经做的重构：
  * 用Form Object的模式重构了AccountEdit, PasswordChange，使其更模块化，而不是一股脑塞在Controller里

### Develop a product
开发这个项目给我带来的最可贵的一些经验，不是具体的某个技术，而是开发整个产品的过程：

* 整个过程中不断的有新点子，新技术，delay这些变数。如何权衡优先级，利用笔记软件和trello来规划开发进度和任务，争取在规定时间完成并部署上线
* 收集到的好的文章和技术，Read it later。
* 项目前期我每次Git提交就是一大堆文件，Commit message也写的很随意，在看了这篇文章后。我开始有意识的利用Git commit来拆分大块的feature，并且用心写Commit，为了以后的可维护性，也为了慢慢锻炼自己作为一个Colaborator的基本素质
* 利用Rubocop和CodeClimate来做代码风格和质量的检查

## Statistic
All：2 weeks 3days

Front-End：3.5 days
