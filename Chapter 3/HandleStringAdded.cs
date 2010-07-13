using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
            ScriptEngine engine = Ruby.GetEngine(runtime);
            ScriptScope scope = engine.CreateScope();
            StringAdder adder = new StringAdder();

            engine.Execute("def self.string_added(val = ''); puts \"The string \\\"#{val}\\\" has been added.\"; end;", scope);
            StringAdder.StringAddedDelegate functionPointer = scope.GetVariable<StringAdder.StringAddedDelegate>("string_added");

            adder.StringAdded += functionPointer;

            Console.WriteLine("Initialisation complete. About to add some strings.\r\n");
            adder.Add("IronRuby");
            adder.Add("IronPython");
            adder.Add("IronJS");
            adder.Add("IronScheme");
            adder.Add("Nua");
            adder.Add("Clojure");

            Console.WriteLine("\r\nSome DLR languages: " + adder);

            // Outputs the following:
            //
            // Initialisation complete. About to add some strings.
            //
            // The string "IronRuby" has been added.
            // The string "IronPython" has been added.
            // The string "IronJS" has been added.
            // The string "IronScheme" has been added.
            // The string "Nua" has been added.
            // The string "Clojure" has been added.
            //
            // Some DLR languages: IronRuby, IronPython, VBx, Managed JavaScript, IronLisp, IronScheme, Nua
        }
    }
}
