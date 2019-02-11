//
//  Video.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 09/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

struct Video {

    let description: String
    let date: String
    let title: String
    let id: String
    let thumbnailURL: String

    init?(with json: JSON) {

        guard let snippet = json["snippet"] as? JSON else { return nil }

        description = snippet["description"] as? String ?? ""
        date = snippet["publishedAt"] as? String ?? ""
        title = snippet["title"] as? String ?? ""
        id = snippet["_1DEZSURw2E"] as? String ?? "_1DEZSURw2E"

        guard let thumbnails = snippet["thumbnails"] as? JSON else { return nil }

        print(thumbnails)

        thumbnailURL = (thumbnails["medium"] as! JSON)["url"] as? String ?? ""

    }
}


/*
 [["etag": "XpPGQXPnxQJhLgs6enD_n8JR4Qk/lHMKRqK07Xmton1OVU1_NqXC5hI", "snippet": {
 channelId = "UC_A--fhX5gea0i4UtpD99Gg";
 channelTitle = "Global Mountain Bike Network";
 description = "We asked you about the WORST mountain bike trail etiquette, and these were the things that annoyed you the most when out on your MTB. From not sharing spares and tools, to riding too close behind another person, we\U2019ve all seen them done. Don\U2019t be THAT guy and have a happy and safe ride.\n\nSubscribe to GMBN: http://gmbn.eu/subscribe\nGet exclusive GMBN gear in the GMBN store! https://gmbn.eu/12R\n\nShare the trail! If we\U2019ve missed any let us know in the comments below \Ud83d\Udc47\n\nIf you'd like to contribute captions and video info in your language, here's the link \Ud83d\Udc4d https://gmbn.eu/12Q\n\nWatch more on GMBN...\n\Ud83d\Udcf9 How To Mount Your Bike | https://gmbn.eu/geton\n\n\Ud83c\Udfb5 Music - licensed by Epidemic Sound:\nSalty Breeze 3 - Martin Gauffin.\nElecric Piano Feelings 15 - Jonatan J\U00e4rpehag.\nalk Back (60s Pop Version) - H\U00e5kan Eriksson.\nA Plate Of Rio 2 - Martin Landstr\U00f6m.\nSchoolyard Playgrounds 5 - Magnus Ringblom.\n\nSubmit your content here: \nhttps://upload.gmbn.com/\n\nClick here to buy GMBN T-shirts, hoodies and more: http://gmbn.eu/GMBNShop\n\nThe Global Mountain Bike Network is the best MTB YouTube channel, with videos for everyone who loves dirt: from the full-faced helmet downhill mountain biker to the lycra-clad cross country rider along with everyone and anyone in between. \n\nWith the help of our pro and ex-pro riding team we\U2019re here to inform, entertain and inspire you to become a better mountain biker, including videos on:\n\n- How to ride faster with expert knowledge\n- Fix everything with pro know-how\n- Ride anything with world-cup winning skills\n- Dial in your bike with bike set-up advice\n- In-depth entertaining features\n- Chat, opinion and interact with us on the Dirt Shed Show\n\nWelcome to the Global Mountain Bike Network | Covering Every Angle\n\nThanks to our sponsors:\nCanyon bikes: http://gmbn.eu/Canyon\nNukeproof: http://gmbn.eu/nukeproof\nChain Reaction Cycles: http://gmbn.eu/chainreactioncycles \nDT Swiss Wheels: http://gmbn.eu/DTSwiss\ncrankbrothers pedals: http://gmbn.eu/crankbros\ncrankbrothers seatposts: http://gmbn.eu/8b\nContinental: http://gmbn.eu/Continental\nPOC helmets and eyewear: http://gmbn.eu/POCsports \nTopeak: http://gmbn.eu/topeak\nWD40: http://gmbn.eu/WD40\nFSA: http://gmbn.eu/fsa\nErgon: http://gmbn.eu/ergon\nPark Tool: http://gmbn.eu/ParkTool\nNorthwave: http://gmbn.eu/Northwave\nCamelbak: http://gmbn.eu/camelbak\nDouchebags: http://gmbn.eu/Ly\n\nYouTube Channel - http://gmbn.eu/GMBNsubs \nFacebook - http://gmbn.eu/GMBNFB\nGoogle+ - http://gmbn.eu/GMBNGplus\nTwitter - http://gmbn.eu/GMBNTW\nInstagram - http://gmbn.eu/GMBNIG\nGMBN Shop - http://gmbn.eu/gmbnshop\nGMBN Tech - http://gmbn.tech/subscribe\nGCN Tech - http://gcntech.co/subscribe\nEMBN - http://embn.me/subscribe\n\nLeave us a comment below!";
 playlistId = "UU_A--fhX5gea0i4UtpD99Gg";
 position = 0;
 publishedAt = "2019-02-08T16:19:29.000Z";
 resourceId =     {
 kind = "youtube#video";
 videoId = "_1DEZSURw2E";
 };
 thumbnails =     {
 default =         {
 height = 90;
 url = "https://i.ytimg.com/vi/_1DEZSURw2E/default.jpg";
 width = 120;
 };
 high =         {
 height = 360;
 url = "https://i.ytimg.com/vi/_1DEZSURw2E/hqdefault.jpg";
 width = 480;
 };
 maxres =         {
 height = 720;
 url = "https://i.ytimg.com/vi/_1DEZSURw2E/maxresdefault.jpg";
 width = 1280;
 };
 medium =         {
 height = 180;
 url = "https://i.ytimg.com/vi/_1DEZSURw2E/mqdefault.jpg";
 width = 320;
 };
 standard =         {
 height = 480;
 url = "https://i.ytimg.com/vi/_1DEZSURw2E/sddefault.jpg";
 width = 640;
 };
 };
 title = "How Not To Behave On A Ride | Mountain Bike Trail Etiquette";
 }, "kind": youtube#playlistItem, "id": VVVfQS0tZmhYNWdlYTBpNFV0cEQ5OUdnLl8xREVaU1VSdzJF]
 */
