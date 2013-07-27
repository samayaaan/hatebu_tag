# encoding: utf-8
#https://devcenter.heroku.com/articles/scheduler#defining-tasks
require 'rexml/document'
require 'open-uri'
require 'json'
require 'cgi'

PROCESS_SIZE = 200
PARSE_WAIT_SEC = 0.5


namespace :timey do
  task :hatebu_tag => [ :environment ] do
    hatebuCategories = HatebuCategory.all
    hatebuCategories.each do |hatebuCategory|
      puts 'processing... : ' + hatebuCategory.name
      tagArray = getHatebuTagArray(hatebuCategory)
      #puts tagArray

      tagArray.each do |tag|
        tagModel = HatebuTag.new
        tagModel.name = tag
        tagModel.hatebu_catebory_id = hatebuCategory.id
        tagModel.cnt = 1

        tagModel.save
      end
    end
  end

  task :hatebu_tag_csv => [ :environment ] do

    file = "tag.csv"
    fileWriteStr = ""
    hatebuTags = HatebuTag.all
    hatebuTags.each do |tag|
      fileWriteStr += tag.name + "/n"
    end

    mode = "w"
    open( file , mode ){|f| f.write(fileWriteStr)}

    #file = "test.txt"
    #str = " " + "add str"
    #mode = "a"
    #open( file , mode ){|f| f.write(str)}
  end
end

private


# 記事URLに含まれるタグ一覧を取得
def getHatenaTag(articleUrl, hatebuCategory)
  resultTagArray = []
  openHatenaApiResp = open('http://b.hatena.ne.jp/entry/jsonlite/?url=' + CGI.escape(articleUrl)).read
  jsonHash = JSON.parser.new(openHatenaApiResp).parse()
  if jsonHash['bookmarks'] != nil then
    # すでに取得済みのエントリーであればtagを取得しない
    hatebuEids = HatebuEid.where(:eid => jsonHash['eid'])
    puts "length"
    puts hatebuEids.length
    puts "size"
    puts hatebuEids.size

    if(hatebuEids.length > 0)
      return []
    end

    # 未取得のエントリーなのでeidを登録
    hatebuEid = HatebuEid.new
    hatebuEid.eid = jsonHash['eid']
    hatebuEid.hatebu_category_id = hatebuCategory.id
    hatebuEid.save

    # tagの配列生成
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


# はてなのRSSをもとに、タグ一覧を取得
def getHatebuTagArray(hatebuCategory)

  # RSSから記事一覧取得
  articleUrlArray = getHatenaArticleUrl(hatebuCategory.url)

  # 記事一覧に含まれるタグ一覧を取得
  tagArray = []
  i = 1
  articleUrlArray.each do |articleUrl|
    tagArray += getHatenaTag(articleUrl, hatebuCategory)
    if i == 3 then
      break
    end
    i += 1
  end

  return tagArray
end

