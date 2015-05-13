#!/usr/bin/python

#
# Copyright 2012-2013 Hippo B.V. (http://www.onehippo.com)
#

import urllib2, sys

# the default base of all URLs of all visitors.
DEFAULT_URL_BASE = 'http://localhost:8080/site'
#DEFAULT_URL_BASE = 'http://localhost:8081/site'
#DEFAULT_URL_BASE = 'http://www.demo.test.onehippo.com'

# map of visitor IP to a list of visited paths
VISITORS = {\
# FAMILY
'199.181.132.250': [\
	'/blogs/2014/10/learning-at-home.html',\
	'/blogs/2014/08/tips-for-ecofriendly-event-planning.html',\
	'/events/2015/04/green-festival.html',\
	'/events/2015/04/green-living-show.html',\
	'/events/2014/11/party-for-the-planet.html',\
	'/products/family/penguin-squeezy.html',\
	'/products/family/earth-kit.html',\
],
# STUDENT
'74.220.126.92': [\
    '/blogs/2014/09/what-steps-are-taken-by-universities-to-become-more-sustainable.html',\
    '/blogs/2014/09/how-to-green-your-dorm-room.html',\
    '/events/2014/10/smart-and-sustainable-campuses-conference.html',\
    '/products/gadgets/laptop-sleeves---neogreene.html',\
    '/products/office/post-consumer-3-ring-binder-3-in.-spine.html',\
    '/products/office/eco-simple-flash-drive---usb.html',\
],
# OVERLAP
'212.58.241.131': [\
    '/blogs/2014/09/is-a-smart-thermostat-worth-the-investment.html',\
    '/blogs/2014/08/tips-for-ecofriendly-event-planning.html',\
    '/events/2015/04/green-festival.html',\
    '/events/2015/04/green-living-show.html',\
    '/products/gadgets/laptop-sleeves---neogreene.html',\
    '/products/office/eco-simple-flash-drive---usb.html',\
],
# BUSINESS OWNER
'83.149.85.230': [\
    '/blogs/2014/08/10-simple-steps-to-green-your-office.html',\
    '/blogs/2014/07/green-office-week.html',\
    '/events/2015/02/natural-capital.html',\
    '/events/2015/01/ces-green.html',\
    '/products/office/banana-paper-business-cards-1000-card-pack.html',\
    '/products/gadgets/external-laptop-charger.html',\
]
#],
# GADGET CONSUMER ORIENTED
#'119.63.198.132': [\
#    '/products/animal--garden/2010/08/portable-solar-lamp-with-radio.html',\
#    '/products/re-use/2010/08/external-laptop-charger.html',\
#    '/products/re-use/2010/08/eco-simple-flash-drive---usb.html',\
#    '/products/re-use/2010/08/portable-pocketsize-charger.html',\
#    '/products/re-use/2010/07/Solio-Magnesium-Solar-Charger.html',\
#],
## MIXED SOLAR / VEGETARIAN  ORIENTED
#'74.125.79.106': [\
#    '/news/2010/07/Solar-powered-plane-completes-26-hour-flight.html',\
#    '/news/2010/05/solar-power-the-skys-the-limit.html',\
#    '/news/2010/07/obama-commits-billions-to-solar-firms.html',\
#    '/news/2011/03/vegetarian.html',\
#    '/products/food/2011/11/fennel.html',\
#],
## MIXED PROF / CONSUMER  ORIENTED
#'74.125.79.94': [\
#    '/jobs/solar/solar-project-manager.html',\
#    '/jobs/IT/Green-field-tester.html',\
#    '/jobs/solar/solar-sales-consultant.html',\
#    '/products/food/2011/11/lentil-and-mushroom-stew.html',\
#    '/products/food/2011/11/cti-solar-oven.html',\
#    '/products/Product+Category/Health+care',\
#]
}

class HttpBot:
    def __init__(self, ip):
        cookie_handler= urllib2.HTTPCookieProcessor()
        redirect_handler= urllib2.HTTPRedirectHandler()
        self._opener = urllib2.build_opener(redirect_handler, cookie_handler)
        self._opener.addheaders = [
            ('X-Forwarded-For', ip),
            ('User-agent', 'Hippo Gecko Hippo Hippo'),
        ]

    def GET(self, url):
        return self._opener.open(url).read()

if __name__ == '__main__':
    url_base = DEFAULT_URL_BASE
    if len(sys.argv) > 1:
        url_base = sys.argv[1]
        
    for ip, paths in VISITORS.iteritems():
        print ip
        bot = HttpBot(ip)
        for path in paths:
            url = url_base + path
            print '  ' + url
            try:
                bot.GET(url)
            except urllib2.URLError as e:
                if hasattr(e, 'reason'):
                    print('! {0}'.format(e.reason))
                elif hasattr(e, 'code'):
                    print('! Error: {0}'.format(e.code))

