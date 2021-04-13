#ifndef _DYNAMICKOMI_H_
#define _DYNAMICKOMI_H_

#include "GoBoard.h"
#include "UctSearch.h"

////////////////
//    定数    //
////////////////

//  コミを緩める勝率の閾値
const double RED = 0.35;

//  コミを厳しくする勝率の閾値
const double GREEN = 0.75;

//  コミの値を収束させる手数
const int LINEAR_THRESHOLD = 200;

//  置き石1子あたりの重み
const int HANDICAP_WEIGHT = 8;

//  Dynamic Komiの設定
enum DYNAMIC_KOMI_MODE {
  DK_OFF,     // Dynamic Komiなし
  DK_LINEAR,  // Linear Handicap
  DK_VALUE,   // Value Situational
};


////////////////
//    関数    //
////////////////

//  置き石の個数の設定
void SetHandicapNum( const int num );

//  置き石の個数の設定(テスト対局用)
void SetConstHandicapNum( const int num );

//  Dynamic Komi
void DynamicKomi( const game_info_t *game, const uct_node_t *root, const int color );

#endif
