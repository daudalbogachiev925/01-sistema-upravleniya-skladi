from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from db import get_session

router = APIRouter()

@router.post("/movement")
def create_movement(product_id: int, cell_id: int, qty: int, kind: str,
                    db: Session = Depends(get_session)):
    db.execute("INSERT INTO movements (product_id, cell_id, qty, kind) VALUES (%s,%s,%s,%s)",
               (product_id, cell_id, qty, kind))
    if kind == 'in':
        db.execute("UPDATE stock SET qty=qty+%s WHERE product_id=%s AND cell_id=%s",
                   (qty, product_id, cell_id))
    else:
        db.execute("UPDATE stock SET qty=qty-%s WHERE product_id=%s AND cell_id=%s",
                   (qty, product_id, cell_id))
    db.commit()
    return {"status": "ok"}
