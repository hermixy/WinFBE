' ########################################################################################
' Microsoft Windows
' Contents: GraphCtx demo
' Compiler: FreeBasic 32 & 64 bit
' Copyright (c) 2017 Jos� Roca. Freeware. Use at your own risk.
' THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
' EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
' MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
' ########################################################################################

#define UNICODE
#INCLUDE ONCE "Afx/CWindow.inc"
#INCLUDE ONCE "Afx/AfxGdiPlus.inc"
#INCLUDE ONCE "Afx/CGraphCtx.inc"
USING Afx

CONST IDC_GRCTX = 1001

DECLARE FUNCTION WinMain (BYVAL hInstance AS HINSTANCE, _
                          BYVAL hPrevInstance AS HINSTANCE, _
                          BYVAL szCmdLine AS ZSTRING PTR, _
                          BYVAL nCmdShow AS LONG) AS LONG

   END WinMain(GetModuleHandleW(NULL), NULL, COMMAND(), SW_NORMAL)

' // Forward declaration
DECLARE FUNCTION WndProc (BYVAL hwnd AS HWND, BYVAL uMsg AS UINT, BYVAL wParam AS WPARAM, BYVAL lParam AS LPARAM) AS LRESULT

' ========================================================================================
' Main
' ========================================================================================
FUNCTION WinMain (BYVAL hInstance AS HINSTANCE, _
                  BYVAL hPrevInstance AS HINSTANCE, _
                  BYVAL szCmdLine AS ZSTRING PTR, _
                  BYVAL nCmdShow AS LONG) AS LONG

   ' // Set process DPI aware
   AfxSetProcessDPIAware

   ' // Create the main window
   DIM pWindow AS CWindow
   pWindow.Create(NULL, "CWindow GDI+ Graphic Control Skeleton", @WndProc)
   pWindow.Brush = CAST(HBRUSH, COLOR_WINDOW + 1)
   pWindow.SetClientSize(350, 250)
   pWindow.Center

   ' // Add a graphic control
   DIM pGraphCtx AS CGraphCtx = CGraphCtx(@pWindow, IDC_GRCTX, "", 0, 0, pWindow.ClientWidth, pWindow.ClientHeight)
   pGraphCtx.Clear BGR(255, 255, 255)
   ' // Initialize GDI+
   DIM token AS UINT_PTR = AfxGdipInit
   ' // Load the image

'   pGraphCtx.LoadImageFromFile($"C:\Users\Pepe\Pictures\Cole_Kyla_01.jpg")
'   pGraphCtx.LoadImageFromFile($"C:\Users\Pepe\Pictures\dita_von_teese_10.jpg")
'   pGraphCtx.CreateBitmapFromFile($"C:\Users\Pepe\Pictures\dita_von_teese_10.jpg")
'   pGraphCtx.CreateBitmapFromFile($"C:\Users\Pepe\Pictures\Cole_Kyla_01.jpg", 0, TRUE)
'   pGraphCtx.LoadImageFromRes(hInstance, "PAZ_VEGA", 30, TRUE)
   pGraphCtx.LoadImageFromRes(hInstance, "PAZ_VEGA")

   ' // Dispatch Windows events
   FUNCTION = pWindow.DoEvents(nCmdShow)

   ' // Shutdown GDI+
   IF token THEN GdiPlusShutdown token

END FUNCTION
' ========================================================================================

' ========================================================================================
' Main window callback procedure
' ========================================================================================
FUNCTION WndProc (BYVAL hwnd AS HWND, BYVAL uMsg AS UINT, BYVAL wParam AS WPARAM, BYVAL lParam AS LPARAM) AS LRESULT

   SELECT CASE uMsg

      CASE WM_COMMAND
         SELECT CASE GET_WM_COMMAND_ID(wParam, lParam)
            CASE IDCANCEL
               ' // If ESC key pressed, close the application by sending an WM_CLOSE message
               IF GET_WM_COMMAND_CMD(wParam, lParam) = BN_CLICKED THEN
                  SendMessageW hwnd, WM_CLOSE, 0, 0
                  EXIT FUNCTION
               END IF
         END SELECT

      CASE WM_SIZE
         ' // If the window isn't minimized, resize it
         IF wParam <> SIZE_MINIMIZED THEN
            DIM pWindow AS CWindow PTR = AfxCWindowPtr(hwnd)
            IF pWindow THEN pWindow->MoveWindow GetDlgItem(hwnd, IDC_GRCTX), 0, 0, pWindow->ClientWidth, pWindow->ClientHeight, CTRUE
         END IF

    	CASE WM_DESTROY
         ' // End the application
         PostQuitMessage(0)
         EXIT FUNCTION

   END SELECT

   ' // Default processing of Windows messages
   FUNCTION = DefWindowProcW(hWnd, uMsg, wParam, lParam)

END FUNCTION
' ========================================================================================
