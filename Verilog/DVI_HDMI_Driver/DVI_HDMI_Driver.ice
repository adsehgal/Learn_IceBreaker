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
          "id": "077f28f9-690f-4c13-b19a-e87059797480",
          "type": "basic.code",
          "data": {
            "code": "",
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
            "width": 192,
            "height": 128
          }
        }
      ],
      "wires": []
    }
  },
  "dependencies": {}
}