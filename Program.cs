// See https://aka.ms/new-console-template for more information

using System.Net;
using System.Net.Sockets;
using System.Text;


Int32 port = 5000;
string server = "192.168.0.178";
var word = "02 00 00 60 03 65";

IPAddress ipAddress = IPAddress.Parse(server);
IPEndPoint ipEndPoint = new(ipAddress, port);
using Socket client = new(
    ipEndPoint.AddressFamily, 
    SocketType.Stream, 
    ProtocolType.Tcp);

    await client.ConnectAsync(ipEndPoint);
// Send message.
    var messageBytes = Encoding.ASCII.GetBytes(word);
    _ = await client.SendAsync(messageBytes, SocketFlags.None);
    Console.WriteLine($"Socket client sent message: \"{word}\"");


    while (true)
{
    

    // Receive ack.
    var buffer = new byte[18];
    var received = await client.ReceiveAsync(buffer, SocketFlags.None);
    var response = Encoding.ASCII.GetString(buffer, 0, received);

    if (response.Any())
    {
        Console.WriteLine(
            $"Socket client received acknowledgment: \"{response}\"");
        break;
    }
    Console.WriteLine(
            $"Socket client received acknowledgment: \"{response}\"");
    
}




    
Console.WriteLine("Hello, World!");
