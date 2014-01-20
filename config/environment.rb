# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Utour::Application.initialize!

WECHAT_TOKEN = "weixin"

LEGACY = 
'
{
	"index": "0",
  "h": "微信主页",
  "render": "tile",
  "contents": [
    {
      "index": "0",
      "h": "团队行程",
      "image": "legacy/icons/icon_1.png",
      "render": "block",
      "contents": [
        {
          "index": "0",
          "h": "亚洲行程",
          "image": "legacy/sample_block.jpeg",
          "render": "block",
          "contents": [
            {
              "index": "0",
              "h": "日本在售线路",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "日本夜航东京大阪7天6晚",
                  "p": "精选港龙航空，停留香港旅程更丰富，尽享东瀛别样风情......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": ["legacy/sample_tour.jpg","legacy/sample_tour.jpg"]
                },
                {
                  "index": "1",
                  "h": "日本安心东阪6天4夜",
                  "p": "在古寺与繁华的商业街中穿梭，象山传统文化与现代魅力的碰撞",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "1",
              "h": "韩国在售线路",
              "image": "legacy/sample_block.jpeg",
              "render": "block",
              "contents": [
                {
                  "index": "0",
                  "h": "首尔济州4晚6天",
                  "p": "超人气泰迪熊博物馆、泡菜学校、天地渊瀑布、尽享韩式风情......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "济州一地4晚6天",
                  "p": "唯美爱情圣地，体会人文与自然的完美结合，特色景点，玩转济州岛......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "2",
                  "h": "首尔济州亲子5天3夜",
                  "p": "带上家人孩子一起游览可爱的泰迪熊博物馆，在3D美术馆一边游玩一边学习......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "3",
                  "h": "济州一地亲子5天3夜",
                  "p": "带上家人孩子寻找韩剧里的浪漫风景......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "4",
                  "h": "济州一地5天3夜",
                  "p": "带上你自己的故事，从另一个角度感受不一样的韩国......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "5",
                  "h": "首尔济州5天3夜",
                  "p": "欣赏舌尖上得韩文化，游览可爱的泰迪熊博物馆......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "2",
              "h": "泰国在售线路",
              "image": "legacy/sample_block.jpeg",
              "render": "block",
              "contents": [
                {
                  "index": "0",
                  "h": "金牌普吉一地6日",
                  "p": "全程泰式精品酒店、2晚海边酒店或同级，赠送人妖秀......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            }
          ]
        },
        {
          "index": "1",
          "h": "欧洲行程",
          "image": "legacy/sample_block.jpeg",
          "render": "block",
          "contents": [
            {
              "index": "0",
              "h": "德法瑞意",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "德法瑞意4国11天 欧洲浪漫之巅",
                  "p": "罗浮宫+多哈半日游......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "德法瑞意4国12天",
                  "p": "新天鹅堡+瓦杜兹+卢浮宫门票......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "2",
                  "h": "德法瑞意4国12天",
                  "p": "法拉利火车+罗浮宫门票......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "3",
                  "h": "德法瑞意4国11天",
                  "p": "经典四国+卢浮宫门票......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "4",
                  "h": "德法瑞意4国13天 欧洲浪漫之巅",
                  "p": "瓦杜兹+童话城堡新天鹅堡+多哈半日游......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "1",
              "h": "一国深度",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "英国+爱尔兰10天 世界遗产之旅",
                  "p": "湖区+爱丁堡+巨人堤+牛津剑桥圣三一......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "英国+爱尔兰10天 世界遗产之旅",
                  "p": "湖区+爱丁堡+巨人堤+牛津剑桥圣三+利物浦",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "2",
              "h": "纵览欧洲",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "法瑞意德奥梵 6国13天",
                  "p": "欧洲多国纵览+卢浮宫门票",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "荷法瑞意德奥比梵8国14天-15天",
                  "p": "欧洲多国纵览+卢浮宫门票",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "2",
                  "h": "荷法瑞意德奥比梵8国14天-15天",
                  "p": "库肯霍夫公园赏花+卢浮宫门票",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "3",
                  "h": "荷法瑞意德奥比梵8国15天",
                  "p": "库肯霍夫公园赏花+杜哈半日游",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "3",
              "h": "法意瑞",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "优品法瑞意之法瑞意+荷兰11日",
                  "p": "价值380欧特色餐食于景点大赠送......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "法瑞意3国10天",
                  "p": "经典三国+卢浮宫门票",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "2",
                  "h": "法瑞意荷4国11天",
                  "p": "库肯霍夫公园+卢浮宫门票",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "3",
                  "h": "法瑞意3国10天",
                  "p": "杜哈半日游+卢浮宫门票",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "4",
                  "h": "金牌 法瑞意13日",
                  "p": "美食盛宴 &金色山口+TGV 双火车体验& 瑞士名山雪朗峰......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "5",
                  "h": "金牌法瑞意+荷兰12日",
                  "p": "美食盛宴 &鲜花之旅 &金色山口+高速双火车体验 &瑞士名山冰川3000 &游船体验......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            }
          ]
        },
        {
          "index": "2",
          "h": "美洲行程",
          "image": "legacy/sample_block.jpeg",
          "render": "block",
          "contents": [
            {
              "index": "0",
              "h": "美国东西海岸",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "美国东西海岸夏威夷14日",
                  "p": "搭乘国航，夏威夷入境、纽约出境......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "美国东西海岸夏威夷15日",
                  "p": "特有拉斯维加斯3晚停留的行程安排，充足......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "2",
                  "h": "美国东西海岸夏11日",
                  "p": "搭乘国航,探寻好莱坞影片背后的秘密......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "3",
                  "h": "美国东西海岸夏12日",
                  "p": "畅游世界最大的电影制片厂环球影城......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "1",
              "h": "美国双人乐园",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "美国双城奇幻乐购9日",
                  "p": "国航直飞，加州冒险乐园+迪斯尼乐园......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "双乐园品质安心14日",
                  "p": "一次畅游美国6大名城，全日造访好莱坞......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "2",
              "h": "夏威夷半自由行",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "夏威夷半自由行5晚8日",
                  "p": "特别赠送前往夏威夷著名的......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "夏威夷半自由行4晚7日",
                  "p": "特别赠送珍珠港以及市区观光小环岛精华游......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "3",
              "h": "美国大城小镇",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "沿太平洋加州9日",
                  "p": "旧金山入境，感受加州丰富的文化遗产......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "墨西哥德克萨斯13日",
                  "p": "搭乘中国国际航空公司豪华客机直飞美国第四大城市......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "2",
                  "h": "美国三城品质10日游",
                  "p": "畅游美国三大经典城市......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "3",
                  "h": "德克萨斯美国德州8日",
                  "p": "国航直飞，独家经休斯顿进入美国境内......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            }
          ]
        },
        {
          "index": "3",
          "h": "澳新行程",
          "image": "legacy/sample_block.jpeg",
          "render": "block",
          "contents": [
            {
              "index": "0",
              "h": "新西兰在售行程",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "新西兰南北岛深度10日游",
                  "p": "纯净天地，深度10日游......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "1",
              "h": "澳新凯在售行程",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "金牌澳新凯9日",
                  "p": "悉尼歌剧院入内参观，乘坐豪华游艇出海......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "澳新凯12日【含墨尔本】",
                  "p": "特别安排在悉尼游船上享用美味三道西式晚餐，全程......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "2",
                  "h": "澳新凯大堡礁12日【布入】",
                  "p": "四星级酒店内带海鲜自足晚餐......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "3",
                  "h": "澳新凯大堡礁【凯入】",
                  "p": "前往绿岛大堡礁，新西兰特色毛利歌舞表演......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "2",
              "h": "澳大利亚在售行程",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "澳大利亚一地7日游",
                  "p": "乘船畅游悉尼港，情人港，邂逅海豚岛......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            },
            {
              "index": "3",
              "h": "澳新在售行程",
              "image": "legacy/sample_block.jpeg",
              "render": "list",
              "contents": [
                {
                  "index": "0",
                  "h": "澳新海豚岛12日【墨入】",
                  "p": "绝代双礁，恋恋海豚岛，库兰达热带雨林......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "1",
                  "h": "澳新10日游【墨入】",
                  "p": "一日畅游绿岛大堡礁以及诺曼外堡礁......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "2",
                  "h": "澳新10日游【悉入】",
                  "p": "搭乘东航，全程酒店为当地四五星级标准......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                },
                {
                  "index": "3",
                  "h": "景点澳新12日",
                  "p": "隆重推出翠儿河捉泥蟹之旅......",
                  "image": "legacy/sample_block.jpeg",
                  "render": "image",
                  "contents": [""]
                }
              ]
            }
          ]
        },
        {
          "index": "4",
          "h": "非洲行程",
          "image": "legacy/sample_block.jpeg",
          "render": "list",
          "contents": [
            {
              "index": "0",
              "h": "花园大道 南非10日",
              "p": "非洲花园大道，自然的召唤，南非10日......",
              "image": "legacy/sample_block.jpeg",
              "render": "image",
              "contents": [""]
            }
          ]
        }
      ]
    },
    {
      "index": "1",
      "h": "自由行程",
      "image": "legacy/icons/icon_2.png",
      "render": "block",
      "contents": []
    },
    {
      "index": "2",
      "h": "推荐专区",
      "image": "legacy/icons/icon_3.png",
      "render": "block",
      "contents": []
    },
    {
      "index": "3",
      "h": "签证资料",
      "image": "legacy/icons/icon_4.png",
      "render": "block",
      "contents": []
    },
    {
      "index": "4",
      "h": "我的订单",
      "image": "legacy/icons/icon_5.png",
      "render": "block",
      "contents": []
    },
    {
      "index": "5",
      "h": "团队状态",
      "image": "legacy/icons/icon_6.png",
      "render": "block",
      "contents": []
    },
    {
      "index": "6",
      "h": "出团说明视频",
      "image": "legacy/icons/icon_7.png",
      "render": "block",
      "contents": []
    },
    {
      "index": "7",
      "h": "出行攻略",
      "image": "legacy/icons/icon_8.png",
      "render": "block",
      "contents": []
    }
  ]
}
'