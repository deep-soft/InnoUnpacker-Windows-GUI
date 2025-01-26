; Setup script for InnoUnpacker (32 bit)
; ======================================
;  � Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

;  The contents of this file may be used under the terms of the
;  Mozilla Public License ("MPL") or
;  GNU Lesser General Public License Version 2 or later (the "LGPL")

;  Software distributed under this License is distributed on an "AS IS" basis,
;  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
;  the specific language governing rights and limitations under the License.

;  Compiles with Inno Setup 6.3.3

#define ApplicationVersion GetVersionNumbersString('..\Release\Win32\InnoUnpack.exe')
#define Year GetDateTimeString('yyyy','','')
#define ProgramName "InnoUnpacker"
#define ProgramAuthor "Dr. J. Rathlev"
#define ProgramWebURL "http://www.rathlev-home.de/?tools/progtools.html"
#define OutputFile "InnoUnpacker-setup"

[Setup]
PrivilegesRequired=admin
AppName={#ProgramName}
AppVersion={#ApplicationVersion}
AppVerName={#ProgramName} {#ApplicationVersion}
AppPublisher={#ProgramAuthor}
AppPublisherURL={#ProgramWebURL}
AppSupportURL={#ProgramWebURL}
AppUpdatesURL={#ProgramWebURL}
AppCopyright=2014-{#Year} {#ProgramAuthor}
VersionInfoVersion={#ApplicationVersion}
DefaultDirName={commonpf}\{#ProgramName}
DefaultGroupName={#ProgramName}
OutputDir=.
OutputBaseFilename={#OutputFile}
SetupIconFile=..\pack-view.ico
UninstallDisplayIcon={app}\pack-view-u.ico
WizardImageFile=WizImage-JR.bmp
WizardSmallImageFile=WizSmallImage-JR.bmp
Compression=lzma
SolidCompression=yes
ChangesAssociations=yes
ShowLanguageDialog=yes
DisableDirPage=auto
DisableProgramGroupPage=auto

[Languages]
Name: "en"; MessagesFile: compiler:Default.isl;           LicenseFile:"license-en.rtf";
Name: "de"; MessagesFile: compiler:Languages\German.isl;  LicenseFile:"license-de.rtf";
Name: "fr"; MessagesFile: compiler:Languages\French.isl;  LicenseFile:"license-fr.rtf";
Name: "it"; MessagesFile: compiler:Languages\Italian.isl; LicenseFile:"license-it.rtf";
Name: "es"; MessagesFile: compiler:Languages\Spanish.isl; LicenseFile:"license-es.rtf";

[CustomMessages]
en.FileAssoc=File associations:
en.DescContext=Add "InnoUnpacker" to context menu of exe files
en.InnoUnpack=Unpack &Inno Setup ..

fr.FileAssoc=Associations de fichiers:
fr.DescContext=Ajouter "InnoUnpacker" au menu contextuel des fichiers exe
fr.InnoUnpack=D�baller &Inno Setup ..

de.FileAssoc=Dateizuordnungem:
de.DescContext=F�ge "InnoUnpacker" zum Kontext-Men� f�r exe-Dateien hinzu
de.InnoUnpack=&Inno Setup entpacken ..

it.FileAssoc=Associazione file:
it.DescContext=Aggiungi "InnoUnpacker" al menu contestuale dei file exe
it.InnoUnpack=Decomprimi file creati con &Inno Setup ..

es.FileAssoc=Asociaciones de fichero:
es.DescContext=A�adir "InnoUnpacker" al men� contextual de ficheros exe
es.InnoUnpack=Descomprimir &Inno Setup ..

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "fileassoc"; Description: "{cm:DescContext}"; GroupDescription: "{cm:FileAssoc}"; 

[Registry]
Root: HKCR; Subkey: "{code:GetKey|EXE}\shell\InnoUnpack"; ValueType: string; ValueName: ""; ValueData: "{cm:InnoUnpack}"; Tasks: fileassoc; Flags: deletevalue
Root: HKCR; Subkey: "{code:GetKey|EXE}\shell\InnoUnpack\Command"; ValueType: string; ValueName: ""; ValueData: """{app}\InnoUnpack.exe"" ""%1"""; Tasks: fileassoc; Flags: deletevalue

[Files]
Source: "..\Release\Win32\InnoUnpack.exe"; DestDir: "{app}"; Flags: ignoreversion restartreplace
Source: "..\innounp-2\Release\innounp.exe"; DestDir: "{app}"; Flags: ignoreversion restartreplace
Source: "..\innounp-2\docs\innounp.htm"; DestDir: "{app}"; Flags: ignoreversion restartreplace
Source: "..\Release\Win32\locale\*.mo"; DestDir: "{app}\locale"; Flags: recursesubdirs ignoreversion restartreplace
Source: "..\Release\Win32\language.cfg"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion restartreplace
Source: "..\..\Common\license-*.rtf"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\InnoUnpack.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\pack-view.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\pack-view-u.ico"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#ProgramName}"; Filename: "{app}\InnoUnpack.exe"
Name: "{group}\{cm:UninstallProgram,{#ProgramName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#ProgramName}"; Filename: "{app}\InnoUnpack.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\InnoUnpack.exe"; Description: "{cm:LaunchProgram,{#ProgramName}}"; Flags: nowait postinstall runasoriginaluser

[Code]
function GetKey (Ext : String) : String;
var
  App : String;
begin
  if not RegQueryStringValue(HKEY_CLASSES_ROOT, '.'+Ext, '', App) then begin
    App:=Ext+' file';
    RegWriteStringValue(HKEY_CLASSES_ROOT, '.'+Ext, '', App);
    end;
  Result:=App;
end;

