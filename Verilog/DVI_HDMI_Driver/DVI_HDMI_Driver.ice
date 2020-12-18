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
          "id": "8523a85a-5d49-48f1-9df5-572ad35de28b",
          "type": "basic.output",
          "data": {
            "name": "R",
            "range": "[3:0]",
            "pins": [
              {
                "index": "3",
                "name": "P1_A8",
                "value": "48"
              },
              {
                "index": "2",
                "name": "P1_A2",
                "value": "2"
              },
              {
                "index": "1",
                "name": "P1_A7",
                "value": "3"
              },
              {
                "index": "0",
                "name": "P1_A1",
                "value": "4"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 2096,
            "y": 112
          }
        },
        {
          "id": "760b0b2e-5675-448c-9850-a73120547da9",
          "type": "basic.output",
          "data": {
            "name": "G",
            "range": "[3:0]",
            "pins": [
              {
                "index": "3",
                "name": "P1_A10",
                "value": "44"
              },
              {
                "index": "2",
                "name": "P1_A4",
                "value": "45"
              },
              {
                "index": "1",
                "name": "P1_A9",
                "value": "46"
              },
              {
                "index": "0",
                "name": "P1_A3",
                "value": "47"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 2096,
            "y": 272
          }
        },
        {
          "id": "b8d41202-6f95-4e70-9736-015e8bcd0bf7",
          "type": "basic.output",
          "data": {
            "name": "B",
            "range": "[3:0]",
            "pins": [
              {
                "index": "3",
                "name": "P1_B3",
                "value": "34"
              },
              {
                "index": "2",
                "name": "P1_B8",
                "value": "36"
              },
              {
                "index": "1",
                "name": "P1_B7",
                "value": "42"
              },
              {
                "index": "0",
                "name": "P1_B1",
                "value": "43"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 2096,
            "y": 432
          }
        },
        {
          "id": "39e226cb-ca54-4391-bd94-31ae4eaea79f",
          "type": "basic.output",
          "data": {
            "name": "hSync",
            "pins": [
              {
                "index": "0",
                "name": "P1_B4",
                "value": "31"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 1440,
            "y": 496
          }
        },
        {
          "id": "a7ca0e18-b6ac-492d-b550-8b98177f9b81",
          "type": "basic.output",
          "data": {
            "name": "vSync",
            "pins": [
              {
                "index": "0",
                "name": "P1_B10",
                "value": "28"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 1440,
            "y": 624
          }
        },
        {
          "id": "aa463bc5-f956-40f5-b22b-5ce4a873ac58",
          "type": "basic.outputLabel",
          "data": {
            "blockColor": "fuchsia",
            "name": "BTN",
            "pins": [
              {
                "index": "0",
                "name": "",
                "value": ""
              }
            ],
            "virtual": true
          },
          "position": {
            "x": 104,
            "y": 760
          }
        },
        {
          "id": "077f28f9-690f-4c13-b19a-e87059797480",
          "type": "basic.code",
          "data": {
            "code": "\n     reg [15:0] pixelX;\n     reg [15:0] pixelY;\n     reg hSync;       //output high when max X coordinate is reached\n     reg vSync;       //output high when max Y coordinate is reached\n     reg inDisplay;   //output high when colors can be shown\n     reg frame;        //output high every frame\n    //counting pixels\n    parameter   maxX = 16'd800,         //maximum value of X coordinate \n                maxY = 16'd525;         //maximum value of Y coordinate\n    \n    parameter   activeX = 16'd640,      //horizontal active region \n                frontPorchX = 16'd16,   //horizontal front porch\n                syncX = 16'd96,         //horizontal sync pulse\n                backPorchX = 16'd48;    //horizontal back porch\n\n    parameter   activeY = 16'd480,      //veritcal active region \n                frontPorchY = 16'd10,   //vertical front porch\n                syncY = 16'd2,          //vertical sync pulse\n                backPorchY = 16'd33;    //vertical back porch\n\n//    reg [15:0]pixelX, pixelY;           //16-bit reg's to store X and Y values\n\n    always @(posedge clk)begin\n        if (!res_n)begin\n            pixelX  <=  16'd0;\n            pixelY  <=  16'd0;\n            frame   <=  1'b0;\n        end\n        if ((pixelX < maxX) && res_n)\n            pixelX  <=  pixelX + 1'b1;    //increment x-counter\n        else begin\n            pixelX  <=  16'd0;    //reset x-counter at 799 pixels;\n            pixelY  <=  pixelX + 1'b1;    //increment Y when X resets\n        end\n\n        frame   <= 1'b0;\n\n        if ((pixelY >= maxY) || !res_n)\n            frame   <=  1'b1;\n            pixelY  <=  16'd0;\n    end\n\n    //assign active region where colors can be displayed\n    always @(posedge clk)begin\n        if ((pixelX < activeX) && (pixelY < activeY))\n            inDisplay   <=  1'b1;\n        else\n            inDisplay   <=  1'b0;\n    end\n\n    //assign hSync and vSync\n    always @(posedge clk)begin\n        if (!res_n)begin\n            hSync   <=  1'b0;\n            vSync   <=  1'b0;\n        end else begin\n            hSync   <=  (pixelX > (activeX + frontPorchX)) && (pixelX < (activeX + frontPorchX + backPorchX));\n            vSync   <=  (pixelY > (activeY + frontPorchY)) && (pixelY < (activeY + frontPorchY + backPorchY)); \n        end\n    end\n    ",
            "params": [],
            "ports": {
              "in": [
                {
                  "name": "clk"
                },
                {
                  "name": "res_n"
                }
              ],
              "out": [
                {
                  "name": "pixelX",
                  "range": "[15:0]",
                  "size": 16
                },
                {
                  "name": "pixelY",
                  "range": "[15:0]",
                  "size": 16
                },
                {
                  "name": "hSync"
                },
                {
                  "name": "vSync"
                },
                {
                  "name": "inDisplay"
                },
                {
                  "name": "frame"
                }
              ]
            }
          },
          "position": {
            "x": 296,
            "y": 192
          },
          "size": {
            "width": 912,
            "height": 800
          }
        },
        {
          "id": "62e3b7e0-d3f7-47eb-bb7a-5a73e54bfb69",
          "type": "basic.code",
          "data": {
            "code": "reg [3:0]R, G, B;\n\nalways@(posedge clk)begin\n    R <= 4'hF;\n    G <= 4'h0;\n    B <= 4'h0;\nend",
            "params": [],
            "ports": {
              "in": [
                {
                  "name": "pixelX",
                  "range": "[15:0]",
                  "size": 16
                },
                {
                  "name": "pixelY",
                  "range": "[15:0]",
                  "size": 16
                },
                {
                  "name": "clk"
                }
              ],
              "out": [
                {
                  "name": "R",
                  "range": "[3:0]",
                  "size": 4
                },
                {
                  "name": "G",
                  "range": "[3:0]",
                  "size": 4
                },
                {
                  "name": "B",
                  "range": "[3:0]",
                  "size": 4
                }
              ]
            }
          },
          "position": {
            "x": 1560,
            "y": 280
          },
          "size": {
            "width": 296,
            "height": 144
          }
        }
      ],
      "wires": [
        {
          "source": {
            "block": "aa463bc5-f956-40f5-b22b-5ce4a873ac58",
            "port": "outlabel"
          },
          "target": {
            "block": "077f28f9-690f-4c13-b19a-e87059797480",
            "port": "res_n"
          }
        },
        {
          "source": {
            "block": "077f28f9-690f-4c13-b19a-e87059797480",
            "port": "vSync"
          },
          "target": {
            "block": "a7ca0e18-b6ac-492d-b550-8b98177f9b81",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "077f28f9-690f-4c13-b19a-e87059797480",
            "port": "hSync"
          },
          "target": {
            "block": "39e226cb-ca54-4391-bd94-31ae4eaea79f",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "077f28f9-690f-4c13-b19a-e87059797480",
            "port": "pixelX"
          },
          "target": {
            "block": "62e3b7e0-d3f7-47eb-bb7a-5a73e54bfb69",
            "port": "pixelX"
          },
          "vertices": [
            {
              "x": 1384,
              "y": 264
            }
          ],
          "size": 16
        },
        {
          "source": {
            "block": "077f28f9-690f-4c13-b19a-e87059797480",
            "port": "pixelY"
          },
          "target": {
            "block": "62e3b7e0-d3f7-47eb-bb7a-5a73e54bfb69",
            "port": "pixelY"
          },
          "vertices": [
            {
              "x": 1384,
              "y": 376
            }
          ],
          "size": 16
        },
        {
          "source": {
            "block": "62e3b7e0-d3f7-47eb-bb7a-5a73e54bfb69",
            "port": "G"
          },
          "target": {
            "block": "760b0b2e-5675-448c-9850-a73120547da9",
            "port": "in"
          },
          "size": 4
        },
        {
          "source": {
            "block": "62e3b7e0-d3f7-47eb-bb7a-5a73e54bfb69",
            "port": "R"
          },
          "target": {
            "block": "8523a85a-5d49-48f1-9df5-572ad35de28b",
            "port": "in"
          },
          "size": 4
        },
        {
          "source": {
            "block": "62e3b7e0-d3f7-47eb-bb7a-5a73e54bfb69",
            "port": "B"
          },
          "target": {
            "block": "b8d41202-6f95-4e70-9736-015e8bcd0bf7",
            "port": "in"
          },
          "size": 4
        }
      ]
    }
  },
  "dependencies": {}
}