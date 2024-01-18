var socket_id = argument0;
var hat = argument1;
var room_id = argument2;
var name = argument3;

var data = scr_wws_create_packet("PlayerJoinS2C", [socket_id, hat, room_id, name]);

for (var i = 0; i < ds_list_size(global.wws_networking_ids); i++)
{
    var send_to = ds_list_find_value(global.wws_networking_ids, i);
    if (send_to == socket_id) continue;

    var player = ds_map_find_value(global.global.wws_players_by_id, send_to);
    var to_new = scr_wws_create_packet("PlayerJoinS2C", [send_to, player.room_id, -1, player.name]);
    scr_wws_send_packet(to_new, socket_id, true);
    scr_wws_send_packet(data, send_to, true, false);
}

buffer_delete(data);

to_new = scr_wws_create_packet("PlayerJoinS2C", [send_to, global.save_equipped_hat, room, "change me"]);
scr_wws_send_packet(to_new, socket_id, true);