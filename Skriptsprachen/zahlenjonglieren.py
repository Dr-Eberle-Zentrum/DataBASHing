import sys, argparse

parser = argparse.ArgumentParser()
parser.add_argument("method", choices=["count", "avg", "min", "max"], default="count", help="Calculation method on numbers")
args = parser.parse_args()

eingabe = sys.stdin.read().strip().splitlines()
eingabe = [float(x) for x in eingabe]

if args.method == "count":
    print("Anzahl =", len(eingabe))
elif args.method == "avg":
    print("Durchschnitt =", sum(eingabe) / len(eingabe))
elif args.method == "min":
    print("Minimum =", min(eingabe))
else:
    print("Maximum =", max(eingabe))