var data = argument0;
var pid = buffer_read(data, buffer_u16);
var checksum = buffer_read(data, buffer_u32);
var calculated_checksum = buffer_crc32(data, 6, buffer_get_size(data) - 6);

// Silently discard packet, might log it to log idk
if (calculated_checksum != checksum)
    return;

var packet = ds_map_find_value(global.wws_packets_by_id, pid);
var args = [argument1]; // Prefill with socket id as arg0

for (var i = 0; i < array_length(packet.types); i++) 
{ 
    var value = buffer_read(data, packet.types[i]);
    args[i + 1] = value;
}

script_execute_ext(packet.handler, args);