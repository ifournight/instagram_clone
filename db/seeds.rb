# Users
User.create(
  [
    # ifournight
    { name: 'ifournight',
      email: 'ifournight@gmail.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.zone.now, sign_in_count: 0 },
    # moerlang_cat
    { name: 'moerlang_cat',
      email: 'moerlangcat@gmail.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.zone.now, sign_in_count: 0 },
    # russy_jin
    { name: 'russy_jin',
      email: 'russy_jin@gmail.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.zone.now, sign_in_count: 0 },
    # playstation
    { name: 'playstation',
      email: 'playstation@gmail.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.zone.now, sign_in_count: 0 }
  ]
)

# FollowActions
ifournight = User.find_by(name: 'ifournight')
moerlang_cat = User.find_by(name: 'moerlang_cat')

User.all.each do |user|
  ifournight.follow(user) if ifournight.id != user.id
end

moerlang_cat.follow(ifournight)

# Posts
Post.create(
  [
    # ifournight's posts
    { content: 'Rapidly growing city #chengdu #home #chengducity',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/16122825_378405132523412_8803285632139919360_n.jpg',
      created_at: 7.weeks.ago },
    { content: 'No turning back',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/s750x750/sh0.08/e35/15803108_1499861153377057_4605947559867842560_n.jpg',
      created_at: 10.weeks.ago },
    { content: '毕棚沟 1.1.2017 #追溯2016 #MyTripin2016',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15623780_925919517539275_2125770827382128640_n.jpg',
      created_at: 10.weeks.ago },
    { content: '龙苍沟 12.11.2016 #追溯2016 #MyTripin2016',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15803642_1850930935196344_5179446322335318016_n.jpg',
      created_at: 10.weeks.ago },
    { content: '蒙顶山 #追溯2016 #MyTripin2016',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15802490_244648345966892_5136853513912975360_n.jpg',
      created_at: 10.weeks.ago },
    { content: '青城山 11.26.2016 #追溯2016 #MyTripin2016',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15803677_360743134289867_3681712980505919488_n.jpg',
      created_at: 10.weeks.ago },
    { content: 'Back to campus at night #sichuanuniversity #westchinahospitalofsichuanuniversity',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15538872_590540454469974_6027772414211915776_n.jpg',
      created_at: 12.weeks.ago },
    { content: '天府软件园G区 #chengducity #softwarepark #tianfusoftwarepark',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15535177_349878138714762_3471009693214703616_n.jpg',
      created_at: 13.weeks.ago },
    { content: '#2016bestnine',
      user_id: User.find_by(name: 'ifournight').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15253201_1177507442342613_926963013171281920_n.jpg',
      created_at: 14.weeks.ago },

    # moerlang_cat's posts
    { content: '太好笑!',
      user_id: User.find_by(name: 'moerlang_cat').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/17265654_1415729221812043_5404299168929808384_n.jpg',
      created_at: 4.days.ago },
    { content: '👌',
      user_id: User.find_by(name: 'moerlang_cat').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/17125800_400683286973414_5767329162205331456_n.jpg',
      created_at: 5.days.ago },
    { content: '👌',
      user_id: User.find_by(name: 'moerlang_cat').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/16228784_687912014723535_7427603389573234688_n.jpg',
      created_at: 7.weeks.ago },
    { content: 'he brave and beloved one.Wish you will march the plains and explore the mountains waiting ahead of you and I.#cat #ネコ #americanshorthair',
      user_id: User.find_by(name: 'moerlang_cat').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15875675_1191811817580759_2935582444276940800_n.jpg',
      created_at: 10.days.ago },
    { content: 'Merry Christmas！#猫 #ネコ #cat',
      user_id: User.find_by(name: 'moerlang_cat').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/15625113_1373434149355842_3535641280207912960_n.jpg',
      created_at: 11.weeks.ago },

    # russy_jin  
    { content: '#yesterday for #zarahome #phonto by @albertopoloianez',
      user_id: User.find_by(name: 'russy_jin').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/17126879_302173823533122_5906172093241753600_n.jpg',
      created_at: 7.hours.ago },
    { content: '#working #colour #makeup by @estherzaragozamakeup',
      user_id: User.find_by(name: 'russy_jin').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/s750x750/sh0.08/e35/17265871_787816781367910_4692833799078150144_n.jpg',
      created_at: 9.hours.ago },
    { content: '#seeyounexttime #zarahome photo by @albertopoloianez',
      user_id: User.find_by(name: 'russy_jin').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/17267354_602457369964139_9050956003595517952_n.jpg',
      created_at: 1.day.ago },
    { content: '#luchtime #work #niceday',
      user_id: User.find_by(name: 'russy_jin').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/16228907_805856156249613_7223592554682384384_n.jpg',
      created_at: 2.weeks.ago },

    # playstation's posts
    { content: "We got the limited edition Death Stranding vinyl, and now you can too. It's back in stock at @mondotees.",
      user_id: User.find_by(name: 'playstation').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/s1080x1080/e35/17267356_427615037586157_6813674317537083392_n.jpg',
      created_at: 9.weeks.ago },
    { content: 'We just unboxed a Nomad from Mass Effect: Andromeda. Join us in our IG Story!',
      user_id: User.find_by(name: 'playstation').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/17265433_776360592513396_6776588202649059328_n.jpg',
      created_at: 1.day.ago },
    { content: 'We just did a full unboxing of the Nier Automata Black Box Edition in our Instagram Story. Enjoy!',
      user_id: User.find_by(name: 'playstation').id,
      remote_picture_url: 'We just did a full unboxing of the Nier Automata Black Box Edition in our Instagram Story. Enjoy!',
      created_at: 5.days.ago },
    { content: "The Art of #HorizonZeroDawn book (in both standard and Limited Editions) offers insight into the game's world and lore with over 300 illustrations plus in-depth commentary from @guerrillagames - swipe left for a sample. #PS4",
      user_id: User.find_by(name: 'playstation').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/s480x480/e35/17077215_888861207920526_3166405269643067392_n.jpg',
      created_at: 6.days.ago },
    { content: "A closer look at the gorgeous #HorizonZeroDawn steelbook case that comes with the Limited and Collector's Edition, released 28th February in North America and 1st March in Europe.",
      user_id: User.find_by(name: 'playstation').id,
      remote_picture_url: 'http://scontent-cdg2-1.cdninstagram.com/t51.2885-15/e35/16906997_436153840078567_7917556916350353408_n.jpg',
      created_at: 3.weeks.ago }
  ]
)