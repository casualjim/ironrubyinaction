using System;
using Microsoft.Scripting;
using Microsoft.Scripting.Hosting;
using IronRuby;

namespace DLRHost
{
    class Program
    {
        static void Main(string[] args)
        {
            ScriptRuntime runtime = Ruby.CreateRuntime(); 

            Console.WriteLine("Executing from file:"); 
            runtime.ExecuteFile("hello_world.rb"); 

            Console.WriteLine("Press any key to close...");
            Console.ReadKey();
        }
    }
}
