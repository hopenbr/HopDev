// Copyright (c) 2007 Readify Pty. Ltd.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Xml;
using System.Security.Cryptography;
using System.Xml.Serialization;
using System.Security.Cryptography.Xml;
using Readify.Useful.TeamFoundation.Common;

namespace TfsDeployer
{
    public static class Encrypter
    {

        public static RSACryptoServiceProvider GenerateKey()
        {


            // Create a new RSA signing key and save it in the container. 
            RSACryptoServiceProvider rsaKey = new RSACryptoServiceProvider();
            return rsaKey;
        }

        public static RSACryptoServiceProvider ReadKey(string fileName)
        {

            if (File.Exists(fileName))
            {
                using (TextReader reader = new StreamReader(fileName))
                {
                    XmlSerializer serializer = new XmlSerializer(typeof(RSAParameters));
                    RSAParameters parameters = (RSAParameters)serializer.Deserialize(reader);
                    reader.Close();
                    RSACryptoServiceProvider rsaKey = new RSACryptoServiceProvider();
                    rsaKey.ImportParameters(parameters);
                    return rsaKey;
                }

            }
            else
            {
                throw new ArgumentOutOfRangeException("fileName", fileName, "Key File cannot be found");
            }

        }

        public static void SaveKey(string fileName, RSACryptoServiceProvider key)
        {
            RSAParameters parameters = key.ExportParameters(true);
            XmlSerializer serializer = new XmlSerializer(typeof(RSAParameters));
            try
            {
                using (FileStream fs = new FileStream(fileName, FileMode.Create))
                {
                    TextWriter writer = new StreamWriter(fs, new UTF8Encoding());
                    // Serialize using the XmlTextWriter.
                    serializer.Serialize(writer, parameters);
                    writer.Close();

                }
            }
            catch(Exception ex)
            {
                TraceHelper.TraceWarning(TraceSwitches.TfsDeployer, "Cannot save key file {0}.", fileName);
                throw;
            }

        }


        public static Boolean VerifyXml(string fileName, string rsaKeyName)
        {
            if (!File.Exists(rsaKeyName))
            {
                TraceHelper.TraceWarning(TraceSwitches.TfsDeployer,"Cannot find key file {0} in order to verify the deployment mappings file.",rsaKeyName);
                return false;
            }
            if (!File.Exists(fileName))
            {
                TraceHelper.TraceWarning(TraceSwitches.TfsDeployer,"Cannot find deployment mapping file {0}.",fileName);
                return false;
            }
            XmlDocument doc = new XmlDocument();
            doc.Load(fileName);
            RSACryptoServiceProvider key = ReadKey(rsaKeyName);
            return VerifyXml(doc, key);
        }

        // Verify the signature of an XML file against an asymmetric 
        // algorithm and return the result.
        public static Boolean VerifyXml(XmlDocument Doc, RSA Key)
        {
            // Check arguments.
            if (Doc == null)
                throw new ArgumentException("Doc");
            if (Key == null)
                throw new ArgumentException("Key");

            // Create a new SignedXml object and pass it
            // the XML document class.
            SignedXml signedXml = new SignedXml(Doc);

            // Find the "Signature" node and create a new
            // XmlNodeList object.
            XmlNodeList nodeList = Doc.GetElementsByTagName("Signature");

            // Throw an exception if no signature was found.
            if (nodeList.Count <= 0)
            {
                TraceHelper.TraceWarning(TraceSwitches.TfsDeployer,"Verification failed: No Signature was found in the document.");
                return false;
            }

            // This example only supports one signature for
            // the entire XML document.  Throw an exception 
            // if more than one signature was found.
            if (nodeList.Count >= 2)
            {
                TraceHelper.TraceWarning(TraceSwitches.TfsDeployer, "Verification failed: More that one signature was found for the document.");
                return false;
            }

            // Load the first <signature> node.  
            signedXml.LoadXml((XmlElement)nodeList[0]);

            // Check the signature and return the result.
            return signedXml.CheckSignature(Key);
        }

        // Sign an XML file. 
        // This document cannot be verified unless the verifying 
        // code has the key with which it was signed.
        public static void SignXml(XmlDocument Doc, RSA Key)
        {
            // Check arguments.
            if (Doc == null)
                throw new ArgumentException("Doc");
            if (Key == null)
                throw new ArgumentException("Key");

            // Create a SignedXml object.
            SignedXml signedXml = new SignedXml(Doc);

            // Add the key to the SignedXml document.
            signedXml.SigningKey = Key;

            // Create a reference to be signed.
            Reference reference = new Reference();
            reference.Uri = "";

            // Add an enveloped transformation to the reference.
            XmlDsigEnvelopedSignatureTransform env = new XmlDsigEnvelopedSignatureTransform();
            reference.AddTransform(env);

            // Add the reference to the SignedXml object.
            signedXml.AddReference(reference);

            // Compute the signature.
            signedXml.ComputeSignature();

            // Get the XML representation of the signature and save
            // it to an XmlElement object.
            XmlElement xmlDigitalSignature = signedXml.GetXml();

            // Append the element to the XML document.
            Doc.DocumentElement.AppendChild(Doc.ImportNode(xmlDigitalSignature, true));

        }

        public static void Encryt(CommandLine commandLine)
        {
            RSACryptoServiceProvider key = RetrieveKey(commandLine);
            if (commandLine.EncyptDeploymentFile)
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(commandLine.DeploymentMappingFileName);
                SignXml(doc, key);
                doc.Save(commandLine.DeploymentMappingFileName);
            }
        }

        private static RSACryptoServiceProvider RetrieveKey(CommandLine commandLine)
        {
            RSACryptoServiceProvider key;
            if (commandLine.CreateKeyFile)
            {
                key = GenerateKey();
                SaveKey(commandLine.CreateKeyFileName, key);
                Console.WriteLine(string.Format("Created the Key File {0}.", commandLine.CreateKeyFileName));
            }
            else
            {
                key = ReadKey(commandLine.KeyFileName);
            }
            return key;
        }

    }
}
