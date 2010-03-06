using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Windows.Data;
using System.Windows.Markup;
using IronRuby;
using IronRuby.Builtins;
using Microsoft.Scripting.Hosting;

namespace Witty.Controls
{
public class RubyConverterExtension : MarkupExtension
{
    private static ScriptRuntime _scriptRuntime;
    public static ICollection<string> LoadPaths { get; set; }

    public string ConverterName { get; set; }
    private const string Suffix = "_converter";
    private ScriptEngine _engine;
    private ObjectOperations _operations;

    public static ScriptRuntime Runtime
    {
        get
        {
            if (_scriptRuntime.IsNotNull()) return _scriptRuntime;

            var setup = new ScriptRuntimeSetup();
            setup.LanguageSetups.Add(Ruby.CreateRubySetup());
            return (_scriptRuntime = Ruby.CreateRuntime(setup));
        }
        set { _scriptRuntime = value; }
    }

    public override object ProvideValue(IServiceProvider serviceProvider)
    {
        EnsureRubyEngine();

        var name = ConverterName.Underscore();
        if(!Regex.IsMatch(name, string.Format("{0}$", Suffix))) name += Suffix;

        return LoadObject<IValueConverter>(name);
    }

    void EnsureRubyEngine()
    {
        if (_engine.IsNull())
        {
            _engine = Ruby.GetEngine(Runtime);
            _engine.SetSearchPaths(LoadPaths);
            _engine.RequireFile("PresentationFramework");
        }
        if (_operations.IsNull()) _operations = _engine.CreateOperations();
    }

    T LoadObject<T>(string fileName)
    {
        var nm = Path.GetFileNameWithoutExtension(fileName);
        _engine.RequireFile(nm);
        var klass = Runtime.Globals.GetVariable<RubyClass>(nm.Pascalize());
        return (T)_operations.CreateInstance(klass);
    }

}
}