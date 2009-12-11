using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.IO.Compression;
using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.Zip;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    
    public class GetChecksum : Task
    {
        private string _dir;
        private string _checksum;
        private string _type;

        [Required]
        public string Folder
        {
            get { return _dir; }
            set { _dir = value; }
        }

        public string CheckSumType
        {
            get { return _type; }
            set { _type = value; }
        }
         
        [Output]
        public string Checksum
        {
            get { return _checksum; }
        }

        public override bool  Execute()
        {
            if (_type != null)
            {
                if (_type.Contains("SHA"))
                {
                    return UseSHA1();
                }
                else
                {
                    return UseMD5();
                }
            }
            else
            {
                return UseMD5();
            }
        }

        private bool UseSHA1()
        {
            SHA1 sha1 = SHA1.Create();
            string zip = @"C:\temp\cs.zip"; //Path.GetTempPath() + @"\checksum.zip";
            StringBuilder sb = new StringBuilder();
            ZipIt(zip);

            sha1.Initialize();

            using (FileStream fs = File.Open(zip, FileMode.Open))
            {
                foreach (byte b in sha1.ComputeHash(fs))
                {
                    sb.Append(b.ToString("x2").ToLower());
                }
            }

            _checksum = sb.ToString();
            File.Delete(zip);
            sha1.Clear();
            return true;

        }

        private bool UseMD5()
        {
            MD5 md5 = MD5.Create();
            
            string zip = @"C:\temp\cs.zip"; //Path.GetTempPath() + @"\checksum.zip";
            StringBuilder sb = new StringBuilder();
            ZipIt(zip);

            md5.Initialize();
    
            using (FileStream fs = File.Open(zip, FileMode.Open))
            {
                foreach (byte b in md5.ComputeHash(fs))
                {
                    sb.Append(b.ToString("x2").ToLower());
                }
            }

            _checksum = sb.ToString();
           File.Delete(zip);
            md5.Clear();
            return true;
        }

        private void ZipIt(string path)
        {
            string[] filenames = Directory.GetFiles(_dir);
            byte[] buffer = new byte[4096];

            using (ZipOutputStream s = new ZipOutputStream(File.Create(path)))
            {

                s.SetLevel(6); // 0 - store only to 9 - means best compression

                foreach (string file in filenames)
                {
                    if (file.EndsWith("dll"))
                    {
                        ZipEntry entry = new ZipEntry(file);
                        s.PutNextEntry(entry);

                        using (FileStream fs = File.OpenRead(file))
                        {
                            StreamUtils.Copy(fs, s, buffer);
                        }
                    }
                }
            }
        }


        #region OLD CODE
        public bool Execute_old()
        {         
            MD5 md5 = MD5.Create();
            StringBuilder sb = new StringBuilder();
            FileStream infile;
            FileStream output = new FileStream(@"c:\temp\csfn.gz", FileMode.CreateNew);
            MemoryStream ms = new MemoryStream();
            // Use the newly created memory stream for the compressed data.
            GZipStream compressedzipStream = new GZipStream(ms , CompressionMode.Compress, true);
            int startpoint = 0;
            StringBuilder str = new StringBuilder();
            
            try
            {
                foreach (string f in Directory.GetFiles(_dir))
                {

                    if (f.EndsWith("dll"))
                    {
                        str.AppendLine(f);
                        // Open the file as a FileStream object.
                        infile = new FileStream(f, FileMode.Open, FileAccess.Read, FileShare.Read);
                        byte[] buffer = new byte[infile.Length];
                        // Read the file to ensure it is readable.

                        int count = infile.Read(buffer, 0, buffer.Length);
                        if (count != buffer.Length)
                        {
                            infile.Close();
                            throw new InvalidOperationException("Test Failed: Unable to read data from file");
                            //return false;
                        }
                        infile.Close();
                         
                        compressedzipStream.Write(buffer, startpoint, buffer.Length);
                       
                        //startpoint = (int)ms.Length + 1;
                       
                        
                    }
                }
            }
            catch (InvalidDataException)
            {
                throw new InvalidOperationException("Error: The file being read contains invalid data.");
            }
            catch (FileNotFoundException)
            {
                throw new InvalidOperationException("Error:The file specified was not found.");
            }
            catch (ArgumentException)
            {
                writeout(str.ToString(), @"c:\temp\checksum.bak");
                throw new InvalidOperationException("Error: path is a zero-length string, contains only white space, or contains one or more invalid characters");
            }
            catch (PathTooLongException)
            {
                throw new InvalidOperationException("Error: The specified path, file name, or both exceed the system-defined maximum length. For example, on Windows-based platforms, paths must be less than 248 characters, and file names must be less than 260 characters.");
            }
            catch (DirectoryNotFoundException)
            {
                throw new InvalidOperationException("Error: The specified path is invalid, such as being on an unmapped drive.");
            }
            catch (IOException)
            {
                throw new InvalidOperationException("Error: An I/O error occurred while opening the file.");
            }
            catch (UnauthorizedAccessException)
            {
                throw new InvalidOperationException("Error: path specified a file that is read-only, the path is a directory, or caller does not have the required permissions.");
            }
            catch (IndexOutOfRangeException)
            {
                throw new InvalidOperationException("Error: You must provide parameters for MyGZIP.");
            }
           

            //get checksum of zip of dlls this makes the checksum a bit more manageable
            foreach (byte b in md5.ComputeHash(ms))
            {
                sb.Append(b.ToString("x2").ToLower());
            }

           
           // Close the stream.
           compressedzipStream.Close();
            _checksum = sb.ToString();
            ms.WriteTo(output);
            ms.Close();
            output.Close();
            return true;

        }
        #endregion

        private void writeout(string text, string path)
        {
            IO oOut = new IO();
            oOut.OutputInText(text, path);
        }

    }
    
}

//using (FileStream fs = File.Open(f, FileMode.Open))
//{
//    foreach (byte b in md5.ComputeHash(fs))
//        sb.Append(b.ToString("x2").ToLower());
//}
