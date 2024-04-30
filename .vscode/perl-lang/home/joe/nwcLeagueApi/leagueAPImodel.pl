{"version":5,"vars":[{"name":"feature","line":2,"containerName":"","kind":2},{"line":5,"containerName":"","kind":2,"name":"Encode"},{"containerName":null,"kind":13,"line":9,"localvar":"my","name":"$baseUrl","definition":"my"},{"name":"Dumper","kind":2,"containerName":"JSON::Data","line":9},{"line":10,"kind":13,"containerName":null,"definition":"my","name":"$ua","localvar":"my"},{"containerName":"UserAgent","kind":12,"line":10,"name":"LWP"},{"name":"new","containerName":"main::","kind":12,"line":10},{"line":11,"containerName":null,"kind":13,"name":"$ua"},{"name":"agent","containerName":"main::","kind":12,"line":11},{"containerName":"main::","kind":12,"line":13,"children":[{"localvar":"my","definition":"my","name":"$page","kind":13,"containerName":"getPageTree","line":14},{"kind":13,"containerName":"getPageTree","line":16,"localvar":"my","name":"$url","definition":"my"},{"name":"$baseUrl","kind":13,"containerName":"getPageTree","line":16},{"containerName":"getPageTree","kind":13,"line":16,"name":"$page"},{"localvar":"my","name":"$root","definition":"my","kind":13,"containerName":"getPageTree","line":17},{"line":17,"containerName":"getPageTree","kind":12,"name":"new"},{"containerName":"getPageTree","kind":13,"line":18,"localvar":"my","name":"$request","definition":"my"},{"line":18,"containerName":"getPageTree","kind":13,"name":"$ua"},{"containerName":"getPageTree","kind":12,"line":18,"name":"get"},{"containerName":"getPageTree","kind":13,"line":18,"name":"$url"},{"name":"$request","line":20,"containerName":"getPageTree","kind":13},{"name":"is_success","line":20,"containerName":"getPageTree","kind":12},{"name":"$root","line":21,"containerName":"getPageTree","kind":13},{"name":"parse","line":21,"containerName":"getPageTree","kind":12},{"name":"$request","containerName":"getPageTree","kind":13,"line":21},{"line":21,"containerName":"getPageTree","kind":12,"name":"content"},{"name":"$root","line":27,"containerName":"getPageTree","kind":13}],"range":{"end":{"character":9999,"line":28},"start":{"line":13,"character":0}},"definition":"sub","name":"getPageTree"},{"name":"HTML","kind":12,"containerName":"TreeBuilder","line":17},{"name":"decode_utf8","kind":12,"line":21},{"children":[{"kind":13,"containerName":"fetchAllClubsAndIds","line":32,"localvar":"my","definition":"my","name":"%clubsdata"},{"kind":13,"containerName":"fetchAllClubsAndIds","line":33,"localvar":"my","definition":"my","name":"$page"},{"kind":13,"containerName":"fetchAllClubsAndIds","line":34,"localvar":"my","definition":"my","name":"$data"},{"name":"$page","line":35,"containerName":"fetchAllClubsAndIds","kind":13},{"name":"look_down","line":35,"containerName":"fetchAllClubsAndIds","kind":12},{"name":"$data","kind":13,"containerName":"fetchAllClubsAndIds","line":43},{"name":"look_down","line":43,"kind":12,"containerName":"fetchAllClubsAndIds"},{"line":45,"kind":13,"containerName":"fetchAllClubsAndIds","definition":"my","name":"$clubname","localvar":"my"},{"name":"$data","line":45,"containerName":"fetchAllClubsAndIds","kind":13},{"name":"as_text","line":45,"kind":12,"containerName":"fetchAllClubsAndIds"},{"line":46,"kind":13,"containerName":"fetchAllClubsAndIds","name":"$club_info_url","definition":"my","localvar":"my"},{"name":"$data","kind":13,"containerName":"fetchAllClubsAndIds","line":46},{"name":"look_down","line":46,"kind":12,"containerName":"fetchAllClubsAndIds"},{"name":"attr","containerName":"fetchAllClubsAndIds","kind":12,"line":46},{"name":"$clubid","definition":"my","localvar":"my","line":49,"kind":13,"containerName":"fetchAllClubsAndIds"},{"name":"$club_info_url","line":51,"containerName":"fetchAllClubsAndIds","kind":13},{"name":"$clubid","containerName":"fetchAllClubsAndIds","kind":13,"line":52},{"containerName":"fetchAllClubsAndIds","kind":13,"line":57,"name":"@clubsdata"},{"name":"$clubname","kind":13,"containerName":"fetchAllClubsAndIds","line":57},{"line":57,"containerName":"fetchAllClubsAndIds","kind":13,"name":"$clubid"},{"line":61,"kind":13,"containerName":"fetchAllClubsAndIds","name":"%clubsdata"}],"line":30,"kind":12,"containerName":"main::","definition":"sub","name":"fetchAllClubsAndIds","range":{"end":{"line":63,"character":9999},"start":{"line":30,"character":0}}},{"kind":12,"line":36,"name":"_tag"},{"line":37,"kind":12,"name":"class"},{"name":"_tag","kind":12,"line":43},{"name":"last","kind":12,"line":43},{"name":"_tag","line":46,"kind":12},{"definition":"sub","name":"fetchClubInfo","range":{"start":{"line":65,"character":0},"end":{"character":9999,"line":89}},"children":[{"containerName":"fetchClubInfo","kind":13,"line":67,"localvar":"my","definition":"my","name":"$id"},{"localvar":"my","definition":"my","name":"$page","containerName":"fetchClubInfo","kind":13,"line":68},{"kind":13,"containerName":"fetchClubInfo","line":69,"localvar":"my","name":"%fields","definition":"my"},{"containerName":"fetchClubInfo","kind":13,"line":71,"localvar":"my","name":"$data","definition":"my"},{"name":"$page","line":72,"kind":13,"containerName":"fetchClubInfo"},{"name":"look_down","kind":12,"containerName":"fetchClubInfo","line":72},{"name":"$k","definition":"my","localvar":"my","line":78,"containerName":"fetchClubInfo","kind":13},{"line":78,"kind":13,"containerName":"fetchClubInfo","name":"$data"},{"name":"look_down","kind":12,"containerName":"fetchClubInfo","line":78},{"name":"as_text","containerName":"fetchClubInfo","kind":12,"line":78},{"name":"$v","definition":"my","localvar":"my","line":79,"containerName":"fetchClubInfo","kind":13},{"line":79,"containerName":"fetchClubInfo","kind":13,"name":"$data"},{"name":"look_down","containerName":"fetchClubInfo","kind":12,"line":79},{"line":79,"containerName":"fetchClubInfo","kind":12,"name":"as_text"},{"name":"$k","line":80,"containerName":"fetchClubInfo","kind":13},{"name":"$v","line":81,"containerName":"fetchClubInfo","kind":13},{"name":"$v","containerName":"fetchClubInfo","kind":13,"line":82},{"name":"$data","line":82,"containerName":"fetchClubInfo","kind":13},{"name":"look_down","containerName":"fetchClubInfo","kind":12,"line":82},{"name":"attr","line":82,"containerName":"fetchClubInfo","kind":12},{"containerName":"fetchClubInfo","kind":13,"line":84,"localvar":"my","name":"%tableHash","definition":"my"},{"line":84,"containerName":"fetchClubInfo","kind":13,"name":"$k"},{"line":84,"kind":13,"containerName":"fetchClubInfo","name":"$v"},{"line":85,"containerName":"fetchClubInfo","kind":13,"name":"$fields"},{"name":"$k","containerName":"fetchClubInfo","kind":13,"line":85},{"kind":13,"containerName":"fetchClubInfo","line":85,"name":"$v"},{"line":88,"containerName":"fetchClubInfo","kind":13,"name":"%fields"}],"line":65,"containerName":"main::","kind":12},{"name":"_tag","kind":12,"line":73},{"name":"class","kind":12,"line":74},{"name":"_tag","line":78,"kind":12},{"name":"_tag","kind":12,"line":79},{"name":"last","kind":12,"line":80},{"name":"_tag","kind":12,"line":82},{"kind":12,"containerName":"main::","line":91,"children":[{"line":92,"containerName":"fetchTeamsByClub","kind":13,"name":"$id","definition":"my","localvar":"my"},{"kind":13,"containerName":"fetchTeamsByClub","line":93,"localvar":"my","name":"$page","definition":"my"},{"definition":"my","name":"$data","localvar":"my","line":95,"containerName":"fetchTeamsByClub","kind":13},{"line":96,"kind":13,"containerName":"fetchTeamsByClub","name":"$page"},{"name":"look_down","kind":12,"containerName":"fetchTeamsByClub","line":96}],"range":{"start":{"line":91,"character":0},"end":{"line":105,"character":9999}},"definition":"sub","name":"fetchTeamsByClub"},{"kind":12,"line":97,"name":"_tag"},{"line":98,"kind":12,"name":"class"},{"kind":12,"containerName":"main::","line":107,"children":[{"line":108,"kind":13,"containerName":"getClubIdByName","definition":"my","name":"$name","localvar":"my"},{"line":109,"containerName":"getClubIdByName","kind":13,"definition":"my","name":"$clubsData","localvar":"my"},{"definition":"my","name":"$clubId","localvar":"my","line":110,"kind":13,"containerName":"getClubIdByName"},{"line":110,"kind":13,"containerName":"getClubIdByName","name":"$clubsData"},{"kind":13,"containerName":"getClubIdByName","line":110,"name":"$name"},{"kind":13,"containerName":"getClubIdByName","line":111,"name":"$clubId"},{"line":111,"containerName":"getClubIdByName","kind":13,"name":"$clubId"}],"range":{"start":{"character":0,"line":107},"end":{"character":9999,"line":113}},"definition":"sub","name":"getClubIdByName"}]}