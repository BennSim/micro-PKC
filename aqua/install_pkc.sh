#!/usr/bin/env bash

set -ex

BASE_EXTENSIONS="CategoryTree,Cite,CiteThisPage,ConfirmEdit,EmbedVideo,Gadgets,ImageMap,InputBox,Interwiki,LocalisationUpdate,MultimediaViewer,Nuke,OATHAuth,PageImages,ParserFunctions,PDFEmbed,PdfHandler,Poem,Renameuser,ReplaceText,Scribunto,SecureLinkFixer,SpamBlacklist,SyntaxHighlight_GeSHi,TemplateData,TextExtracts,TitleBlacklist,WikiEditor"
EXTENSIONS="$BASE_EXTENSIONS,PDFEmbed,DataAccounting"
# TODO install intersection extension
# --quiet
# --wiki=domain_id
# Use --dbpassfile and --passfile for higher security
php maintenance/install.php --server="http://localhost:9352" \
                --dbuser=wikiuser \
                --dbpass=example \
                --dbname=my_wiki \
                --dbserver="database:3306" \
                --pass=metalanguage \
                --skins=Medik \
                --with-extensions="$EXTENSIONS" \
                --scriptpath="" \
                "Personal Knowledge Container" \
                "Admin"

# Extend settings
cat aqua/extraAquaSettings.txt >> LocalSettings.php

# Update sidebar
php maintenance/edit.php -s "Use PKC sidebar" -u Admin MediaWiki:Sidebar < aqua/sidebar.wiki

# Populate a page
php maintenance/edit.php -a -u Admin "Moore's Law" < aqua/MooresLaw.wiki