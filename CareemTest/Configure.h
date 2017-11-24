//
//  Configure.h
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#ifndef Configure_h
#define Configure_h

/*************
 *
 *  Network Defindation
 *
 *************/
#define kNetworkManagerAPIKey                          @"2696829a81b1b5827d515ff121700838"

#define kNetworkManagerMovieSearchURLDEBUG             [NSString stringWithFormat:@"http://api.themoviedb.org/3/search/movie?api_key=%@&query=%%@&page=%%d",kNetworkManagerAPIKey]
#define kNetworkManagerMovieSearchURLRELEASE           [NSString stringWithFormat:@"http://api.themoviedb.org/3/search/movie?api_key=%@&query=%%@&page=%%d",kNetworkManagerAPIKey]
#if DEBUG
#define kNetworkManagerMovieSearchURL                  kNetworkManagerMovieSearchURLDEBUG
#else
#define kNetworkManagerMovieSearchURL                  kNetworkManagerMovieSearchURLRELEASE
#endif

#define kNetworkManagerTimeOut                         30.0f


#endif /* Configure_h */
