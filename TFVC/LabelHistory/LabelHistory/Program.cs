using System;
using System.IO;
using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Common;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.VersionControl.Client;
using Microsoft.TeamFoundation.VersionControl.Common;

//
// code originally written by Buck Hodges (MSFT)
// http://blogs.msdn.com/buckh/archive/2005/10/25/484854.aspx
//

class Program
{
    static void Main(string[] args)
    {
        
        // Check and get the arguments.
        String path, scope;
        VersionControlServer sourceControl;
        GetPathAndScope(args, out path, out scope, out sourceControl);

        // Retrieve and print the label history for the file.
        VersionControlLabel[] labels = null;
        try
        {
            // The first three arguments here are null because we do not
            // want to filter by label name, scope, or owner.
            // Since we don't need the server to send back the items in
            // the label, we get much better performance by ommitting
            // those through setting the fourth parameter to false.
            labels = sourceControl.QueryLabels(null, scope, null, false, path, VersionSpec.Latest);
        }
        catch (TeamFoundationServerException e)
        {
            // We couldn't contact the server, the item wasn't found,
            // or there was some other problem reported by the server,
            // so we stop here.
            Console.Error.WriteLine(e.Message);
            Environment.Exit(1);
        }

        if (labels.Length == 0)
        {
            Console.WriteLine("There are no labels for " + path);
        }
        else
        {
            foreach (VersionControlLabel label in labels)
            {
                // Display the label's name and when it was last modified.
                Console.WriteLine("{0} ({1})", label.Name, label.LastModifiedDate.ToString("g"));

                // For labels that actually have comments, display it.
                if (label.Comment.Length > 0)
                {
                    Console.WriteLine("   Comment: " + label.Comment);
                }
            }
        }
    }

    private static void ShowHelp()
    {
        Console.WriteLine("Usage: labelhist");
        Console.WriteLine("       labelhist path [label scope]");
        Console.WriteLine();
        Console.WriteLine("With no arguments, all label names and comments are displayed.");
        Console.WriteLine("If a path is specified, only the labels containing that path");
        Console.WriteLine("are displayed.");
        Console.WriteLine("If a scope is supplied, only labels at or below that scope will");
        Console.WriteLine("will be displayed.");
        Console.WriteLine();
        Console.WriteLine("Examples: labelhist c:\\projects\\secret\\notes.txt");
        Console.WriteLine("          labelhist $/secret/notes.txt");
        Console.WriteLine("          labelhist c:\\projects\\secret\\notes.txt $/secret");
    }

    private static void GetPathAndScope(String[] args, out String path, out String scope, 
        out VersionControlServer sourceControl)
    {
        // This little app takes either no args or a file path and optionally a scope.
        if (args.Length > 2 || args.Length == 1 && args[0] == "/?")
        {
            ShowHelp();
            Environment.Exit(1);
        }

        // Figure out the server based on either the argument or the current directory.
        WorkspaceInfo wi = null;
        if (args.Length < 1)
        {
            path = null;
        }
        else
        {
            path = args[0];
            try
            {
                if (!VersionControlPath.IsServerItem(path))
                {
                    wi = Workstation.Current.GetLocalWorkspaceInfo(path);
                }
            }
            catch (Exception e)
            {
                // The user provided a bad path argument.
                Console.Error.WriteLine(e.Message);
                Environment.Exit(1);
            }
        }

        if (wi == null)
        {
            wi = Workstation.Current.GetLocalWorkspaceInfo(Environment.CurrentDirectory);
        }

        // Stop if we couldn't figure out the server.
        if (wi == null)
        {
            Console.Error.WriteLine("Unable to automatically determine the Team Foundation Server. You must execute this command from a local path that is mapped to a TFS Workspace.");
            Environment.Exit(1);
        }

        TeamFoundationServer tfs = TeamFoundationServerFactory.GetServer(wi.ServerUri.AbsoluteUri);
        sourceControl = (VersionControlServer)tfs.GetService(typeof(VersionControlServer));

        // Pick up the label scope, if supplied.
        scope = VersionControlPath.RootFolder;
        if (args.Length == 2)
        {
            // The scope must be a server path, so we convert it here if
            // the user specified a local path.
            if (!VersionControlPath.IsServerItem(args[1]))
            {
                Workspace workspace = wi.GetWorkspace(tfs);
                scope = workspace.GetServerItemForLocalItem(args[1]);
            }
            else
            {
                scope = args[1];
            }
        }
    }
}