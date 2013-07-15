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
  task :hatebu_tag do
    categoryTagHash = getHatenaCategoryTagHash(hatenaCategoryRssHash)
    puts categoryTagHash
  end
end

private


# 記事URLに含まれるタグ一覧を取得
def getHatenaTag(articleUrl)
  resultTagArray = []
  openHatenaApiResp = open('http://b.hatena.ne.jp/entry/jsonlite/?url=' + CGI.escape(articleUrl)).read
  jsonHash = JSON.parser.new(openHatenaApiResp).parse()

  jsonHash['bookmarks'].each do |bookmark|
    #puts bookmark['tags']
    resultTagArray += bookmark['tags']
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
    articleUrlArray.each do |articleUrl|
      tagArray += getHatenaTag(articleUrl)

      break
    end

    categoryTagHash[hatenaCategoryRss[0]] = tagArray

  end

  return categoryTagHash
end

