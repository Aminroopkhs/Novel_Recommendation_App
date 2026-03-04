def split_novel_text(novel):
    return {
        "tropes": novel.tropes or "",
        "genre": novel.genre or "",
        "synopsis": novel.synopsis or novel.description or ""
    }
