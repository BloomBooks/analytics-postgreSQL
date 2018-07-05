ERROR:  cannot drop function ip2int(character varying) because other objects depend on it
DETAIL:  view bloomreadertest.countries depends on function ip2int(character varying)
view bloomreaderbeta.phonespng depends on function ip2int(character varying)
view bloomreader.phonespng depends on function ip2int(character varying)
view bloomreadertest.unionphones depends on view bloomreader.phonespng
view bloomreadertest.books depends on function ip2int(character varying)
view bloomreadertest.languages depends on view bloomreadertest.books
view bloomreadertest.numtitles depends on function ip2int(character varying)
view bloomreadertest.timepermon depends on function ip2int(character varying)
view bloomreadertest.timepermonpng depends on function ip2int(character varying)
view bloomreadertest.phonespng depends on function ip2int(character varying)
view bloomreadertest.comprehension depends on function ip2int(character varying)
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
SQL state: 2BP01