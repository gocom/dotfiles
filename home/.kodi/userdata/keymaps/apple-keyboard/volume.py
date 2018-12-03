import json, sys, xbmc
step = 5
if sys.argv[1] == 'down':
    step *= -1
rpc = '{"jsonrpc": "2.0", "method": "Application.GetProperties", "params": {"properties": ["volume"]}, "id": 1}'
vol = json.loads(xbmc.executeJSONRPC(rpc))["result"]["volume"]
xbmc.executebuiltin('SetVolume(%d,showVolumeBar)' % (vol + step))
