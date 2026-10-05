from fastapi import FastAPI
from routes import products, stock, reports

app = FastAPI(title="WMS API")
app.include_router(products.router, prefix="/products")
app.include_router(stock.router, prefix="/stock")
app.include_router(reports.router, prefix="/reports")

@app.get("/health")
def health(): return {"status": "ok"}
