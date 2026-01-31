import pandas as pd
from sqlalchemy.orm import Session
from database import SessionLocal
from models import Novel

CSV_PATH = "data/novel.csv"  # change name if needed


def load_novels():
    db: Session = SessionLocal()

    df = pd.read_csv(CSV_PATH)

    for _, row in df.iterrows():
        novel = Novel(
            title=row["title"],
            author=row.get("author"),
            genre=row["genre"],
            tropes=row.get("tropes"),
            image_url=row.get("imageUrl"),
            synopsis=row.get("synopsis"),
            rating=str(row.get("rating")),
            rated_by=str(row.get("ratedBy"))
        )
        db.add(novel)

    db.commit()
    db.close()
    print("✅ Novels loaded successfully")


if __name__ == "__main__":
    load_novels()
