#!/usr/bin/env python3
import http.server
import socketserver
import webbrowser
import os
import sys

# Change to the project directory
os.chdir(r"C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest")

PORT = 3000

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

print("=" * 50)
print("    NutriQuest Demo Server")
print("=" * 50)
print(f"Starting server on port {PORT}...")
print(f"Opening browser...")
print("=" * 50)

# Open browser
webbrowser.open(f'http://localhost:{PORT}')

# Start server
with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
    print(f"Server running at http://localhost:{PORT}")
    print("Press Ctrl+C to stop the server")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped.")
        sys.exit(0)
