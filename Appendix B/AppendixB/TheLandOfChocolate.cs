using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IronRuby;
using IronRuby.Builtins;
using IronRuby.Runtime;

namespace AppendixB
{
    [RubyModule("MyIronRubyModule", BuildConfig = "!SILVERLIGHT")]
    public class MyModule {

        [RubyClass("MyClass")]
        public class TheLandOfChocolate {

            [RubyConstant("DEFAULT_COLOR")]
            public const string DEFAULT_CHOCOLATE_COLOR = "milk";

            [RubyMethod("foo_bar?")]
            public static bool IsFooBar(RubyContext context, object self) {
                return true;
            }

        }

        [RubyConstant("MySingletonClass")]
        [RubySingleton]
        public class MySingletonClass { }

        [RubyMethod("Foo")]
        public static void Foo(object self) {
            Console.WriteLine("Foo");
        }

    }

    [RubyClass]
    [Includes(typeof(MyModule), Copy = true)]
    [HideMethod("Foo")]
    public class MyClass {
        /* "Foo" is no longer visible to IronRuby */

        [RubyConstructor]
        public static MyClass CreateMyClass(RubyClass self) {
            return new MyClass();
        }
    }

    [RubyException("MyError")]
    [Serializable]
    public class MyError : Exception
    {
        public MyError(string msg, Exception innerEx) : base(msg, innerEx) {
        }
    }

}
