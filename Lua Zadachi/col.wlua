Ihandle.dlg = IupColorDlg();


IupSetAttribute(dlg, "VALUE", "128 0 255");
IupSetAttribute(dlg, "ALPHA", "142");
IupSetAttribute(dlg, "SHOWHEX", "YES");
IupSetAttribute(dlg, "SHOWCOLORTABLE", "YES");
IupSetAttribute(dlg, "TITLE", "IupColorDlg Test");
IupSetCallback(dlg, "HELP_CB", (Icallback)help_cb);

IupPopup(dlg, IUP_CURRENT, IUP_CURRENT);

if (IupGetInt(dlg, "STATUS"))
{
  printf("OK\n");
  printf("  COLOR(%s)\n", IupGetAttribute(dlg, "COLOR"));
  printf("  COLORTABLE(%s)\n", IupGetAttribute(dlg, "COLORTABLE"));
}
else
  printf("CANCEL\n");

IupDestroy(dlg);
