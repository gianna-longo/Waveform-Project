#include <iostream>

#include "myproject.h"
#include "parameters.h"

void myproject(
    input_t conv1d_15_input[N_INPUT_1_1*N_INPUT_2_1],
    result_t layer14_out[N_LAYER_13]
) {

    // hls-fpga-machine-learning insert IO
    #pragma HLS ARRAY_RESHAPE variable=conv1d_15_input complete dim=0
    #pragma HLS ARRAY_PARTITION variable=layer14_out complete dim=0

#ifndef __SYNTHESIS__
    static bool loaded_weights = false;
    if (!loaded_weights) {
        // hls-fpga-machine-learning insert load weights
        nnet::load_weights_from_txt<conv1d_15_weight_t, 40>(w2, "w2.txt");
        nnet::load_weights_from_txt<conv1d_15_bias_t, 8>(b2, "b2.txt");
        nnet::load_weights_from_txt<conv1d_16_weight_t, 640>(w5, "w5.txt");
        nnet::load_weights_from_txt<conv1d_16_bias_t, 16>(b5, "b5.txt");
        nnet::load_weights_from_txt<conv1d_17_weight_t, 768>(w8, "w8.txt");
        nnet::load_weights_from_txt<conv1d_17_bias_t, 16>(b8, "b8.txt");
        nnet::load_weights_from_txt<dense_10_weight_t, 512>(w11, "w11.txt");
        nnet::load_weights_from_txt<dense_10_bias_t, 32>(b11, "b11.txt");
        nnet::load_weights_from_txt<dense_11_weight_t, 96>(w13, "w13.txt");
        nnet::load_weights_from_txt<dense_11_bias_t, 3>(b13, "b13.txt");
        loaded_weights = true;
    }
#endif

    // ****************************************
    // NETWORK INSTANTIATION
    // ****************************************

    // hls-fpga-machine-learning insert layers

    layer2_t layer2_out[N_OUTPUTS_2*N_FILT_2];
    #pragma HLS ARRAY_PARTITION variable=layer2_out complete dim=0
    nnet::conv_1d_cl<input_t, layer2_t, config2>(conv1d_15_input, layer2_out, w2, b2); // conv1d_15

    layer3_t layer3_out[N_OUTPUTS_2*N_FILT_2];
    #pragma HLS ARRAY_PARTITION variable=layer3_out complete dim=0
    nnet::relu<layer2_t, layer3_t, relu_config3>(layer2_out, layer3_out); // conv1d_15_relu

    layer4_t layer4_out[N_OUTPUTS_4*N_FILT_4];
    #pragma HLS ARRAY_PARTITION variable=layer4_out complete dim=0
    nnet::pooling1d_cl<layer3_t, layer4_t, config4>(layer3_out, layer4_out); // max_pooling1d_10

    layer5_t layer5_out[N_OUTPUTS_5*N_FILT_5];
    #pragma HLS ARRAY_PARTITION variable=layer5_out complete dim=0
    nnet::conv_1d_cl<layer4_t, layer5_t, config5>(layer4_out, layer5_out, w5, b5); // conv1d_16

    layer6_t layer6_out[N_OUTPUTS_5*N_FILT_5];
    #pragma HLS ARRAY_PARTITION variable=layer6_out complete dim=0
    nnet::relu<layer5_t, layer6_t, relu_config6>(layer5_out, layer6_out); // conv1d_16_relu

    layer7_t layer7_out[N_OUTPUTS_7*N_FILT_7];
    #pragma HLS ARRAY_PARTITION variable=layer7_out complete dim=0
    nnet::pooling1d_cl<layer6_t, layer7_t, config7>(layer6_out, layer7_out); // max_pooling1d_11

    layer8_t layer8_out[N_OUTPUTS_8*N_FILT_8];
    #pragma HLS ARRAY_PARTITION variable=layer8_out complete dim=0
    nnet::conv_1d_cl<layer7_t, layer8_t, config8>(layer7_out, layer8_out, w8, b8); // conv1d_17

    layer9_t layer9_out[N_OUTPUTS_8*N_FILT_8];
    #pragma HLS ARRAY_PARTITION variable=layer9_out complete dim=0
    nnet::relu<layer8_t, layer9_t, relu_config9>(layer8_out, layer9_out); // conv1d_17_relu

    layer10_t layer10_out[N_FILT_10];
    #pragma HLS ARRAY_PARTITION variable=layer10_out complete dim=0
    nnet::global_pooling1d_cl<layer9_t, layer10_t, config10>(layer9_out, layer10_out); // global_average_pooling1d_5

    layer11_t layer11_out[N_LAYER_11];
    #pragma HLS ARRAY_PARTITION variable=layer11_out complete dim=0
    nnet::dense<layer10_t, layer11_t, config11>(layer10_out, layer11_out, w11, b11); // dense_10

    layer12_t layer12_out[N_LAYER_11];
    #pragma HLS ARRAY_PARTITION variable=layer12_out complete dim=0
    nnet::relu<layer11_t, layer12_t, relu_config12>(layer11_out, layer12_out); // dense_10_relu

    layer13_t layer13_out[N_LAYER_13];
    #pragma HLS ARRAY_PARTITION variable=layer13_out complete dim=0
    nnet::dense<layer12_t, layer13_t, config13>(layer12_out, layer13_out, w13, b13); // dense_11

    nnet::softmax<layer13_t, result_t, softmax_config14>(layer13_out, layer14_out); // dense_11_softmax

}
