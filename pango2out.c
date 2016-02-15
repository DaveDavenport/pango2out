/**
 * pango2out
 *
 * MIT/X11 License
 * Copyright 2016 Qball Cow <qball@gmpclient.org>
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <stdio.h>
#include <stdlib.h>
#include <glib.h>
#include <pango/pango.h>

int main ( int argc, char **argv )
{
    GError *error = NULL;
    char *buffer = NULL;
    size_t buffer_length = 0;
    GMarkupParseContext *pc = pango_markup_parser_new ( 0 );
    while ( error == NULL && getline ( &buffer, &buffer_length, stdin) > 0 ) {
        g_markup_parse_context_parse(pc, buffer, buffer_length, &error);
    }
    free(buffer);
    buffer = NULL;
    if ( error == NULL &&  pango_markup_parser_finish ( pc, NULL, &buffer, NULL, &error)) {
        fputs(buffer, stdout);
    } else {
        fprintf(stderr, "Failed to parse input: '%s'\n",error->message);
        g_error_free(error);
    }
    g_free(buffer);
    g_markup_parse_context_free(pc);
}
