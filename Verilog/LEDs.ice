{
  "version": "1.2",
  "package": {
    "name": "",
    "version": "",
    "description": "",
    "author": "",
    "image": ""
  },
  "design": {
    "board": "iCEBreaker",
    "graph": {
      "blocks": [
        {
          "id": "fa1e85e3-de04-4c8c-b6cd-8a0d0c20287d",
          "type": "basic.input",
          "data": {
            "name": "BTN0",
            "pins": [
              {
                "index": "0",
                "name": "P2_9",
                "value": "20"
              }
            ],
            "virtual": false,
            "clock": false
          },
          "position": {
            "x": 792,
            "y": 744
          }
        },
        {
          "id": "58e3b8dd-f3c9-425a-a31f-ed893876b774",
          "type": "basic.output",
          "data": {
            "name": "LED",
            "range": "[4:0]",
            "pins": [
              {
                "index": "4",
                "name": "P2_8",
                "value": "23"
              },
              {
                "index": "3",
                "name": "P2_1",
                "value": "27"
              },
              {
                "index": "2",
                "name": "P2_7",
                "value": "26"
              },
              {
                "index": "1",
                "name": "P2_2",
                "value": "25"
              },
              {
                "index": "0",
                "name": "P2_3",
                "value": "21"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 2080,
            "y": 792
          }
        },
        {
          "id": "8031570e-6870-4604-960d-ae6e2ace609a",
          "type": "basic.input",
          "data": {
            "name": "BTN1",
            "pins": [
              {
                "index": "0",
                "name": "P2_4",
                "value": "19"
              }
            ],
            "virtual": false,
            "clock": false
          },
          "position": {
            "x": 792,
            "y": 808
          }
        },
        {
          "id": "79935aac-2921-4c4f-8624-b346c2b743d6",
          "type": "basic.input",
          "data": {
            "name": "BTN2",
            "pins": [
              {
                "index": "0",
                "name": "P2_10",
                "value": "18"
              }
            ],
            "virtual": false,
            "clock": false
          },
          "position": {
            "x": 792,
            "y": 872
          }
        },
        {
          "id": "6e10ad4c-bbc3-41c7-bcf9-48dca1aaf2d2",
          "type": "basic.output",
          "data": {
            "name": "RGB",
            "range": "[1:0]",
            "pins": [
              {
                "index": "1",
                "name": "LEDR",
                "value": "11"
              },
              {
                "index": "0",
                "name": "LEDG",
                "value": "37"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 2080,
            "y": 1016
          }
        },
        {
          "id": "65d7d1e4-ba15-4758-8452-6d2df35573df",
          "type": "6a50747141af6d1cfb3bb9d0093fb94862ff5a65",
          "position": {
            "x": 1128,
            "y": 1136
          },
          "size": {
            "width": 96,
            "height": 64
          }
        },
        {
          "id": "798f86ff-1df9-4ad6-bc38-7a98699e36b0",
          "type": "cfd9babc26edba88e2152493023c4bef7c47f247",
          "position": {
            "x": 968,
            "y": 856
          },
          "size": {
            "width": 96,
            "height": 64
          }
        },
        {
          "id": "c9a2c6b4-94be-4930-86b8-10fe4ad49672",
          "type": "cfd9babc26edba88e2152493023c4bef7c47f247",
          "position": {
            "x": 968,
            "y": 792
          },
          "size": {
            "width": 96,
            "height": 64
          }
        },
        {
          "id": "75359ffc-4b61-44d1-afbe-e4e8dac0dad4",
          "type": "cfd9babc26edba88e2152493023c4bef7c47f247",
          "position": {
            "x": 968,
            "y": 728
          },
          "size": {
            "width": 96,
            "height": 64
          }
        },
        {
          "id": "2d667d4a-abf7-49ff-bc32-4ee9a4c302ac",
          "type": "basic.code",
          "data": {
            "code": "reg [4:0]LED;\nreg [1:0]RGB;\n\nreg[4:0]LED_State;\nreg[1:0]RGB_State;\nreg[2:0]state;\n\nparameter ONE_LED_CYCLE     = 3'b001;\nparameter COUNT_LED_CYCLE   = 3'b010;\nparameter ALL_LED_FLASH     = 3'b011;\nparameter ALL_LED_ON        = 3'b100;\nparameter ALL_LED_OFF       = 3'b101;\n\nalways (*)begin\n    begin\n    case ({btn2, btn1, btn0})\n      3'b000  : state <= state;\n      3'b001  : state <= ONE_LED_CYCLE;\n      3'b010  : state <= COUNT_LED_CYCLE;\n      3'b100  : state <= ALL_LED_FLASH;\n      default : state <= state; \n    endcase\nend\n\nalways @(posedge clk)begin\n    if(state == 0 || LED_State == 0 || RGB_State == 0;)begin\n        LED_State <= 5'b00001;\n        RGB_State <= 2'b01;\n    end\n    else if(state == ONE_LED_CYCLE)begin\n        LED_State <= LED_State << 1;\n        RGB_State <= ~RGB_State;\n    end\n    else if (state == COUNT_LED_CYCLE)begin\n        LED_State <= LED_State + 1;\n        RGB_State <= ~RGB_State;\n    end\n    else if (state == ALL_LED_FLASH)begin\n        LED_State <= ~LED_State;\n        RGB_State <= ~RGB_State;\n    end\nend",
            "params": [],
            "ports": {
              "in": [
                {
                  "name": "btn0"
                },
                {
                  "name": "btn1"
                },
                {
                  "name": "btn2"
                },
                {
                  "name": "clk"
                },
                {
                  "name": "res_n"
                }
              ],
              "out": [
                {
                  "name": "LED",
                  "range": "[4:0]",
                  "size": 5
                },
                {
                  "name": "RGB",
                  "range": "[1:0]",
                  "size": 2
                }
              ]
            }
          },
          "position": {
            "x": 1328,
            "y": 824
          },
          "size": {
            "width": 616,
            "height": 488
          }
        }
      ],
      "wires": [
        {
          "source": {
            "block": "65d7d1e4-ba15-4758-8452-6d2df35573df",
            "port": "7e07d449-6475-4839-b43e-8aead8be2aac"
          },
          "target": {
            "block": "2d667d4a-abf7-49ff-bc32-4ee9a4c302ac",
            "port": "clk"
          }
        },
        {
          "source": {
            "block": "2d667d4a-abf7-49ff-bc32-4ee9a4c302ac",
            "port": "LED"
          },
          "target": {
            "block": "58e3b8dd-f3c9-425a-a31f-ed893876b774",
            "port": "in"
          },
          "size": 5
        },
        {
          "source": {
            "block": "2d667d4a-abf7-49ff-bc32-4ee9a4c302ac",
            "port": "RGB"
          },
          "target": {
            "block": "6e10ad4c-bbc3-41c7-bcf9-48dca1aaf2d2",
            "port": "in"
          },
          "size": 2
        },
        {
          "source": {
            "block": "fa1e85e3-de04-4c8c-b6cd-8a0d0c20287d",
            "port": "out"
          },
          "target": {
            "block": "75359ffc-4b61-44d1-afbe-e4e8dac0dad4",
            "port": "c9e1af2a-6f09-4cf6-a5b3-fdf7ec2c6530"
          }
        },
        {
          "source": {
            "block": "8031570e-6870-4604-960d-ae6e2ace609a",
            "port": "out"
          },
          "target": {
            "block": "c9a2c6b4-94be-4930-86b8-10fe4ad49672",
            "port": "c9e1af2a-6f09-4cf6-a5b3-fdf7ec2c6530"
          }
        },
        {
          "source": {
            "block": "79935aac-2921-4c4f-8624-b346c2b743d6",
            "port": "out"
          },
          "target": {
            "block": "798f86ff-1df9-4ad6-bc38-7a98699e36b0",
            "port": "c9e1af2a-6f09-4cf6-a5b3-fdf7ec2c6530"
          }
        },
        {
          "source": {
            "block": "798f86ff-1df9-4ad6-bc38-7a98699e36b0",
            "port": "22ff3fa1-943b-4d1a-bd89-36e1c054d077"
          },
          "target": {
            "block": "2d667d4a-abf7-49ff-bc32-4ee9a4c302ac",
            "port": "btn2"
          },
          "vertices": [
            {
              "x": 1160,
              "y": 976
            }
          ]
        },
        {
          "source": {
            "block": "c9a2c6b4-94be-4930-86b8-10fe4ad49672",
            "port": "22ff3fa1-943b-4d1a-bd89-36e1c054d077"
          },
          "target": {
            "block": "2d667d4a-abf7-49ff-bc32-4ee9a4c302ac",
            "port": "btn1"
          },
          "vertices": [
            {
              "x": 1184,
              "y": 912
            }
          ]
        },
        {
          "source": {
            "block": "75359ffc-4b61-44d1-afbe-e4e8dac0dad4",
            "port": "22ff3fa1-943b-4d1a-bd89-36e1c054d077"
          },
          "target": {
            "block": "2d667d4a-abf7-49ff-bc32-4ee9a4c302ac",
            "port": "btn0"
          },
          "vertices": [
            {
              "x": 1208,
              "y": 824
            }
          ]
        }
      ]
    }
  },
  "dependencies": {
    "6a50747141af6d1cfb3bb9d0093fb94862ff5a65": {
      "package": {
        "name": "PrescalerN",
        "version": "0.1",
        "description": "Parametric N-bits prescaler",
        "author": "Juan Gonzalez (Obijuan)",
        "image": ""
      },
      "design": {
        "graph": {
          "blocks": [
            {
              "id": "e19c6f2f-5747-4ed1-87c8-748575f0cc10",
              "type": "basic.input",
              "data": {
                "name": "",
                "clock": true
              },
              "position": {
                "x": 0,
                "y": 256
              }
            },
            {
              "id": "7e07d449-6475-4839-b43e-8aead8be2aac",
              "type": "basic.output",
              "data": {
                "name": ""
              },
              "position": {
                "x": 720,
                "y": 256
              }
            },
            {
              "id": "de2d8a2d-7908-48a2-9e35-7763a45886e4",
              "type": "basic.constant",
              "data": {
                "name": "N",
                "value": "22",
                "local": false
              },
              "position": {
                "x": 352,
                "y": 56
              }
            },
            {
              "id": "2330955f-5ce6-4d1c-8ee4-0a09a0349389",
              "type": "basic.code",
              "data": {
                "code": "//-- Number of bits of the prescaler\n//parameter N = 22;\n\n//-- divisor register\nreg [N-1:0] divcounter;\n\n//-- N bit counter\nalways @(posedge clk_in)\n  divcounter <= divcounter + 1;\n\n//-- Use the most significant bit as output\nassign clk_out = divcounter[N-1];",
                "params": [
                  {
                    "name": "N"
                  }
                ],
                "ports": {
                  "in": [
                    {
                      "name": "clk_in"
                    }
                  ],
                  "out": [
                    {
                      "name": "clk_out"
                    }
                  ]
                }
              },
              "position": {
                "x": 176,
                "y": 176
              },
              "size": {
                "width": 448,
                "height": 224
              }
            }
          ],
          "wires": [
            {
              "source": {
                "block": "2330955f-5ce6-4d1c-8ee4-0a09a0349389",
                "port": "clk_out"
              },
              "target": {
                "block": "7e07d449-6475-4839-b43e-8aead8be2aac",
                "port": "in"
              }
            },
            {
              "source": {
                "block": "e19c6f2f-5747-4ed1-87c8-748575f0cc10",
                "port": "out"
              },
              "target": {
                "block": "2330955f-5ce6-4d1c-8ee4-0a09a0349389",
                "port": "clk_in"
              }
            },
            {
              "source": {
                "block": "de2d8a2d-7908-48a2-9e35-7763a45886e4",
                "port": "constant-out"
              },
              "target": {
                "block": "2330955f-5ce6-4d1c-8ee4-0a09a0349389",
                "port": "N"
              }
            }
          ]
        }
      }
    },
    "cfd9babc26edba88e2152493023c4bef7c47f247": {
      "package": {
        "name": "Debouncer",
        "version": "1.0.0",
        "description": "Remove the rebound on a mechanical switch",
        "author": "Juan González",
        "image": "%3Csvg%20xmlns=%22http://www.w3.org/2000/svg%22%20viewBox=%22-252%20400.9%2090%2040%22%3E%3Cpath%20d=%22M-251.547%20436.672h22.802v-30.353h5.862v30.353h5.259v-30.353h3.447v30.353h2.984v-30.353h3.506v30.523h6.406V405.77h38.868%22%20fill=%22none%22%20stroke=%22#000%22%20stroke-width=%221.4%22%20stroke-linecap=%22round%22%20stroke-linejoin=%22round%22/%3E%3Cpath%20d=%22M-232.57%20403.877l26.946%2032.391M-205.624%20403.877l-26.946%2032.391%22%20fill=%22none%22%20stroke=%22red%22%20stroke-width=%223%22%20stroke-linecap=%22round%22/%3E%3C/svg%3E"
      },
      "design": {
        "graph": {
          "blocks": [
            {
              "id": "4bf41c17-a2da-4140-95f7-2a80d51b1e1a",
              "type": "basic.input",
              "data": {
                "name": "",
                "clock": true
              },
              "position": {
                "x": 48,
                "y": 144
              }
            },
            {
              "id": "22ff3fa1-943b-4d1a-bd89-36e1c054d077",
              "type": "basic.output",
              "data": {
                "name": ""
              },
              "position": {
                "x": 768,
                "y": 208
              }
            },
            {
              "id": "c9e1af2a-6f09-4cf6-a5b3-fdf7ec2c6530",
              "type": "basic.input",
              "data": {
                "name": "",
                "clock": false
              },
              "position": {
                "x": 48,
                "y": 272
              }
            },
            {
              "id": "92490e7e-c3ba-4e9c-a917-2a771d99f1ef",
              "type": "basic.code",
              "data": {
                "code": "//-- Debouncer Circuit\n//-- It produces a stable output when the\n//-- input signal is bouncing\n\nreg btn_prev = 0;\nreg btn_out_r = 0;\n\nreg [16:0] counter = 0;\n\n\nalways @(posedge clk) begin\n\n  //-- If btn_prev and btn_in are differents\n  if (btn_prev ^ in == 1'b1) begin\n    \n      //-- Reset the counter\n      counter <= 0;\n      \n      //-- Capture the button status\n      btn_prev <= in;\n  end\n    \n  //-- If no timeout, increase the counter\n  else if (counter[16] == 1'b0)\n      counter <= counter + 1;\n      \n  else\n    //-- Set the output to the stable value\n    btn_out_r <= btn_prev;\n\nend\n\nassign out = btn_out_r;\n",
                "params": [],
                "ports": {
                  "in": [
                    {
                      "name": "clk"
                    },
                    {
                      "name": "in"
                    }
                  ],
                  "out": [
                    {
                      "name": "out"
                    }
                  ]
                }
              },
              "position": {
                "x": 264,
                "y": 112
              },
              "size": {
                "width": 384,
                "height": 256
              }
            }
          ],
          "wires": [
            {
              "source": {
                "block": "92490e7e-c3ba-4e9c-a917-2a771d99f1ef",
                "port": "out"
              },
              "target": {
                "block": "22ff3fa1-943b-4d1a-bd89-36e1c054d077",
                "port": "in"
              }
            },
            {
              "source": {
                "block": "4bf41c17-a2da-4140-95f7-2a80d51b1e1a",
                "port": "out"
              },
              "target": {
                "block": "92490e7e-c3ba-4e9c-a917-2a771d99f1ef",
                "port": "clk"
              }
            },
            {
              "source": {
                "block": "c9e1af2a-6f09-4cf6-a5b3-fdf7ec2c6530",
                "port": "out"
              },
              "target": {
                "block": "92490e7e-c3ba-4e9c-a917-2a771d99f1ef",
                "port": "in"
              }
            }
          ]
        }
      }
    }
  }
}