from influenster.items import InfluensterItem, ReviewItem
from scrapy import Spider, Request
from time import sleep

class InfluensterSpider(Spider):

	name = 'influenster'
	allowed_urls = ['https://www.influenster.com']
	start_urls = ['https://www.influenster.com/reviews/shampoo']
	#https://www.influenster.com/reviews/shampoo
	#https://www.influenster.com/reviews/conditioner
	#https://www.influenster.com/reviews/hair-oil

	url_page = 1

	def parse(self, response):
		rank = response.xpath('//div[@class="category-product-ranking"]/text()').extract()
		links = response.xpath('//a[@class="category-product"]/@href').extract()
	
		product_links = map(lambda x: "https://www.influenster.com" + x, links)

		for link in product_links:
			yield Request(link, callback=self.parse_product)

		self.url_page += 1

		#select top 54 products(6 pages)
		if self.url_page > 6: 
			return

		next_page = self.start_urls[0] + '?page={}'.format(self.url_page)
		yield Request(next_page, callback=self.parse)


	def parse_product(self, response):

		product_link = response.url
		
		rank = response.xpath('//a[@class="product-cat-ranking"]/text()').extract_first()
		product_name = response.xpath('//div[@class="product-details"]/h1/text()').extract_first().strip()
		company = response.xpath('//div[@class="product-details"]/h2/text()').extract_first().strip()
		overall_rating = response.xpath('//div[@class="product-review-count"]/strong/text()').extract_first().strip()
		reviews_count = response.xpath('//div[@class="product-review-count"]/a/text()').extract_first().strip()
		highlights = response.xpath('//ul[@class="product-cphrases-list"]/li/text()').extract()
		
		productItem = InfluensterItem()
		productItem['product_link'] = product_link
		productItem['rank'] = rank
		productItem['product_name'] = product_name
		productItem['company'] = company
		productItem['overall_rating'] = overall_rating
		productItem['reviews_count'] = reviews_count
		productItem['highlights'] = highlights
		
		yield productItem

		self.review_url = 1

		yield Request(response.url, callback=self.parse_reviews, dont_filter = True)
		#https://stackoverflow.com/questions/18928253/why-is-my-scrapy-spider-not-following-the-request-callback-in-my-item-parse-func
	

	def parse_reviews(self, response):
		
		#extract reviews
		reviews = response.xpath('//div[@class="content-item review-item"]')
		for i in range(0,len(reviews)):
			author_name = reviews[i].xpath('./div/a/div[@class="author-name"]/text()').extract_first()
			author_location = reviews[i].xpath('./div/div[@class="author-location"]/text()').extract_first()
			star = reviews[i].xpath('./div/div/div[@class="avg-stars "]/@data-stars').extract_first()
			content = reviews[i].xpath('./div/div[@class="content-item-text review-text"]/text()').extract_first()
			profile = reviews[i].xpath('./div/div/div/div/div[@class="review-author-user-profile-response-answers"]/span/text()').extract()
			date = reviews[i].xpath('./div/div/a[@class="date"]/text()').extract_first()
			product_name = response.xpath('//div[@class="product-details"]/h1/text()').extract_first().strip()


			item = ReviewItem()
			item['product_name'] = product_name
			item['author_name'] = author_name
			item['author_location'] = author_location 
			item['profile'] = profile
			item['star'] = star
			item['content'] = content 
			item['date'] = date

			yield item

		# yield request for next page of reviews
		next_page_url = response.xpath('//a[@class="review-pagination "]/@href').extract_first()
		
		# check that next page indeed exists
		if next_page_url!=[]:
			absolute_next_page_url = response.urljoin(next_page_url)

			request = Request(absolute_next_page_url, callback = self.parse_reviews)
			request.meta['item'] = item
			yield request