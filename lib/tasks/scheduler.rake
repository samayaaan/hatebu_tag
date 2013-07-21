# encoding: utf-8
#https://devcenter.heroku.com/articles/scheduler#defining-tasks
require 'rexml/document'
require 'open-uri'
require 'json'
require 'cgi'

PROCESS_SIZE = 200
PARSE_WAIT_SEC = 0.5


# カテゴリとRSSの組み合わせhash
hatenaCategoryRssHash =
    {'it' => 'http://b.hatena.ne.jp/entrylist/it?sort=hot&threshold=3&mode=rss',
     'economics' => 'http://b.hatena.ne.jp/entrylist/economics?sort=hot&threshold=3&mode=rss'}


namespace :timey do
  task :hatebu_tag => [ :environment ] do
    categoryTagHash = getHatenaCategoryTagHash(hatenaCategoryRssHash)
    puts categoryTagHash
    categoryTagHash.to_a.each do |categoryTagArray|
      categoryTagArray[1].each do |tag|
        #hatebuTagHash = {"tag" => tag, "category" => categoryTagHash[0]}
        puts 'a'
        #HatebuTag.new(hatebuTagHash).save
        tagModel = HatebuTag.new
        puts 'c'
        tagModel.category = categoryTagArray[0]
        puts 'd'
        tagModel.tag = tag
        puts 'e'

        tagModel.save
      end
    end

  end
end

private


# 記事URLに含まれるタグ一覧を取得
def getHatenaTag(articleUrl)
  resultTagArray = []
  openHatenaApiResp = open('http://b.hatena.ne.jp/entry/jsonlite/?url=' + CGI.escape(articleUrl)).read
  jsonHash = JSON.parser.new(openHatenaApiResp).parse()
  if jsonHash['bookmarks'] != nil then
    jsonHash['bookmarks'].each do |bookmark|
      #puts bookmark['tags']
      resultTagArray += bookmark['tags']
    end
  end

  return resultTagArray
end



## xml parse
# はてなのRSSから記事URLを取得
def getHatenaArticleUrl(hatenaRssUrl)
  openRssResp = open(hatenaRssUrl).read
  doc = REXML::Document.new(openRssResp)

  articleUrlArray = []
  doc.elements.each('rdf:RDF/item') do |element|
    #puts element.attributes['rdf:about']
    articleUrlArray.push(element.attributes['rdf:about'])
  end

  return articleUrlArray
end


# はてなのRSSをもとに、カテゴリとタグの対応一覧を取得
def getHatenaCategoryTagHash(hatenaCategoryRssHash)
  categoryTagHash = Hash::new

  hatenaCategoryRssHash.to_a.each do |hatenaCategoryRss|
    # RSSから記事一覧取得
    puts 'processing... : ' + hatenaCategoryRss[0]
    articleUrlArray = getHatenaArticleUrl(hatenaCategoryRss[1])

    # 記事一覧に含まれるタグ一覧を取得
    tagArray = []
    i = 1
    articleUrlArray.each do |articleUrl|
      tagArray += getHatenaTag(articleUrl)
      if i == 3 then
        break
      end
      i += 1
    end

    categoryTagHash[hatenaCategoryRss[0]] = tagArray

  end

  return categoryTagHash
end

