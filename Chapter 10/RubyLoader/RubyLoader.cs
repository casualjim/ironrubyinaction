using Autodesk.AutoCAD.ApplicationServices;
using Autodesk.AutoCAD.DatabaseServices;
using Autodesk.AutoCAD.Runtime;
using Autodesk.AutoCAD.EditorInput;
using IronRuby.Hosting;
using IronRuby;
using Microsoft.Scripting.Hosting;
using System.Reflection;
using System;
 
namespace RubyLoader
{
  public class Commands
  {
    [CommandMethod("-RBLOAD")]
    public static void RubyLoadCmdLine()
    {
      RubyLoad(true);
    }
 
    [CommandMethod("RBLOAD")]
    public static void RubyLoadUI()
    {
      RubyLoad(false);
    }
 
    public static void RubyLoad(bool useCmdLine)
    {
      Document doc = Application.DocumentManager.MdiActiveDocument;
      Editor ed = doc.Editor;
 
      short fd = (short)Application.GetSystemVariable("FILEDIA");
 
      PromptOpenFileOptions pfo = new PromptOpenFileOptions(
            "Select Ruby script to load");
      pfo.Filter = "Ruby script (*.rb)|*.rb";
      pfo.PreferCommandLine = (useCmdLine || fd == 0);
      PromptFileNameResult pr = ed.GetFileNameForOpen(pfo);
 
      if (pr.Status == PromptStatus.OK)
        ExecuteRubyScript(pr.StringResult);
    }
 
    [LispFunction("RBLOAD")]
    public ResultBuffer RubyLoadLISP(ResultBuffer rb)
    {
      const int RTSTR = 5005;
 
      Document doc = Application.DocumentManager.MdiActiveDocument;
      Editor ed = doc.Editor;
 
      if (rb == null)
      {
        ed.WriteMessage("\nError: too few arguments\n");
      }
      else
      {
        Array args = rb.AsArray();
        TypedValue tv = (TypedValue)args.GetValue(0);
 
        if (tv != null && tv.TypeCode == RTSTR)
        {
          bool success =
            ExecuteRubyScript(Convert.ToString(tv.Value));
          return
            (success 
              ? new ResultBuffer(new TypedValue(RTSTR, tv.Value))
              : null);
        }
      }
      return null;
    }
 
    private static bool ExecuteRubyScript(string file)
    {
      bool ret = System.IO.File.Exists(file);
      if (ret)
      {
        try
        {
          LanguageSetup ls = Ruby.CreateRubySetup();
          ScriptRuntimeSetup rs = new ScriptRuntimeSetup();
          rs.LanguageSetups.Add(ls);
          rs.DebugMode = true;
 
          ScriptRuntime runtime = Ruby.CreateRuntime(rs);
          runtime.LoadAssembly(
            Assembly.GetAssembly(typeof(Commands))
          );
 
          ScriptEngine engine = Ruby.GetEngine(runtime);
          engine.ExecuteFile(file);
        }
        catch (System.Exception ex)
        {
          Document doc =
            Application.DocumentManager.MdiActiveDocument;
          Editor ed = doc.Editor;
 
          ed.WriteMessage(
            "\nProblem executing script: {0}", ex
          );
        }
      }
      return ret;
    }
  }
}

