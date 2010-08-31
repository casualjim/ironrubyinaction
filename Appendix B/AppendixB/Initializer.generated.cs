/* ****************************************************************************
 *
 * Copyright (c) Microsoft Corporation. 
 *
 * This source code is subject to terms and conditions of the Microsoft Public License. A 
 * copy of the license can be found in the License.html file at the root of this distribution. If 
 * you cannot locate the  Microsoft Public License, please send an email to 
 * ironruby@microsoft.com. By using this source code in any fashion, you are agreeing to be bound 
 * by the terms of the Microsoft Public License.
 *
 * You must not remove this notice, or any other, from this software.
 *
 *
 * ***************************************************************************/

#pragma warning disable 169 // mcs: unused private method
[assembly: IronRuby.Runtime.RubyLibraryAttribute(typeof(AppendixB.AppendixBLibraryInitializer))]

namespace AppendixB {
    using System;
    using Microsoft.Scripting.Utils;
    
    public sealed class AppendixBLibraryInitializer : IronRuby.Builtins.LibraryInitializer {
        protected override void LoadModules() {
            IronRuby.Builtins.RubyClass classRef0 = GetClass(typeof(System.Object));
            IronRuby.Builtins.RubyClass classRef1 = GetClass(typeof(System.Exception));
            
            
            DefineGlobalClass("MyError", typeof(AppendixB.MyError), 0x00000008, classRef1, null, null, null, IronRuby.Builtins.RubyModule.EmptyArray, 
            new System.Func<IronRuby.Builtins.RubyClass, System.Object, System.Exception>(AppendixBLibraryInitializer.ExceptionFactory__MyError));
            #if !SILVERLIGHT
            IronRuby.Builtins.RubyModule def1 = DefineGlobalModule("MyIronRubyModule", typeof(AppendixB.MyModule), 0x00000008, LoadMyIronRubyModule_Instance, null, null, IronRuby.Builtins.RubyModule.EmptyArray);
            #endif
            #if !SILVERLIGHT
            IronRuby.Builtins.RubyClass def3 = DefineClass("MyIronRubyModule::MyClass", typeof(AppendixB.MyModule.TheLandOfChocolate), 0x00000008, classRef0, LoadMyIronRubyModule__MyClass_Instance, null, LoadMyIronRubyModule__MyClass_Constants, IronRuby.Builtins.RubyModule.EmptyArray);
            #endif
            #if !SILVERLIGHT
            object def2 = DefineSingleton(null, null, null, IronRuby.Builtins.RubyModule.EmptyArray);
            #endif
            DefineGlobalClass("MyClass", typeof(AppendixB.MyClass), 0x00000008, classRef0, LoadMyClass_Instance, LoadMyClass_Class, null, IronRuby.Builtins.RubyModule.EmptyArray, 
                new System.Func<IronRuby.Builtins.RubyClass, AppendixB.MyClass>(AppendixB.MyClass.CreateMyClass)
            );
            #if !SILVERLIGHT
            SetConstant(def1, "MyClass", def3);
            #endif
            #if !SILVERLIGHT
            SetConstant(def1, "MySingletonClass", def2);
            SetConstant(def1, "MySingletonClass", def2);
            #endif
        }
        
        private static void LoadMyClass_Instance(IronRuby.Builtins.RubyModule/*!*/ module) {
            LoadMyIronRubyModule_Instance(module);
            module.HideMethod("Foo");
        }
        
        private static void LoadMyClass_Class(IronRuby.Builtins.RubyModule/*!*/ module) {
        }
        
        #if !SILVERLIGHT
        private static void LoadMyIronRubyModule_Instance(IronRuby.Builtins.RubyModule/*!*/ module) {
            DefineLibraryMethod(module, "Foo", 0x11, 
                0x00000000U, 
                new Action<System.Object>(AppendixB.MyModule.Foo)
            );
            
        }
        #endif
        
        #if !SILVERLIGHT
        private static void LoadMyIronRubyModule__MyClass_Constants(IronRuby.Builtins.RubyModule/*!*/ module) {
            SetConstant(module, "DEFAULT_COLOR", AppendixB.MyModule.TheLandOfChocolate.DEFAULT_CHOCOLATE_COLOR);
            
        }
        #endif
        
        #if !SILVERLIGHT
        private static void LoadMyIronRubyModule__MyClass_Instance(IronRuby.Builtins.RubyModule/*!*/ module) {
            DefineLibraryMethod(module, "foo_bar?", 0x11, 
                0x00000000U, 
                new System.Func<IronRuby.Runtime.RubyContext, System.Object, System.Boolean>(AppendixB.MyModule.TheLandOfChocolate.IsFooBar)
            );
            
        }
        #endif
        
        public static System.Exception/*!*/ ExceptionFactory__MyError(IronRuby.Builtins.RubyClass/*!*/ self, [System.Runtime.InteropServices.DefaultParameterValueAttribute(null)]object message) {
            return IronRuby.Runtime.RubyExceptionData.InitializeException(new AppendixB.MyError(IronRuby.Runtime.RubyExceptionData.GetClrMessage(self, message), (System.Exception)null), message);
        }
        
    }
}

