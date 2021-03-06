[System.Reflection.Assembly]::Load("Microsoft.SqlServer.Smo,Culture=Neutral,Version=9.0.242.0,PublicKeyToken=89845dcd8080cc91") | out-null
[System.Reflection.Assembly]::Load("Microsoft.SqlServer.ConnectionInfo,Culture=Neutral,Version=9.0.242.0,PublicKeyToken=89845dcd8080cc91") | out-null
[System.Reflection.Assembly]::Load("System.Data,Culture=Neutral,Version=2.0.0.0,PublicKeyToken=b77a5c561934e089") | out-null
[System.Reflection.Assembly]::Load("Microsoft.SqlServer.SqlEnum,Culture=Neutral,Version=9.0.242.0,PublicKeyToken=89845dcd8080cc91") | out-null


function global:Get-SMOT_ExecutionStatus
{
[Microsoft.SqlServer.Management.Smo.ExecutionStatus]
}

New-Alias gst_ExecutionStatus Get-SMOT_ExecutionStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ExecutionStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ExecutionStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ExecutionStatus" ($args)
}
}

New-Alias gs_ExecutionStatus Get-SMO_ExecutionStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SmoApplication
{
[Microsoft.SqlServer.Management.Smo.SmoApplication]
}

New-Alias gst_SmoApplication Get-SMOT_SmoApplication -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SmoApplication
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SmoApplication"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SmoApplication" ($args)
}
}

New-Alias gs_SmoApplication Get-SMO_SmoApplication -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SmoEventArgs
{
[Microsoft.SqlServer.Management.Smo.SmoEventArgs]
}

New-Alias gst_SmoEventArgs Get-SMOT_SmoEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SmoEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SmoEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SmoEventArgs" ($args)
}
}

New-Alias gs_SmoEventArgs Get-SMO_SmoEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectCreatedEventArgs
{
[Microsoft.SqlServer.Management.Smo.ObjectCreatedEventArgs]
}

New-Alias gst_ObjectCreatedEventArgs Get-SMOT_ObjectCreatedEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectCreatedEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectCreatedEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectCreatedEventArgs" ($args)
}
}

New-Alias gs_ObjectCreatedEventArgs Get-SMO_ObjectCreatedEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectDroppedEventArgs
{
[Microsoft.SqlServer.Management.Smo.ObjectDroppedEventArgs]
}

New-Alias gst_ObjectDroppedEventArgs Get-SMOT_ObjectDroppedEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectDroppedEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectDroppedEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectDroppedEventArgs" ($args)
}
}

New-Alias gs_ObjectDroppedEventArgs Get-SMO_ObjectDroppedEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectRenamedEventArgs
{
[Microsoft.SqlServer.Management.Smo.ObjectRenamedEventArgs]
}

New-Alias gst_ObjectRenamedEventArgs Get-SMOT_ObjectRenamedEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectRenamedEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectRenamedEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectRenamedEventArgs" ($args)
}
}

New-Alias gs_ObjectRenamedEventArgs Get-SMO_ObjectRenamedEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectAlteredEventArgs
{
[Microsoft.SqlServer.Management.Smo.ObjectAlteredEventArgs]
}

New-Alias gst_ObjectAlteredEventArgs Get-SMOT_ObjectAlteredEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectAlteredEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectAlteredEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectAlteredEventArgs" ($args)
}
}

New-Alias gs_ObjectAlteredEventArgs Get-SMO_ObjectAlteredEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseEventType
{
[Microsoft.SqlServer.Management.Smo.DatabaseEventType]
}

New-Alias gst_DatabaseEventType Get-SMOT_DatabaseEventType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseEventType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEventType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEventType" ($args)
}
}

New-Alias gs_DatabaseEventType Get-SMO_DatabaseEventType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseEventArgs
{
[Microsoft.SqlServer.Management.Smo.DatabaseEventArgs]
}

New-Alias gst_DatabaseEventArgs Get-SMOT_DatabaseEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEventArgs" ($args)
}
}

New-Alias gs_DatabaseEventArgs Get-SMO_DatabaseEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SmoObjectBase
{
[Microsoft.SqlServer.Management.Smo.SmoObjectBase]
}

New-Alias gst_SmoObjectBase Get-SMOT_SmoObjectBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SmoObjectBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SmoObjectBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SmoObjectBase" ($args)
}
}

New-Alias gs_SmoObjectBase Get-SMO_SmoObjectBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlSmoObject
{
[Microsoft.SqlServer.Management.Smo.SqlSmoObject]
}

New-Alias gst_SqlSmoObject Get-SMOT_SqlSmoObject -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlSmoObject
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlSmoObject"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlSmoObject" ($args)
}
}

New-Alias gs_SqlSmoObject Get-SMO_SqlSmoObject -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NamedSmoObject
{
[Microsoft.SqlServer.Management.Smo.NamedSmoObject]
}

New-Alias gst_NamedSmoObject Get-SMOT_NamedSmoObject -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NamedSmoObject
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.NamedSmoObject"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.NamedSmoObject" ($args)
}
}

New-Alias gs_NamedSmoObject Get-SMO_NamedSmoObject -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ScriptNameObjectBase
{
[Microsoft.SqlServer.Management.Smo.ScriptNameObjectBase]
}

New-Alias gst_ScriptNameObjectBase Get-SMOT_ScriptNameObjectBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ScriptNameObjectBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptNameObjectBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptNameObjectBase" ($args)
}
}

New-Alias gs_ScriptNameObjectBase Get-SMO_ScriptNameObjectBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IExtendedProperties
{
[Microsoft.SqlServer.Management.Smo.IExtendedProperties]
}

New-Alias gst_IExtendedProperties Get-SMOT_IExtendedProperties -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IExtendedProperties
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IExtendedProperties"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IExtendedProperties" ($args)
}
}

New-Alias gs_IExtendedProperties Get-SMO_IExtendedProperties -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Column
{
[Microsoft.SqlServer.Management.Smo.Column]
}

New-Alias gst_Column Get-SMOT_Column -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Column
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Column"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Column" ($args)
}
}

New-Alias gs_Column Get-SMO_Column -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AbstractCollectionBase
{
[Microsoft.SqlServer.Management.Smo.AbstractCollectionBase]
}

New-Alias gst_AbstractCollectionBase Get-SMOT_AbstractCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AbstractCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AbstractCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AbstractCollectionBase" ($args)
}
}

New-Alias gs_AbstractCollectionBase Get-SMO_AbstractCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SmoCollectionBase
{
[Microsoft.SqlServer.Management.Smo.SmoCollectionBase]
}

New-Alias gst_SmoCollectionBase Get-SMOT_SmoCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SmoCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SmoCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SmoCollectionBase" ($args)
}
}

New-Alias gs_SmoCollectionBase Get-SMO_SmoCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ArrayListCollectionBase
{
[Microsoft.SqlServer.Management.Smo.ArrayListCollectionBase]
}

New-Alias gst_ArrayListCollectionBase Get-SMOT_ArrayListCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ArrayListCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ArrayListCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ArrayListCollectionBase" ($args)
}
}

New-Alias gs_ArrayListCollectionBase Get-SMO_ArrayListCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ParameterCollectionBase
{
[Microsoft.SqlServer.Management.Smo.ParameterCollectionBase]
}

New-Alias gst_ParameterCollectionBase Get-SMOT_ParameterCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ParameterCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ParameterCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ParameterCollectionBase" ($args)
}
}

New-Alias gs_ParameterCollectionBase Get-SMO_ParameterCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ColumnCollection
{
[Microsoft.SqlServer.Management.Smo.ColumnCollection]
}

New-Alias gst_ColumnCollection Get-SMOT_ColumnCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ColumnCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ColumnCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ColumnCollection" ($args)
}
}

New-Alias gs_ColumnCollection Get-SMO_ColumnCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerProxyAccount
{
[Microsoft.SqlServer.Management.Smo.ServerProxyAccount]
}

New-Alias gst_ServerProxyAccount Get-SMOT_ServerProxyAccount -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerProxyAccount
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerProxyAccount"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerProxyAccount" ($args)
}
}

New-Alias gs_ServerProxyAccount Get-SMO_ServerProxyAccount -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SortedListCollectionBase
{
[Microsoft.SqlServer.Management.Smo.SortedListCollectionBase]
}

New-Alias gst_SortedListCollectionBase Get-SMOT_SortedListCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SortedListCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SortedListCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SortedListCollectionBase" ($args)
}
}

New-Alias gs_SortedListCollectionBase Get-SMO_SortedListCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SimpleObjectCollectionBase
{
[Microsoft.SqlServer.Management.Smo.SimpleObjectCollectionBase]
}

New-Alias gst_SimpleObjectCollectionBase Get-SMOT_SimpleObjectCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SimpleObjectCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SimpleObjectCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SimpleObjectCollectionBase" ($args)
}
}

New-Alias gs_SimpleObjectCollectionBase Get-SMO_SimpleObjectCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SymmetricKeyCollection
{
[Microsoft.SqlServer.Management.Smo.SymmetricKeyCollection]
}

New-Alias gst_SymmetricKeyCollection Get-SMOT_SymmetricKeyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SymmetricKeyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKeyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKeyCollection" ($args)
}
}

New-Alias gs_SymmetricKeyCollection Get-SMO_SymmetricKeyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_KeyEncryptionType
{
[Microsoft.SqlServer.Management.Smo.KeyEncryptionType]
}

New-Alias gst_KeyEncryptionType Get-SMOT_KeyEncryptionType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_KeyEncryptionType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.KeyEncryptionType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.KeyEncryptionType" ($args)
}
}

New-Alias gs_KeyEncryptionType Get-SMO_KeyEncryptionType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SymmetricKeyEncryption
{
[Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryption]
}

New-Alias gst_SymmetricKeyEncryption Get-SMOT_SymmetricKeyEncryption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SymmetricKeyEncryption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryption" ($args)
}
}

New-Alias gs_SymmetricKeyEncryption Get-SMO_SymmetricKeyEncryption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IObjectPermission
{
[Microsoft.SqlServer.Management.Smo.IObjectPermission]
}

New-Alias gst_IObjectPermission Get-SMOT_IObjectPermission -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IObjectPermission
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IObjectPermission"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IObjectPermission" ($args)
}
}

New-Alias gs_IObjectPermission Get-SMO_IObjectPermission -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SymmetricKey
{
[Microsoft.SqlServer.Management.Smo.SymmetricKey]
}

New-Alias gst_SymmetricKey Get-SMOT_SymmetricKey -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SymmetricKey
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKey"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKey" ($args)
}
}

New-Alias gs_SymmetricKey Get-SMO_SymmetricKey -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AsymmetricKeyCollection
{
[Microsoft.SqlServer.Management.Smo.AsymmetricKeyCollection]
}

New-Alias gst_AsymmetricKeyCollection Get-SMOT_AsymmetricKeyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AsymmetricKeyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AsymmetricKeyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AsymmetricKeyCollection" ($args)
}
}

New-Alias gs_AsymmetricKeyCollection Get-SMO_AsymmetricKeyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AsymmetricKeySourceType
{
[Microsoft.SqlServer.Management.Smo.AsymmetricKeySourceType]
}

New-Alias gst_AsymmetricKeySourceType Get-SMOT_AsymmetricKeySourceType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AsymmetricKeySourceType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AsymmetricKeySourceType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AsymmetricKeySourceType" ($args)
}
}

New-Alias gs_AsymmetricKeySourceType Get-SMO_AsymmetricKeySourceType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AsymmetricKey
{
[Microsoft.SqlServer.Management.Smo.AsymmetricKey]
}

New-Alias gst_AsymmetricKey Get-SMOT_AsymmetricKey -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AsymmetricKey
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AsymmetricKey"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AsymmetricKey" ($args)
}
}

New-Alias gs_AsymmetricKey Get-SMO_AsymmetricKey -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseCollection
{
[Microsoft.SqlServer.Management.Smo.DatabaseCollection]
}

New-Alias gst_DatabaseCollection Get-SMOT_DatabaseCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseCollection" ($args)
}
}

New-Alias gs_DatabaseCollection Get-SMO_DatabaseCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IScriptable
{
[Microsoft.SqlServer.Management.Smo.IScriptable]
}

New-Alias gst_IScriptable Get-SMOT_IScriptable -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IScriptable
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IScriptable"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IScriptable" ($args)
}
}

New-Alias gs_IScriptable Get-SMO_IScriptable -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseRole
{
[Microsoft.SqlServer.Management.Smo.DatabaseRole]
}

New-Alias gst_DatabaseRole Get-SMOT_DatabaseRole -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseRole
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseRole"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseRole" ($args)
}
}

New-Alias gs_DatabaseRole Get-SMO_DatabaseRole -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseRoleCollection
{
[Microsoft.SqlServer.Management.Smo.DatabaseRoleCollection]
}

New-Alias gst_DatabaseRoleCollection Get-SMOT_DatabaseRoleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseRoleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseRoleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseRoleCollection" ($args)
}
}

New-Alias gs_DatabaseRoleCollection Get-SMO_DatabaseRoleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SmoExceptionType
{
[Microsoft.SqlServer.Management.Smo.SmoExceptionType]
}

New-Alias gst_SmoExceptionType Get-SMOT_SmoExceptionType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SmoExceptionType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SmoExceptionType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SmoExceptionType" ($args)
}
}

New-Alias gs_SmoExceptionType Get-SMO_SmoExceptionType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SmoException
{
[Microsoft.SqlServer.Management.Smo.SmoException]
}

New-Alias gst_SmoException Get-SMOT_SmoException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SmoException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SmoException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SmoException" ($args)
}
}

New-Alias gs_SmoException Get-SMO_SmoException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MissingObjectException
{
[Microsoft.SqlServer.Management.Smo.MissingObjectException]
}

New-Alias gst_MissingObjectException Get-SMOT_MissingObjectException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MissingObjectException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MissingObjectException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MissingObjectException" ($args)
}
}

New-Alias gs_MissingObjectException Get-SMO_MissingObjectException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PropertyNotSetException
{
[Microsoft.SqlServer.Management.Smo.PropertyNotSetException]
}

New-Alias gst_PropertyNotSetException Get-SMOT_PropertyNotSetException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PropertyNotSetException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyNotSetException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyNotSetException" ($args)
}
}

New-Alias gs_PropertyNotSetException Get-SMO_PropertyNotSetException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_WrongPropertyValueException
{
[Microsoft.SqlServer.Management.Smo.WrongPropertyValueException]
}

New-Alias gst_WrongPropertyValueException Get-SMOT_WrongPropertyValueException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_WrongPropertyValueException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.WrongPropertyValueException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.WrongPropertyValueException" ($args)
}
}

New-Alias gs_WrongPropertyValueException Get-SMO_WrongPropertyValueException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PropertyTypeMismatchException
{
[Microsoft.SqlServer.Management.Smo.PropertyTypeMismatchException]
}

New-Alias gst_PropertyTypeMismatchException Get-SMOT_PropertyTypeMismatchException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PropertyTypeMismatchException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyTypeMismatchException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyTypeMismatchException" ($args)
}
}

New-Alias gs_PropertyTypeMismatchException Get-SMO_PropertyTypeMismatchException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UnknownPropertyException
{
[Microsoft.SqlServer.Management.Smo.UnknownPropertyException]
}

New-Alias gst_UnknownPropertyException Get-SMOT_UnknownPropertyException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UnknownPropertyException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UnknownPropertyException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UnknownPropertyException" ($args)
}
}

New-Alias gs_UnknownPropertyException Get-SMO_UnknownPropertyException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PropertyReadOnlyException
{
[Microsoft.SqlServer.Management.Smo.PropertyReadOnlyException]
}

New-Alias gst_PropertyReadOnlyException Get-SMOT_PropertyReadOnlyException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PropertyReadOnlyException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyReadOnlyException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyReadOnlyException" ($args)
}
}

New-Alias gs_PropertyReadOnlyException Get-SMO_PropertyReadOnlyException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PropertyWriteException
{
[Microsoft.SqlServer.Management.Smo.PropertyWriteException]
}

New-Alias gst_PropertyWriteException Get-SMOT_PropertyWriteException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PropertyWriteException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyWriteException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyWriteException" ($args)
}
}

New-Alias gs_PropertyWriteException Get-SMO_PropertyWriteException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InvalidSmoOperationException
{
[Microsoft.SqlServer.Management.Smo.InvalidSmoOperationException]
}

New-Alias gst_InvalidSmoOperationException Get-SMOT_InvalidSmoOperationException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InvalidSmoOperationException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.InvalidSmoOperationException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.InvalidSmoOperationException" ($args)
}
}

New-Alias gs_InvalidSmoOperationException Get-SMO_InvalidSmoOperationException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InvalidVersionSmoOperationException
{
[Microsoft.SqlServer.Management.Smo.InvalidVersionSmoOperationException]
}

New-Alias gst_InvalidVersionSmoOperationException Get-SMOT_InvalidVersionSmoOperationException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InvalidVersionSmoOperationException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.InvalidVersionSmoOperationException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.InvalidVersionSmoOperationException" ($args)
}
}

New-Alias gs_InvalidVersionSmoOperationException Get-SMO_InvalidVersionSmoOperationException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CollectionNotAvailableException
{
[Microsoft.SqlServer.Management.Smo.CollectionNotAvailableException]
}

New-Alias gst_CollectionNotAvailableException Get-SMOT_CollectionNotAvailableException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CollectionNotAvailableException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CollectionNotAvailableException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CollectionNotAvailableException" ($args)
}
}

New-Alias gs_CollectionNotAvailableException Get-SMO_CollectionNotAvailableException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PropertyCannotBeRetrievedException
{
[Microsoft.SqlServer.Management.Smo.PropertyCannotBeRetrievedException]
}

New-Alias gst_PropertyCannotBeRetrievedException Get-SMOT_PropertyCannotBeRetrievedException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PropertyCannotBeRetrievedException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyCannotBeRetrievedException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyCannotBeRetrievedException" ($args)
}
}

New-Alias gs_PropertyCannotBeRetrievedException Get-SMO_PropertyCannotBeRetrievedException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InternalSmoErrorException
{
[Microsoft.SqlServer.Management.Smo.InternalSmoErrorException]
}

New-Alias gst_InternalSmoErrorException Get-SMOT_InternalSmoErrorException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InternalSmoErrorException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.InternalSmoErrorException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.InternalSmoErrorException" ($args)
}
}

New-Alias gs_InternalSmoErrorException Get-SMO_InternalSmoErrorException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FailedOperationException
{
[Microsoft.SqlServer.Management.Smo.FailedOperationException]
}

New-Alias gst_FailedOperationException Get-SMOT_FailedOperationException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FailedOperationException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FailedOperationException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FailedOperationException" ($args)
}
}

New-Alias gs_FailedOperationException Get-SMO_FailedOperationException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UnsupportedObjectNameException
{
[Microsoft.SqlServer.Management.Smo.UnsupportedObjectNameException]
}

New-Alias gst_UnsupportedObjectNameException Get-SMOT_UnsupportedObjectNameException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UnsupportedObjectNameException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UnsupportedObjectNameException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UnsupportedObjectNameException" ($args)
}
}

New-Alias gs_UnsupportedObjectNameException Get-SMO_UnsupportedObjectNameException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceRequestException
{
[Microsoft.SqlServer.Management.Smo.ServiceRequestException]
}

New-Alias gst_ServiceRequestException Get-SMOT_ServiceRequestException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceRequestException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceRequestException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceRequestException" ($args)
}
}

New-Alias gs_ServiceRequestException Get-SMO_ServiceRequestException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UnsupportedVersionException
{
[Microsoft.SqlServer.Management.Smo.UnsupportedVersionException]
}

New-Alias gst_UnsupportedVersionException Get-SMOT_UnsupportedVersionException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UnsupportedVersionException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UnsupportedVersionException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UnsupportedVersionException" ($args)
}
}

New-Alias gs_UnsupportedVersionException Get-SMO_UnsupportedVersionException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UnsupportedFeatureException
{
[Microsoft.SqlServer.Management.Smo.UnsupportedFeatureException]
}

New-Alias gst_UnsupportedFeatureException Get-SMOT_UnsupportedFeatureException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UnsupportedFeatureException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UnsupportedFeatureException"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UnsupportedFeatureException" ($args)
}
}

New-Alias gs_UnsupportedFeatureException Get-SMO_UnsupportedFeatureException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AgentObjectBase
{
[Microsoft.SqlServer.Management.Smo.Agent.AgentObjectBase]
}

New-Alias gst_AgentObjectBase Get-SMOT_AgentObjectBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AgentObjectBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AgentObjectBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AgentObjectBase" ($args)
}
}

New-Alias gs_AgentObjectBase Get-SMO_AgentObjectBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Job
{
[Microsoft.SqlServer.Management.Smo.Agent.Job]
}

New-Alias gst_Job Get-SMOT_Job -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Job
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.Job"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.Job" ($args)
}
}

New-Alias gs_Job Get-SMO_Job -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.JobCollection]
}

New-Alias gst_JobCollection Get-SMOT_JobCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobCollection" ($args)
}
}

New-Alias gs_JobCollection Get-SMO_JobCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobHistoryFilter
{
[Microsoft.SqlServer.Management.Smo.Agent.JobHistoryFilter]
}

New-Alias gst_JobHistoryFilter Get-SMOT_JobHistoryFilter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobHistoryFilter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobHistoryFilter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobHistoryFilter" ($args)
}
}

New-Alias gs_JobHistoryFilter Get-SMO_JobHistoryFilter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobServer
{
[Microsoft.SqlServer.Management.Smo.Agent.JobServer]
}

New-Alias gst_JobServer Get-SMOT_JobServer -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobServer
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobServer"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobServer" ($args)
}
}

New-Alias gs_JobServer Get-SMO_JobServer -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobFilter
{
[Microsoft.SqlServer.Management.Smo.Agent.JobFilter]
}

New-Alias gst_JobFilter Get-SMOT_JobFilter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobFilter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobFilter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobFilter" ($args)
}
}

New-Alias gs_JobFilter Get-SMO_JobFilter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FindOperand
{
[Microsoft.SqlServer.Management.Smo.Agent.FindOperand]
}

New-Alias gst_FindOperand Get-SMOT_FindOperand -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FindOperand
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.FindOperand"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.FindOperand" ($args)
}
}

New-Alias gs_FindOperand Get-SMO_FindOperand -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProxyAccount
{
[Microsoft.SqlServer.Management.Smo.Agent.ProxyAccount]
}

New-Alias gst_ProxyAccount Get-SMOT_ProxyAccount -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProxyAccount
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.ProxyAccount"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.ProxyAccount" ($args)
}
}

New-Alias gs_ProxyAccount Get-SMO_ProxyAccount -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProxyAccountCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.ProxyAccountCollection]
}

New-Alias gst_ProxyAccountCollection Get-SMOT_ProxyAccountCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProxyAccountCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.ProxyAccountCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.ProxyAccountCollection" ($args)
}
}

New-Alias gs_ProxyAccountCollection Get-SMO_ProxyAccountCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Language
{
[Microsoft.SqlServer.Management.Smo.Language]
}

New-Alias gst_Language Get-SMOT_Language -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Language
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Language"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Language" ($args)
}
}

New-Alias gs_Language Get-SMO_Language -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LanguageCollection
{
[Microsoft.SqlServer.Management.Smo.LanguageCollection]
}

New-Alias gst_LanguageCollection Get-SMOT_LanguageCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LanguageCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LanguageCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LanguageCollection" ($args)
}
}

New-Alias gs_LanguageCollection Get-SMO_LanguageCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LinkedServer
{
[Microsoft.SqlServer.Management.Smo.LinkedServer]
}

New-Alias gst_LinkedServer Get-SMOT_LinkedServer -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LinkedServer
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedServer"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedServer" ($args)
}
}

New-Alias gs_LinkedServer Get-SMO_LinkedServer -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LinkedServerCollection
{
[Microsoft.SqlServer.Management.Smo.LinkedServerCollection]
}

New-Alias gst_LinkedServerCollection Get-SMOT_LinkedServerCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LinkedServerCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedServerCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedServerCollection" ($args)
}
}

New-Alias gs_LinkedServerCollection Get-SMO_LinkedServerCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LogFileCollection
{
[Microsoft.SqlServer.Management.Smo.LogFileCollection]
}

New-Alias gst_LogFileCollection Get-SMOT_LogFileCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LogFileCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LogFileCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LogFileCollection" ($args)
}
}

New-Alias gs_LogFileCollection Get-SMO_LogFileCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Login
{
[Microsoft.SqlServer.Management.Smo.Login]
}

New-Alias gst_Login Get-SMOT_Login -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Login
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Login"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Login" ($args)
}
}

New-Alias gs_Login Get-SMO_Login -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LoginEvents
{
[Microsoft.SqlServer.Management.Smo.LoginEvents]
}

New-Alias gst_LoginEvents Get-SMOT_LoginEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LoginEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LoginEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LoginEvents" ($args)
}
}

New-Alias gs_LoginEvents Get-SMO_LoginEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LoginCollection
{
[Microsoft.SqlServer.Management.Smo.LoginCollection]
}

New-Alias gst_LoginCollection Get-SMOT_LoginCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LoginCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LoginCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LoginCollection" ($args)
}
}

New-Alias gs_LoginCollection Get-SMO_LoginCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Server
{
[Microsoft.SqlServer.Management.Smo.Server]
}

New-Alias gst_Server Get-SMOT_Server -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Server
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Server"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Server" ($args)
}
}

New-Alias gs_Server Get-SMO_Server -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerRole
{
[Microsoft.SqlServer.Management.Smo.ServerRole]
}

New-Alias gst_ServerRole Get-SMOT_ServerRole -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerRole
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerRole"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerRole" ($args)
}
}

New-Alias gs_ServerRole Get-SMO_ServerRole -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerRoleCollection
{
[Microsoft.SqlServer.Management.Smo.ServerRoleCollection]
}

New-Alias gst_ServerRoleCollection Get-SMOT_ServerRoleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerRoleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerRoleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerRoleCollection" ($args)
}
}

New-Alias gs_ServerRoleCollection Get-SMO_ServerRoleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ScriptSchemaObjectBase
{
[Microsoft.SqlServer.Management.Smo.ScriptSchemaObjectBase]
}

New-Alias gst_ScriptSchemaObjectBase Get-SMOT_ScriptSchemaObjectBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ScriptSchemaObjectBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptSchemaObjectBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptSchemaObjectBase" ($args)
}
}

New-Alias gs_ScriptSchemaObjectBase Get-SMO_ScriptSchemaObjectBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ITextObject
{
[Microsoft.SqlServer.Management.Smo.ITextObject]
}

New-Alias gst_ITextObject Get-SMOT_ITextObject -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ITextObject
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ITextObject"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ITextObject" ($args)
}
}

New-Alias gs_ITextObject Get-SMO_ITextObject -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StoredProcedure
{
[Microsoft.SqlServer.Management.Smo.StoredProcedure]
}

New-Alias gst_StoredProcedure Get-SMOT_StoredProcedure -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StoredProcedure
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedure"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedure" ($args)
}
}

New-Alias gs_StoredProcedure Get-SMO_StoredProcedure -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StoredProcedureEvents
{
[Microsoft.SqlServer.Management.Smo.StoredProcedureEvents]
}

New-Alias gst_StoredProcedureEvents Get-SMOT_StoredProcedureEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StoredProcedureEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureEvents" ($args)
}
}

New-Alias gs_StoredProcedureEvents Get-SMO_StoredProcedureEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SchemaCollectionBase
{
[Microsoft.SqlServer.Management.Smo.SchemaCollectionBase]
}

New-Alias gst_SchemaCollectionBase Get-SMOT_SchemaCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SchemaCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SchemaCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SchemaCollectionBase" ($args)
}
}

New-Alias gs_SchemaCollectionBase Get-SMO_SchemaCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StoredProcedureCollection
{
[Microsoft.SqlServer.Management.Smo.StoredProcedureCollection]
}

New-Alias gst_StoredProcedureCollection Get-SMOT_StoredProcedureCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StoredProcedureCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureCollection" ($args)
}
}

New-Alias gs_StoredProcedureCollection Get-SMO_StoredProcedureCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ParameterBase
{
[Microsoft.SqlServer.Management.Smo.ParameterBase]
}

New-Alias gst_ParameterBase Get-SMOT_ParameterBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ParameterBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ParameterBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ParameterBase" ($args)
}
}

New-Alias gs_ParameterBase Get-SMO_ParameterBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Parameter
{
[Microsoft.SqlServer.Management.Smo.Parameter]
}

New-Alias gst_Parameter Get-SMOT_Parameter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Parameter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Parameter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Parameter" ($args)
}
}

New-Alias gs_Parameter Get-SMO_Parameter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StoredProcedureParameter
{
[Microsoft.SqlServer.Management.Smo.StoredProcedureParameter]
}

New-Alias gst_StoredProcedureParameter Get-SMOT_StoredProcedureParameter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StoredProcedureParameter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureParameter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureParameter" ($args)
}
}

New-Alias gs_StoredProcedureParameter Get-SMO_StoredProcedureParameter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StoredProcedureParameterCollection
{
[Microsoft.SqlServer.Management.Smo.StoredProcedureParameterCollection]
}

New-Alias gst_StoredProcedureParameterCollection Get-SMOT_StoredProcedureParameterCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StoredProcedureParameterCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureParameterCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureParameterCollection" ($args)
}
}

New-Alias gs_StoredProcedureParameterCollection Get-SMO_StoredProcedureParameterCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ExtendedStoredProcedure
{
[Microsoft.SqlServer.Management.Smo.ExtendedStoredProcedure]
}

New-Alias gst_ExtendedStoredProcedure Get-SMOT_ExtendedStoredProcedure -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ExtendedStoredProcedure
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ExtendedStoredProcedure"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ExtendedStoredProcedure" ($args)
}
}

New-Alias gs_ExtendedStoredProcedure Get-SMO_ExtendedStoredProcedure -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ExtendedStoredProcedureCollection
{
[Microsoft.SqlServer.Management.Smo.ExtendedStoredProcedureCollection]
}

New-Alias gst_ExtendedStoredProcedureCollection Get-SMOT_ExtendedStoredProcedureCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ExtendedStoredProcedureCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ExtendedStoredProcedureCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ExtendedStoredProcedureCollection" ($args)
}
}

New-Alias gs_ExtendedStoredProcedureCollection Get-SMO_ExtendedStoredProcedureCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TableViewBase
{
[Microsoft.SqlServer.Management.Smo.TableViewBase]
}

New-Alias gst_TableViewBase Get-SMOT_TableViewBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TableViewBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TableViewBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TableViewBase" ($args)
}
}

New-Alias gs_TableViewBase Get-SMO_TableViewBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IColumnPermission
{
[Microsoft.SqlServer.Management.Smo.IColumnPermission]
}

New-Alias gst_IColumnPermission Get-SMOT_IColumnPermission -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IColumnPermission
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IColumnPermission"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IColumnPermission" ($args)
}
}

New-Alias gs_IColumnPermission Get-SMO_IColumnPermission -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Table
{
[Microsoft.SqlServer.Management.Smo.Table]
}

New-Alias gst_Table Get-SMOT_Table -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Table
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Table"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Table" ($args)
}
}

New-Alias gs_Table Get-SMO_Table -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TableEvents
{
[Microsoft.SqlServer.Management.Smo.TableEvents]
}

New-Alias gst_TableEvents Get-SMOT_TableEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TableEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TableEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TableEvents" ($args)
}
}

New-Alias gs_TableEvents Get-SMO_TableEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TableCollection
{
[Microsoft.SqlServer.Management.Smo.TableCollection]
}

New-Alias gst_TableCollection Get-SMOT_TableCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TableCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TableCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TableCollection" ($args)
}
}

New-Alias gs_TableCollection Get-SMO_TableCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseFile
{
[Microsoft.SqlServer.Management.Smo.DatabaseFile]
}

New-Alias gst_DatabaseFile Get-SMOT_DatabaseFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseFile" ($args)
}
}

New-Alias gs_DatabaseFile Get-SMO_DatabaseFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LogFile
{
[Microsoft.SqlServer.Management.Smo.LogFile]
}

New-Alias gst_LogFile Get-SMOT_LogFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LogFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LogFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LogFile" ($args)
}
}

New-Alias gs_LogFile Get-SMO_LogFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataFile
{
[Microsoft.SqlServer.Management.Smo.DataFile]
}

New-Alias gst_DataFile Get-SMOT_DataFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DataFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DataFile" ($args)
}
}

New-Alias gs_DataFile Get-SMO_DataFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FileGroup
{
[Microsoft.SqlServer.Management.Smo.FileGroup]
}

New-Alias gst_FileGroup Get-SMOT_FileGroup -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FileGroup
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FileGroup"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FileGroup" ($args)
}
}

New-Alias gs_FileGroup Get-SMO_FileGroup -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataFileCollection
{
[Microsoft.SqlServer.Management.Smo.DataFileCollection]
}

New-Alias gst_DataFileCollection Get-SMOT_DataFileCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataFileCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DataFileCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DataFileCollection" ($args)
}
}

New-Alias gs_DataFileCollection Get-SMO_DataFileCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FileGroupCollection
{
[Microsoft.SqlServer.Management.Smo.FileGroupCollection]
}

New-Alias gst_FileGroupCollection Get-SMOT_FileGroupCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FileGroupCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FileGroupCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FileGroupCollection" ($args)
}
}

New-Alias gs_FileGroupCollection Get-SMO_FileGroupCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AttachOptions
{
[Microsoft.SqlServer.Management.Smo.AttachOptions]
}

New-Alias gst_AttachOptions Get-SMOT_AttachOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AttachOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AttachOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AttachOptions" ($args)
}
}

New-Alias gs_AttachOptions Get-SMO_AttachOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PrivilegeTypes
{
[Microsoft.SqlServer.Management.Smo.PrivilegeTypes]
}

New-Alias gst_PrivilegeTypes Get-SMOT_PrivilegeTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PrivilegeTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PrivilegeTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PrivilegeTypes" ($args)
}
}

New-Alias gs_PrivilegeTypes Get-SMO_PrivilegeTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StatisticsScanType
{
[Microsoft.SqlServer.Management.Smo.StatisticsScanType]
}

New-Alias gst_StatisticsScanType Get-SMOT_StatisticsScanType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StatisticsScanType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticsScanType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticsScanType" ($args)
}
}

New-Alias gs_StatisticsScanType Get-SMO_StatisticsScanType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StatisticsTarget
{
[Microsoft.SqlServer.Management.Smo.StatisticsTarget]
}

New-Alias gst_StatisticsTarget Get-SMOT_StatisticsTarget -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StatisticsTarget
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticsTarget"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticsTarget" ($args)
}
}

New-Alias gs_StatisticsTarget Get-SMO_StatisticsTarget -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RepairType
{
[Microsoft.SqlServer.Management.Smo.RepairType]
}

New-Alias gst_RepairType Get-SMOT_RepairType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RepairType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RepairType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RepairType" ($args)
}
}

New-Alias gs_RepairType Get-SMO_RepairType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ShrinkMethod
{
[Microsoft.SqlServer.Management.Smo.ShrinkMethod]
}

New-Alias gst_ShrinkMethod Get-SMOT_ShrinkMethod -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ShrinkMethod
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ShrinkMethod"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ShrinkMethod" ($args)
}
}

New-Alias gs_ShrinkMethod Get-SMO_ShrinkMethod -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TransactionTypes
{
[Microsoft.SqlServer.Management.Smo.TransactionTypes]
}

New-Alias gst_TransactionTypes Get-SMOT_TransactionTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TransactionTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TransactionTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TransactionTypes" ($args)
}
}

New-Alias gs_TransactionTypes Get-SMO_TransactionTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LinkedTableType
{
[Microsoft.SqlServer.Management.Smo.LinkedTableType]
}

New-Alias gst_LinkedTableType Get-SMOT_LinkedTableType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LinkedTableType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedTableType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedTableType" ($args)
}
}

New-Alias gs_LinkedTableType Get-SMO_LinkedTableType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexEnableAction
{
[Microsoft.SqlServer.Management.Smo.IndexEnableAction]
}

New-Alias gst_IndexEnableAction Get-SMOT_IndexEnableAction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexEnableAction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexEnableAction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexEnableAction" ($args)
}
}

New-Alias gs_IndexEnableAction Get-SMO_IndexEnableAction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexOperation
{
[Microsoft.SqlServer.Management.Smo.IndexOperation]
}

New-Alias gst_IndexOperation Get-SMOT_IndexOperation -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexOperation
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexOperation"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexOperation" ($args)
}
}

New-Alias gs_IndexOperation Get-SMO_IndexOperation -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FragmentationOption
{
[Microsoft.SqlServer.Management.Smo.FragmentationOption]
}

New-Alias gst_FragmentationOption Get-SMOT_FragmentationOption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FragmentationOption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FragmentationOption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FragmentationOption" ($args)
}
}

New-Alias gs_FragmentationOption Get-SMO_FragmentationOption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlServerVersions
{
[Microsoft.SqlServer.Management.Smo.SqlServerVersions]
}

New-Alias gst_SqlServerVersions Get-SMOT_SqlServerVersions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlServerVersions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlServerVersions"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlServerVersions" ($args)
}
}

New-Alias gs_SqlServerVersions Get-SMO_SqlServerVersions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SortOrder
{
[Microsoft.SqlServer.Management.Smo.SortOrder]
}

New-Alias gst_SortOrder Get-SMOT_SortOrder -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SortOrder
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SortOrder"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SortOrder" ($args)
}
}

New-Alias gs_SortOrder Get-SMO_SortOrder -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseObjectTypes
{
[Microsoft.SqlServer.Management.Smo.DatabaseObjectTypes]
}

New-Alias gst_DatabaseObjectTypes Get-SMOT_DatabaseObjectTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseObjectTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseObjectTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseObjectTypes" ($args)
}
}

New-Alias gs_DatabaseObjectTypes Get-SMO_DatabaseObjectTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RoleTypes
{
[Microsoft.SqlServer.Management.Smo.RoleTypes]
}

New-Alias gst_RoleTypes Get-SMOT_RoleTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RoleTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RoleTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RoleTypes" ($args)
}
}

New-Alias gs_RoleTypes Get-SMO_RoleTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DependencyType
{
[Microsoft.SqlServer.Management.Smo.DependencyType]
}

New-Alias gst_DependencyType Get-SMOT_DependencyType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DependencyType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyType" ($args)
}
}

New-Alias gs_DependencyType Get-SMO_DependencyType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Month
{
[Microsoft.SqlServer.Management.Smo.Month]
}

New-Alias gst_Month Get-SMOT_Month -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Month
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Month"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Month" ($args)
}
}

New-Alias gs_Month Get-SMO_Month -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Edition
{
[Microsoft.SqlServer.Management.Smo.Edition]
}

New-Alias gst_Edition Get-SMOT_Edition -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Edition
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Edition"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Edition" ($args)
}
}

New-Alias gs_Edition Get-SMO_Edition -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_User
{
[Microsoft.SqlServer.Management.Smo.User]
}

New-Alias gst_User Get-SMOT_User -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_User
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.User"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.User" ($args)
}
}

New-Alias gs_User Get-SMO_User -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserEvents
{
[Microsoft.SqlServer.Management.Smo.UserEvents]
}

New-Alias gst_UserEvents Get-SMOT_UserEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserEvents" ($args)
}
}

New-Alias gs_UserEvents Get-SMO_UserEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserCollection
{
[Microsoft.SqlServer.Management.Smo.UserCollection]
}

New-Alias gst_UserCollection Get-SMOT_UserCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserCollection" ($args)
}
}

New-Alias gs_UserCollection Get-SMO_UserCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_View
{
[Microsoft.SqlServer.Management.Smo.View]
}

New-Alias gst_View Get-SMOT_View -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_View
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.View"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.View" ($args)
}
}

New-Alias gs_View Get-SMO_View -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ViewEvents
{
[Microsoft.SqlServer.Management.Smo.ViewEvents]
}

New-Alias gst_ViewEvents Get-SMOT_ViewEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ViewEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ViewEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ViewEvents" ($args)
}
}

New-Alias gs_ViewEvents Get-SMO_ViewEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ViewCollection
{
[Microsoft.SqlServer.Management.Smo.ViewCollection]
}

New-Alias gst_ViewCollection Get-SMOT_ViewCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ViewCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ViewCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ViewCollection" ($args)
}
}

New-Alias gs_ViewCollection Get-SMO_ViewCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlSmoState
{
[Microsoft.SqlServer.Management.Smo.SqlSmoState]
}

New-Alias gst_SqlSmoState Get-SMOT_SqlSmoState -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlSmoState
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlSmoState"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlSmoState" ($args)
}
}

New-Alias gs_SqlSmoState Get-SMO_SqlSmoState -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Database
{
[Microsoft.SqlServer.Management.Smo.Database]
}

New-Alias gst_Database Get-SMOT_Database -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Database
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Database"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Database" ($args)
}
}

New-Alias gs_Database Get-SMO_Database -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseEvents
{
[Microsoft.SqlServer.Management.Smo.DatabaseEvents]
}

New-Alias gst_DatabaseEvents Get-SMOT_DatabaseEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEvents" ($args)
}
}

New-Alias gs_DatabaseEvents Get-SMO_DatabaseEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LoginCreateOptions
{
[Microsoft.SqlServer.Management.Smo.LoginCreateOptions]
}

New-Alias gst_LoginCreateOptions Get-SMOT_LoginCreateOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LoginCreateOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LoginCreateOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LoginCreateOptions" ($args)
}
}

New-Alias gs_LoginCreateOptions Get-SMO_LoginCreateOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseMapping
{
[Microsoft.SqlServer.Management.Smo.DatabaseMapping]
}

New-Alias gst_DatabaseMapping Get-SMOT_DatabaseMapping -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseMapping
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseMapping"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseMapping" ($args)
}
}

New-Alias gs_DatabaseMapping Get-SMO_DatabaseMapping -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerEvents
{
[Microsoft.SqlServer.Management.Smo.ServerEvents]
}

New-Alias gst_ServerEvents Get-SMOT_ServerEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEvents" ($args)
}
}

New-Alias gs_ServerEvents Get-SMO_ServerEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProgressReportEventHandler
{
[Microsoft.SqlServer.Management.Smo.ProgressReportEventHandler]
}

New-Alias gst_ProgressReportEventHandler Get-SMOT_ProgressReportEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProgressReportEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ProgressReportEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ProgressReportEventHandler" ($args)
}
}

New-Alias gs_ProgressReportEventHandler Get-SMO_ProgressReportEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ScriptingFilter
{
[Microsoft.SqlServer.Management.Smo.ScriptingFilter]
}

New-Alias gst_ScriptingFilter Get-SMOT_ScriptingFilter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ScriptingFilter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptingFilter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptingFilter" ($args)
}
}

New-Alias gs_ScriptingFilter Get-SMO_ScriptingFilter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DependencyWalker
{
[Microsoft.SqlServer.Management.Smo.DependencyWalker]
}

New-Alias gst_DependencyWalker Get-SMOT_DependencyWalker -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DependencyWalker
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyWalker"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyWalker" ($args)
}
}

New-Alias gs_DependencyWalker Get-SMO_DependencyWalker -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProgressReportEventArgs
{
[Microsoft.SqlServer.Management.Smo.ProgressReportEventArgs]
}

New-Alias gst_ProgressReportEventArgs Get-SMOT_ProgressReportEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProgressReportEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ProgressReportEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ProgressReportEventArgs" ($args)
}
}

New-Alias gs_ProgressReportEventArgs Get-SMO_ProgressReportEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DependencyNode
{
[Microsoft.SqlServer.Management.Smo.DependencyNode]
}

New-Alias gst_DependencyNode Get-SMOT_DependencyNode -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DependencyNode
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyNode"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyNode" ($args)
}
}

New-Alias gs_DependencyNode Get-SMO_DependencyNode -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DependencyTreeNode
{
[Microsoft.SqlServer.Management.Smo.DependencyTreeNode]
}

New-Alias gst_DependencyTreeNode Get-SMOT_DependencyTreeNode -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DependencyTreeNode
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyTreeNode"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyTreeNode" ($args)
}
}

New-Alias gs_DependencyTreeNode Get-SMO_DependencyTreeNode -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DependencyTree
{
[Microsoft.SqlServer.Management.Smo.DependencyTree]
}

New-Alias gst_DependencyTree Get-SMOT_DependencyTree -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DependencyTree
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyTree"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyTree" ($args)
}
}

New-Alias gs_DependencyTree Get-SMO_DependencyTree -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DependencyCollectionNode
{
[Microsoft.SqlServer.Management.Smo.DependencyCollectionNode]
}

New-Alias gst_DependencyCollectionNode Get-SMOT_DependencyCollectionNode -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DependencyCollectionNode
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyCollectionNode"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyCollectionNode" ($args)
}
}

New-Alias gs_DependencyCollectionNode Get-SMO_DependencyCollectionNode -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DependencyCollection
{
[Microsoft.SqlServer.Management.Smo.DependencyCollection]
}

New-Alias gst_DependencyCollection Get-SMOT_DependencyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DependencyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DependencyCollection" ($args)
}
}

New-Alias gs_DependencyCollection Get-SMO_DependencyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UrnCollection
{
[Microsoft.SqlServer.Management.Smo.UrnCollection]
}

New-Alias gst_UrnCollection Get-SMOT_UrnCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UrnCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UrnCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UrnCollection" ($args)
}
}

New-Alias gs_UrnCollection Get-SMO_UrnCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ScriptingErrorEventHandler
{
[Microsoft.SqlServer.Management.Smo.ScriptingErrorEventHandler]
}

New-Alias gst_ScriptingErrorEventHandler Get-SMOT_ScriptingErrorEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ScriptingErrorEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptingErrorEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptingErrorEventHandler" ($args)
}
}

New-Alias gs_ScriptingErrorEventHandler Get-SMO_ScriptingErrorEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ScriptingErrorEventArgs
{
[Microsoft.SqlServer.Management.Smo.ScriptingErrorEventArgs]
}

New-Alias gst_ScriptingErrorEventArgs Get-SMOT_ScriptingErrorEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ScriptingErrorEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptingErrorEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptingErrorEventArgs" ($args)
}
}

New-Alias gs_ScriptingErrorEventArgs Get-SMO_ScriptingErrorEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Scripter
{
[Microsoft.SqlServer.Management.Smo.Scripter]
}

New-Alias gst_Scripter Get-SMOT_Scripter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Scripter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Scripter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Scripter" ($args)
}
}

New-Alias gs_Scripter Get-SMO_Scripter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlServerVersion
{
[Microsoft.SqlServer.Management.Smo.SqlServerVersion]
}

New-Alias gst_SqlServerVersion Get-SMOT_SqlServerVersion -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlServerVersion
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlServerVersion"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlServerVersion" ($args)
}
}

New-Alias gs_SqlServerVersion Get-SMO_SqlServerVersion -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ScriptOption
{
[Microsoft.SqlServer.Management.Smo.ScriptOption]
}

New-Alias gst_ScriptOption Get-SMOT_ScriptOption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ScriptOption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptOption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptOption" ($args)
}
}

New-Alias gs_ScriptOption Get-SMO_ScriptOption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ScriptingOptions
{
[Microsoft.SqlServer.Management.Smo.ScriptingOptions]
}

New-Alias gst_ScriptingOptions Get-SMOT_ScriptingOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ScriptingOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptingOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ScriptingOptions" ($args)
}
}

New-Alias gs_ScriptingOptions Get-SMO_ScriptingOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Index
{
[Microsoft.SqlServer.Management.Smo.Index]
}

New-Alias gst_Index Get-SMOT_Index -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Index
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Index"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Index" ($args)
}
}

New-Alias gs_Index Get-SMO_Index -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexEvents
{
[Microsoft.SqlServer.Management.Smo.IndexEvents]
}

New-Alias gst_IndexEvents Get-SMOT_IndexEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexEvents" ($args)
}
}

New-Alias gs_IndexEvents Get-SMO_IndexEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexCollection
{
[Microsoft.SqlServer.Management.Smo.IndexCollection]
}

New-Alias gst_IndexCollection Get-SMOT_IndexCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexCollection" ($args)
}
}

New-Alias gs_IndexCollection Get-SMO_IndexCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Statistic
{
[Microsoft.SqlServer.Management.Smo.Statistic]
}

New-Alias gst_Statistic Get-SMOT_Statistic -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Statistic
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Statistic"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Statistic" ($args)
}
}

New-Alias gs_Statistic Get-SMO_Statistic -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StatisticEvents
{
[Microsoft.SqlServer.Management.Smo.StatisticEvents]
}

New-Alias gst_StatisticEvents Get-SMOT_StatisticEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StatisticEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticEvents" ($args)
}
}

New-Alias gs_StatisticEvents Get-SMO_StatisticEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StatisticCollection
{
[Microsoft.SqlServer.Management.Smo.StatisticCollection]
}

New-Alias gst_StatisticCollection Get-SMOT_StatisticCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StatisticCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticCollection" ($args)
}
}

New-Alias gs_StatisticCollection Get-SMO_StatisticCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StatisticColumn
{
[Microsoft.SqlServer.Management.Smo.StatisticColumn]
}

New-Alias gst_StatisticColumn Get-SMOT_StatisticColumn -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StatisticColumn
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticColumn"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticColumn" ($args)
}
}

New-Alias gs_StatisticColumn Get-SMO_StatisticColumn -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StatisticColumnCollection
{
[Microsoft.SqlServer.Management.Smo.StatisticColumnCollection]
}

New-Alias gst_StatisticColumnCollection Get-SMOT_StatisticColumnCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StatisticColumnCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticColumnCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StatisticColumnCollection" ($args)
}
}

New-Alias gs_StatisticColumnCollection Get-SMO_StatisticColumnCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Trigger
{
[Microsoft.SqlServer.Management.Smo.Trigger]
}

New-Alias gst_Trigger Get-SMOT_Trigger -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Trigger
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Trigger"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Trigger" ($args)
}
}

New-Alias gs_Trigger Get-SMO_Trigger -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TriggerEvents
{
[Microsoft.SqlServer.Management.Smo.TriggerEvents]
}

New-Alias gst_TriggerEvents Get-SMOT_TriggerEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TriggerEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TriggerEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TriggerEvents" ($args)
}
}

New-Alias gs_TriggerEvents Get-SMO_TriggerEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TriggerCollection
{
[Microsoft.SqlServer.Management.Smo.TriggerCollection]
}

New-Alias gst_TriggerCollection Get-SMOT_TriggerCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TriggerCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TriggerCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TriggerCollection" ($args)
}
}

New-Alias gs_TriggerCollection Get-SMO_TriggerCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Check
{
[Microsoft.SqlServer.Management.Smo.Check]
}

New-Alias gst_Check Get-SMOT_Check -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Check
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Check"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Check" ($args)
}
}

New-Alias gs_Check Get-SMO_Check -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CheckCollection
{
[Microsoft.SqlServer.Management.Smo.CheckCollection]
}

New-Alias gst_CheckCollection Get-SMOT_CheckCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CheckCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CheckCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CheckCollection" ($args)
}
}

New-Alias gs_CheckCollection Get-SMO_CheckCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexedColumn
{
[Microsoft.SqlServer.Management.Smo.IndexedColumn]
}

New-Alias gst_IndexedColumn Get-SMOT_IndexedColumn -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexedColumn
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexedColumn"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexedColumn" ($args)
}
}

New-Alias gs_IndexedColumn Get-SMO_IndexedColumn -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexedColumnCollection
{
[Microsoft.SqlServer.Management.Smo.IndexedColumnCollection]
}

New-Alias gst_IndexedColumnCollection Get-SMOT_IndexedColumnCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexedColumnCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexedColumnCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexedColumnCollection" ($args)
}
}

New-Alias gs_IndexedColumnCollection Get-SMO_IndexedColumnCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ForeignKey
{
[Microsoft.SqlServer.Management.Smo.ForeignKey]
}

New-Alias gst_ForeignKey Get-SMOT_ForeignKey -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ForeignKey
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKey"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKey" ($args)
}
}

New-Alias gs_ForeignKey Get-SMO_ForeignKey -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ForeignKeyCollection
{
[Microsoft.SqlServer.Management.Smo.ForeignKeyCollection]
}

New-Alias gst_ForeignKeyCollection Get-SMOT_ForeignKeyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ForeignKeyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKeyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKeyCollection" ($args)
}
}

New-Alias gs_ForeignKeyCollection Get-SMO_ForeignKeyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DefaultRuleBase
{
[Microsoft.SqlServer.Management.Smo.DefaultRuleBase]
}

New-Alias gst_DefaultRuleBase Get-SMOT_DefaultRuleBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DefaultRuleBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DefaultRuleBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DefaultRuleBase" ($args)
}
}

New-Alias gs_DefaultRuleBase Get-SMO_DefaultRuleBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Default
{
[Microsoft.SqlServer.Management.Smo.Default]
}

New-Alias gst_Default Get-SMOT_Default -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Default
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Default"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Default" ($args)
}
}

New-Alias gs_Default Get-SMO_Default -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DefaultCollection
{
[Microsoft.SqlServer.Management.Smo.DefaultCollection]
}

New-Alias gst_DefaultCollection Get-SMOT_DefaultCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DefaultCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DefaultCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DefaultCollection" ($args)
}
}

New-Alias gs_DefaultCollection Get-SMO_DefaultCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Rule
{
[Microsoft.SqlServer.Management.Smo.Rule]
}

New-Alias gst_Rule Get-SMOT_Rule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Rule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Rule"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Rule" ($args)
}
}

New-Alias gs_Rule Get-SMO_Rule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedDataType
{
[Microsoft.SqlServer.Management.Smo.UserDefinedDataType]
}

New-Alias gst_UserDefinedDataType Get-SMOT_UserDefinedDataType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedDataType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedDataType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedDataType" ($args)
}
}

New-Alias gs_UserDefinedDataType Get-SMO_UserDefinedDataType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedDataTypeCollection
{
[Microsoft.SqlServer.Management.Smo.UserDefinedDataTypeCollection]
}

New-Alias gst_UserDefinedDataTypeCollection Get-SMOT_UserDefinedDataTypeCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedDataTypeCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedDataTypeCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedDataTypeCollection" ($args)
}
}

New-Alias gs_UserDefinedDataTypeCollection Get-SMO_UserDefinedDataTypeCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedFunction
{
[Microsoft.SqlServer.Management.Smo.UserDefinedFunction]
}

New-Alias gst_UserDefinedFunction Get-SMOT_UserDefinedFunction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedFunction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunction" ($args)
}
}

New-Alias gs_UserDefinedFunction Get-SMO_UserDefinedFunction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedFunctionEvents
{
[Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEvents]
}

New-Alias gst_UserDefinedFunctionEvents Get-SMOT_UserDefinedFunctionEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedFunctionEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEvents" ($args)
}
}

New-Alias gs_UserDefinedFunctionEvents Get-SMO_UserDefinedFunctionEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedFunctionParameter
{
[Microsoft.SqlServer.Management.Smo.UserDefinedFunctionParameter]
}

New-Alias gst_UserDefinedFunctionParameter Get-SMOT_UserDefinedFunctionParameter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedFunctionParameter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionParameter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionParameter" ($args)
}
}

New-Alias gs_UserDefinedFunctionParameter Get-SMO_UserDefinedFunctionParameter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedFunctionCollection
{
[Microsoft.SqlServer.Management.Smo.UserDefinedFunctionCollection]
}

New-Alias gst_UserDefinedFunctionCollection Get-SMOT_UserDefinedFunctionCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedFunctionCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionCollection" ($args)
}
}

New-Alias gs_UserDefinedFunctionCollection Get-SMO_UserDefinedFunctionCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedFunctionParameterCollection
{
[Microsoft.SqlServer.Management.Smo.UserDefinedFunctionParameterCollection]
}

New-Alias gst_UserDefinedFunctionParameterCollection Get-SMOT_UserDefinedFunctionParameterCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedFunctionParameterCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionParameterCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionParameterCollection" ($args)
}
}

New-Alias gs_UserDefinedFunctionParameterCollection Get-SMO_UserDefinedFunctionParameterCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RuleCollection
{
[Microsoft.SqlServer.Management.Smo.RuleCollection]
}

New-Alias gst_RuleCollection Get-SMOT_RuleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RuleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RuleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RuleCollection" ($args)
}
}

New-Alias gs_RuleCollection Get-SMO_RuleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConfigurationBase
{
[Microsoft.SqlServer.Management.Smo.ConfigurationBase]
}

New-Alias gst_ConfigurationBase Get-SMOT_ConfigurationBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConfigurationBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ConfigurationBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ConfigurationBase" ($args)
}
}

New-Alias gs_ConfigurationBase Get-SMO_ConfigurationBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Configuration
{
[Microsoft.SqlServer.Management.Smo.Configuration]
}

New-Alias gst_Configuration Get-SMOT_Configuration -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Configuration
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Configuration"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Configuration" ($args)
}
}

New-Alias gs_Configuration Get-SMO_Configuration -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConfigProperty
{
[Microsoft.SqlServer.Management.Smo.ConfigProperty]
}

New-Alias gst_ConfigProperty Get-SMOT_ConfigProperty -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConfigProperty
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ConfigProperty"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ConfigProperty" ($args)
}
}

New-Alias gs_ConfigProperty Get-SMO_ConfigProperty -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConfigPropertyCollection
{
[Microsoft.SqlServer.Management.Smo.ConfigPropertyCollection]
}

New-Alias gst_ConfigPropertyCollection Get-SMOT_ConfigPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConfigPropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ConfigPropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ConfigPropertyCollection" ($args)
}
}

New-Alias gs_ConfigPropertyCollection Get-SMO_ConfigPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Transfer
{
[Microsoft.SqlServer.Management.Smo.Transfer]
}

New-Alias gst_Transfer Get-SMOT_Transfer -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Transfer
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Transfer"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Transfer" ($args)
}
}

New-Alias gs_Transfer Get-SMO_Transfer -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseFileMappingsDictionary
{
[Microsoft.SqlServer.Management.Smo.DatabaseFileMappingsDictionary]
}

New-Alias gst_DatabaseFileMappingsDictionary Get-SMOT_DatabaseFileMappingsDictionary -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseFileMappingsDictionary
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseFileMappingsDictionary"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseFileMappingsDictionary" ($args)
}
}

New-Alias gs_DatabaseFileMappingsDictionary Get-SMO_DatabaseFileMappingsDictionary -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ExtendedProperty
{
[Microsoft.SqlServer.Management.Smo.ExtendedProperty]
}

New-Alias gst_ExtendedProperty Get-SMOT_ExtendedProperty -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ExtendedProperty
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ExtendedProperty"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ExtendedProperty" ($args)
}
}

New-Alias gs_ExtendedProperty Get-SMO_ExtendedProperty -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ExtendedPropertyCollection
{
[Microsoft.SqlServer.Management.Smo.ExtendedPropertyCollection]
}

New-Alias gst_ExtendedPropertyCollection Get-SMOT_ExtendedPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ExtendedPropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ExtendedPropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ExtendedPropertyCollection" ($args)
}
}

New-Alias gs_ExtendedPropertyCollection Get-SMO_ExtendedPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DefaultConstraint
{
[Microsoft.SqlServer.Management.Smo.DefaultConstraint]
}

New-Alias gst_DefaultConstraint Get-SMOT_DefaultConstraint -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DefaultConstraint
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DefaultConstraint"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DefaultConstraint" ($args)
}
}

New-Alias gs_DefaultConstraint Get-SMO_DefaultConstraint -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupRestoreBase
{
[Microsoft.SqlServer.Management.Smo.BackupRestoreBase]
}

New-Alias gst_BackupRestoreBase Get-SMOT_BackupRestoreBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupRestoreBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupRestoreBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupRestoreBase" ($args)
}
}

New-Alias gs_BackupRestoreBase Get-SMO_BackupRestoreBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DeviceType
{
[Microsoft.SqlServer.Management.Smo.DeviceType]
}

New-Alias gst_DeviceType Get-SMOT_DeviceType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DeviceType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DeviceType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DeviceType" ($args)
}
}

New-Alias gs_DeviceType Get-SMO_DeviceType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PercentCompleteEventHandler
{
[Microsoft.SqlServer.Management.Smo.PercentCompleteEventHandler]
}

New-Alias gst_PercentCompleteEventHandler Get-SMOT_PercentCompleteEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PercentCompleteEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PercentCompleteEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PercentCompleteEventHandler" ($args)
}
}

New-Alias gs_PercentCompleteEventHandler Get-SMO_PercentCompleteEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PercentCompleteEventArgs
{
[Microsoft.SqlServer.Management.Smo.PercentCompleteEventArgs]
}

New-Alias gst_PercentCompleteEventArgs Get-SMOT_PercentCompleteEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PercentCompleteEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PercentCompleteEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PercentCompleteEventArgs" ($args)
}
}

New-Alias gs_PercentCompleteEventArgs Get-SMO_PercentCompleteEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AsyncStatus
{
[Microsoft.SqlServer.Management.Smo.AsyncStatus]
}

New-Alias gst_AsyncStatus Get-SMOT_AsyncStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AsyncStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AsyncStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AsyncStatus" ($args)
}
}

New-Alias gs_AsyncStatus Get-SMO_AsyncStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupDeviceItem
{
[Microsoft.SqlServer.Management.Smo.BackupDeviceItem]
}

New-Alias gst_BackupDeviceItem Get-SMOT_BackupDeviceItem -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupDeviceItem
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceItem"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceItem" ($args)
}
}

New-Alias gs_BackupDeviceItem Get-SMO_BackupDeviceItem -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupDeviceList
{
[Microsoft.SqlServer.Management.Smo.BackupDeviceList]
}

New-Alias gst_BackupDeviceList Get-SMOT_BackupDeviceList -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupDeviceList
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceList"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceList" ($args)
}
}

New-Alias gs_BackupDeviceList Get-SMO_BackupDeviceList -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Backup
{
[Microsoft.SqlServer.Management.Smo.Backup]
}

New-Alias gst_Backup Get-SMOT_Backup -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Backup
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Backup"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Backup" ($args)
}
}

New-Alias gs_Backup Get-SMO_Backup -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupTruncateLogType
{
[Microsoft.SqlServer.Management.Smo.BackupTruncateLogType]
}

New-Alias gst_BackupTruncateLogType Get-SMOT_BackupTruncateLogType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupTruncateLogType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupTruncateLogType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupTruncateLogType" ($args)
}
}

New-Alias gs_BackupTruncateLogType Get-SMO_BackupTruncateLogType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupActionType
{
[Microsoft.SqlServer.Management.Smo.BackupActionType]
}

New-Alias gst_BackupActionType Get-SMOT_BackupActionType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupActionType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupActionType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupActionType" ($args)
}
}

New-Alias gs_BackupActionType Get-SMO_BackupActionType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Restore
{
[Microsoft.SqlServer.Management.Smo.Restore]
}

New-Alias gst_Restore Get-SMOT_Restore -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Restore
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Restore"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Restore" ($args)
}
}

New-Alias gs_Restore Get-SMO_Restore -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RestoreActionType
{
[Microsoft.SqlServer.Management.Smo.RestoreActionType]
}

New-Alias gst_RestoreActionType Get-SMOT_RestoreActionType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RestoreActionType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RestoreActionType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RestoreActionType" ($args)
}
}

New-Alias gs_RestoreActionType Get-SMO_RestoreActionType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlVerifyAction
{
[Microsoft.SqlServer.Management.Smo.SqlVerifyAction]
}

New-Alias gst_SqlVerifyAction Get-SMOT_SqlVerifyAction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlVerifyAction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlVerifyAction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlVerifyAction" ($args)
}
}

New-Alias gs_SqlVerifyAction Get-SMO_SqlVerifyAction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RelocateFile
{
[Microsoft.SqlServer.Management.Smo.RelocateFile]
}

New-Alias gst_RelocateFile Get-SMOT_RelocateFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RelocateFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RelocateFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RelocateFile" ($args)
}
}

New-Alias gs_RelocateFile Get-SMO_RelocateFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_VerifyCompleteEventHandler
{
[Microsoft.SqlServer.Management.Smo.VerifyCompleteEventHandler]
}

New-Alias gst_VerifyCompleteEventHandler Get-SMOT_VerifyCompleteEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_VerifyCompleteEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.VerifyCompleteEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.VerifyCompleteEventHandler" ($args)
}
}

New-Alias gs_VerifyCompleteEventHandler Get-SMO_VerifyCompleteEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_VerifyCompleteEventArgs
{
[Microsoft.SqlServer.Management.Smo.VerifyCompleteEventArgs]
}

New-Alias gst_VerifyCompleteEventArgs Get-SMOT_VerifyCompleteEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_VerifyCompleteEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.VerifyCompleteEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.VerifyCompleteEventArgs" ($args)
}
}

New-Alias gs_VerifyCompleteEventArgs Get-SMO_VerifyCompleteEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_WmiSmoObject
{
[Microsoft.SqlServer.Management.Smo.Wmi.WmiSmoObject]
}

New-Alias gst_WmiSmoObject Get-SMOT_WmiSmoObject -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_WmiSmoObject
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.WmiSmoObject"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.WmiSmoObject" ($args)
}
}

New-Alias gs_WmiSmoObject Get-SMO_WmiSmoObject -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProviderArchitecture
{
[Microsoft.SqlServer.Management.Smo.Wmi.ProviderArchitecture]
}

New-Alias gst_ProviderArchitecture Get-SMOT_ProviderArchitecture -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProviderArchitecture
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ProviderArchitecture"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ProviderArchitecture" ($args)
}
}

New-Alias gs_ProviderArchitecture Get-SMO_ProviderArchitecture -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ManagedComputer
{
[Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer]
}

New-Alias gst_ManagedComputer Get-SMOT_ManagedComputer -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ManagedComputer
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer" ($args)
}
}

New-Alias gs_ManagedComputer Get-SMO_ManagedComputer -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_WmiConnectionInfo
{
[Microsoft.SqlServer.Management.Smo.Wmi.WmiConnectionInfo]
}

New-Alias gst_WmiConnectionInfo Get-SMOT_WmiConnectionInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_WmiConnectionInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.WmiConnectionInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.WmiConnectionInfo" ($args)
}
}

New-Alias gs_WmiConnectionInfo Get-SMO_WmiConnectionInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_WmiCollectionBase
{
[Microsoft.SqlServer.Management.Smo.Wmi.WmiCollectionBase]
}

New-Alias gst_WmiCollectionBase Get-SMOT_WmiCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_WmiCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.WmiCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.WmiCollectionBase" ($args)
}
}

New-Alias gs_WmiCollectionBase Get-SMO_WmiCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Service
{
[Microsoft.SqlServer.Management.Smo.Wmi.Service]
}

New-Alias gst_Service Get-SMOT_Service -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Service
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.Service"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.Service" ($args)
}
}

New-Alias gs_Service Get-SMO_Service -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServiceCollection]
}

New-Alias gst_ServiceCollection Get-SMOT_ServiceCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServiceCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServiceCollection" ($args)
}
}

New-Alias gs_ServiceCollection Get-SMO_ServiceCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolBase
{
[Microsoft.SqlServer.Management.Smo.Wmi.ProtocolBase]
}

New-Alias gst_ProtocolBase Get-SMOT_ProtocolBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ProtocolBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ProtocolBase" ($args)
}
}

New-Alias gs_ProtocolBase Get-SMO_ProtocolBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ClientProtocol
{
[Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocol]
}

New-Alias gst_ClientProtocol Get-SMOT_ClientProtocol -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ClientProtocol
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocol"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocol" ($args)
}
}

New-Alias gs_ClientProtocol Get-SMO_ClientProtocol -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ClientProtocolCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolCollection]
}

New-Alias gst_ClientProtocolCollection Get-SMOT_ClientProtocolCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ClientProtocolCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolCollection" ($args)
}
}

New-Alias gs_ClientProtocolCollection Get-SMO_ClientProtocolCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NetLibInfo
{
[Microsoft.SqlServer.Management.Smo.Wmi.NetLibInfo]
}

New-Alias gst_NetLibInfo Get-SMOT_NetLibInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NetLibInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.NetLibInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.NetLibInfo" ($args)
}
}

New-Alias gs_NetLibInfo Get-SMO_NetLibInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerAlias
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerAlias]
}

New-Alias gst_ServerAlias Get-SMOT_ServerAlias -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerAlias
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerAlias"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerAlias" ($args)
}
}

New-Alias gs_ServerAlias Get-SMO_ServerAlias -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerAliasCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerAliasCollection]
}

New-Alias gst_ServerAliasCollection Get-SMOT_ServerAliasCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerAliasCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerAliasCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerAliasCollection" ($args)
}
}

New-Alias gs_ServerAliasCollection Get-SMO_ServerAliasCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerProtocol
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocol]
}

New-Alias gst_ServerProtocol Get-SMOT_ServerProtocol -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerProtocol
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocol"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocol" ($args)
}
}

New-Alias gs_ServerProtocol Get-SMO_ServerProtocol -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerProtocolCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolCollection]
}

New-Alias gst_ServerProtocolCollection Get-SMOT_ServerProtocolCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerProtocolCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolCollection" ($args)
}
}

New-Alias gs_ServerProtocolCollection Get-SMO_ServerProtocolCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Property
{
[Microsoft.SqlServer.Management.Smo.Property]
}

New-Alias gst_Property Get-SMOT_Property -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Property
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Property"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Property" ($args)
}
}

New-Alias gs_Property Get-SMO_Property -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolProperty
{
[Microsoft.SqlServer.Management.Smo.Wmi.ProtocolProperty]
}

New-Alias gst_ProtocolProperty Get-SMOT_ProtocolProperty -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolProperty
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ProtocolProperty"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ProtocolProperty" ($args)
}
}

New-Alias gs_ProtocolProperty Get-SMO_ProtocolProperty -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ClientProtocolProperty
{
[Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolProperty]
}

New-Alias gst_ClientProtocolProperty Get-SMOT_ClientProtocolProperty -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ClientProtocolProperty
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolProperty"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolProperty" ($args)
}
}

New-Alias gs_ClientProtocolProperty Get-SMO_ClientProtocolProperty -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerProtocolProperty
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolProperty]
}

New-Alias gst_ServerProtocolProperty Get-SMOT_ServerProtocolProperty -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerProtocolProperty
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolProperty"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolProperty" ($args)
}
}

New-Alias gs_ServerProtocolProperty Get-SMO_ServerProtocolProperty -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IPAddressProperty
{
[Microsoft.SqlServer.Management.Smo.Wmi.IPAddressProperty]
}

New-Alias gst_IPAddressProperty Get-SMOT_IPAddressProperty -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IPAddressProperty
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.IPAddressProperty"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.IPAddressProperty" ($args)
}
}

New-Alias gs_IPAddressProperty Get-SMO_IPAddressProperty -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolPropertyCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ProtocolPropertyCollection]
}

New-Alias gst_ProtocolPropertyCollection Get-SMOT_ProtocolPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolPropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ProtocolPropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ProtocolPropertyCollection" ($args)
}
}

New-Alias gs_ProtocolPropertyCollection Get-SMO_ProtocolPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ClientProtocolPropertyCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolPropertyCollection]
}

New-Alias gst_ClientProtocolPropertyCollection Get-SMOT_ClientProtocolPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ClientProtocolPropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolPropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ClientProtocolPropertyCollection" ($args)
}
}

New-Alias gs_ClientProtocolPropertyCollection Get-SMO_ClientProtocolPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerProtocolPropertyCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolPropertyCollection]
}

New-Alias gst_ServerProtocolPropertyCollection Get-SMOT_ServerProtocolPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerProtocolPropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolPropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerProtocolPropertyCollection" ($args)
}
}

New-Alias gs_ServerProtocolPropertyCollection Get-SMO_ServerProtocolPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IPAddressPropertyCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.IPAddressPropertyCollection]
}

New-Alias gst_IPAddressPropertyCollection Get-SMOT_IPAddressPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IPAddressPropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.IPAddressPropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.IPAddressPropertyCollection" ($args)
}
}

New-Alias gs_IPAddressPropertyCollection Get-SMO_IPAddressPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceBroker
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceBroker]
}

New-Alias gst_ServiceBroker Get-SMOT_ServiceBroker -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceBroker
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceBroker"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceBroker" ($args)
}
}

New-Alias gs_ServiceBroker Get-SMO_ServiceBroker -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BrokerObjectBase
{
[Microsoft.SqlServer.Management.Smo.Broker.BrokerObjectBase]
}

New-Alias gst_BrokerObjectBase Get-SMOT_BrokerObjectBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BrokerObjectBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.BrokerObjectBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.BrokerObjectBase" ($args)
}
}

New-Alias gs_BrokerObjectBase Get-SMO_BrokerObjectBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MessageType
{
[Microsoft.SqlServer.Management.Smo.Broker.MessageType]
}

New-Alias gst_MessageType Get-SMOT_MessageType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MessageType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageType" ($args)
}
}

New-Alias gs_MessageType Get-SMO_MessageType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MessageTypeEvents
{
[Microsoft.SqlServer.Management.Smo.Broker.MessageTypeEvents]
}

New-Alias gst_MessageTypeEvents Get-SMOT_MessageTypeEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MessageTypeEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageTypeEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageTypeEvents" ($args)
}
}

New-Alias gs_MessageTypeEvents Get-SMO_MessageTypeEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MessageTypeCollection
{
[Microsoft.SqlServer.Management.Smo.Broker.MessageTypeCollection]
}

New-Alias gst_MessageTypeCollection Get-SMOT_MessageTypeCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MessageTypeCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageTypeCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageTypeCollection" ($args)
}
}

New-Alias gs_MessageTypeCollection Get-SMO_MessageTypeCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceContract
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceContract]
}

New-Alias gst_ServiceContract Get-SMOT_ServiceContract -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceContract
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContract"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContract" ($args)
}
}

New-Alias gs_ServiceContract Get-SMO_ServiceContract -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceContractEvents
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceContractEvents]
}

New-Alias gst_ServiceContractEvents Get-SMOT_ServiceContractEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceContractEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContractEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContractEvents" ($args)
}
}

New-Alias gs_ServiceContractEvents Get-SMO_ServiceContractEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceContractCollection
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceContractCollection]
}

New-Alias gst_ServiceContractCollection Get-SMOT_ServiceContractCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceContractCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContractCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContractCollection" ($args)
}
}

New-Alias gs_ServiceContractCollection Get-SMO_ServiceContractCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MessageTypeMapping
{
[Microsoft.SqlServer.Management.Smo.Broker.MessageTypeMapping]
}

New-Alias gst_MessageTypeMapping Get-SMOT_MessageTypeMapping -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MessageTypeMapping
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageTypeMapping"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageTypeMapping" ($args)
}
}

New-Alias gs_MessageTypeMapping Get-SMO_MessageTypeMapping -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MessageTypeMappingCollection
{
[Microsoft.SqlServer.Management.Smo.Broker.MessageTypeMappingCollection]
}

New-Alias gst_MessageTypeMappingCollection Get-SMOT_MessageTypeMappingCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MessageTypeMappingCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageTypeMappingCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.MessageTypeMappingCollection" ($args)
}
}

New-Alias gs_MessageTypeMappingCollection Get-SMO_MessageTypeMappingCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BrokerService
{
[Microsoft.SqlServer.Management.Smo.Broker.BrokerService]
}

New-Alias gst_BrokerService Get-SMOT_BrokerService -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BrokerService
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.BrokerService"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.BrokerService" ($args)
}
}

New-Alias gs_BrokerService Get-SMO_BrokerService -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BrokerServiceEvents
{
[Microsoft.SqlServer.Management.Smo.Broker.BrokerServiceEvents]
}

New-Alias gst_BrokerServiceEvents Get-SMOT_BrokerServiceEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BrokerServiceEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.BrokerServiceEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.BrokerServiceEvents" ($args)
}
}

New-Alias gs_BrokerServiceEvents Get-SMO_BrokerServiceEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BrokerServiceCollection
{
[Microsoft.SqlServer.Management.Smo.Broker.BrokerServiceCollection]
}

New-Alias gst_BrokerServiceCollection Get-SMOT_BrokerServiceCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BrokerServiceCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.BrokerServiceCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.BrokerServiceCollection" ($args)
}
}

New-Alias gs_BrokerServiceCollection Get-SMO_BrokerServiceCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceContractMapping
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceContractMapping]
}

New-Alias gst_ServiceContractMapping Get-SMOT_ServiceContractMapping -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceContractMapping
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContractMapping"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContractMapping" ($args)
}
}

New-Alias gs_ServiceContractMapping Get-SMO_ServiceContractMapping -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceContractMappingCollection
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceContractMappingCollection]
}

New-Alias gst_ServiceContractMappingCollection Get-SMOT_ServiceContractMappingCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceContractMappingCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContractMappingCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceContractMappingCollection" ($args)
}
}

New-Alias gs_ServiceContractMappingCollection Get-SMO_ServiceContractMappingCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceQueue
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceQueue]
}

New-Alias gst_ServiceQueue Get-SMOT_ServiceQueue -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceQueue
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceQueue"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceQueue" ($args)
}
}

New-Alias gs_ServiceQueue Get-SMO_ServiceQueue -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceQueueEvents
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceQueueEvents]
}

New-Alias gst_ServiceQueueEvents Get-SMOT_ServiceQueueEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceQueueEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceQueueEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceQueueEvents" ($args)
}
}

New-Alias gs_ServiceQueueEvents Get-SMO_ServiceQueueEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceQueueCollection
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceQueueCollection]
}

New-Alias gst_ServiceQueueCollection Get-SMOT_ServiceQueueCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceQueueCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceQueueCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceQueueCollection" ($args)
}
}

New-Alias gs_ServiceQueueCollection Get-SMO_ServiceQueueCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceRoute
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceRoute]
}

New-Alias gst_ServiceRoute Get-SMOT_ServiceRoute -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceRoute
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceRoute"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceRoute" ($args)
}
}

New-Alias gs_ServiceRoute Get-SMO_ServiceRoute -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceRouteEvents
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceRouteEvents]
}

New-Alias gst_ServiceRouteEvents Get-SMOT_ServiceRouteEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceRouteEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceRouteEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceRouteEvents" ($args)
}
}

New-Alias gs_ServiceRouteEvents Get-SMO_ServiceRouteEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceRouteCollection
{
[Microsoft.SqlServer.Management.Smo.Broker.ServiceRouteCollection]
}

New-Alias gst_ServiceRouteCollection Get-SMOT_ServiceRouteCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceRouteCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceRouteCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.ServiceRouteCollection" ($args)
}
}

New-Alias gs_ServiceRouteCollection Get-SMO_ServiceRouteCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RemoteServiceBinding
{
[Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBinding]
}

New-Alias gst_RemoteServiceBinding Get-SMOT_RemoteServiceBinding -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RemoteServiceBinding
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBinding"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBinding" ($args)
}
}

New-Alias gs_RemoteServiceBinding Get-SMO_RemoteServiceBinding -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RemoteServiceBindingEvents
{
[Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBindingEvents]
}

New-Alias gst_RemoteServiceBindingEvents Get-SMOT_RemoteServiceBindingEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RemoteServiceBindingEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBindingEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBindingEvents" ($args)
}
}

New-Alias gs_RemoteServiceBindingEvents Get-SMO_RemoteServiceBindingEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RemoteServiceBindingCollection
{
[Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBindingCollection]
}

New-Alias gst_RemoteServiceBindingCollection Get-SMOT_RemoteServiceBindingCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RemoteServiceBindingCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBindingCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Broker.RemoteServiceBindingCollection" ($args)
}
}

New-Alias gs_RemoteServiceBindingCollection Get-SMO_RemoteServiceBindingCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CategoryBase
{
[Microsoft.SqlServer.Management.Smo.Agent.CategoryBase]
}

New-Alias gst_CategoryBase Get-SMOT_CategoryBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CategoryBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.CategoryBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.CategoryBase" ($args)
}
}

New-Alias gs_CategoryBase Get-SMO_CategoryBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobCategory
{
[Microsoft.SqlServer.Management.Smo.Agent.JobCategory]
}

New-Alias gst_JobCategory Get-SMOT_JobCategory -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobCategory
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobCategory"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobCategory" ($args)
}
}

New-Alias gs_JobCategory Get-SMO_JobCategory -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobCategoryCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.JobCategoryCollection]
}

New-Alias gst_JobCategoryCollection Get-SMOT_JobCategoryCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobCategoryCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobCategoryCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobCategoryCollection" ($args)
}
}

New-Alias gs_JobCategoryCollection Get-SMO_JobCategoryCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AlertCategory
{
[Microsoft.SqlServer.Management.Smo.Agent.AlertCategory]
}

New-Alias gst_AlertCategory Get-SMOT_AlertCategory -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AlertCategory
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertCategory"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertCategory" ($args)
}
}

New-Alias gs_AlertCategory Get-SMO_AlertCategory -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AlertCategoryCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.AlertCategoryCollection]
}

New-Alias gst_AlertCategoryCollection Get-SMOT_AlertCategoryCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AlertCategoryCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertCategoryCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertCategoryCollection" ($args)
}
}

New-Alias gs_AlertCategoryCollection Get-SMO_AlertCategoryCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_OperatorCategory
{
[Microsoft.SqlServer.Management.Smo.Agent.OperatorCategory]
}

New-Alias gst_OperatorCategory Get-SMOT_OperatorCategory -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_OperatorCategory
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.OperatorCategory"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.OperatorCategory" ($args)
}
}

New-Alias gs_OperatorCategory Get-SMO_OperatorCategory -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_OperatorCategoryCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.OperatorCategoryCollection]
}

New-Alias gst_OperatorCategoryCollection Get-SMOT_OperatorCategoryCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_OperatorCategoryCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.OperatorCategoryCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.OperatorCategoryCollection" ($args)
}
}

New-Alias gs_OperatorCategoryCollection Get-SMO_OperatorCategoryCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AlertSystem
{
[Microsoft.SqlServer.Management.Smo.Agent.AlertSystem]
}

New-Alias gst_AlertSystem Get-SMOT_AlertSystem -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AlertSystem
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertSystem"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertSystem" ($args)
}
}

New-Alias gs_AlertSystem Get-SMO_AlertSystem -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Operator
{
[Microsoft.SqlServer.Management.Smo.Agent.Operator]
}

New-Alias gst_Operator Get-SMOT_Operator -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Operator
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.Operator"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.Operator" ($args)
}
}

New-Alias gs_Operator Get-SMO_Operator -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_OperatorCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.OperatorCollection]
}

New-Alias gst_OperatorCollection Get-SMOT_OperatorCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_OperatorCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.OperatorCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.OperatorCollection" ($args)
}
}

New-Alias gs_OperatorCollection Get-SMO_OperatorCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Alert
{
[Microsoft.SqlServer.Management.Smo.Agent.Alert]
}

New-Alias gst_Alert Get-SMOT_Alert -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Alert
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.Alert"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.Alert" ($args)
}
}

New-Alias gs_Alert Get-SMO_Alert -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotifyType
{
[Microsoft.SqlServer.Management.Smo.Agent.NotifyType]
}

New-Alias gst_NotifyType Get-SMOT_NotifyType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotifyType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.NotifyType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.NotifyType" ($args)
}
}

New-Alias gs_NotifyType Get-SMO_NotifyType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AlertCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.AlertCollection]
}

New-Alias gst_AlertCollection Get-SMOT_AlertCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AlertCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertCollection" ($args)
}
}

New-Alias gs_AlertCollection Get-SMO_AlertCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TargetServer
{
[Microsoft.SqlServer.Management.Smo.Agent.TargetServer]
}

New-Alias gst_TargetServer Get-SMOT_TargetServer -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TargetServer
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServer"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServer" ($args)
}
}

New-Alias gs_TargetServer Get-SMO_TargetServer -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TargetServerCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.TargetServerCollection]
}

New-Alias gst_TargetServerCollection Get-SMOT_TargetServerCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TargetServerCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServerCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServerCollection" ($args)
}
}

New-Alias gs_TargetServerCollection Get-SMO_TargetServerCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TargetServerGroup
{
[Microsoft.SqlServer.Management.Smo.Agent.TargetServerGroup]
}

New-Alias gst_TargetServerGroup Get-SMOT_TargetServerGroup -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TargetServerGroup
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServerGroup"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServerGroup" ($args)
}
}

New-Alias gs_TargetServerGroup Get-SMO_TargetServerGroup -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TargetServerGroupCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.TargetServerGroupCollection]
}

New-Alias gst_TargetServerGroupCollection Get-SMOT_TargetServerGroupCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TargetServerGroupCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServerGroupCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServerGroupCollection" ($args)
}
}

New-Alias gs_TargetServerGroupCollection Get-SMO_TargetServerGroupCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NumberedStoredProcedureParameter
{
[Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureParameter]
}

New-Alias gst_NumberedStoredProcedureParameter Get-SMOT_NumberedStoredProcedureParameter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NumberedStoredProcedureParameter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureParameter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureParameter" ($args)
}
}

New-Alias gs_NumberedStoredProcedureParameter Get-SMO_NumberedStoredProcedureParameter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobStep
{
[Microsoft.SqlServer.Management.Smo.Agent.JobStep]
}

New-Alias gst_JobStep Get-SMOT_JobStep -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobStep
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobStep"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobStep" ($args)
}
}

New-Alias gs_JobStep Get-SMO_JobStep -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobStepCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.JobStepCollection]
}

New-Alias gst_JobStepCollection Get-SMOT_JobStepCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobStepCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobStepCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobStepCollection" ($args)
}
}

New-Alias gs_JobStepCollection Get-SMO_JobStepCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ScheduleBase
{
[Microsoft.SqlServer.Management.Smo.Agent.ScheduleBase]
}

New-Alias gst_ScheduleBase Get-SMOT_ScheduleBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ScheduleBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.ScheduleBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.ScheduleBase" ($args)
}
}

New-Alias gs_ScheduleBase Get-SMO_ScheduleBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobSchedule
{
[Microsoft.SqlServer.Management.Smo.Agent.JobSchedule]
}

New-Alias gst_JobSchedule Get-SMOT_JobSchedule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobSchedule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobSchedule"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobSchedule" ($args)
}
}

New-Alias gs_JobSchedule Get-SMO_JobSchedule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobScheduleCollectionBase
{
[Microsoft.SqlServer.Management.Smo.JobScheduleCollectionBase]
}

New-Alias gst_JobScheduleCollectionBase Get-SMOT_JobScheduleCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobScheduleCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.JobScheduleCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.JobScheduleCollectionBase" ($args)
}
}

New-Alias gs_JobScheduleCollectionBase Get-SMO_JobScheduleCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobScheduleCollection
{
[Microsoft.SqlServer.Management.Smo.Agent.JobScheduleCollection]
}

New-Alias gst_JobScheduleCollection Get-SMOT_JobScheduleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobScheduleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobScheduleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobScheduleCollection" ($args)
}
}

New-Alias gs_JobScheduleCollection Get-SMO_JobScheduleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserOptions
{
[Microsoft.SqlServer.Management.Smo.UserOptions]
}

New-Alias gst_UserOptions Get-SMOT_UserOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserOptions" ($args)
}
}

New-Alias gs_UserOptions Get-SMO_UserOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Information
{
[Microsoft.SqlServer.Management.Smo.Information]
}

New-Alias gst_Information Get-SMOT_Information -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Information
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Information"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Information" ($args)
}
}

New-Alias gs_Information Get-SMO_Information -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Settings
{
[Microsoft.SqlServer.Management.Smo.Settings]
}

New-Alias gst_Settings Get-SMOT_Settings -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Settings
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Settings"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Settings" ($args)
}
}

New-Alias gs_Settings Get-SMO_Settings -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ForeignKeyColumnCollection
{
[Microsoft.SqlServer.Management.Smo.ForeignKeyColumnCollection]
}

New-Alias gst_ForeignKeyColumnCollection Get-SMOT_ForeignKeyColumnCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ForeignKeyColumnCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKeyColumnCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKeyColumnCollection" ($args)
}
}

New-Alias gs_ForeignKeyColumnCollection Get-SMO_ForeignKeyColumnCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ForeignKeyColumn
{
[Microsoft.SqlServer.Management.Smo.ForeignKeyColumn]
}

New-Alias gst_ForeignKeyColumn Get-SMOT_ForeignKeyColumn -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ForeignKeyColumn
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKeyColumn"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKeyColumn" ($args)
}
}

New-Alias gs_ForeignKeyColumn Get-SMO_ForeignKeyColumn -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LinkedServerLogin
{
[Microsoft.SqlServer.Management.Smo.LinkedServerLogin]
}

New-Alias gst_LinkedServerLogin Get-SMOT_LinkedServerLogin -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LinkedServerLogin
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedServerLogin"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedServerLogin" ($args)
}
}

New-Alias gs_LinkedServerLogin Get-SMO_LinkedServerLogin -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LinkedServerLoginCollection
{
[Microsoft.SqlServer.Management.Smo.LinkedServerLoginCollection]
}

New-Alias gst_LinkedServerLoginCollection Get-SMOT_LinkedServerLoginCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LinkedServerLoginCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedServerLoginCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LinkedServerLoginCollection" ($args)
}
}

New-Alias gs_LinkedServerLoginCollection Get-SMO_LinkedServerLoginCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupDevice
{
[Microsoft.SqlServer.Management.Smo.BackupDevice]
}

New-Alias gst_BackupDevice Get-SMOT_BackupDevice -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupDevice
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDevice"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDevice" ($args)
}
}

New-Alias gs_BackupDevice Get-SMO_BackupDevice -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupDeviceCollection
{
[Microsoft.SqlServer.Management.Smo.BackupDeviceCollection]
}

New-Alias gst_BackupDeviceCollection Get-SMOT_BackupDeviceCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupDeviceCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceCollection" ($args)
}
}

New-Alias gs_BackupDeviceCollection Get-SMO_BackupDeviceCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionFunction
{
[Microsoft.SqlServer.Management.Smo.PartitionFunction]
}

New-Alias gst_PartitionFunction Get-SMOT_PartitionFunction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionFunction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunction" ($args)
}
}

New-Alias gs_PartitionFunction Get-SMO_PartitionFunction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionFunctionEvents
{
[Microsoft.SqlServer.Management.Smo.PartitionFunctionEvents]
}

New-Alias gst_PartitionFunctionEvents Get-SMOT_PartitionFunctionEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionFunctionEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunctionEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunctionEvents" ($args)
}
}

New-Alias gs_PartitionFunctionEvents Get-SMO_PartitionFunctionEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionFunctionCollection
{
[Microsoft.SqlServer.Management.Smo.PartitionFunctionCollection]
}

New-Alias gst_PartitionFunctionCollection Get-SMOT_PartitionFunctionCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionFunctionCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunctionCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunctionCollection" ($args)
}
}

New-Alias gs_PartitionFunctionCollection Get-SMO_PartitionFunctionCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionFunctionParameter
{
[Microsoft.SqlServer.Management.Smo.PartitionFunctionParameter]
}

New-Alias gst_PartitionFunctionParameter Get-SMOT_PartitionFunctionParameter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionFunctionParameter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunctionParameter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunctionParameter" ($args)
}
}

New-Alias gs_PartitionFunctionParameter Get-SMO_PartitionFunctionParameter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionFunctionParameterCollection
{
[Microsoft.SqlServer.Management.Smo.PartitionFunctionParameterCollection]
}

New-Alias gst_PartitionFunctionParameterCollection Get-SMOT_PartitionFunctionParameterCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionFunctionParameterCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunctionParameterCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionFunctionParameterCollection" ($args)
}
}

New-Alias gs_PartitionFunctionParameterCollection Get-SMO_PartitionFunctionParameterCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionScheme
{
[Microsoft.SqlServer.Management.Smo.PartitionScheme]
}

New-Alias gst_PartitionScheme Get-SMOT_PartitionScheme -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionScheme
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionScheme"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionScheme" ($args)
}
}

New-Alias gs_PartitionScheme Get-SMO_PartitionScheme -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionSchemeEvents
{
[Microsoft.SqlServer.Management.Smo.PartitionSchemeEvents]
}

New-Alias gst_PartitionSchemeEvents Get-SMOT_PartitionSchemeEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionSchemeEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionSchemeEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionSchemeEvents" ($args)
}
}

New-Alias gs_PartitionSchemeEvents Get-SMO_PartitionSchemeEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionSchemeCollection
{
[Microsoft.SqlServer.Management.Smo.PartitionSchemeCollection]
}

New-Alias gst_PartitionSchemeCollection Get-SMOT_PartitionSchemeCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionSchemeCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionSchemeCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionSchemeCollection" ($args)
}
}

New-Alias gs_PartitionSchemeCollection Get-SMO_PartitionSchemeCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionSchemeParameter
{
[Microsoft.SqlServer.Management.Smo.PartitionSchemeParameter]
}

New-Alias gst_PartitionSchemeParameter Get-SMOT_PartitionSchemeParameter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionSchemeParameter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionSchemeParameter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionSchemeParameter" ($args)
}
}

New-Alias gs_PartitionSchemeParameter Get-SMO_PartitionSchemeParameter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PartitionSchemeParameterCollection
{
[Microsoft.SqlServer.Management.Smo.PartitionSchemeParameterCollection]
}

New-Alias gst_PartitionSchemeParameterCollection Get-SMOT_PartitionSchemeParameterCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PartitionSchemeParameterCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionSchemeParameterCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PartitionSchemeParameterCollection" ($args)
}
}

New-Alias gs_PartitionSchemeParameterCollection Get-SMO_PartitionSchemeParameterCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlAssembly
{
[Microsoft.SqlServer.Management.Smo.SqlAssembly]
}

New-Alias gst_SqlAssembly Get-SMOT_SqlAssembly -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlAssembly
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssembly"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssembly" ($args)
}
}

New-Alias gs_SqlAssembly Get-SMO_SqlAssembly -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlAssemblyEvents
{
[Microsoft.SqlServer.Management.Smo.SqlAssemblyEvents]
}

New-Alias gst_SqlAssemblyEvents Get-SMOT_SqlAssemblyEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlAssemblyEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyEvents" ($args)
}
}

New-Alias gs_SqlAssemblyEvents Get-SMO_SqlAssemblyEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlAssemblyCollection
{
[Microsoft.SqlServer.Management.Smo.SqlAssemblyCollection]
}

New-Alias gst_SqlAssemblyCollection Get-SMOT_SqlAssemblyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlAssemblyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyCollection" ($args)
}
}

New-Alias gs_SqlAssemblyCollection Get-SMO_SqlAssemblyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlAssemblyFile
{
[Microsoft.SqlServer.Management.Smo.SqlAssemblyFile]
}

New-Alias gst_SqlAssemblyFile Get-SMOT_SqlAssemblyFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlAssemblyFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyFile" ($args)
}
}

New-Alias gs_SqlAssemblyFile Get-SMO_SqlAssemblyFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlAssemblyFileCollection
{
[Microsoft.SqlServer.Management.Smo.SqlAssemblyFileCollection]
}

New-Alias gst_SqlAssemblyFileCollection Get-SMOT_SqlAssemblyFileCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlAssemblyFileCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyFileCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyFileCollection" ($args)
}
}

New-Alias gs_SqlAssemblyFileCollection Get-SMO_SqlAssemblyFileCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedType
{
[Microsoft.SqlServer.Management.Smo.UserDefinedType]
}

New-Alias gst_UserDefinedType Get-SMOT_UserDefinedType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedType" ($args)
}
}

New-Alias gs_UserDefinedType Get-SMO_UserDefinedType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedTypeEvents
{
[Microsoft.SqlServer.Management.Smo.UserDefinedTypeEvents]
}

New-Alias gst_UserDefinedTypeEvents Get-SMOT_UserDefinedTypeEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedTypeEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedTypeEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedTypeEvents" ($args)
}
}

New-Alias gs_UserDefinedTypeEvents Get-SMO_UserDefinedTypeEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedTypeCollection
{
[Microsoft.SqlServer.Management.Smo.UserDefinedTypeCollection]
}

New-Alias gst_UserDefinedTypeCollection Get-SMOT_UserDefinedTypeCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedTypeCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedTypeCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedTypeCollection" ($args)
}
}

New-Alias gs_UserDefinedTypeCollection Get-SMO_UserDefinedTypeCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedAggregate
{
[Microsoft.SqlServer.Management.Smo.UserDefinedAggregate]
}

New-Alias gst_UserDefinedAggregate Get-SMOT_UserDefinedAggregate -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedAggregate
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedAggregate"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedAggregate" ($args)
}
}

New-Alias gs_UserDefinedAggregate Get-SMO_UserDefinedAggregate -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedAggregateCollection
{
[Microsoft.SqlServer.Management.Smo.UserDefinedAggregateCollection]
}

New-Alias gst_UserDefinedAggregateCollection Get-SMOT_UserDefinedAggregateCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedAggregateCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedAggregateCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedAggregateCollection" ($args)
}
}

New-Alias gs_UserDefinedAggregateCollection Get-SMO_UserDefinedAggregateCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedAggregateParameter
{
[Microsoft.SqlServer.Management.Smo.UserDefinedAggregateParameter]
}

New-Alias gst_UserDefinedAggregateParameter Get-SMOT_UserDefinedAggregateParameter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedAggregateParameter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedAggregateParameter"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedAggregateParameter" ($args)
}
}

New-Alias gs_UserDefinedAggregateParameter Get-SMO_UserDefinedAggregateParameter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedAggregateParameterCollection
{
[Microsoft.SqlServer.Management.Smo.UserDefinedAggregateParameterCollection]
}

New-Alias gst_UserDefinedAggregateParameterCollection Get-SMOT_UserDefinedAggregateParameterCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedAggregateParameterCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedAggregateParameterCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedAggregateParameterCollection" ($args)
}
}

New-Alias gs_UserDefinedAggregateParameterCollection Get-SMO_UserDefinedAggregateParameterCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FullTextService
{
[Microsoft.SqlServer.Management.Smo.FullTextService]
}

New-Alias gst_FullTextService Get-SMOT_FullTextService -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FullTextService
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextService"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextService" ($args)
}
}

New-Alias gs_FullTextService Get-SMO_FullTextService -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FullTextCatalog
{
[Microsoft.SqlServer.Management.Smo.FullTextCatalog]
}

New-Alias gst_FullTextCatalog Get-SMOT_FullTextCatalog -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FullTextCatalog
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextCatalog"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextCatalog" ($args)
}
}

New-Alias gs_FullTextCatalog Get-SMO_FullTextCatalog -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FullTextCatalogCollection
{
[Microsoft.SqlServer.Management.Smo.FullTextCatalogCollection]
}

New-Alias gst_FullTextCatalogCollection Get-SMOT_FullTextCatalogCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FullTextCatalogCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextCatalogCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextCatalogCollection" ($args)
}
}

New-Alias gs_FullTextCatalogCollection Get-SMO_FullTextCatalogCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FullTextIndex
{
[Microsoft.SqlServer.Management.Smo.FullTextIndex]
}

New-Alias gst_FullTextIndex Get-SMOT_FullTextIndex -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FullTextIndex
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextIndex"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextIndex" ($args)
}
}

New-Alias gs_FullTextIndex Get-SMO_FullTextIndex -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FullTextIndexColumn
{
[Microsoft.SqlServer.Management.Smo.FullTextIndexColumn]
}

New-Alias gst_FullTextIndexColumn Get-SMOT_FullTextIndexColumn -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FullTextIndexColumn
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextIndexColumn"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextIndexColumn" ($args)
}
}

New-Alias gs_FullTextIndexColumn Get-SMO_FullTextIndexColumn -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FullTextIndexColumnCollection
{
[Microsoft.SqlServer.Management.Smo.FullTextIndexColumnCollection]
}

New-Alias gst_FullTextIndexColumnCollection Get-SMOT_FullTextIndexColumnCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FullTextIndexColumnCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextIndexColumnCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FullTextIndexColumnCollection" ($args)
}
}

New-Alias gs_FullTextIndexColumnCollection Get-SMO_FullTextIndexColumnCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabasePermission
{
[Microsoft.SqlServer.Management.Smo.DatabasePermission]
}

New-Alias gst_DatabasePermission Get-SMOT_DatabasePermission -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabasePermission
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabasePermission"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabasePermission" ($args)
}
}

New-Alias gs_DatabasePermission Get-SMO_DatabasePermission -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PermissionSetBase
{
[Microsoft.SqlServer.Management.Smo.PermissionSetBase]
}

New-Alias gst_PermissionSetBase Get-SMOT_PermissionSetBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PermissionSetBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PermissionSetBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PermissionSetBase" ($args)
}
}

New-Alias gs_PermissionSetBase Get-SMO_PermissionSetBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabasePermissionSet
{
[Microsoft.SqlServer.Management.Smo.DatabasePermissionSet]
}

New-Alias gst_DatabasePermissionSet Get-SMOT_DatabasePermissionSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabasePermissionSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabasePermissionSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabasePermissionSet" ($args)
}
}

New-Alias gs_DatabasePermissionSet Get-SMO_DatabasePermissionSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectPermission
{
[Microsoft.SqlServer.Management.Smo.ObjectPermission]
}

New-Alias gst_ObjectPermission Get-SMOT_ObjectPermission -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectPermission
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectPermission"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectPermission" ($args)
}
}

New-Alias gs_ObjectPermission Get-SMO_ObjectPermission -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectPermissionSet
{
[Microsoft.SqlServer.Management.Smo.ObjectPermissionSet]
}

New-Alias gst_ObjectPermissionSet Get-SMOT_ObjectPermissionSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectPermissionSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectPermissionSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectPermissionSet" ($args)
}
}

New-Alias gs_ObjectPermissionSet Get-SMO_ObjectPermissionSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerPermission
{
[Microsoft.SqlServer.Management.Smo.ServerPermission]
}

New-Alias gst_ServerPermission Get-SMOT_ServerPermission -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerPermission
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerPermission"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerPermission" ($args)
}
}

New-Alias gs_ServerPermission Get-SMO_ServerPermission -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerPermissionSet
{
[Microsoft.SqlServer.Management.Smo.ServerPermissionSet]
}

New-Alias gst_ServerPermissionSet Get-SMOT_ServerPermissionSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerPermissionSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerPermissionSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerPermissionSet" ($args)
}
}

New-Alias gs_ServerPermissionSet Get-SMO_ServerPermissionSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PermissionInfo
{
[Microsoft.SqlServer.Management.Smo.PermissionInfo]
}

New-Alias gst_PermissionInfo Get-SMOT_PermissionInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PermissionInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PermissionInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PermissionInfo" ($args)
}
}

New-Alias gs_PermissionInfo Get-SMO_PermissionInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectPermissionInfo
{
[Microsoft.SqlServer.Management.Smo.ObjectPermissionInfo]
}

New-Alias gst_ObjectPermissionInfo Get-SMOT_ObjectPermissionInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectPermissionInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectPermissionInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectPermissionInfo" ($args)
}
}

New-Alias gs_ObjectPermissionInfo Get-SMO_ObjectPermissionInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabasePermissionInfo
{
[Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo]
}

New-Alias gst_DatabasePermissionInfo Get-SMOT_DatabasePermissionInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabasePermissionInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo" ($args)
}
}

New-Alias gs_DatabasePermissionInfo Get-SMO_DatabasePermissionInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerPermissionInfo
{
[Microsoft.SqlServer.Management.Smo.ServerPermissionInfo]
}

New-Alias gst_ServerPermissionInfo Get-SMOT_ServerPermissionInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerPermissionInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerPermissionInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerPermissionInfo" ($args)
}
}

New-Alias gs_ServerPermissionInfo Get-SMO_ServerPermissionInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MessageObjectBase
{
[Microsoft.SqlServer.Management.Smo.MessageObjectBase]
}

New-Alias gst_MessageObjectBase Get-SMOT_MessageObjectBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MessageObjectBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MessageObjectBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MessageObjectBase" ($args)
}
}

New-Alias gs_MessageObjectBase Get-SMO_MessageObjectBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SystemMessage
{
[Microsoft.SqlServer.Management.Smo.SystemMessage]
}

New-Alias gst_SystemMessage Get-SMOT_SystemMessage -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SystemMessage
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SystemMessage"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SystemMessage" ($args)
}
}

New-Alias gs_SystemMessage Get-SMO_SystemMessage -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MessageCollectionBase
{
[Microsoft.SqlServer.Management.Smo.MessageCollectionBase]
}

New-Alias gst_MessageCollectionBase Get-SMOT_MessageCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MessageCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MessageCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MessageCollectionBase" ($args)
}
}

New-Alias gs_MessageCollectionBase Get-SMO_MessageCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SystemMessageCollection
{
[Microsoft.SqlServer.Management.Smo.SystemMessageCollection]
}

New-Alias gst_SystemMessageCollection Get-SMOT_SystemMessageCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SystemMessageCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SystemMessageCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SystemMessageCollection" ($args)
}
}

New-Alias gs_SystemMessageCollection Get-SMO_SystemMessageCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedMessage
{
[Microsoft.SqlServer.Management.Smo.UserDefinedMessage]
}

New-Alias gst_UserDefinedMessage Get-SMOT_UserDefinedMessage -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedMessage
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedMessage"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedMessage" ($args)
}
}

New-Alias gs_UserDefinedMessage Get-SMO_UserDefinedMessage -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedMessageCollection
{
[Microsoft.SqlServer.Management.Smo.UserDefinedMessageCollection]
}

New-Alias gst_UserDefinedMessageCollection Get-SMOT_UserDefinedMessageCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedMessageCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedMessageCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedMessageCollection" ($args)
}
}

New-Alias gs_UserDefinedMessageCollection Get-SMO_UserDefinedMessageCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationRole
{
[Microsoft.SqlServer.Management.Smo.ApplicationRole]
}

New-Alias gst_ApplicationRole Get-SMOT_ApplicationRole -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationRole
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ApplicationRole"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ApplicationRole" ($args)
}
}

New-Alias gs_ApplicationRole Get-SMO_ApplicationRole -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationRoleEvents
{
[Microsoft.SqlServer.Management.Smo.ApplicationRoleEvents]
}

New-Alias gst_ApplicationRoleEvents Get-SMOT_ApplicationRoleEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationRoleEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ApplicationRoleEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ApplicationRoleEvents" ($args)
}
}

New-Alias gs_ApplicationRoleEvents Get-SMO_ApplicationRoleEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationRoleCollection
{
[Microsoft.SqlServer.Management.Smo.ApplicationRoleCollection]
}

New-Alias gst_ApplicationRoleCollection Get-SMOT_ApplicationRoleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationRoleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ApplicationRoleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ApplicationRoleCollection" ($args)
}
}

New-Alias gs_ApplicationRoleCollection Get-SMO_ApplicationRoleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Schema
{
[Microsoft.SqlServer.Management.Smo.Schema]
}

New-Alias gst_Schema Get-SMOT_Schema -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Schema
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Schema"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Schema" ($args)
}
}

New-Alias gs_Schema Get-SMO_Schema -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SchemaEvents
{
[Microsoft.SqlServer.Management.Smo.SchemaEvents]
}

New-Alias gst_SchemaEvents Get-SMOT_SchemaEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SchemaEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SchemaEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SchemaEvents" ($args)
}
}

New-Alias gs_SchemaEvents Get-SMO_SchemaEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SchemaCollection
{
[Microsoft.SqlServer.Management.Smo.SchemaCollection]
}

New-Alias gst_SchemaCollection Get-SMOT_SchemaCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SchemaCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SchemaCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SchemaCollection" ($args)
}
}

New-Alias gs_SchemaCollection Get-SMO_SchemaCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Synonym
{
[Microsoft.SqlServer.Management.Smo.Synonym]
}

New-Alias gst_Synonym Get-SMOT_Synonym -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Synonym
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Synonym"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Synonym" ($args)
}
}

New-Alias gs_Synonym Get-SMO_Synonym -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SynonymEvents
{
[Microsoft.SqlServer.Management.Smo.SynonymEvents]
}

New-Alias gst_SynonymEvents Get-SMOT_SynonymEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SynonymEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SynonymEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SynonymEvents" ($args)
}
}

New-Alias gs_SynonymEvents Get-SMO_SynonymEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SynonymCollection
{
[Microsoft.SqlServer.Management.Smo.SynonymCollection]
}

New-Alias gst_SynonymCollection Get-SMOT_SynonymCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SynonymCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SynonymCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SynonymCollection" ($args)
}
}

New-Alias gs_SynonymCollection Get-SMO_SynonymCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseOptions
{
[Microsoft.SqlServer.Management.Smo.DatabaseOptions]
}

New-Alias gst_DatabaseOptions Get-SMOT_DatabaseOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseOptions" ($args)
}
}

New-Alias gs_DatabaseOptions Get-SMO_DatabaseOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TerminationClause
{
[Microsoft.SqlServer.Management.Smo.TerminationClause]
}

New-Alias gst_TerminationClause Get-SMOT_TerminationClause -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TerminationClause
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TerminationClause"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TerminationClause" ($args)
}
}

New-Alias gs_TerminationClause Get-SMO_TerminationClause -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlDataType
{
[Microsoft.SqlServer.Management.Smo.SqlDataType]
}

New-Alias gst_SqlDataType Get-SMOT_SqlDataType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlDataType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlDataType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlDataType" ($args)
}
}

New-Alias gs_SqlDataType Get-SMO_SqlDataType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataType
{
[Microsoft.SqlServer.Management.Smo.DataType]
}

New-Alias gst_DataType Get-SMOT_DataType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DataType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DataType" ($args)
}
}

New-Alias gs_DataType Get-SMO_DataType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SystemDataType
{
[Microsoft.SqlServer.Management.Smo.SystemDataType]
}

New-Alias gst_SystemDataType Get-SMOT_SystemDataType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SystemDataType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SystemDataType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SystemDataType" ($args)
}
}

New-Alias gs_SystemDataType Get-SMO_SystemDataType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SystemDataTypeCollection
{
[Microsoft.SqlServer.Management.Smo.SystemDataTypeCollection]
}

New-Alias gst_SystemDataTypeCollection Get-SMOT_SystemDataTypeCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SystemDataTypeCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SystemDataTypeCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SystemDataTypeCollection" ($args)
}
}

New-Alias gs_SystemDataTypeCollection Get-SMO_SystemDataTypeCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PropertyCollection
{
[Microsoft.SqlServer.Management.Smo.PropertyCollection]
}

New-Alias gst_PropertyCollection Get-SMOT_PropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PropertyCollection" ($args)
}
}

New-Alias gs_PropertyCollection Get-SMO_PropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlPropertyCollection
{
[Microsoft.SqlServer.Management.Smo.SqlPropertyCollection]
}

New-Alias gst_SqlPropertyCollection Get-SMOT_SqlPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlPropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlPropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlPropertyCollection" ($args)
}
}

New-Alias gs_SqlPropertyCollection Get-SMO_SqlPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlPropertyInfo
{
[Microsoft.SqlServer.Management.Smo.SqlPropertyInfo]
}

New-Alias gst_SqlPropertyInfo Get-SMOT_SqlPropertyInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlPropertyInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlPropertyInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlPropertyInfo" ($args)
}
}

New-Alias gs_SqlPropertyInfo Get-SMO_SqlPropertyInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerActiveDirectory
{
[Microsoft.SqlServer.Management.Smo.ServerActiveDirectory]
}

New-Alias gst_ServerActiveDirectory Get-SMOT_ServerActiveDirectory -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerActiveDirectory
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerActiveDirectory"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerActiveDirectory" ($args)
}
}

New-Alias gs_ServerActiveDirectory Get-SMO_ServerActiveDirectory -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseActiveDirectory
{
[Microsoft.SqlServer.Management.Smo.DatabaseActiveDirectory]
}

New-Alias gst_DatabaseActiveDirectory Get-SMOT_DatabaseActiveDirectory -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseActiveDirectory
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseActiveDirectory"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseActiveDirectory" ($args)
}
}

New-Alias gs_DatabaseActiveDirectory Get-SMO_DatabaseActiveDirectory -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventType
{
[Microsoft.SqlServer.Management.Smo.EventType]
}

New-Alias gst_EventType Get-SMOT_EventType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EventType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EventType" ($args)
}
}

New-Alias gs_EventType Get-SMO_EventType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerEvent
{
[Microsoft.SqlServer.Management.Smo.ServerEvent]
}

New-Alias gst_ServerEvent Get-SMOT_ServerEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEvent" ($args)
}
}

New-Alias gs_ServerEvent Get-SMO_ServerEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerEventSet
{
[Microsoft.SqlServer.Management.Smo.ServerEventSet]
}

New-Alias gst_ServerEventSet Get-SMOT_ServerEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEventSet" ($args)
}
}

New-Alias gs_ServerEventSet Get-SMO_ServerEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerTraceEvent
{
[Microsoft.SqlServer.Management.Smo.ServerTraceEvent]
}

New-Alias gst_ServerTraceEvent Get-SMOT_ServerTraceEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerTraceEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerTraceEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerTraceEvent" ($args)
}
}

New-Alias gs_ServerTraceEvent Get-SMO_ServerTraceEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerTraceEventSet
{
[Microsoft.SqlServer.Management.Smo.ServerTraceEventSet]
}

New-Alias gst_ServerTraceEventSet Get-SMOT_ServerTraceEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerTraceEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerTraceEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerTraceEventSet" ($args)
}
}

New-Alias gs_ServerTraceEventSet Get-SMO_ServerTraceEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseEvent
{
[Microsoft.SqlServer.Management.Smo.DatabaseEvent]
}

New-Alias gst_DatabaseEvent Get-SMOT_DatabaseEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEvent" ($args)
}
}

New-Alias gs_DatabaseEvent Get-SMO_DatabaseEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseEventSet
{
[Microsoft.SqlServer.Management.Smo.DatabaseEventSet]
}

New-Alias gst_DatabaseEventSet Get-SMOT_DatabaseEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseEventSet" ($args)
}
}

New-Alias gs_DatabaseEventSet Get-SMO_DatabaseEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TableEvent
{
[Microsoft.SqlServer.Management.Smo.TableEvent]
}

New-Alias gst_TableEvent Get-SMOT_TableEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TableEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TableEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TableEvent" ($args)
}
}

New-Alias gs_TableEvent Get-SMO_TableEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TableEventSet
{
[Microsoft.SqlServer.Management.Smo.TableEventSet]
}

New-Alias gst_TableEventSet Get-SMOT_TableEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TableEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TableEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TableEventSet" ($args)
}
}

New-Alias gs_TableEventSet Get-SMO_TableEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ViewEvent
{
[Microsoft.SqlServer.Management.Smo.ViewEvent]
}

New-Alias gst_ViewEvent Get-SMOT_ViewEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ViewEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ViewEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ViewEvent" ($args)
}
}

New-Alias gs_ViewEvent Get-SMO_ViewEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ViewEventSet
{
[Microsoft.SqlServer.Management.Smo.ViewEventSet]
}

New-Alias gst_ViewEventSet Get-SMOT_ViewEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ViewEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ViewEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ViewEventSet" ($args)
}
}

New-Alias gs_ViewEventSet Get-SMO_ViewEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceQueueEvent
{
[Microsoft.SqlServer.Management.Smo.ServiceQueueEvent]
}

New-Alias gst_ServiceQueueEvent Get-SMOT_ServiceQueueEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceQueueEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceQueueEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceQueueEvent" ($args)
}
}

New-Alias gs_ServiceQueueEvent Get-SMO_ServiceQueueEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceQueueEventSet
{
[Microsoft.SqlServer.Management.Smo.ServiceQueueEventSet]
}

New-Alias gst_ServiceQueueEventSet Get-SMOT_ServiceQueueEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceQueueEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceQueueEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceQueueEventSet" ($args)
}
}

New-Alias gs_ServiceQueueEventSet Get-SMO_ServiceQueueEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectEvent
{
[Microsoft.SqlServer.Management.Smo.ObjectEvent]
}

New-Alias gst_ObjectEvent Get-SMOT_ObjectEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectEvent" ($args)
}
}

New-Alias gs_ObjectEvent Get-SMO_ObjectEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectEventSet
{
[Microsoft.SqlServer.Management.Smo.ObjectEventSet]
}

New-Alias gst_ObjectEventSet Get-SMOT_ObjectEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectEventSet" ($args)
}
}

New-Alias gs_ObjectEventSet Get-SMO_ObjectEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedFunctionEvent
{
[Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEvent]
}

New-Alias gst_UserDefinedFunctionEvent Get-SMOT_UserDefinedFunctionEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedFunctionEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEvent" ($args)
}
}

New-Alias gs_UserDefinedFunctionEvent Get-SMO_UserDefinedFunctionEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedFunctionEventSet
{
[Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEventSet]
}

New-Alias gst_UserDefinedFunctionEventSet Get-SMOT_UserDefinedFunctionEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedFunctionEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionEventSet" ($args)
}
}

New-Alias gs_UserDefinedFunctionEventSet Get-SMO_UserDefinedFunctionEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StoredProcedureEvent
{
[Microsoft.SqlServer.Management.Smo.StoredProcedureEvent]
}

New-Alias gst_StoredProcedureEvent Get-SMOT_StoredProcedureEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StoredProcedureEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureEvent" ($args)
}
}

New-Alias gs_StoredProcedureEvent Get-SMO_StoredProcedureEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StoredProcedureEventSet
{
[Microsoft.SqlServer.Management.Smo.StoredProcedureEventSet]
}

New-Alias gst_StoredProcedureEventSet Get-SMOT_StoredProcedureEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StoredProcedureEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.StoredProcedureEventSet" ($args)
}
}

New-Alias gs_StoredProcedureEventSet Get-SMO_StoredProcedureEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlAssemblyEvent
{
[Microsoft.SqlServer.Management.Smo.SqlAssemblyEvent]
}

New-Alias gst_SqlAssemblyEvent Get-SMOT_SqlAssemblyEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlAssemblyEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyEvent" ($args)
}
}

New-Alias gs_SqlAssemblyEvent Get-SMO_SqlAssemblyEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlAssemblyEventSet
{
[Microsoft.SqlServer.Management.Smo.SqlAssemblyEventSet]
}

New-Alias gst_SqlAssemblyEventSet Get-SMOT_SqlAssemblyEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlAssemblyEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SqlAssemblyEventSet" ($args)
}
}

New-Alias gs_SqlAssemblyEventSet Get-SMO_SqlAssemblyEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerEventHandler
{
[Microsoft.SqlServer.Management.Smo.ServerEventHandler]
}

New-Alias gst_ServerEventHandler Get-SMOT_ServerEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEventHandler" ($args)
}
}

New-Alias gs_ServerEventHandler Get-SMO_ServerEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerEventArgs
{
[Microsoft.SqlServer.Management.Smo.ServerEventArgs]
}

New-Alias gst_ServerEventArgs Get-SMOT_ServerEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerEventArgs" ($args)
}
}

New-Alias gs_ServerEventArgs Get-SMO_ServerEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventProperty
{
[Microsoft.SqlServer.Management.Smo.EventProperty]
}

New-Alias gst_EventProperty Get-SMOT_EventProperty -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventProperty
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EventProperty"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EventProperty" ($args)
}
}

New-Alias gs_EventProperty Get-SMO_EventProperty -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventPropertyCollection
{
[Microsoft.SqlServer.Management.Smo.EventPropertyCollection]
}

New-Alias gst_EventPropertyCollection Get-SMOT_EventPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventPropertyCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EventPropertyCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EventPropertyCollection" ($args)
}
}

New-Alias gs_EventPropertyCollection Get-SMO_EventPropertyCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SoapMethodCollectionBase
{
[Microsoft.SqlServer.Management.Smo.SoapMethodCollectionBase]
}

New-Alias gst_SoapMethodCollectionBase Get-SMOT_SoapMethodCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SoapMethodCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SoapMethodCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SoapMethodCollectionBase" ($args)
}
}

New-Alias gs_SoapMethodCollectionBase Get-SMO_SoapMethodCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SoapMethodObject
{
[Microsoft.SqlServer.Management.Smo.SoapMethodObject]
}

New-Alias gst_SoapMethodObject Get-SMOT_SoapMethodObject -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SoapMethodObject
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SoapMethodObject"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SoapMethodObject" ($args)
}
}

New-Alias gs_SoapMethodObject Get-SMO_SoapMethodObject -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerInstance
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerInstance]
}

New-Alias gst_ServerInstance Get-SMOT_ServerInstance -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerInstance
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerInstance"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerInstance" ($args)
}
}

New-Alias gs_ServerInstance Get-SMO_ServerInstance -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerInstanceCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerInstanceCollection]
}

New-Alias gst_ServerInstanceCollection Get-SMOT_ServerInstanceCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerInstanceCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerInstanceCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerInstanceCollection" ($args)
}
}

New-Alias gs_ServerInstanceCollection Get-SMO_ServerInstanceCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerIPAddress
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerIPAddress]
}

New-Alias gst_ServerIPAddress Get-SMOT_ServerIPAddress -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerIPAddress
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerIPAddress"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerIPAddress" ($args)
}
}

New-Alias gs_ServerIPAddress Get-SMO_ServerIPAddress -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerIPAddressCollection
{
[Microsoft.SqlServer.Management.Smo.Wmi.ServerIPAddressCollection]
}

New-Alias gst_ServerIPAddressCollection Get-SMOT_ServerIPAddressCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerIPAddressCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerIPAddressCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Wmi.ServerIPAddressCollection" ($args)
}
}

New-Alias gs_ServerIPAddressCollection Get-SMO_ServerIPAddressCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_OleDbProviderSettings
{
[Microsoft.SqlServer.Management.Smo.OleDbProviderSettings]
}

New-Alias gst_OleDbProviderSettings Get-SMOT_OleDbProviderSettings -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_OleDbProviderSettings
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.OleDbProviderSettings"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.OleDbProviderSettings" ($args)
}
}

New-Alias gs_OleDbProviderSettings Get-SMO_OleDbProviderSettings -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_OleDbProviderSettingsCollection
{
[Microsoft.SqlServer.Management.Smo.OleDbProviderSettingsCollection]
}

New-Alias gst_OleDbProviderSettingsCollection Get-SMOT_OleDbProviderSettingsCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_OleDbProviderSettingsCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.OleDbProviderSettingsCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.OleDbProviderSettingsCollection" ($args)
}
}

New-Alias gs_OleDbProviderSettingsCollection Get-SMO_OleDbProviderSettingsCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_XmlSchemaCollection
{
[Microsoft.SqlServer.Management.Smo.XmlSchemaCollection]
}

New-Alias gst_XmlSchemaCollection Get-SMOT_XmlSchemaCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_XmlSchemaCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.XmlSchemaCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.XmlSchemaCollection" ($args)
}
}

New-Alias gs_XmlSchemaCollection Get-SMO_XmlSchemaCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_XmlSchemaCollectionCollection
{
[Microsoft.SqlServer.Management.Smo.XmlSchemaCollectionCollection]
}

New-Alias gst_XmlSchemaCollectionCollection Get-SMOT_XmlSchemaCollectionCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_XmlSchemaCollectionCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.XmlSchemaCollectionCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.XmlSchemaCollectionCollection" ($args)
}
}

New-Alias gs_XmlSchemaCollectionCollection Get-SMO_XmlSchemaCollectionCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlMail
{
[Microsoft.SqlServer.Management.Smo.Mail.SqlMail]
}

New-Alias gst_SqlMail Get-SMOT_SqlMail -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlMail
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.SqlMail"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.SqlMail" ($args)
}
}

New-Alias gs_SqlMail Get-SMO_SqlMail -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MailProfile
{
[Microsoft.SqlServer.Management.Smo.Mail.MailProfile]
}

New-Alias gst_MailProfile Get-SMOT_MailProfile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MailProfile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailProfile"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailProfile" ($args)
}
}

New-Alias gs_MailProfile Get-SMO_MailProfile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MailProfileCollection
{
[Microsoft.SqlServer.Management.Smo.Mail.MailProfileCollection]
}

New-Alias gst_MailProfileCollection Get-SMOT_MailProfileCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MailProfileCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailProfileCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailProfileCollection" ($args)
}
}

New-Alias gs_MailProfileCollection Get-SMO_MailProfileCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MailAccount
{
[Microsoft.SqlServer.Management.Smo.Mail.MailAccount]
}

New-Alias gst_MailAccount Get-SMOT_MailAccount -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MailAccount
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailAccount"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailAccount" ($args)
}
}

New-Alias gs_MailAccount Get-SMO_MailAccount -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MailAccountCollection
{
[Microsoft.SqlServer.Management.Smo.Mail.MailAccountCollection]
}

New-Alias gst_MailAccountCollection Get-SMOT_MailAccountCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MailAccountCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailAccountCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailAccountCollection" ($args)
}
}

New-Alias gs_MailAccountCollection Get-SMO_MailAccountCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MailServer
{
[Microsoft.SqlServer.Management.Smo.Mail.MailServer]
}

New-Alias gst_MailServer Get-SMOT_MailServer -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MailServer
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailServer"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailServer" ($args)
}
}

New-Alias gs_MailServer Get-SMO_MailServer -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MailServerCollection
{
[Microsoft.SqlServer.Management.Smo.Mail.MailServerCollection]
}

New-Alias gst_MailServerCollection Get-SMOT_MailServerCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MailServerCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailServerCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.MailServerCollection" ($args)
}
}

New-Alias gs_MailServerCollection Get-SMO_MailServerCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConfigurationValue
{
[Microsoft.SqlServer.Management.Smo.Mail.ConfigurationValue]
}

New-Alias gst_ConfigurationValue Get-SMOT_ConfigurationValue -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConfigurationValue
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.ConfigurationValue"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.ConfigurationValue" ($args)
}
}

New-Alias gs_ConfigurationValue Get-SMO_ConfigurationValue -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConfigurationValueCollection
{
[Microsoft.SqlServer.Management.Smo.Mail.ConfigurationValueCollection]
}

New-Alias gst_ConfigurationValueCollection Get-SMOT_ConfigurationValueCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConfigurationValueCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.ConfigurationValueCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Mail.ConfigurationValueCollection" ($args)
}
}

New-Alias gs_ConfigurationValueCollection Get-SMO_ConfigurationValueCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DdlTriggerBase
{
[Microsoft.SqlServer.Management.Smo.DdlTriggerBase]
}

New-Alias gst_DdlTriggerBase Get-SMOT_DdlTriggerBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DdlTriggerBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DdlTriggerBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DdlTriggerBase" ($args)
}
}

New-Alias gs_DdlTriggerBase Get-SMO_DdlTriggerBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseDdlTrigger
{
[Microsoft.SqlServer.Management.Smo.DatabaseDdlTrigger]
}

New-Alias gst_DatabaseDdlTrigger Get-SMOT_DatabaseDdlTrigger -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseDdlTrigger
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTrigger"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTrigger" ($args)
}
}

New-Alias gs_DatabaseDdlTrigger Get-SMO_DatabaseDdlTrigger -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseDdlTriggerCollection
{
[Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerCollection]
}

New-Alias gst_DatabaseDdlTriggerCollection Get-SMOT_DatabaseDdlTriggerCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseDdlTriggerCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerCollection" ($args)
}
}

New-Alias gs_DatabaseDdlTriggerCollection Get-SMO_DatabaseDdlTriggerCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerDdlTrigger
{
[Microsoft.SqlServer.Management.Smo.ServerDdlTrigger]
}

New-Alias gst_ServerDdlTrigger Get-SMOT_ServerDdlTrigger -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerDdlTrigger
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTrigger"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTrigger" ($args)
}
}

New-Alias gs_ServerDdlTrigger Get-SMO_ServerDdlTrigger -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerDdlTriggerCollection
{
[Microsoft.SqlServer.Management.Smo.ServerDdlTriggerCollection]
}

New-Alias gst_ServerDdlTriggerCollection Get-SMOT_ServerDdlTriggerCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerDdlTriggerCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTriggerCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTriggerCollection" ($args)
}
}

New-Alias gs_ServerDdlTriggerCollection Get-SMO_ServerDdlTriggerCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Payload
{
[Microsoft.SqlServer.Management.Smo.Payload]
}

New-Alias gst_Payload Get-SMOT_Payload -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Payload
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Payload"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Payload" ($args)
}
}

New-Alias gs_Payload Get-SMO_Payload -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Protocol
{
[Microsoft.SqlServer.Management.Smo.Protocol]
}

New-Alias gst_Protocol Get-SMOT_Protocol -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Protocol
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Protocol"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Protocol" ($args)
}
}

New-Alias gs_Protocol Get-SMO_Protocol -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EndpointProtocol
{
[Microsoft.SqlServer.Management.Smo.EndpointProtocol]
}

New-Alias gst_EndpointProtocol Get-SMOT_EndpointProtocol -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EndpointProtocol
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointProtocol"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointProtocol" ($args)
}
}

New-Alias gs_EndpointProtocol Get-SMO_EndpointProtocol -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EndpointPayload
{
[Microsoft.SqlServer.Management.Smo.EndpointPayload]
}

New-Alias gst_EndpointPayload Get-SMOT_EndpointPayload -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EndpointPayload
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointPayload"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointPayload" ($args)
}
}

New-Alias gs_EndpointPayload Get-SMO_EndpointPayload -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Endpoint
{
[Microsoft.SqlServer.Management.Smo.Endpoint]
}

New-Alias gst_Endpoint Get-SMOT_Endpoint -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Endpoint
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Endpoint"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Endpoint" ($args)
}
}

New-Alias gs_Endpoint Get-SMO_Endpoint -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EndpointCollection
{
[Microsoft.SqlServer.Management.Smo.EndpointCollection]
}

New-Alias gst_EndpointCollection Get-SMOT_EndpointCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EndpointCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointCollection" ($args)
}
}

New-Alias gs_EndpointCollection Get-SMO_EndpointCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SoapPayload
{
[Microsoft.SqlServer.Management.Smo.SoapPayload]
}

New-Alias gst_SoapPayload Get-SMOT_SoapPayload -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SoapPayload
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SoapPayload"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SoapPayload" ($args)
}
}

New-Alias gs_SoapPayload Get-SMO_SoapPayload -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseMirroringPayload
{
[Microsoft.SqlServer.Management.Smo.DatabaseMirroringPayload]
}

New-Alias gst_DatabaseMirroringPayload Get-SMOT_DatabaseMirroringPayload -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseMirroringPayload
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseMirroringPayload"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseMirroringPayload" ($args)
}
}

New-Alias gs_DatabaseMirroringPayload Get-SMO_DatabaseMirroringPayload -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_HttpProtocol
{
[Microsoft.SqlServer.Management.Smo.HttpProtocol]
}

New-Alias gst_HttpProtocol Get-SMOT_HttpProtocol -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_HttpProtocol
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.HttpProtocol"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.HttpProtocol" ($args)
}
}

New-Alias gs_HttpProtocol Get-SMO_HttpProtocol -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TcpProtocol
{
[Microsoft.SqlServer.Management.Smo.TcpProtocol]
}

New-Alias gst_TcpProtocol Get-SMOT_TcpProtocol -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TcpProtocol
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.TcpProtocol"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.TcpProtocol" ($args)
}
}

New-Alias gs_TcpProtocol Get-SMO_TcpProtocol -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceBrokerPayload
{
[Microsoft.SqlServer.Management.Smo.ServiceBrokerPayload]
}

New-Alias gst_ServiceBrokerPayload Get-SMOT_ServiceBrokerPayload -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceBrokerPayload
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceBrokerPayload"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceBrokerPayload" ($args)
}
}

New-Alias gs_ServiceBrokerPayload Get-SMO_ServiceBrokerPayload -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SoapPayloadMethod
{
[Microsoft.SqlServer.Management.Smo.SoapPayloadMethod]
}

New-Alias gst_SoapPayloadMethod Get-SMOT_SoapPayloadMethod -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SoapPayloadMethod
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SoapPayloadMethod"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SoapPayloadMethod" ($args)
}
}

New-Alias gs_SoapPayloadMethod Get-SMO_SoapPayloadMethod -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SoapPayloadMethodCollection
{
[Microsoft.SqlServer.Management.Smo.SoapPayloadMethodCollection]
}

New-Alias gst_SoapPayloadMethodCollection Get-SMOT_SoapPayloadMethodCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SoapPayloadMethodCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SoapPayloadMethodCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SoapPayloadMethodCollection" ($args)
}
}

New-Alias gs_SoapPayloadMethodCollection Get-SMO_SoapPayloadMethodCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RegSvrSmoObject
{
[Microsoft.SqlServer.Management.Smo.RegisteredServers.RegSvrSmoObject]
}

New-Alias gst_RegSvrSmoObject Get-SMOT_RegSvrSmoObject -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RegSvrSmoObject
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.RegSvrSmoObject"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.RegSvrSmoObject" ($args)
}
}

New-Alias gs_RegSvrSmoObject Get-SMO_RegSvrSmoObject -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerGroupBase
{
[Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroupBase]
}

New-Alias gst_ServerGroupBase Get-SMOT_ServerGroupBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerGroupBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroupBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroupBase" ($args)
}
}

New-Alias gs_ServerGroupBase Get-SMO_ServerGroupBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerGroup
{
[Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroup]
}

New-Alias gst_ServerGroup Get-SMOT_ServerGroup -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerGroup
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroup"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroup" ($args)
}
}

New-Alias gs_ServerGroup Get-SMO_ServerGroup -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RegisteredServer
{
[Microsoft.SqlServer.Management.Smo.RegisteredServers.RegisteredServer]
}

New-Alias gst_RegisteredServer Get-SMOT_RegisteredServer -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RegisteredServer
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.RegisteredServer"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.RegisteredServer" ($args)
}
}

New-Alias gs_RegisteredServer Get-SMO_RegisteredServer -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RegSvrCollectionBase
{
[Microsoft.SqlServer.Management.Smo.RegisteredServers.RegSvrCollectionBase]
}

New-Alias gst_RegSvrCollectionBase Get-SMOT_RegSvrCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RegSvrCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.RegSvrCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.RegSvrCollectionBase" ($args)
}
}

New-Alias gs_RegSvrCollectionBase Get-SMO_RegSvrCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RegisteredServerCollection
{
[Microsoft.SqlServer.Management.Smo.RegisteredServers.RegisteredServerCollection]
}

New-Alias gst_RegisteredServerCollection Get-SMOT_RegisteredServerCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RegisteredServerCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.RegisteredServerCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.RegisteredServerCollection" ($args)
}
}

New-Alias gs_RegisteredServerCollection Get-SMO_RegisteredServerCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerGroupCollection
{
[Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroupCollection]
}

New-Alias gst_ServerGroupCollection Get-SMOT_ServerGroupCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerGroupCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroupCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RegisteredServers.ServerGroupCollection" ($args)
}
}

New-Alias gs_ServerGroupCollection Get-SMO_ServerGroupCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NumberedStoredProcedure
{
[Microsoft.SqlServer.Management.Smo.NumberedStoredProcedure]
}

New-Alias gst_NumberedStoredProcedure Get-SMOT_NumberedStoredProcedure -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NumberedStoredProcedure
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedStoredProcedure"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedStoredProcedure" ($args)
}
}

New-Alias gs_NumberedStoredProcedure Get-SMO_NumberedStoredProcedure -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NumberedObjectCollectionBase
{
[Microsoft.SqlServer.Management.Smo.NumberedObjectCollectionBase]
}

New-Alias gst_NumberedObjectCollectionBase Get-SMOT_NumberedObjectCollectionBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NumberedObjectCollectionBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedObjectCollectionBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedObjectCollectionBase" ($args)
}
}

New-Alias gs_NumberedObjectCollectionBase Get-SMO_NumberedObjectCollectionBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NumberedStoredProcedureCollection
{
[Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureCollection]
}

New-Alias gst_NumberedStoredProcedureCollection Get-SMOT_NumberedStoredProcedureCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NumberedStoredProcedureCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureCollection" ($args)
}
}

New-Alias gs_NumberedStoredProcedureCollection Get-SMO_NumberedStoredProcedureCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NumberedStoredProcedureParameterCollection
{
[Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureParameterCollection]
}

New-Alias gst_NumberedStoredProcedureParameterCollection Get-SMOT_NumberedStoredProcedureParameterCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NumberedStoredProcedureParameterCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureParameterCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.NumberedStoredProcedureParameterCollection" ($args)
}
}

New-Alias gs_NumberedStoredProcedureParameterCollection Get-SMO_NumberedStoredProcedureParameterCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Credential
{
[Microsoft.SqlServer.Management.Smo.Credential]
}

New-Alias gst_Credential Get-SMOT_Credential -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Credential
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Credential"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Credential" ($args)
}
}

New-Alias gs_Credential Get-SMO_Credential -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CredentialCollection
{
[Microsoft.SqlServer.Management.Smo.CredentialCollection]
}

New-Alias gst_CredentialCollection Get-SMOT_CredentialCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CredentialCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CredentialCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CredentialCollection" ($args)
}
}

New-Alias gs_CredentialCollection Get-SMO_CredentialCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServiceMasterKey
{
[Microsoft.SqlServer.Management.Smo.ServiceMasterKey]
}

New-Alias gst_ServiceMasterKey Get-SMOT_ServiceMasterKey -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServiceMasterKey
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceMasterKey"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServiceMasterKey" ($args)
}
}

New-Alias gs_ServiceMasterKey Get-SMO_ServiceMasterKey -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MasterKey
{
[Microsoft.SqlServer.Management.Smo.MasterKey]
}

New-Alias gst_MasterKey Get-SMOT_MasterKey -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MasterKey
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MasterKey"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MasterKey" ($args)
}
}

New-Alias gs_MasterKey Get-SMO_MasterKey -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CertificateSourceType
{
[Microsoft.SqlServer.Management.Smo.CertificateSourceType]
}

New-Alias gst_CertificateSourceType Get-SMOT_CertificateSourceType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CertificateSourceType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CertificateSourceType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CertificateSourceType" ($args)
}
}

New-Alias gs_CertificateSourceType Get-SMO_CertificateSourceType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Certificate
{
[Microsoft.SqlServer.Management.Smo.Certificate]
}

New-Alias gst_Certificate Get-SMOT_Certificate -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Certificate
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Certificate"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Certificate" ($args)
}
}

New-Alias gs_Certificate Get-SMO_Certificate -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CertificateEvents
{
[Microsoft.SqlServer.Management.Smo.CertificateEvents]
}

New-Alias gst_CertificateEvents Get-SMOT_CertificateEvents -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CertificateEvents
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CertificateEvents"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CertificateEvents" ($args)
}
}

New-Alias gs_CertificateEvents Get-SMO_CertificateEvents -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CertificateCollection
{
[Microsoft.SqlServer.Management.Smo.CertificateCollection]
}

New-Alias gst_CertificateCollection Get-SMOT_CertificateCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CertificateCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CertificateCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CertificateCollection" ($args)
}
}

New-Alias gs_CertificateCollection Get-SMO_CertificateCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationServices
{
[Microsoft.SqlServer.Management.Nmo.NotificationServices]
}

New-Alias gst_NotificationServices Get-SMOT_NotificationServices -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationServices
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationServices"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationServices" ($args)
}
}

New-Alias gs_NotificationServices Get-SMO_NotificationServices -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Instance
{
[Microsoft.SqlServer.Management.Nmo.Instance]
}

New-Alias gst_Instance Get-SMOT_Instance -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Instance
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.Instance"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.Instance" ($args)
}
}

New-Alias gs_Instance Get-SMO_Instance -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InstanceCollection
{
[Microsoft.SqlServer.Management.Nmo.InstanceCollection]
}

New-Alias gst_InstanceCollection Get-SMOT_InstanceCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InstanceCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceCollection" ($args)
}
}

New-Alias gs_InstanceCollection Get-SMO_InstanceCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DeliveryChannel
{
[Microsoft.SqlServer.Management.Nmo.DeliveryChannel]
}

New-Alias gst_DeliveryChannel Get-SMOT_DeliveryChannel -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DeliveryChannel
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.DeliveryChannel"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.DeliveryChannel" ($args)
}
}

New-Alias gs_DeliveryChannel Get-SMO_DeliveryChannel -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DeliveryChannelCollection
{
[Microsoft.SqlServer.Management.Nmo.DeliveryChannelCollection]
}

New-Alias gst_DeliveryChannelCollection Get-SMOT_DeliveryChannelCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DeliveryChannelCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.DeliveryChannelCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.DeliveryChannelCollection" ($args)
}
}

New-Alias gs_DeliveryChannelCollection Get-SMO_DeliveryChannelCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DeliveryChannelArgument
{
[Microsoft.SqlServer.Management.Nmo.DeliveryChannelArgument]
}

New-Alias gst_DeliveryChannelArgument Get-SMOT_DeliveryChannelArgument -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DeliveryChannelArgument
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.DeliveryChannelArgument"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.DeliveryChannelArgument" ($args)
}
}

New-Alias gs_DeliveryChannelArgument Get-SMO_DeliveryChannelArgument -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DeliveryChannelArgumentCollection
{
[Microsoft.SqlServer.Management.Nmo.DeliveryChannelArgumentCollection]
}

New-Alias gst_DeliveryChannelArgumentCollection Get-SMOT_DeliveryChannelArgumentCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DeliveryChannelArgumentCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.DeliveryChannelArgumentCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.DeliveryChannelArgumentCollection" ($args)
}
}

New-Alias gs_DeliveryChannelArgumentCollection Get-SMO_DeliveryChannelArgumentCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolDefinition
{
[Microsoft.SqlServer.Management.Nmo.ProtocolDefinition]
}

New-Alias gst_ProtocolDefinition Get-SMOT_ProtocolDefinition -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolDefinition
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolDefinition"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolDefinition" ($args)
}
}

New-Alias gs_ProtocolDefinition Get-SMO_ProtocolDefinition -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolDefinitionCollection
{
[Microsoft.SqlServer.Management.Nmo.ProtocolDefinitionCollection]
}

New-Alias gst_ProtocolDefinitionCollection Get-SMOT_ProtocolDefinitionCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolDefinitionCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolDefinitionCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolDefinitionCollection" ($args)
}
}

New-Alias gs_ProtocolDefinitionCollection Get-SMO_ProtocolDefinitionCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Application
{
[Microsoft.SqlServer.Management.Nmo.Application]
}

New-Alias gst_Application Get-SMOT_Application -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Application
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.Application"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.Application" ($args)
}
}

New-Alias gs_Application Get-SMO_Application -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationCollection
{
[Microsoft.SqlServer.Management.Nmo.ApplicationCollection]
}

New-Alias gst_ApplicationCollection Get-SMOT_ApplicationCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationCollection" ($args)
}
}

New-Alias gs_ApplicationCollection Get-SMO_ApplicationCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_VacuumSchedule
{
[Microsoft.SqlServer.Management.Nmo.VacuumSchedule]
}

New-Alias gst_VacuumSchedule Get-SMOT_VacuumSchedule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_VacuumSchedule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.VacuumSchedule"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.VacuumSchedule" ($args)
}
}

New-Alias gs_VacuumSchedule Get-SMO_VacuumSchedule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_VacuumScheduleCollection
{
[Microsoft.SqlServer.Management.Nmo.VacuumScheduleCollection]
}

New-Alias gst_VacuumScheduleCollection Get-SMOT_VacuumScheduleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_VacuumScheduleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.VacuumScheduleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.VacuumScheduleCollection" ($args)
}
}

New-Alias gs_VacuumScheduleCollection Get-SMO_VacuumScheduleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Distributor
{
[Microsoft.SqlServer.Management.Nmo.Distributor]
}

New-Alias gst_Distributor Get-SMOT_Distributor -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Distributor
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.Distributor"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.Distributor" ($args)
}
}

New-Alias gs_Distributor Get-SMO_Distributor -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DistributorCollection
{
[Microsoft.SqlServer.Management.Nmo.DistributorCollection]
}

New-Alias gst_DistributorCollection Get-SMOT_DistributorCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DistributorCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.DistributorCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.DistributorCollection" ($args)
}
}

New-Alias gs_DistributorCollection Get-SMO_DistributorCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_Generator
{
[Microsoft.SqlServer.Management.Nmo.Generator]
}

New-Alias gst_Generator Get-SMOT_Generator -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_Generator
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.Generator"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.Generator" ($args)
}
}

New-Alias gs_Generator Get-SMO_Generator -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationDatabaseOptions
{
[Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseOptions]
}

New-Alias gst_ApplicationDatabaseOptions Get-SMOT_ApplicationDatabaseOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationDatabaseOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseOptions" ($args)
}
}

New-Alias gs_ApplicationDatabaseOptions Get-SMO_ApplicationDatabaseOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InstanceDatabaseOptions
{
[Microsoft.SqlServer.Management.Nmo.InstanceDatabaseOptions]
}

New-Alias gst_InstanceDatabaseOptions Get-SMOT_InstanceDatabaseOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InstanceDatabaseOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseOptions" ($args)
}
}

New-Alias gs_InstanceDatabaseOptions Get-SMO_InstanceDatabaseOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationDatabaseFileGroup
{
[Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileGroup]
}

New-Alias gst_ApplicationDatabaseFileGroup Get-SMOT_ApplicationDatabaseFileGroup -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationDatabaseFileGroup
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileGroup"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileGroup" ($args)
}
}

New-Alias gs_ApplicationDatabaseFileGroup Get-SMO_ApplicationDatabaseFileGroup -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationDatabaseFileGroupCollection
{
[Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileGroupCollection]
}

New-Alias gst_ApplicationDatabaseFileGroupCollection Get-SMOT_ApplicationDatabaseFileGroupCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationDatabaseFileGroupCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileGroupCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileGroupCollection" ($args)
}
}

New-Alias gs_ApplicationDatabaseFileGroupCollection Get-SMO_ApplicationDatabaseFileGroupCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationDatabaseFile
{
[Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFile]
}

New-Alias gst_ApplicationDatabaseFile Get-SMOT_ApplicationDatabaseFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationDatabaseFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFile" ($args)
}
}

New-Alias gs_ApplicationDatabaseFile Get-SMO_ApplicationDatabaseFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationDatabaseFileCollection
{
[Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileCollection]
}

New-Alias gst_ApplicationDatabaseFileCollection Get-SMOT_ApplicationDatabaseFileCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationDatabaseFileCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseFileCollection" ($args)
}
}

New-Alias gs_ApplicationDatabaseFileCollection Get-SMO_ApplicationDatabaseFileCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InstanceDatabaseFileGroup
{
[Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileGroup]
}

New-Alias gst_InstanceDatabaseFileGroup Get-SMOT_InstanceDatabaseFileGroup -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InstanceDatabaseFileGroup
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileGroup"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileGroup" ($args)
}
}

New-Alias gs_InstanceDatabaseFileGroup Get-SMO_InstanceDatabaseFileGroup -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InstanceDatabaseFileGroupCollection
{
[Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileGroupCollection]
}

New-Alias gst_InstanceDatabaseFileGroupCollection Get-SMOT_InstanceDatabaseFileGroupCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InstanceDatabaseFileGroupCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileGroupCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileGroupCollection" ($args)
}
}

New-Alias gs_InstanceDatabaseFileGroupCollection Get-SMO_InstanceDatabaseFileGroupCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InstanceDatabaseFile
{
[Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFile]
}

New-Alias gst_InstanceDatabaseFile Get-SMOT_InstanceDatabaseFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InstanceDatabaseFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFile" ($args)
}
}

New-Alias gs_InstanceDatabaseFile Get-SMO_InstanceDatabaseFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InstanceDatabaseFileCollection
{
[Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileCollection]
}

New-Alias gst_InstanceDatabaseFileCollection Get-SMOT_InstanceDatabaseFileCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InstanceDatabaseFileCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseFileCollection" ($args)
}
}

New-Alias gs_InstanceDatabaseFileCollection Get-SMO_InstanceDatabaseFileCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationDatabaseLogFile
{
[Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseLogFile]
}

New-Alias gst_ApplicationDatabaseLogFile Get-SMOT_ApplicationDatabaseLogFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationDatabaseLogFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseLogFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseLogFile" ($args)
}
}

New-Alias gs_ApplicationDatabaseLogFile Get-SMO_ApplicationDatabaseLogFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ApplicationDatabaseLogFileCollection
{
[Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseLogFileCollection]
}

New-Alias gst_ApplicationDatabaseLogFileCollection Get-SMOT_ApplicationDatabaseLogFileCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ApplicationDatabaseLogFileCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseLogFileCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ApplicationDatabaseLogFileCollection" ($args)
}
}

New-Alias gs_ApplicationDatabaseLogFileCollection Get-SMO_ApplicationDatabaseLogFileCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InstanceDatabaseLogFile
{
[Microsoft.SqlServer.Management.Nmo.InstanceDatabaseLogFile]
}

New-Alias gst_InstanceDatabaseLogFile Get-SMOT_InstanceDatabaseLogFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InstanceDatabaseLogFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseLogFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseLogFile" ($args)
}
}

New-Alias gs_InstanceDatabaseLogFile Get-SMO_InstanceDatabaseLogFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InstanceDatabaseLogFileCollection
{
[Microsoft.SqlServer.Management.Nmo.InstanceDatabaseLogFileCollection]
}

New-Alias gst_InstanceDatabaseLogFileCollection Get-SMOT_InstanceDatabaseLogFileCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InstanceDatabaseLogFileCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseLogFileCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.InstanceDatabaseLogFileCollection" ($args)
}
}

New-Alias gs_InstanceDatabaseLogFileCollection Get-SMO_InstanceDatabaseLogFileCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventClass
{
[Microsoft.SqlServer.Management.Nmo.EventClass]
}

New-Alias gst_EventClass Get-SMOT_EventClass -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventClass
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.EventClass"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.EventClass" ($args)
}
}

New-Alias gs_EventClass Get-SMO_EventClass -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventClassCollection
{
[Microsoft.SqlServer.Management.Nmo.EventClassCollection]
}

New-Alias gst_EventClassCollection Get-SMOT_EventClassCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventClassCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.EventClassCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.EventClassCollection" ($args)
}
}

New-Alias gs_EventClassCollection Get-SMO_EventClassCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventField
{
[Microsoft.SqlServer.Management.Nmo.EventField]
}

New-Alias gst_EventField Get-SMOT_EventField -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventField
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.EventField"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.EventField" ($args)
}
}

New-Alias gs_EventField Get-SMO_EventField -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventFieldCollection
{
[Microsoft.SqlServer.Management.Nmo.EventFieldCollection]
}

New-Alias gst_EventFieldCollection Get-SMOT_EventFieldCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventFieldCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.EventFieldCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.EventFieldCollection" ($args)
}
}

New-Alias gs_EventFieldCollection Get-SMO_EventFieldCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventChronicleRule
{
[Microsoft.SqlServer.Management.Nmo.EventChronicleRule]
}

New-Alias gst_EventChronicleRule Get-SMOT_EventChronicleRule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventChronicleRule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.EventChronicleRule"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.EventChronicleRule" ($args)
}
}

New-Alias gs_EventChronicleRule Get-SMO_EventChronicleRule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventChronicle
{
[Microsoft.SqlServer.Management.Nmo.EventChronicle]
}

New-Alias gst_EventChronicle Get-SMOT_EventChronicle -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventChronicle
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.EventChronicle"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.EventChronicle" ($args)
}
}

New-Alias gs_EventChronicle Get-SMO_EventChronicle -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventChronicleCollection
{
[Microsoft.SqlServer.Management.Nmo.EventChronicleCollection]
}

New-Alias gst_EventChronicleCollection Get-SMOT_EventChronicleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventChronicleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.EventChronicleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.EventChronicleCollection" ($args)
}
}

New-Alias gs_EventChronicleCollection Get-SMO_EventChronicleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NonHostedEventProvider
{
[Microsoft.SqlServer.Management.Nmo.NonHostedEventProvider]
}

New-Alias gst_NonHostedEventProvider Get-SMOT_NonHostedEventProvider -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NonHostedEventProvider
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NonHostedEventProvider"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NonHostedEventProvider" ($args)
}
}

New-Alias gs_NonHostedEventProvider Get-SMO_NonHostedEventProvider -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NonHostedEventProviderCollection
{
[Microsoft.SqlServer.Management.Nmo.NonHostedEventProviderCollection]
}

New-Alias gst_NonHostedEventProviderCollection Get-SMOT_NonHostedEventProviderCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NonHostedEventProviderCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NonHostedEventProviderCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NonHostedEventProviderCollection" ($args)
}
}

New-Alias gs_NonHostedEventProviderCollection Get-SMO_NonHostedEventProviderCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_HostedEventProvider
{
[Microsoft.SqlServer.Management.Nmo.HostedEventProvider]
}

New-Alias gst_HostedEventProvider Get-SMOT_HostedEventProvider -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_HostedEventProvider
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.HostedEventProvider"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.HostedEventProvider" ($args)
}
}

New-Alias gs_HostedEventProvider Get-SMO_HostedEventProvider -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_HostedEventProviderCollection
{
[Microsoft.SqlServer.Management.Nmo.HostedEventProviderCollection]
}

New-Alias gst_HostedEventProviderCollection Get-SMOT_HostedEventProviderCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_HostedEventProviderCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.HostedEventProviderCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.HostedEventProviderCollection" ($args)
}
}

New-Alias gs_HostedEventProviderCollection Get-SMO_HostedEventProviderCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_HostedEventProviderArgument
{
[Microsoft.SqlServer.Management.Nmo.HostedEventProviderArgument]
}

New-Alias gst_HostedEventProviderArgument Get-SMOT_HostedEventProviderArgument -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_HostedEventProviderArgument
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.HostedEventProviderArgument"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.HostedEventProviderArgument" ($args)
}
}

New-Alias gs_HostedEventProviderArgument Get-SMO_HostedEventProviderArgument -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_HostedEventProviderArgumentCollection
{
[Microsoft.SqlServer.Management.Nmo.HostedEventProviderArgumentCollection]
}

New-Alias gst_HostedEventProviderArgumentCollection Get-SMOT_HostedEventProviderArgumentCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_HostedEventProviderArgumentCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.HostedEventProviderArgumentCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.HostedEventProviderArgumentCollection" ($args)
}
}

New-Alias gs_HostedEventProviderArgumentCollection Get-SMO_HostedEventProviderArgumentCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationClass
{
[Microsoft.SqlServer.Management.Nmo.NotificationClass]
}

New-Alias gst_NotificationClass Get-SMOT_NotificationClass -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationClass
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationClass"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationClass" ($args)
}
}

New-Alias gs_NotificationClass Get-SMO_NotificationClass -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationClassCollection
{
[Microsoft.SqlServer.Management.Nmo.NotificationClassCollection]
}

New-Alias gst_NotificationClassCollection Get-SMOT_NotificationClassCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationClassCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationClassCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationClassCollection" ($args)
}
}

New-Alias gs_NotificationClassCollection Get-SMO_NotificationClassCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationField
{
[Microsoft.SqlServer.Management.Nmo.NotificationField]
}

New-Alias gst_NotificationField Get-SMOT_NotificationField -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationField
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationField"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationField" ($args)
}
}

New-Alias gs_NotificationField Get-SMO_NotificationField -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationFieldCollection
{
[Microsoft.SqlServer.Management.Nmo.NotificationFieldCollection]
}

New-Alias gst_NotificationFieldCollection Get-SMOT_NotificationFieldCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationFieldCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationFieldCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationFieldCollection" ($args)
}
}

New-Alias gs_NotificationFieldCollection Get-SMO_NotificationFieldCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationComputedField
{
[Microsoft.SqlServer.Management.Nmo.NotificationComputedField]
}

New-Alias gst_NotificationComputedField Get-SMOT_NotificationComputedField -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationComputedField
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationComputedField"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationComputedField" ($args)
}
}

New-Alias gs_NotificationComputedField Get-SMO_NotificationComputedField -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationComputedFieldCollection
{
[Microsoft.SqlServer.Management.Nmo.NotificationComputedFieldCollection]
}

New-Alias gst_NotificationComputedFieldCollection Get-SMOT_NotificationComputedFieldCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationComputedFieldCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationComputedFieldCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationComputedFieldCollection" ($args)
}
}

New-Alias gs_NotificationComputedFieldCollection Get-SMO_NotificationComputedFieldCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ContentFormatter
{
[Microsoft.SqlServer.Management.Nmo.ContentFormatter]
}

New-Alias gst_ContentFormatter Get-SMOT_ContentFormatter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ContentFormatter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ContentFormatter"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ContentFormatter" ($args)
}
}

New-Alias gs_ContentFormatter Get-SMO_ContentFormatter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ContentFormatterArgument
{
[Microsoft.SqlServer.Management.Nmo.ContentFormatterArgument]
}

New-Alias gst_ContentFormatterArgument Get-SMOT_ContentFormatterArgument -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ContentFormatterArgument
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ContentFormatterArgument"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ContentFormatterArgument" ($args)
}
}

New-Alias gs_ContentFormatterArgument Get-SMO_ContentFormatterArgument -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ContentFormatterArgumentCollection
{
[Microsoft.SqlServer.Management.Nmo.ContentFormatterArgumentCollection]
}

New-Alias gst_ContentFormatterArgumentCollection Get-SMOT_ContentFormatterArgumentCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ContentFormatterArgumentCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ContentFormatterArgumentCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ContentFormatterArgumentCollection" ($args)
}
}

New-Alias gs_ContentFormatterArgumentCollection Get-SMO_ContentFormatterArgumentCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationClassProtocol
{
[Microsoft.SqlServer.Management.Nmo.NotificationClassProtocol]
}

New-Alias gst_NotificationClassProtocol Get-SMOT_NotificationClassProtocol -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationClassProtocol
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationClassProtocol"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationClassProtocol" ($args)
}
}

New-Alias gs_NotificationClassProtocol Get-SMO_NotificationClassProtocol -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotificationClassProtocolCollection
{
[Microsoft.SqlServer.Management.Nmo.NotificationClassProtocolCollection]
}

New-Alias gst_NotificationClassProtocolCollection Get-SMOT_NotificationClassProtocolCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotificationClassProtocolCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationClassProtocolCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.NotificationClassProtocolCollection" ($args)
}
}

New-Alias gs_NotificationClassProtocolCollection Get-SMO_NotificationClassProtocolCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolField
{
[Microsoft.SqlServer.Management.Nmo.ProtocolField]
}

New-Alias gst_ProtocolField Get-SMOT_ProtocolField -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolField
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolField"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolField" ($args)
}
}

New-Alias gs_ProtocolField Get-SMO_ProtocolField -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolFieldCollection
{
[Microsoft.SqlServer.Management.Nmo.ProtocolFieldCollection]
}

New-Alias gst_ProtocolFieldCollection Get-SMOT_ProtocolFieldCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolFieldCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolFieldCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolFieldCollection" ($args)
}
}

New-Alias gs_ProtocolFieldCollection Get-SMO_ProtocolFieldCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolRetrySchedule
{
[Microsoft.SqlServer.Management.Nmo.ProtocolRetrySchedule]
}

New-Alias gst_ProtocolRetrySchedule Get-SMOT_ProtocolRetrySchedule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolRetrySchedule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolRetrySchedule"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolRetrySchedule" ($args)
}
}

New-Alias gs_ProtocolRetrySchedule Get-SMO_ProtocolRetrySchedule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolRetryScheduleCollection
{
[Microsoft.SqlServer.Management.Nmo.ProtocolRetryScheduleCollection]
}

New-Alias gst_ProtocolRetryScheduleCollection Get-SMOT_ProtocolRetryScheduleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolRetryScheduleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolRetryScheduleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.ProtocolRetryScheduleCollection" ($args)
}
}

New-Alias gs_ProtocolRetryScheduleCollection Get-SMO_ProtocolRetryScheduleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionClass
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionClass]
}

New-Alias gst_SubscriptionClass Get-SMOT_SubscriptionClass -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionClass
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionClass"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionClass" ($args)
}
}

New-Alias gs_SubscriptionClass Get-SMO_SubscriptionClass -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionClassCollection
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionClassCollection]
}

New-Alias gst_SubscriptionClassCollection Get-SMOT_SubscriptionClassCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionClassCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionClassCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionClassCollection" ($args)
}
}

New-Alias gs_SubscriptionClassCollection Get-SMO_SubscriptionClassCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionField
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionField]
}

New-Alias gst_SubscriptionField Get-SMOT_SubscriptionField -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionField
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionField"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionField" ($args)
}
}

New-Alias gs_SubscriptionField Get-SMO_SubscriptionField -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionFieldCollection
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionFieldCollection]
}

New-Alias gst_SubscriptionFieldCollection Get-SMOT_SubscriptionFieldCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionFieldCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionFieldCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionFieldCollection" ($args)
}
}

New-Alias gs_SubscriptionFieldCollection Get-SMO_SubscriptionFieldCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionEventRule
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionEventRule]
}

New-Alias gst_SubscriptionEventRule Get-SMOT_SubscriptionEventRule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionEventRule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionEventRule"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionEventRule" ($args)
}
}

New-Alias gs_SubscriptionEventRule Get-SMO_SubscriptionEventRule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionEventRuleCollection
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionEventRuleCollection]
}

New-Alias gst_SubscriptionEventRuleCollection Get-SMOT_SubscriptionEventRuleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionEventRuleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionEventRuleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionEventRuleCollection" ($args)
}
}

New-Alias gs_SubscriptionEventRuleCollection Get-SMO_SubscriptionEventRuleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionConditionEventRule
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionConditionEventRule]
}

New-Alias gst_SubscriptionConditionEventRule Get-SMOT_SubscriptionConditionEventRule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionConditionEventRule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionConditionEventRule"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionConditionEventRule" ($args)
}
}

New-Alias gs_SubscriptionConditionEventRule Get-SMO_SubscriptionConditionEventRule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionConditionEventRuleCollection
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionConditionEventRuleCollection]
}

New-Alias gst_SubscriptionConditionEventRuleCollection Get-SMOT_SubscriptionConditionEventRuleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionConditionEventRuleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionConditionEventRuleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionConditionEventRuleCollection" ($args)
}
}

New-Alias gs_SubscriptionConditionEventRuleCollection Get-SMO_SubscriptionConditionEventRuleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionScheduledRule
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionScheduledRule]
}

New-Alias gst_SubscriptionScheduledRule Get-SMOT_SubscriptionScheduledRule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionScheduledRule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionScheduledRule"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionScheduledRule" ($args)
}
}

New-Alias gs_SubscriptionScheduledRule Get-SMO_SubscriptionScheduledRule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionScheduledRuleCollection
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionScheduledRuleCollection]
}

New-Alias gst_SubscriptionScheduledRuleCollection Get-SMOT_SubscriptionScheduledRuleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionScheduledRuleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionScheduledRuleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionScheduledRuleCollection" ($args)
}
}

New-Alias gs_SubscriptionScheduledRuleCollection Get-SMO_SubscriptionScheduledRuleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionConditionScheduledRule
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionConditionScheduledRule]
}

New-Alias gst_SubscriptionConditionScheduledRule Get-SMOT_SubscriptionConditionScheduledRule -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionConditionScheduledRule
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionConditionScheduledRule"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionConditionScheduledRule" ($args)
}
}

New-Alias gs_SubscriptionConditionScheduledRule Get-SMO_SubscriptionConditionScheduledRule -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionConditionScheduledRuleCollection
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionConditionScheduledRuleCollection]
}

New-Alias gst_SubscriptionConditionScheduledRuleCollection Get-SMOT_SubscriptionConditionScheduledRuleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionConditionScheduledRuleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionConditionScheduledRuleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionConditionScheduledRuleCollection" ($args)
}
}

New-Alias gs_SubscriptionConditionScheduledRuleCollection Get-SMO_SubscriptionConditionScheduledRuleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionChronicle
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionChronicle]
}

New-Alias gst_SubscriptionChronicle Get-SMOT_SubscriptionChronicle -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionChronicle
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionChronicle"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionChronicle" ($args)
}
}

New-Alias gs_SubscriptionChronicle Get-SMO_SubscriptionChronicle -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SubscriptionChronicleCollection
{
[Microsoft.SqlServer.Management.Nmo.SubscriptionChronicleCollection]
}

New-Alias gst_SubscriptionChronicleCollection Get-SMOT_SubscriptionChronicleCollection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SubscriptionChronicleCollection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionChronicleCollection"
}
else
{
new-object "Microsoft.SqlServer.Management.Nmo.SubscriptionChronicleCollection" ($args)
}
}

New-Alias gs_SubscriptionChronicleCollection Get-SMO_SubscriptionChronicleCollection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IDataRecordChanger
{
[Microsoft.SqlServer.Management.Trace.IDataRecordChanger]
}

New-Alias gst_IDataRecordChanger Get-SMOT_IDataRecordChanger -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IDataRecordChanger
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.IDataRecordChanger"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.IDataRecordChanger" ($args)
}
}

New-Alias gs_IDataRecordChanger Get-SMO_IDataRecordChanger -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TraceEventArgs
{
[Microsoft.SqlServer.Management.Trace.TraceEventArgs]
}

New-Alias gst_TraceEventArgs Get-SMOT_TraceEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TraceEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.TraceEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.TraceEventArgs" ($args)
}
}

New-Alias gs_TraceEventArgs Get-SMO_TraceEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_WriteNotifyEventHandler
{
[Microsoft.SqlServer.Management.Trace.WriteNotifyEventHandler]
}

New-Alias gst_WriteNotifyEventHandler Get-SMOT_WriteNotifyEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_WriteNotifyEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.WriteNotifyEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.WriteNotifyEventHandler" ($args)
}
}

New-Alias gs_WriteNotifyEventHandler Get-SMO_WriteNotifyEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ITraceDataWriter
{
[Microsoft.SqlServer.Management.Trace.ITraceDataWriter]
}

New-Alias gst_ITraceDataWriter Get-SMOT_ITraceDataWriter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ITraceDataWriter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.ITraceDataWriter"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.ITraceDataWriter" ($args)
}
}

New-Alias gs_ITraceDataWriter Get-SMO_ITraceDataWriter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlServerManagementException
{
[Microsoft.SqlServer.Management.Common.SqlServerManagementException]
}

New-Alias gst_SqlServerManagementException Get-SMOT_SqlServerManagementException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlServerManagementException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.SqlServerManagementException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.SqlServerManagementException" ($args)
}
}

New-Alias gs_SqlServerManagementException Get-SMO_SqlServerManagementException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlTraceException
{
[Microsoft.SqlServer.Management.Trace.SqlTraceException]
}

New-Alias gst_SqlTraceException Get-SMOT_SqlTraceException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlTraceException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.SqlTraceException"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.SqlTraceException" ($args)
}
}

New-Alias gs_SqlTraceException Get-SMO_SqlTraceException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlTraceFailToLoadInstAPIAssemblyException
{
[Microsoft.SqlServer.Management.Trace.SqlTraceFailToLoadInstAPIAssemblyException]
}

New-Alias gst_SqlTraceFailToLoadInstAPIAssemblyException Get-SMOT_SqlTraceFailToLoadInstAPIAssemblyException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlTraceFailToLoadInstAPIAssemblyException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.SqlTraceFailToLoadInstAPIAssemblyException"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.SqlTraceFailToLoadInstAPIAssemblyException" ($args)
}
}

New-Alias gs_SqlTraceFailToLoadInstAPIAssemblyException Get-SMO_SqlTraceFailToLoadInstAPIAssemblyException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlTraceFailToInstantiateTypeException
{
[Microsoft.SqlServer.Management.Trace.SqlTraceFailToInstantiateTypeException]
}

New-Alias gst_SqlTraceFailToInstantiateTypeException Get-SMOT_SqlTraceFailToInstantiateTypeException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlTraceFailToInstantiateTypeException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.SqlTraceFailToInstantiateTypeException"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.SqlTraceFailToInstantiateTypeException" ($args)
}
}

New-Alias gs_SqlTraceFailToInstantiateTypeException Get-SMO_SqlTraceFailToInstantiateTypeException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TraceReader
{
[Microsoft.SqlServer.Management.Trace.TraceReader]
}

New-Alias gst_TraceReader Get-SMOT_TraceReader -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TraceReader
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.TraceReader"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.TraceReader" ($args)
}
}

New-Alias gs_TraceReader Get-SMO_TraceReader -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TraceReaderWriter
{
[Microsoft.SqlServer.Management.Trace.TraceReaderWriter]
}

New-Alias gst_TraceReaderWriter Get-SMOT_TraceReaderWriter -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TraceReaderWriter
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.TraceReaderWriter"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.TraceReaderWriter" ($args)
}
}

New-Alias gs_TraceReaderWriter Get-SMO_TraceReaderWriter -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TraceFile
{
[Microsoft.SqlServer.Management.Trace.TraceFile]
}

New-Alias gst_TraceFile Get-SMOT_TraceFile -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TraceFile
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.TraceFile"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.TraceFile" ($args)
}
}

New-Alias gs_TraceFile Get-SMO_TraceFile -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TraceTable
{
[Microsoft.SqlServer.Management.Trace.TraceTable]
}

New-Alias gst_TraceTable Get-SMOT_TraceTable -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TraceTable
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.TraceTable"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.TraceTable" ($args)
}
}

New-Alias gs_TraceTable Get-SMO_TraceTable -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TraceServer
{
[Microsoft.SqlServer.Management.Trace.TraceServer]
}

New-Alias gst_TraceServer Get-SMOT_TraceServer -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TraceServer
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.TraceServer"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.TraceServer" ($args)
}
}

New-Alias gs_TraceServer Get-SMO_TraceServer -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ReplayMode
{
[Microsoft.SqlServer.Management.Trace.ReplayMode]
}

New-Alias gst_ReplayMode Get-SMOT_ReplayMode -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ReplayMode
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayMode"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayMode" ($args)
}
}

New-Alias gs_ReplayMode Get-SMO_ReplayMode -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ReplayEventArgs
{
[Microsoft.SqlServer.Management.Trace.ReplayEventArgs]
}

New-Alias gst_ReplayEventArgs Get-SMOT_ReplayEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ReplayEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayEventArgs" ($args)
}
}

New-Alias gs_ReplayEventArgs Get-SMO_ReplayEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ReplayEventHandler
{
[Microsoft.SqlServer.Management.Trace.ReplayEventHandler]
}

New-Alias gst_ReplayEventHandler Get-SMOT_ReplayEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ReplayEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayEventHandler" ($args)
}
}

New-Alias gs_ReplayEventHandler Get-SMO_ReplayEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ReplayResultEventHandler
{
[Microsoft.SqlServer.Management.Trace.ReplayResultEventHandler]
}

New-Alias gst_ReplayResultEventHandler Get-SMOT_ReplayResultEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ReplayResultEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayResultEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayResultEventHandler" ($args)
}
}

New-Alias gs_ReplayResultEventHandler Get-SMO_ReplayResultEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ReplayStartHandler
{
[Microsoft.SqlServer.Management.Trace.ReplayStartHandler]
}

New-Alias gst_ReplayStartHandler Get-SMOT_ReplayStartHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ReplayStartHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayStartHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayStartHandler" ($args)
}
}

New-Alias gs_ReplayStartHandler Get-SMO_ReplayStartHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ReplayPauseHandler
{
[Microsoft.SqlServer.Management.Trace.ReplayPauseHandler]
}

New-Alias gst_ReplayPauseHandler Get-SMOT_ReplayPauseHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ReplayPauseHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayPauseHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayPauseHandler" ($args)
}
}

New-Alias gs_ReplayPauseHandler Get-SMO_ReplayPauseHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ReplayStopHandler
{
[Microsoft.SqlServer.Management.Trace.ReplayStopHandler]
}

New-Alias gst_ReplayStopHandler Get-SMOT_ReplayStopHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ReplayStopHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayStopHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.ReplayStopHandler" ($args)
}
}

New-Alias gs_ReplayStopHandler Get-SMO_ReplayStopHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TraceReplayOptions
{
[Microsoft.SqlServer.Management.Trace.TraceReplayOptions]
}

New-Alias gst_TraceReplayOptions Get-SMOT_TraceReplayOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TraceReplayOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.TraceReplayOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.TraceReplayOptions" ($args)
}
}

New-Alias gs_TraceReplayOptions Get-SMO_TraceReplayOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TraceReplay
{
[Microsoft.SqlServer.Management.Trace.TraceReplay]
}

New-Alias gst_TraceReplay Get-SMOT_TraceReplay -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TraceReplay
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Trace.TraceReplay"
}
else
{
new-object "Microsoft.SqlServer.Management.Trace.TraceReplay" ($args)
}
}

New-Alias gs_TraceReplay Get-SMO_TraceReplay -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConnectionSettings
{
[Microsoft.SqlServer.Management.Common.ConnectionSettings]
}

New-Alias gst_ConnectionSettings Get-SMOT_ConnectionSettings -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConnectionSettings
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionSettings"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionSettings" ($args)
}
}

New-Alias gs_ConnectionSettings Get-SMO_ConnectionSettings -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConnectionManager
{
[Microsoft.SqlServer.Management.Common.ConnectionManager]
}

New-Alias gst_ConnectionManager Get-SMOT_ConnectionManager -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConnectionManager
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionManager"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionManager" ($args)
}
}

New-Alias gs_ConnectionManager Get-SMO_ConnectionManager -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CapturedSql
{
[Microsoft.SqlServer.Management.Common.CapturedSql]
}

New-Alias gst_CapturedSql Get-SMOT_CapturedSql -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CapturedSql
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.CapturedSql"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.CapturedSql" ($args)
}
}

New-Alias gs_CapturedSql Get-SMO_CapturedSql -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerConnection
{
[Microsoft.SqlServer.Management.Common.ServerConnection]
}

New-Alias gst_ServerConnection Get-SMOT_ServerConnection -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerConnection
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ServerConnection"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ServerConnection" ($args)
}
}

New-Alias gs_ServerConnection Get-SMO_ServerConnection -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StatementEventHandler
{
[Microsoft.SqlServer.Management.Common.StatementEventHandler]
}

New-Alias gst_StatementEventHandler Get-SMOT_StatementEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StatementEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.StatementEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.StatementEventHandler" ($args)
}
}

New-Alias gs_StatementEventHandler Get-SMO_StatementEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StatementEventArgs
{
[Microsoft.SqlServer.Management.Common.StatementEventArgs]
}

New-Alias gst_StatementEventArgs Get-SMOT_StatementEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StatementEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.StatementEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.StatementEventArgs" ($args)
}
}

New-Alias gs_StatementEventArgs Get-SMO_StatementEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerMessageEventHandler
{
[Microsoft.SqlServer.Management.Common.ServerMessageEventHandler]
}

New-Alias gst_ServerMessageEventHandler Get-SMOT_ServerMessageEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerMessageEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ServerMessageEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ServerMessageEventHandler" ($args)
}
}

New-Alias gs_ServerMessageEventHandler Get-SMO_ServerMessageEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerMessageEventArgs
{
[Microsoft.SqlServer.Management.Common.ServerMessageEventArgs]
}

New-Alias gst_ServerMessageEventArgs Get-SMOT_ServerMessageEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerMessageEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ServerMessageEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ServerMessageEventArgs" ($args)
}
}

New-Alias gs_ServerMessageEventArgs Get-SMO_ServerMessageEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NetworkProtocol
{
[Microsoft.SqlServer.Management.Common.NetworkProtocol]
}

New-Alias gst_NetworkProtocol Get-SMOT_NetworkProtocol -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NetworkProtocol
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.NetworkProtocol"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.NetworkProtocol" ($args)
}
}

New-Alias gs_NetworkProtocol Get-SMO_NetworkProtocol -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ExecutionTypes
{
[Microsoft.SqlServer.Management.Common.ExecutionTypes]
}

New-Alias gst_ExecutionTypes Get-SMOT_ExecutionTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ExecutionTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ExecutionTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ExecutionTypes" ($args)
}
}

New-Alias gs_ExecutionTypes Get-SMO_ExecutionTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlExecutionModes
{
[Microsoft.SqlServer.Management.Common.SqlExecutionModes]
}

New-Alias gst_SqlExecutionModes Get-SMOT_SqlExecutionModes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlExecutionModes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.SqlExecutionModes"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.SqlExecutionModes" ($args)
}
}

New-Alias gs_SqlExecutionModes Get-SMO_SqlExecutionModes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FixedServerRoles
{
[Microsoft.SqlServer.Management.Common.FixedServerRoles]
}

New-Alias gst_FixedServerRoles Get-SMOT_FixedServerRoles -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FixedServerRoles
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.FixedServerRoles"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.FixedServerRoles" ($args)
}
}

New-Alias gs_FixedServerRoles Get-SMO_FixedServerRoles -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerUserProfiles
{
[Microsoft.SqlServer.Management.Common.ServerUserProfiles]
}

New-Alias gst_ServerUserProfiles Get-SMOT_ServerUserProfiles -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerUserProfiles
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ServerUserProfiles"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ServerUserProfiles" ($args)
}
}

New-Alias gs_ServerUserProfiles Get-SMO_ServerUserProfiles -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AutoDisconnectMode
{
[Microsoft.SqlServer.Management.Common.AutoDisconnectMode]
}

New-Alias gst_AutoDisconnectMode Get-SMOT_AutoDisconnectMode -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AutoDisconnectMode
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.AutoDisconnectMode"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.AutoDisconnectMode" ($args)
}
}

New-Alias gs_AutoDisconnectMode Get-SMO_AutoDisconnectMode -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConnectionException
{
[Microsoft.SqlServer.Management.Common.ConnectionException]
}

New-Alias gst_ConnectionException Get-SMOT_ConnectionException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConnectionException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionException" ($args)
}
}

New-Alias gs_ConnectionException Get-SMO_ConnectionException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConnectionCannotBeChangedException
{
[Microsoft.SqlServer.Management.Common.ConnectionCannotBeChangedException]
}

New-Alias gst_ConnectionCannotBeChangedException Get-SMOT_ConnectionCannotBeChangedException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConnectionCannotBeChangedException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionCannotBeChangedException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionCannotBeChangedException" ($args)
}
}

New-Alias gs_ConnectionCannotBeChangedException Get-SMO_ConnectionCannotBeChangedException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InvalidPropertyValueException
{
[Microsoft.SqlServer.Management.Common.InvalidPropertyValueException]
}

New-Alias gst_InvalidPropertyValueException Get-SMOT_InvalidPropertyValueException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InvalidPropertyValueException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.InvalidPropertyValueException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.InvalidPropertyValueException" ($args)
}
}

New-Alias gs_InvalidPropertyValueException Get-SMO_InvalidPropertyValueException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConnectionFailureException
{
[Microsoft.SqlServer.Management.Common.ConnectionFailureException]
}

New-Alias gst_ConnectionFailureException Get-SMOT_ConnectionFailureException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConnectionFailureException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionFailureException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionFailureException" ($args)
}
}

New-Alias gs_ConnectionFailureException Get-SMO_ConnectionFailureException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ExecutionFailureException
{
[Microsoft.SqlServer.Management.Common.ExecutionFailureException]
}

New-Alias gst_ExecutionFailureException Get-SMOT_ExecutionFailureException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ExecutionFailureException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ExecutionFailureException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ExecutionFailureException" ($args)
}
}

New-Alias gs_ExecutionFailureException Get-SMO_ExecutionFailureException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotInTransactionException
{
[Microsoft.SqlServer.Management.Common.NotInTransactionException]
}

New-Alias gst_NotInTransactionException Get-SMOT_NotInTransactionException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotInTransactionException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.NotInTransactionException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.NotInTransactionException" ($args)
}
}

New-Alias gs_NotInTransactionException Get-SMO_NotInTransactionException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_InvalidArgumentException
{
[Microsoft.SqlServer.Management.Common.InvalidArgumentException]
}

New-Alias gst_InvalidArgumentException Get-SMOT_InvalidArgumentException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_InvalidArgumentException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.InvalidArgumentException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.InvalidArgumentException" ($args)
}
}

New-Alias gs_InvalidArgumentException Get-SMO_InvalidArgumentException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PropertyNotSetException
{
[Microsoft.SqlServer.Management.Common.PropertyNotSetException]
}

New-Alias gst_PropertyNotSetException Get-SMOT_PropertyNotSetException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PropertyNotSetException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.PropertyNotSetException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.PropertyNotSetException" ($args)
}
}

New-Alias gs_PropertyNotSetException Get-SMO_PropertyNotSetException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PropertyNotAvailableException
{
[Microsoft.SqlServer.Management.Common.PropertyNotAvailableException]
}

New-Alias gst_PropertyNotAvailableException Get-SMOT_PropertyNotAvailableException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PropertyNotAvailableException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.PropertyNotAvailableException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.PropertyNotAvailableException" ($args)
}
}

New-Alias gs_PropertyNotAvailableException Get-SMO_PropertyNotAvailableException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ChangePasswordFailureException
{
[Microsoft.SqlServer.Management.Common.ChangePasswordFailureException]
}

New-Alias gst_ChangePasswordFailureException Get-SMOT_ChangePasswordFailureException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ChangePasswordFailureException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ChangePasswordFailureException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ChangePasswordFailureException" ($args)
}
}

New-Alias gs_ChangePasswordFailureException Get-SMO_ChangePasswordFailureException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerVersion
{
[Microsoft.SqlServer.Management.Common.ServerVersion]
}

New-Alias gst_ServerVersion Get-SMOT_ServerVersion -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerVersion
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ServerVersion"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ServerVersion" ($args)
}
}

New-Alias gs_ServerVersion Get-SMO_ServerVersion -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerCaseSensitivity
{
[Microsoft.SqlServer.Management.Common.ServerCaseSensitivity]
}

New-Alias gst_ServerCaseSensitivity Get-SMOT_ServerCaseSensitivity -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerCaseSensitivity
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ServerCaseSensitivity"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ServerCaseSensitivity" ($args)
}
}

New-Alias gs_ServerCaseSensitivity Get-SMO_ServerCaseSensitivity -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConnectionType
{
[Microsoft.SqlServer.Management.Common.ConnectionType]
}

New-Alias gst_ConnectionType Get-SMOT_ConnectionType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConnectionType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionType"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionType" ($args)
}
}

New-Alias gs_ConnectionType Get-SMO_ConnectionType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ConnectionInfoBase
{
[Microsoft.SqlServer.Management.Common.ConnectionInfoBase]
}

New-Alias gst_ConnectionInfoBase Get-SMOT_ConnectionInfoBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ConnectionInfoBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionInfoBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ConnectionInfoBase" ($args)
}
}

New-Alias gs_ConnectionInfoBase Get-SMO_ConnectionInfoBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlOlapConnectionInfoBase
{
[Microsoft.SqlServer.Management.Common.SqlOlapConnectionInfoBase]
}

New-Alias gst_SqlOlapConnectionInfoBase Get-SMOT_SqlOlapConnectionInfoBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlOlapConnectionInfoBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.SqlOlapConnectionInfoBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.SqlOlapConnectionInfoBase" ($args)
}
}

New-Alias gs_SqlOlapConnectionInfoBase Get-SMO_SqlOlapConnectionInfoBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_OlapConnectionInfo
{
[Microsoft.SqlServer.Management.Common.OlapConnectionInfo]
}

New-Alias gst_OlapConnectionInfo Get-SMOT_OlapConnectionInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_OlapConnectionInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.OlapConnectionInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.OlapConnectionInfo" ($args)
}
}

New-Alias gs_OlapConnectionInfo Get-SMO_OlapConnectionInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SqlConnectionInfo
{
[Microsoft.SqlServer.Management.Common.SqlConnectionInfo]
}

New-Alias gst_SqlConnectionInfo Get-SMOT_SqlConnectionInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SqlConnectionInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.SqlConnectionInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.SqlConnectionInfo" ($args)
}
}

New-Alias gs_SqlConnectionInfo Get-SMO_SqlConnectionInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IRestrictedAccess
{
[Microsoft.SqlServer.Management.Common.IRestrictedAccess]
}

New-Alias gst_IRestrictedAccess Get-SMOT_IRestrictedAccess -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IRestrictedAccess
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.IRestrictedAccess"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.IRestrictedAccess" ($args)
}
}

New-Alias gs_IRestrictedAccess Get-SMO_IRestrictedAccess -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ICreatable
{
[Microsoft.SqlServer.Management.Common.ICreatable]
}

New-Alias gst_ICreatable Get-SMOT_ICreatable -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ICreatable
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ICreatable"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ICreatable" ($args)
}
}

New-Alias gs_ICreatable Get-SMO_ICreatable -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IDroppable
{
[Microsoft.SqlServer.Management.Common.IDroppable]
}

New-Alias gst_IDroppable Get-SMOT_IDroppable -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IDroppable
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.IDroppable"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.IDroppable" ($args)
}
}

New-Alias gs_IDroppable Get-SMO_IDroppable -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IAlterable
{
[Microsoft.SqlServer.Management.Common.IAlterable]
}

New-Alias gst_IAlterable Get-SMOT_IAlterable -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IAlterable
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.IAlterable"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.IAlterable" ($args)
}
}

New-Alias gs_IAlterable Get-SMO_IAlterable -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IMarkForDrop
{
[Microsoft.SqlServer.Management.Common.IMarkForDrop]
}

New-Alias gst_IMarkForDrop Get-SMOT_IMarkForDrop -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IMarkForDrop
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.IMarkForDrop"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.IMarkForDrop" ($args)
}
}

New-Alias gs_IMarkForDrop Get-SMO_IMarkForDrop -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IRenamable
{
[Microsoft.SqlServer.Management.Common.IRenamable]
}

New-Alias gst_IRenamable Get-SMOT_IRenamable -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IRenamable
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.IRenamable"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.IRenamable" ($args)
}
}

New-Alias gs_IRenamable Get-SMO_IRenamable -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ITransferMetadataProvider
{
[Microsoft.SqlServer.Management.Common.ITransferMetadataProvider]
}

New-Alias gst_ITransferMetadataProvider Get-SMOT_ITransferMetadataProvider -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ITransferMetadataProvider
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.ITransferMetadataProvider"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.ITransferMetadataProvider" ($args)
}
}

New-Alias gs_ITransferMetadataProvider Get-SMO_ITransferMetadataProvider -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IDataTransferProvider
{
[Microsoft.SqlServer.Management.Common.IDataTransferProvider]
}

New-Alias gst_IDataTransferProvider Get-SMOT_IDataTransferProvider -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IDataTransferProvider
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.IDataTransferProvider"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.IDataTransferProvider" ($args)
}
}

New-Alias gs_IDataTransferProvider Get-SMO_IDataTransferProvider -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TransferException
{
[Microsoft.SqlServer.Management.Common.TransferException]
}

New-Alias gst_TransferException Get-SMOT_TransferException -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TransferException
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.TransferException"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.TransferException" ($args)
}
}

New-Alias gs_TransferException Get-SMO_TransferException -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataTransferEventHandler
{
[Microsoft.SqlServer.Management.Common.DataTransferEventHandler]
}

New-Alias gst_DataTransferEventHandler Get-SMOT_DataTransferEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataTransferEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferEventHandler" ($args)
}
}

New-Alias gs_DataTransferEventHandler Get-SMO_DataTransferEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataTransferEventArgs
{
[Microsoft.SqlServer.Management.Common.DataTransferEventArgs]
}

New-Alias gst_DataTransferEventArgs Get-SMOT_DataTransferEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataTransferEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferEventArgs" ($args)
}
}

New-Alias gs_DataTransferEventArgs Get-SMO_DataTransferEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataTransferEventType
{
[Microsoft.SqlServer.Management.Common.DataTransferEventType]
}

New-Alias gst_DataTransferEventType Get-SMOT_DataTransferEventType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataTransferEventType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferEventType"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferEventType" ($args)
}
}

New-Alias gs_DataTransferEventType Get-SMO_DataTransferEventType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataTransferProgressEventHandler
{
[Microsoft.SqlServer.Management.Common.DataTransferProgressEventHandler]
}

New-Alias gst_DataTransferProgressEventHandler Get-SMOT_DataTransferProgressEventHandler -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataTransferProgressEventHandler
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferProgressEventHandler"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferProgressEventHandler" ($args)
}
}

New-Alias gs_DataTransferProgressEventHandler Get-SMO_DataTransferProgressEventHandler -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataTransferProgressEventType
{
[Microsoft.SqlServer.Management.Common.DataTransferProgressEventType]
}

New-Alias gst_DataTransferProgressEventType Get-SMOT_DataTransferProgressEventType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataTransferProgressEventType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferProgressEventType"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferProgressEventType" ($args)
}
}

New-Alias gs_DataTransferProgressEventType Get-SMO_DataTransferProgressEventType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DataTransferProgressEventArgs
{
[Microsoft.SqlServer.Management.Common.DataTransferProgressEventArgs]
}

New-Alias gst_DataTransferProgressEventArgs Get-SMOT_DataTransferProgressEventArgs -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DataTransferProgressEventArgs
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferProgressEventArgs"
}
else
{
new-object "Microsoft.SqlServer.Management.Common.DataTransferProgressEventArgs" ($args)
}
}

New-Alias gs_DataTransferProgressEventArgs Get-SMO_DataTransferProgressEventArgs -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FileGrowthType
{
[Microsoft.SqlServer.Management.Smo.FileGrowthType]
}

New-Alias gst_FileGrowthType Get-SMOT_FileGrowthType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FileGrowthType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.FileGrowthType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.FileGrowthType" ($args)
}
}

New-Alias gs_FileGrowthType Get-SMO_FileGrowthType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexKeyType
{
[Microsoft.SqlServer.Management.Smo.IndexKeyType]
}

New-Alias gst_IndexKeyType Get-SMOT_IndexKeyType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexKeyType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexKeyType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexKeyType" ($args)
}
}

New-Alias gs_IndexKeyType Get-SMO_IndexKeyType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PermissionState
{
[Microsoft.SqlServer.Management.Smo.PermissionState]
}

New-Alias gst_PermissionState Get-SMOT_PermissionState -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PermissionState
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PermissionState"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PermissionState" ($args)
}
}

New-Alias gs_PermissionState Get-SMO_PermissionState -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupDeviceType
{
[Microsoft.SqlServer.Management.Smo.BackupDeviceType]
}

New-Alias gst_BackupDeviceType Get-SMOT_BackupDeviceType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupDeviceType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceType" ($args)
}
}

New-Alias gs_BackupDeviceType Get-SMO_BackupDeviceType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedFunctionType
{
[Microsoft.SqlServer.Management.Smo.UserDefinedFunctionType]
}

New-Alias gst_UserDefinedFunctionType Get-SMOT_UserDefinedFunctionType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedFunctionType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedFunctionType" ($args)
}
}

New-Alias gs_UserDefinedFunctionType Get-SMO_UserDefinedFunctionType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerLoginMode
{
[Microsoft.SqlServer.Management.Smo.ServerLoginMode]
}

New-Alias gst_ServerLoginMode Get-SMOT_ServerLoginMode -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerLoginMode
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerLoginMode"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerLoginMode" ($args)
}
}

New-Alias gs_ServerLoginMode Get-SMO_ServerLoginMode -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LockRequestStatus
{
[Microsoft.SqlServer.Management.Smo.LockRequestStatus]
}

New-Alias gst_LockRequestStatus Get-SMOT_LockRequestStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LockRequestStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LockRequestStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LockRequestStatus" ($args)
}
}

New-Alias gs_LockRequestStatus Get-SMO_LockRequestStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RecoveryModel
{
[Microsoft.SqlServer.Management.Smo.RecoveryModel]
}

New-Alias gst_RecoveryModel Get-SMOT_RecoveryModel -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RecoveryModel
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RecoveryModel"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RecoveryModel" ($args)
}
}

New-Alias gs_RecoveryModel Get-SMO_RecoveryModel -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MediaTypes
{
[Microsoft.SqlServer.Management.Smo.MediaTypes]
}

New-Alias gst_MediaTypes Get-SMOT_MediaTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MediaTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MediaTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MediaTypes" ($args)
}
}

New-Alias gs_MediaTypes Get-SMO_MediaTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LoginType
{
[Microsoft.SqlServer.Management.Smo.LoginType]
}

New-Alias gst_LoginType Get-SMOT_LoginType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LoginType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LoginType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LoginType" ($args)
}
}

New-Alias gs_LoginType Get-SMO_LoginType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserType
{
[Microsoft.SqlServer.Management.Smo.UserType]
}

New-Alias gst_UserType Get-SMOT_UserType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserType" ($args)
}
}

New-Alias gs_UserType Get-SMO_UserType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_WindowsLoginAccessType
{
[Microsoft.SqlServer.Management.Smo.WindowsLoginAccessType]
}

New-Alias gst_WindowsLoginAccessType Get-SMOT_WindowsLoginAccessType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_WindowsLoginAccessType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.WindowsLoginAccessType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.WindowsLoginAccessType" ($args)
}
}

New-Alias gs_WindowsLoginAccessType Get-SMO_WindowsLoginAccessType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseUserAccess
{
[Microsoft.SqlServer.Management.Smo.DatabaseUserAccess]
}

New-Alias gst_DatabaseUserAccess Get-SMOT_DatabaseUserAccess -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseUserAccess
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseUserAccess"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseUserAccess" ($args)
}
}

New-Alias gs_DatabaseUserAccess Get-SMO_DatabaseUserAccess -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CompatibilityLevel
{
[Microsoft.SqlServer.Management.Smo.CompatibilityLevel]
}

New-Alias gst_CompatibilityLevel Get-SMOT_CompatibilityLevel -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CompatibilityLevel
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CompatibilityLevel"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CompatibilityLevel" ($args)
}
}

New-Alias gs_CompatibilityLevel Get-SMO_CompatibilityLevel -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseStatus
{
[Microsoft.SqlServer.Management.Smo.DatabaseStatus]
}

New-Alias gst_DatabaseStatus Get-SMOT_DatabaseStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseStatus" ($args)
}
}

New-Alias gs_DatabaseStatus Get-SMO_DatabaseStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SnapshotIsolationState
{
[Microsoft.SqlServer.Management.Smo.SnapshotIsolationState]
}

New-Alias gst_SnapshotIsolationState Get-SMOT_SnapshotIsolationState -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SnapshotIsolationState
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SnapshotIsolationState"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SnapshotIsolationState" ($args)
}
}

New-Alias gs_SnapshotIsolationState Get-SMO_SnapshotIsolationState -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RangeType
{
[Microsoft.SqlServer.Management.Smo.RangeType]
}

New-Alias gst_RangeType Get-SMOT_RangeType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RangeType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RangeType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RangeType" ($args)
}
}

New-Alias gs_RangeType Get-SMO_RangeType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AssemblySecurityLevel
{
[Microsoft.SqlServer.Management.Smo.AssemblySecurityLevel]
}

New-Alias gst_AssemblySecurityLevel Get-SMOT_AssemblySecurityLevel -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AssemblySecurityLevel
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AssemblySecurityLevel"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AssemblySecurityLevel" ($args)
}
}

New-Alias gs_AssemblySecurityLevel Get-SMO_AssemblySecurityLevel -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ExecutionContext
{
[Microsoft.SqlServer.Management.Smo.ExecutionContext]
}

New-Alias gst_ExecutionContext Get-SMOT_ExecutionContext -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ExecutionContext
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ExecutionContext"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ExecutionContext" ($args)
}
}

New-Alias gs_ExecutionContext Get-SMO_ExecutionContext -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerDdlTriggerExecutionContext
{
[Microsoft.SqlServer.Management.Smo.ServerDdlTriggerExecutionContext]
}

New-Alias gst_ServerDdlTriggerExecutionContext Get-SMOT_ServerDdlTriggerExecutionContext -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerDdlTriggerExecutionContext
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTriggerExecutionContext"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTriggerExecutionContext" ($args)
}
}

New-Alias gs_ServerDdlTriggerExecutionContext Get-SMO_ServerDdlTriggerExecutionContext -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseDdlTriggerExecutionContext
{
[Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerExecutionContext]
}

New-Alias gst_DatabaseDdlTriggerExecutionContext Get-SMOT_DatabaseDdlTriggerExecutionContext -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseDdlTriggerExecutionContext
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerExecutionContext"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerExecutionContext" ($args)
}
}

New-Alias gs_DatabaseDdlTriggerExecutionContext Get-SMO_DatabaseDdlTriggerExecutionContext -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ActivationExecutionContext
{
[Microsoft.SqlServer.Management.Smo.ActivationExecutionContext]
}

New-Alias gst_ActivationExecutionContext Get-SMOT_ActivationExecutionContext -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ActivationExecutionContext
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ActivationExecutionContext"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ActivationExecutionContext" ($args)
}
}

New-Alias gs_ActivationExecutionContext Get-SMO_ActivationExecutionContext -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AssemblyAlterOptions
{
[Microsoft.SqlServer.Management.Smo.AssemblyAlterOptions]
}

New-Alias gst_AssemblyAlterOptions Get-SMOT_AssemblyAlterOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AssemblyAlterOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AssemblyAlterOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AssemblyAlterOptions" ($args)
}
}

New-Alias gs_AssemblyAlterOptions Get-SMO_AssemblyAlterOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ImplementationType
{
[Microsoft.SqlServer.Management.Smo.ImplementationType]
}

New-Alias gst_ImplementationType Get-SMOT_ImplementationType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ImplementationType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ImplementationType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ImplementationType" ($args)
}
}

New-Alias gs_ImplementationType Get-SMO_ImplementationType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_UserDefinedTypeFormat
{
[Microsoft.SqlServer.Management.Smo.UserDefinedTypeFormat]
}

New-Alias gst_UserDefinedTypeFormat Get-SMOT_UserDefinedTypeFormat -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_UserDefinedTypeFormat
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedTypeFormat"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.UserDefinedTypeFormat" ($args)
}
}

New-Alias gs_UserDefinedTypeFormat Get-SMO_UserDefinedTypeFormat -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ResourceUsage
{
[Microsoft.SqlServer.Management.Smo.ResourceUsage]
}

New-Alias gst_ResourceUsage Get-SMOT_ResourceUsage -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ResourceUsage
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ResourceUsage"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ResourceUsage" ($args)
}
}

New-Alias gs_ResourceUsage Get-SMO_ResourceUsage -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_RestoreType
{
[Microsoft.SqlServer.Management.Smo.RestoreType]
}

New-Alias gst_RestoreType Get-SMOT_RestoreType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_RestoreType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.RestoreType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.RestoreType" ($args)
}
}

New-Alias gs_RestoreType Get-SMO_RestoreType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CatalogPopulationStatus
{
[Microsoft.SqlServer.Management.Smo.CatalogPopulationStatus]
}

New-Alias gst_CatalogPopulationStatus Get-SMOT_CatalogPopulationStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CatalogPopulationStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CatalogPopulationStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CatalogPopulationStatus" ($args)
}
}

New-Alias gs_CatalogPopulationStatus Get-SMO_CatalogPopulationStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CatalogPopulationAction
{
[Microsoft.SqlServer.Management.Smo.CatalogPopulationAction]
}

New-Alias gst_CatalogPopulationAction Get-SMOT_CatalogPopulationAction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CatalogPopulationAction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.CatalogPopulationAction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.CatalogPopulationAction" ($args)
}
}

New-Alias gs_CatalogPopulationAction Get-SMO_CatalogPopulationAction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexPopulationAction
{
[Microsoft.SqlServer.Management.Smo.IndexPopulationAction]
}

New-Alias gst_IndexPopulationAction Get-SMOT_IndexPopulationAction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexPopulationAction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexPopulationAction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexPopulationAction" ($args)
}
}

New-Alias gs_IndexPopulationAction Get-SMO_IndexPopulationAction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupSetFlag
{
[Microsoft.SqlServer.Management.Smo.BackupSetFlag]
}

New-Alias gst_BackupSetFlag Get-SMOT_BackupSetFlag -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupSetFlag
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupSetFlag"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupSetFlag" ($args)
}
}

New-Alias gs_BackupSetFlag Get-SMO_BackupSetFlag -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_BackupSetType
{
[Microsoft.SqlServer.Management.Smo.BackupSetType]
}

New-Alias gst_BackupSetType Get-SMOT_BackupSetType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_BackupSetType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.BackupSetType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.BackupSetType" ($args)
}
}

New-Alias gs_BackupSetType Get-SMO_BackupSetType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_IndexPopulationStatus
{
[Microsoft.SqlServer.Management.Smo.IndexPopulationStatus]
}

New-Alias gst_IndexPopulationStatus Get-SMOT_IndexPopulationStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_IndexPopulationStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.IndexPopulationStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.IndexPopulationStatus" ($args)
}
}

New-Alias gs_IndexPopulationStatus Get-SMO_IndexPopulationStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ChangeTracking
{
[Microsoft.SqlServer.Management.Smo.ChangeTracking]
}

New-Alias gst_ChangeTracking Get-SMOT_ChangeTracking -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ChangeTracking
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ChangeTracking"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ChangeTracking" ($args)
}
}

New-Alias gs_ChangeTracking Get-SMO_ChangeTracking -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ReplicationOptions
{
[Microsoft.SqlServer.Management.Smo.ReplicationOptions]
}

New-Alias gst_ReplicationOptions Get-SMOT_ReplicationOptions -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ReplicationOptions
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ReplicationOptions"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ReplicationOptions" ($args)
}
}

New-Alias gs_ReplicationOptions Get-SMO_ReplicationOptions -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PrincipalType
{
[Microsoft.SqlServer.Management.Smo.PrincipalType]
}

New-Alias gst_PrincipalType Get-SMOT_PrincipalType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PrincipalType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PrincipalType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PrincipalType" ($args)
}
}

New-Alias gs_PrincipalType Get-SMO_PrincipalType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PrivateKeyEncryptionType
{
[Microsoft.SqlServer.Management.Smo.PrivateKeyEncryptionType]
}

New-Alias gst_PrivateKeyEncryptionType Get-SMOT_PrivateKeyEncryptionType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PrivateKeyEncryptionType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PrivateKeyEncryptionType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PrivateKeyEncryptionType" ($args)
}
}

New-Alias gs_PrivateKeyEncryptionType Get-SMO_PrivateKeyEncryptionType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SymmetricKeyEncryptionAlgorithm
{
[Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryptionAlgorithm]
}

New-Alias gst_SymmetricKeyEncryptionAlgorithm Get-SMOT_SymmetricKeyEncryptionAlgorithm -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SymmetricKeyEncryptionAlgorithm
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryptionAlgorithm"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryptionAlgorithm" ($args)
}
}

New-Alias gs_SymmetricKeyEncryptionAlgorithm Get-SMO_SymmetricKeyEncryptionAlgorithm -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AsymmetricKeyEncryptionAlgorithm
{
[Microsoft.SqlServer.Management.Smo.AsymmetricKeyEncryptionAlgorithm]
}

New-Alias gst_AsymmetricKeyEncryptionAlgorithm Get-SMOT_AsymmetricKeyEncryptionAlgorithm -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AsymmetricKeyEncryptionAlgorithm
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AsymmetricKeyEncryptionAlgorithm"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AsymmetricKeyEncryptionAlgorithm" ($args)
}
}

New-Alias gs_AsymmetricKeyEncryptionAlgorithm Get-SMO_AsymmetricKeyEncryptionAlgorithm -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SymmetricKeyEncryptionType
{
[Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryptionType]
}

New-Alias gst_SymmetricKeyEncryptionType Get-SMOT_SymmetricKeyEncryptionType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SymmetricKeyEncryptionType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryptionType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SymmetricKeyEncryptionType" ($args)
}
}

New-Alias gs_SymmetricKeyEncryptionType Get-SMO_SymmetricKeyEncryptionType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectClass
{
[Microsoft.SqlServer.Management.Smo.ObjectClass]
}

New-Alias gst_ObjectClass Get-SMOT_ObjectClass -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectClass
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectClass"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectClass" ($args)
}
}

New-Alias gs_ObjectClass Get-SMO_ObjectClass -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PageVerify
{
[Microsoft.SqlServer.Management.Smo.PageVerify]
}

New-Alias gst_PageVerify Get-SMOT_PageVerify -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PageVerify
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PageVerify"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PageVerify" ($args)
}
}

New-Alias gs_PageVerify Get-SMO_PageVerify -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MirroringRole
{
[Microsoft.SqlServer.Management.Smo.MirroringRole]
}

New-Alias gst_MirroringRole Get-SMOT_MirroringRole -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MirroringRole
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringRole"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringRole" ($args)
}
}

New-Alias gs_MirroringRole Get-SMO_MirroringRole -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MirroringSafetyLevel
{
[Microsoft.SqlServer.Management.Smo.MirroringSafetyLevel]
}

New-Alias gst_MirroringSafetyLevel Get-SMOT_MirroringSafetyLevel -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MirroringSafetyLevel
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringSafetyLevel"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringSafetyLevel" ($args)
}
}

New-Alias gs_MirroringSafetyLevel Get-SMO_MirroringSafetyLevel -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MirroringOption
{
[Microsoft.SqlServer.Management.Smo.MirroringOption]
}

New-Alias gst_MirroringOption Get-SMOT_MirroringOption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MirroringOption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringOption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringOption" ($args)
}
}

New-Alias gs_MirroringOption Get-SMO_MirroringOption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MirroringStatus
{
[Microsoft.SqlServer.Management.Smo.MirroringStatus]
}

New-Alias gst_MirroringStatus Get-SMOT_MirroringStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MirroringStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringStatus" ($args)
}
}

New-Alias gs_MirroringStatus Get-SMO_MirroringStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MirroringWitnessStatus
{
[Microsoft.SqlServer.Management.Smo.MirroringWitnessStatus]
}

New-Alias gst_MirroringWitnessStatus Get-SMOT_MirroringWitnessStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MirroringWitnessStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringWitnessStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MirroringWitnessStatus" ($args)
}
}

New-Alias gs_MirroringWitnessStatus Get-SMO_MirroringWitnessStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_HttpPortTypes
{
[Microsoft.SqlServer.Management.Smo.HttpPortTypes]
}

New-Alias gst_HttpPortTypes Get-SMOT_HttpPortTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_HttpPortTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.HttpPortTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.HttpPortTypes" ($args)
}
}

New-Alias gs_HttpPortTypes Get-SMO_HttpPortTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EndpointState
{
[Microsoft.SqlServer.Management.Smo.EndpointState]
}

New-Alias gst_EndpointState Get-SMOT_EndpointState -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EndpointState
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointState"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointState" ($args)
}
}

New-Alias gs_EndpointState Get-SMO_EndpointState -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_XmlFormatOption
{
[Microsoft.SqlServer.Management.Smo.XmlFormatOption]
}

New-Alias gst_XmlFormatOption Get-SMOT_XmlFormatOption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_XmlFormatOption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.XmlFormatOption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.XmlFormatOption" ($args)
}
}

New-Alias gs_XmlFormatOption Get-SMO_XmlFormatOption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_XsdSchemaOption
{
[Microsoft.SqlServer.Management.Smo.XsdSchemaOption]
}

New-Alias gst_XsdSchemaOption Get-SMOT_XsdSchemaOption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_XsdSchemaOption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.XsdSchemaOption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.XsdSchemaOption" ($args)
}
}

New-Alias gs_XsdSchemaOption Get-SMO_XsdSchemaOption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ResultFormat
{
[Microsoft.SqlServer.Management.Smo.ResultFormat]
}

New-Alias gst_ResultFormat Get-SMOT_ResultFormat -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ResultFormat
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ResultFormat"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ResultFormat" ($args)
}
}

New-Alias gs_ResultFormat Get-SMO_ResultFormat -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MethodXsdSchemaOption
{
[Microsoft.SqlServer.Management.Smo.MethodXsdSchemaOption]
}

New-Alias gst_MethodXsdSchemaOption Get-SMOT_MethodXsdSchemaOption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MethodXsdSchemaOption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MethodXsdSchemaOption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MethodXsdSchemaOption" ($args)
}
}

New-Alias gs_MethodXsdSchemaOption Get-SMO_MethodXsdSchemaOption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_WsdlGeneratorOption
{
[Microsoft.SqlServer.Management.Smo.WsdlGeneratorOption]
}

New-Alias gst_WsdlGeneratorOption Get-SMOT_WsdlGeneratorOption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_WsdlGeneratorOption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.WsdlGeneratorOption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.WsdlGeneratorOption" ($args)
}
}

New-Alias gs_WsdlGeneratorOption Get-SMO_WsdlGeneratorOption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_HttpAuthenticationModes
{
[Microsoft.SqlServer.Management.Smo.HttpAuthenticationModes]
}

New-Alias gst_HttpAuthenticationModes Get-SMOT_HttpAuthenticationModes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_HttpAuthenticationModes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.HttpAuthenticationModes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.HttpAuthenticationModes" ($args)
}
}

New-Alias gs_HttpAuthenticationModes Get-SMO_HttpAuthenticationModes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LogReuseWaitStatus
{
[Microsoft.SqlServer.Management.Smo.LogReuseWaitStatus]
}

New-Alias gst_LogReuseWaitStatus Get-SMOT_LogReuseWaitStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LogReuseWaitStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LogReuseWaitStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LogReuseWaitStatus" ($args)
}
}

New-Alias gs_LogReuseWaitStatus Get-SMO_LogReuseWaitStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_XmlTypeKind
{
[Microsoft.SqlServer.Management.Smo.XmlTypeKind]
}

New-Alias gst_XmlTypeKind Get-SMOT_XmlTypeKind -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_XmlTypeKind
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.XmlTypeKind"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.XmlTypeKind" ($args)
}
}

New-Alias gs_XmlTypeKind Get-SMO_XmlTypeKind -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_XmlTypeDerivation
{
[Microsoft.SqlServer.Management.Smo.XmlTypeDerivation]
}

New-Alias gst_XmlTypeDerivation Get-SMOT_XmlTypeDerivation -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_XmlTypeDerivation
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.XmlTypeDerivation"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.XmlTypeDerivation" ($args)
}
}

New-Alias gs_XmlTypeDerivation Get-SMO_XmlTypeDerivation -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_SecondaryXmlIndexType
{
[Microsoft.SqlServer.Management.Smo.SecondaryXmlIndexType]
}

New-Alias gst_SecondaryXmlIndexType Get-SMOT_SecondaryXmlIndexType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_SecondaryXmlIndexType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.SecondaryXmlIndexType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.SecondaryXmlIndexType" ($args)
}
}

New-Alias gs_SecondaryXmlIndexType Get-SMO_SecondaryXmlIndexType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EndpointType
{
[Microsoft.SqlServer.Management.Smo.EndpointType]
}

New-Alias gst_EndpointType Get-SMOT_EndpointType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EndpointType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointType" ($args)
}
}

New-Alias gs_EndpointType Get-SMO_EndpointType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EndpointEncryption
{
[Microsoft.SqlServer.Management.Smo.EndpointEncryption]
}

New-Alias gst_EndpointEncryption Get-SMOT_EndpointEncryption -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EndpointEncryption
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointEncryption"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointEncryption" ($args)
}
}

New-Alias gs_EndpointEncryption Get-SMO_EndpointEncryption -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EndpointEncryptionAlgorithm
{
[Microsoft.SqlServer.Management.Smo.EndpointEncryptionAlgorithm]
}

New-Alias gst_EndpointEncryptionAlgorithm Get-SMOT_EndpointEncryptionAlgorithm -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EndpointEncryptionAlgorithm
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointEncryptionAlgorithm"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointEncryptionAlgorithm" ($args)
}
}

New-Alias gs_EndpointEncryptionAlgorithm Get-SMO_EndpointEncryptionAlgorithm -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EndpointAuthenticationOrder
{
[Microsoft.SqlServer.Management.Smo.EndpointAuthenticationOrder]
}

New-Alias gst_EndpointAuthenticationOrder Get-SMOT_EndpointAuthenticationOrder -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EndpointAuthenticationOrder
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointAuthenticationOrder"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EndpointAuthenticationOrder" ($args)
}
}

New-Alias gs_EndpointAuthenticationOrder Get-SMO_EndpointAuthenticationOrder -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ProtocolType
{
[Microsoft.SqlServer.Management.Smo.ProtocolType]
}

New-Alias gst_ProtocolType Get-SMOT_ProtocolType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ProtocolType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ProtocolType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ProtocolType" ($args)
}
}

New-Alias gs_ProtocolType Get-SMO_ProtocolType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerMirroringRole
{
[Microsoft.SqlServer.Management.Smo.ServerMirroringRole]
}

New-Alias gst_ServerMirroringRole Get-SMOT_ServerMirroringRole -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerMirroringRole
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerMirroringRole"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerMirroringRole" ($args)
}
}

New-Alias gs_ServerMirroringRole Get-SMO_ServerMirroringRole -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ForeignKeyAction
{
[Microsoft.SqlServer.Management.Smo.ForeignKeyAction]
}

New-Alias gst_ForeignKeyAction Get-SMOT_ForeignKeyAction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ForeignKeyAction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKeyAction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ForeignKeyAction" ($args)
}
}

New-Alias gs_ForeignKeyAction Get-SMO_ForeignKeyAction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_XmlDocumentConstraint
{
[Microsoft.SqlServer.Management.Smo.XmlDocumentConstraint]
}

New-Alias gst_XmlDocumentConstraint Get-SMOT_XmlDocumentConstraint -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_XmlDocumentConstraint
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.XmlDocumentConstraint"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.XmlDocumentConstraint" ($args)
}
}

New-Alias gs_XmlDocumentConstraint Get-SMO_XmlDocumentConstraint -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NSActivationState
{
[Microsoft.SqlServer.Management.Smo.NSActivationState]
}

New-Alias gst_NSActivationState Get-SMOT_NSActivationState -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NSActivationState
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.NSActivationState"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.NSActivationState" ($args)
}
}

New-Alias gs_NSActivationState Get-SMO_NSActivationState -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_MethodLoginType
{
[Microsoft.SqlServer.Management.Smo.MethodLoginType]
}

New-Alias gst_MethodLoginType Get-SMOT_MethodLoginType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_MethodLoginType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.MethodLoginType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.MethodLoginType" ($args)
}
}

New-Alias gs_MethodLoginType Get-SMO_MethodLoginType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AuditLevel
{
[Microsoft.SqlServer.Management.Smo.AuditLevel]
}

New-Alias gst_AuditLevel Get-SMOT_AuditLevel -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AuditLevel
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.AuditLevel"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.AuditLevel" ($args)
}
}

New-Alias gs_AuditLevel Get-SMO_AuditLevel -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_PerfMonMode
{
[Microsoft.SqlServer.Management.Smo.PerfMonMode]
}

New-Alias gst_PerfMonMode Get-SMOT_PerfMonMode -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_PerfMonMode
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.PerfMonMode"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.PerfMonMode" ($args)
}
}

New-Alias gs_PerfMonMode Get-SMO_PerfMonMode -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ActivationOrder
{
[Microsoft.SqlServer.Management.Smo.Agent.ActivationOrder]
}

New-Alias gst_ActivationOrder Get-SMOT_ActivationOrder -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ActivationOrder
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.ActivationOrder"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.ActivationOrder" ($args)
}
}

New-Alias gs_ActivationOrder Get-SMO_ActivationOrder -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AgentLogLevels
{
[Microsoft.SqlServer.Management.Smo.Agent.AgentLogLevels]
}

New-Alias gst_AgentLogLevels Get-SMOT_AgentLogLevels -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AgentLogLevels
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AgentLogLevels"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AgentLogLevels" ($args)
}
}

New-Alias gs_AgentLogLevels Get-SMO_AgentLogLevels -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AgentMailType
{
[Microsoft.SqlServer.Management.Smo.Agent.AgentMailType]
}

New-Alias gst_AgentMailType Get-SMOT_AgentMailType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AgentMailType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AgentMailType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AgentMailType" ($args)
}
}

New-Alias gs_AgentMailType Get-SMO_AgentMailType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AgentSubSystem
{
[Microsoft.SqlServer.Management.Smo.Agent.AgentSubSystem]
}

New-Alias gst_AgentSubSystem Get-SMOT_AgentSubSystem -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AgentSubSystem
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AgentSubSystem"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AgentSubSystem" ($args)
}
}

New-Alias gs_AgentSubSystem Get-SMO_AgentSubSystem -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_AlertType
{
[Microsoft.SqlServer.Management.Smo.Agent.AlertType]
}

New-Alias gst_AlertType Get-SMOT_AlertType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_AlertType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.AlertType" ($args)
}
}

New-Alias gs_AlertType Get-SMO_AlertType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CategoryType
{
[Microsoft.SqlServer.Management.Smo.Agent.CategoryType]
}

New-Alias gst_CategoryType Get-SMOT_CategoryType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CategoryType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.CategoryType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.CategoryType" ($args)
}
}

New-Alias gs_CategoryType Get-SMO_CategoryType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CompletionAction
{
[Microsoft.SqlServer.Management.Smo.Agent.CompletionAction]
}

New-Alias gst_CompletionAction Get-SMOT_CompletionAction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CompletionAction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.CompletionAction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.CompletionAction" ($args)
}
}

New-Alias gs_CompletionAction Get-SMO_CompletionAction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_CompletionResult
{
[Microsoft.SqlServer.Management.Smo.Agent.CompletionResult]
}

New-Alias gst_CompletionResult Get-SMOT_CompletionResult -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_CompletionResult
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.CompletionResult"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.CompletionResult" ($args)
}
}

New-Alias gs_CompletionResult Get-SMO_CompletionResult -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FrequencyRelativeIntervals
{
[Microsoft.SqlServer.Management.Smo.Agent.FrequencyRelativeIntervals]
}

New-Alias gst_FrequencyRelativeIntervals Get-SMOT_FrequencyRelativeIntervals -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FrequencyRelativeIntervals
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.FrequencyRelativeIntervals"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.FrequencyRelativeIntervals" ($args)
}
}

New-Alias gs_FrequencyRelativeIntervals Get-SMO_FrequencyRelativeIntervals -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FrequencySubDayTypes
{
[Microsoft.SqlServer.Management.Smo.Agent.FrequencySubDayTypes]
}

New-Alias gst_FrequencySubDayTypes Get-SMOT_FrequencySubDayTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FrequencySubDayTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.FrequencySubDayTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.FrequencySubDayTypes" ($args)
}
}

New-Alias gs_FrequencySubDayTypes Get-SMO_FrequencySubDayTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_FrequencyTypes
{
[Microsoft.SqlServer.Management.Smo.Agent.FrequencyTypes]
}

New-Alias gst_FrequencyTypes Get-SMOT_FrequencyTypes -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_FrequencyTypes
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.FrequencyTypes"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.FrequencyTypes" ($args)
}
}

New-Alias gs_FrequencyTypes Get-SMO_FrequencyTypes -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobExecutionStatus
{
[Microsoft.SqlServer.Management.Smo.Agent.JobExecutionStatus]
}

New-Alias gst_JobExecutionStatus Get-SMOT_JobExecutionStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobExecutionStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobExecutionStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobExecutionStatus" ($args)
}
}

New-Alias gs_JobExecutionStatus Get-SMO_JobExecutionStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobOutcome
{
[Microsoft.SqlServer.Management.Smo.Agent.JobOutcome]
}

New-Alias gst_JobOutcome Get-SMOT_JobOutcome -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobOutcome
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobOutcome"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobOutcome" ($args)
}
}

New-Alias gs_JobOutcome Get-SMO_JobOutcome -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobServerType
{
[Microsoft.SqlServer.Management.Smo.Agent.JobServerType]
}

New-Alias gst_JobServerType Get-SMOT_JobServerType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobServerType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobServerType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobServerType" ($args)
}
}

New-Alias gs_JobServerType Get-SMO_JobServerType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobStepFlags
{
[Microsoft.SqlServer.Management.Smo.Agent.JobStepFlags]
}

New-Alias gst_JobStepFlags Get-SMOT_JobStepFlags -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobStepFlags
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobStepFlags"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobStepFlags" ($args)
}
}

New-Alias gs_JobStepFlags Get-SMO_JobStepFlags -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_JobType
{
[Microsoft.SqlServer.Management.Smo.Agent.JobType]
}

New-Alias gst_JobType Get-SMOT_JobType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_JobType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.JobType" ($args)
}
}

New-Alias gs_JobType Get-SMO_JobType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_NotifyMethods
{
[Microsoft.SqlServer.Management.Smo.Agent.NotifyMethods]
}

New-Alias gst_NotifyMethods Get-SMOT_NotifyMethods -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_NotifyMethods
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.NotifyMethods"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.NotifyMethods" ($args)
}
}

New-Alias gs_NotifyMethods Get-SMO_NotifyMethods -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_OSRunPriority
{
[Microsoft.SqlServer.Management.Smo.Agent.OSRunPriority]
}

New-Alias gst_OSRunPriority Get-SMOT_OSRunPriority -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_OSRunPriority
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.OSRunPriority"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.OSRunPriority" ($args)
}
}

New-Alias gs_OSRunPriority Get-SMO_OSRunPriority -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_StepCompletionAction
{
[Microsoft.SqlServer.Management.Smo.Agent.StepCompletionAction]
}

New-Alias gst_StepCompletionAction Get-SMOT_StepCompletionAction -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_StepCompletionAction
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.StepCompletionAction"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.StepCompletionAction" ($args)
}
}

New-Alias gs_StepCompletionAction Get-SMO_StepCompletionAction -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_TargetServerStatus
{
[Microsoft.SqlServer.Management.Smo.Agent.TargetServerStatus]
}

New-Alias gst_TargetServerStatus Get-SMOT_TargetServerStatus -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_TargetServerStatus
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServerStatus"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.TargetServerStatus" ($args)
}
}

New-Alias gs_TargetServerStatus Get-SMO_TargetServerStatus -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_WeekDays
{
[Microsoft.SqlServer.Management.Smo.Agent.WeekDays]
}

New-Alias gst_WeekDays Get-SMOT_WeekDays -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_WeekDays
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.WeekDays"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.Agent.WeekDays" ($args)
}
}

New-Alias gs_WeekDays Get-SMO_WeekDays -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_LinkFieldType
{
[Microsoft.SqlServer.Management.Smo.LinkFieldType]
}

New-Alias gst_LinkFieldType Get-SMOT_LinkFieldType -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_LinkFieldType
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.LinkFieldType"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.LinkFieldType" ($args)
}
}

New-Alias gs_LinkFieldType Get-SMO_LinkFieldType -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DdlTextParserHeaderInfo
{
[Microsoft.SqlServer.Management.Smo.DdlTextParserHeaderInfo]
}

New-Alias gst_DdlTextParserHeaderInfo Get-SMOT_DdlTextParserHeaderInfo -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DdlTextParserHeaderInfo
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DdlTextParserHeaderInfo"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DdlTextParserHeaderInfo" ($args)
}
}

New-Alias gs_DdlTextParserHeaderInfo Get-SMO_DdlTextParserHeaderInfo -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabasePermissionSetValue
{
[Microsoft.SqlServer.Management.Smo.DatabasePermissionSetValue]
}

New-Alias gst_DatabasePermissionSetValue Get-SMOT_DatabasePermissionSetValue -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabasePermissionSetValue
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabasePermissionSetValue"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabasePermissionSetValue" ($args)
}
}

New-Alias gs_DatabasePermissionSetValue Get-SMO_DatabasePermissionSetValue -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ObjectPermissionSetValue
{
[Microsoft.SqlServer.Management.Smo.ObjectPermissionSetValue]
}

New-Alias gst_ObjectPermissionSetValue Get-SMOT_ObjectPermissionSetValue -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ObjectPermissionSetValue
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectPermissionSetValue"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ObjectPermissionSetValue" ($args)
}
}

New-Alias gs_ObjectPermissionSetValue Get-SMO_ObjectPermissionSetValue -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerPermissionSetValue
{
[Microsoft.SqlServer.Management.Smo.ServerPermissionSetValue]
}

New-Alias gst_ServerPermissionSetValue Get-SMOT_ServerPermissionSetValue -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerPermissionSetValue
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerPermissionSetValue"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerPermissionSetValue" ($args)
}
}

New-Alias gs_ServerPermissionSetValue Get-SMO_ServerPermissionSetValue -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_EventSetBase
{
[Microsoft.SqlServer.Management.Smo.EventSetBase]
}

New-Alias gst_EventSetBase Get-SMOT_EventSetBase -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_EventSetBase
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.EventSetBase"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.EventSetBase" ($args)
}
}

New-Alias gs_EventSetBase Get-SMO_EventSetBase -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerDdlTriggerEvent
{
[Microsoft.SqlServer.Management.Smo.ServerDdlTriggerEvent]
}

New-Alias gst_ServerDdlTriggerEvent Get-SMOT_ServerDdlTriggerEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerDdlTriggerEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTriggerEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTriggerEvent" ($args)
}
}

New-Alias gs_ServerDdlTriggerEvent Get-SMO_ServerDdlTriggerEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_ServerDdlTriggerEventSet
{
[Microsoft.SqlServer.Management.Smo.ServerDdlTriggerEventSet]
}

New-Alias gst_ServerDdlTriggerEventSet Get-SMOT_ServerDdlTriggerEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_ServerDdlTriggerEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTriggerEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.ServerDdlTriggerEventSet" ($args)
}
}

New-Alias gs_ServerDdlTriggerEventSet Get-SMO_ServerDdlTriggerEventSet -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseDdlTriggerEvent
{
[Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerEvent]
}

New-Alias gst_DatabaseDdlTriggerEvent Get-SMOT_DatabaseDdlTriggerEvent -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseDdlTriggerEvent
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerEvent"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerEvent" ($args)
}
}

New-Alias gs_DatabaseDdlTriggerEvent Get-SMO_DatabaseDdlTriggerEvent -ErrorAction "SilentlyContinue" -scope "global"



function global:Get-SMOT_DatabaseDdlTriggerEventSet
{
[Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerEventSet]
}

New-Alias gst_DatabaseDdlTriggerEventSet Get-SMOT_DatabaseDdlTriggerEventSet -ErrorAction "SilentlyContinue" -scope "global"


function global:Get-SMO_DatabaseDdlTriggerEventSet
{
if($args.length -eq 0)
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerEventSet"
}
else
{
new-object "Microsoft.SqlServer.Management.Smo.DatabaseDdlTriggerEventSet" ($args)
}
}

New-Alias gs_DatabaseDdlTriggerEventSet Get-SMO_DatabaseDdlTriggerEventSet -ErrorAction "SilentlyContinue" -scope "global"


