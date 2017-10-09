xquery version "3.1";

module namespace wust="http://xquery.weber-gesamtausgabe.de/modules/wega-util-shared-tests";

declare namespace test="http://exist-db.org/xquery/xqsuite";
import module namespace wega-util-shared="http://xquery.weber-gesamtausgabe.de/modules/wega-util-shared" at "../xquery/wega-util-shared.xqm";

declare %test:assertFalse function wust:test-has-content-empty-string() as xs:boolean {
    wega-util-shared:has-content('') or
    wega-util-shared:has-content('   ')
};

declare %test:assertFalse function wust:test-has-content-empty-sequence() as xs:boolean {
    wega-util-shared:has-content(()) 
};

declare %test:assertTrue function wust:test-has-content-string() as xs:boolean {
    wega-util-shared:has-content('foo') and
    wega-util-shared:has-content(('foo', '')) 
};

declare %test:assertTrue function wust:test-has-content-number() as xs:boolean {
    wega-util-shared:has-content(4) and
    wega-util-shared:has-content(4.2) and
    wega-util-shared:has-content(-4) and
    wega-util-shared:has-content(-4.2) and
    wega-util-shared:has-content((3, 2, 0)) and
    wega-util-shared:has-content((3.7, 2.7, 0)) and
    wega-util-shared:has-content(xs:double('INF')) and 
    wega-util-shared:has-content(xs:double('-INF'))
};

declare %test:assertFalse function wust:test-has-content-zeroNaN() as xs:boolean {
    wega-util-shared:has-content(0) or
    wega-util-shared:has-content(xs:double('NaN'))
};


declare %test:assertFalse function wust:test-has-content-empty-map() as xs:boolean {
    wega-util-shared:has-content(map {'foo': ()}) or
    wega-util-shared:has-content(map {}) 
};

declare %test:assertTrue function wust:test-has-content-map() as xs:boolean {
    wega-util-shared:has-content(map {'foo': 'bar'}) and
    wega-util-shared:has-content(map {'foo': (), 'foo': 'bar'}) 
};

declare %test:assertTrue function wust:test-has-content-function() as xs:boolean {
    wega-util-shared:has-content(function() {'foo'}) 
};

declare %test:assertFalse function wust:test-has-content-empty-array() as xs:boolean {
    wega-util-shared:has-content([]) or
    wega-util-shared:has-content([()]) or
    wega-util-shared:has-content(['']) 
};

declare %test:assertTrue function wust:test-has-content-array() as xs:boolean {
    wega-util-shared:has-content(['a']) and
    wega-util-shared:has-content([4]) and
    wega-util-shared:has-content([map {'foo': 'bar'}]) and
    wega-util-shared:has-content(['a', '']) 
};

declare %test:assertFalse function wust:test-has-content-empty-attribute() as xs:boolean {
    let $nodeA := <a href=""/>
    let $nodeB := <a href="   "/>
    let $nodeC := <a href="0"/>
    let $nodeD := <a href="NaN"/>
    return
        wega-util-shared:has-content($nodeA/@href) or
        wega-util-shared:has-content($nodeB/@href) or
        wega-util-shared:has-content($nodeA/@foo) or
        wega-util-shared:has-content($nodeC/@href) or
        wega-util-shared:has-content($nodeD/@href)
};

declare %test:assertTrue function wust:test-has-content-attribute() as xs:boolean {
    let $node := <a href="foo"/>
    return
        wega-util-shared:has-content($node/@href) 
};

declare %test:assertFalse function wust:test-has-content-empty-element() as xs:boolean {
    wega-util-shared:has-content(<a/>) or
    wega-util-shared:has-content(<a></a>) or
    wega-util-shared:has-content(<a> </a>) or
    wega-util-shared:has-content(element a {'   '}) or
    wega-util-shared:has-content(<a href="foo"/>) or
    wega-util-shared:has-content(<a>0</a>) or
    wega-util-shared:has-content(<a>NaN</a>)
};

declare %test:assertTrue function wust:test-has-content-element() as xs:boolean {
    wega-util-shared:has-content(<a>foo</a>) and
    wega-util-shared:has-content(<a> foo bar </a>) and
    wega-util-shared:has-content(<a> 0 0 </a>)
};
