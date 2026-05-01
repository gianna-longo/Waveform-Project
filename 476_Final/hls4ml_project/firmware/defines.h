#ifndef DEFINES_H_
#define DEFINES_H_

#include "ap_fixed.h"
#include "ap_int.h"
#include "nnet_utils/nnet_types.h"
#include <cstddef>
#include <cstdio>

// hls-fpga-machine-learning insert numbers
#define N_INPUT_1_1 200
#define N_INPUT_2_1 1
#define N_OUTPUTS_2 200
#define N_FILT_2 8
#define N_OUTPUTS_2 200
#define N_FILT_2 8
#define N_OUTPUTS_4 100
#define N_FILT_4 8
#define N_OUTPUTS_5 100
#define N_FILT_5 16
#define N_OUTPUTS_5 100
#define N_FILT_5 16
#define N_OUTPUTS_7 50
#define N_FILT_7 16
#define N_OUTPUTS_8 50
#define N_FILT_8 16
#define N_OUTPUTS_8 50
#define N_FILT_8 16
#define N_FILT_10 16
#define N_LAYER_11 32
#define N_LAYER_11 32
#define N_LAYER_13 3
#define N_LAYER_13 3

// hls-fpga-machine-learning insert layer-precision
typedef ap_fixed<24,8> input_t;
typedef ap_fixed<24,8> model_default_t;
typedef ap_fixed<24,8> layer2_t;
typedef ap_fixed<24,8> conv1d_15_weight_t;
typedef ap_fixed<24,8> conv1d_15_bias_t;
typedef ap_fixed<24,8> layer3_t;
typedef ap_fixed<18,8> conv1d_15_relu_table_t;
typedef ap_fixed<24,8> layer4_t;
typedef ap_fixed<24,8> layer5_t;
typedef ap_fixed<24,8> conv1d_16_weight_t;
typedef ap_fixed<24,8> conv1d_16_bias_t;
typedef ap_fixed<24,8> layer6_t;
typedef ap_fixed<18,8> conv1d_16_relu_table_t;
typedef ap_fixed<24,8> layer7_t;
typedef ap_fixed<24,8> layer8_t;
typedef ap_fixed<24,8> conv1d_17_weight_t;
typedef ap_fixed<24,8> conv1d_17_bias_t;
typedef ap_fixed<24,8> layer9_t;
typedef ap_fixed<18,8> conv1d_17_relu_table_t;
typedef ap_fixed<24,8> layer10_t;
typedef ap_fixed<24,8> layer11_t;
typedef ap_fixed<24,8> dense_10_weight_t;
typedef ap_fixed<24,8> dense_10_bias_t;
typedef ap_uint<1> layer11_index;
typedef ap_fixed<24,8> layer12_t;
typedef ap_fixed<18,8> dense_10_relu_table_t;
typedef ap_fixed<24,8> layer13_t;
typedef ap_fixed<24,8> dense_11_weight_t;
typedef ap_fixed<24,8> dense_11_bias_t;
typedef ap_uint<1> layer13_index;
typedef ap_fixed<24,8> result_t;
typedef ap_fixed<18,8> dense_11_softmax_table_t;
typedef ap_fixed<18,8,AP_RND,AP_SAT> dense_11_softmax_exp_table_t;
typedef ap_fixed<18,8,AP_RND,AP_SAT> dense_11_softmax_inv_table_t;

#endif
