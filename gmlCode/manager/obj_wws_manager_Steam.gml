var packet = buffer_create(6, buffer_grow, 1);
while (steam_net_packet_receive())
{
    steam_net_packet_get_data(packet);
    buffer_seek(packet, buffer_seek_start, 0);
    scr_wws_handle_packet(packet);
}