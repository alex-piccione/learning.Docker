
type Currency = {
    code: string,
    name: string
}

const currencies:Currency[] = [
    {code: "EUR", name: "Euro"},
    {code: "GBP", name: "Pound"},
]

const CurrencyService = () => {
    return {
        list: () => currencies
    }
}

export default CurrencyService