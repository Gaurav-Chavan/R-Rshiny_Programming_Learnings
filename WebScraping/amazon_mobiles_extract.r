# Install Missing Packages ----

library(pacman)

pacman::p_install(package = c("rvest","xml2","selectr"))


library(xml2)
library(rvest)
library(jsonlite)
library(stringr)
library(selectr)



# Scraping Mi Data ----

url_list <- c(
  "https://www.amazon.in/Redmi-Pro-Gold-32GB-Storage/dp/B07DJHV6S7/ref=sr_1_4?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-4",
  "https://www.amazon.in/Redmi-Pro-Black-32GB-Storage/dp/B07DJL15QT/ref=sr_1_3?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-3",
  "https://www.amazon.in/Redmi-Pro-Blue-64GB-Storage/dp/B07DJHR5DY/ref=sr_1_2?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-2",
  "https://www.amazon.in/Redmi-Black-3GB-64GB-Storage/dp/B07R9RSB2T/ref=sr_1_1?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-1",
  "https://www.amazon.in/Redmi-Pro-Gold-32GB-Storage/dp/B07DJHV6S7/ref=sr_1_4?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-4",
  "https://www.amazon.in/Mi-A2-Red-64GB-Storage/dp/B077PWJ8RX/ref=sr_1_5?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-5",
  "https://www.amazon.in/Xiaomi-Redmi-Pro-Rose-Storage/dp/B07QSK5G28/ref=sr_1_6?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-6",
  "https://www.amazon.in/Redmi-Rose-Gold-64GB-Storage/dp/B07QR45666/ref=sr_1_7?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-7",
  "https://www.amazon.in/Note-Pro-Neptune-Blue-64GB/dp/B07W31CP3K/ref=sr_1_8?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-8",
  "https://www.amazon.in/Redmi-Pro-Red-32GB-Storage/dp/B07DJCJB4G/ref=sr_1_9?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-9",
  "https://www.amazon.in/Mi-A2-Black-64GB-Storage/dp/B077PW9VBW/ref=sr_1_10?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-10",
  "https://www.amazon.in/Mi-A2-Blue-64GB-Storage/dp/B07DJCJ9VN/ref=sr_1_11?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-11",
  "https://www.amazon.in/Mi-Redmi-Note-7S-Sapphire/dp/B07S7DMG1R/ref=sr_1_12?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-12",
  "https://www.amazon.in/Xiaomi-Redmi-Note-Pro-Storage/dp/B07BJZJWBK/ref=sr_1_13?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&smid=A2JRT5V3UPLILP&sr=1-13",
  "https://www.amazon.in/Redmi-Gold-3GB-64GB-Storage/dp/B07R7GR49F/ref=sr_1_14?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-14",
  "https://www.amazon.in/Redmi-Blue-3GB-64GB-Storage/dp/B07R4DTM3W/ref=sr_1_15?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-15",
  "https://www.amazon.in/Note-Pro-Space-Black-64GB/dp/B07VWXLFQM/ref=sr_1_16?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-16",
  "https://www.amazon.in/Mi-Redmi-Note-Sapphire-Blue/dp/B07SGKM1YQ/ref=sr_1_17?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-17",
  "https://www.amazon.in/Redmi-Pro-Blue-32GB-Storage/dp/B07DJD229S/ref=sr_1_19?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-19",
  "https://www.amazon.in/Redmi-Note-Pro-64GB-Gold/dp/B07CNLVQH6/ref=sr_1_20?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-20",
  "https://www.amazon.in/Redmi-Note-Onyx-Black-RAM/dp/B07SHGQ5F5/ref=sr_1_21?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-21",
  "https://www.amazon.in/Mi-Redmi-Note-7S-Black/dp/B07SFH3FFV/ref=sr_1_23?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-23",
  "https://www.amazon.in/Mi-A2-Gold-128GB-Storage/dp/B07DJCN7C4/ref=sr_1_24?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569145915&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-24",
  "https://www.amazon.in/Redmi-Pro-Blue-32GB-Storage/dp/B07DJD229S/ref=sr_1_25?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-25",
  "https://www.amazon.in/Mi-Redmi-Note-Ruby-32GB/dp/B07SMVNCFJ/ref=sr_1_26?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobile",
  "https://www.amazon.in/Mi-A2-Black-128GB-Storage/dp/B07DJHZD1W/ref=sr_1_27?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-27",
  "https://www.amazon.in/Mi-A2-Gold-64GB-Storage/dp/B07DJHWT5V/ref=sr_1_28?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-28",
  "https://www.amazon.in/Redmi-Note-Pro-64GB-Storage/dp/B07K4952R3/ref=sr_1_30?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-30",
  "https://www.amazon.in/Redmi-5-Rose-Gold-64GB/dp/B077PWBGRD/ref=sr_1_31?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-31",
  "https://www.amazon.in/Mi-A2-Red-128GB-Storage/dp/B07DJD1CBT/ref=sr_1_32?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-32",
  "https://www.amazon.in/Mi-Redmi-Note-7S-64GB/dp/B07SFVY5VV/ref=sr_1_33?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-33",
  "https://www.amazon.in/Mi-A2-Blue-128GB-Storage/dp/B07DJHXX4D/ref=sr_1_34?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-34",
  "https://www.amazon.in/Redmi-Note-Pro-Black-Storage/dp/B07K4WTQ95/ref=sr_1_35?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-35",
  "https://www.amazon.in/Redmi-Grey-3GB-32GB-Storage/dp/B0756ZJ1FN/ref=sr_1_36?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-36",
  "https://www.amazon.in/Redmi-Note-Pro-Black-Storage/dp/B07FK4DNRS/ref=sr_1_37?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-37",
  "https://www.amazon.in/Renewed-Mi-Redmi-Note-Sapphire/dp/B07WR9LZMS/ref=sr_1_38?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-38",
  "https://www.amazon.in/Xiaomi-Redmi-Gold-32-RAM/dp/B07JM64RF6/ref=sr_1_39?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-39",
  "https://www.amazon.in/Renewed-Mi-Redmi-Blue-Storage/dp/B07RGWTPT6/ref=sr_1_40?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-40",
  "https://www.amazon.in/Redmi-Rose-Gold-32GB-Storage/dp/B07N3ZG6JJ/ref=sr_1_42?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-42",
  "https://www.amazon.in/Mi-A2-Rose-Gold-Storage/dp/B07DJD1RP7/ref=sr_1_44?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-44",
  "https://www.amazon.in/Mi-Redmi-4-Black-64GB/dp/B01N9J9N6A/ref=sr_1_46?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146121&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-46",
  "https://www.amazon.in/Redmi-Gold-3GB-32GB-Storage/dp/B0756Z242J/ref=sr_1_49?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-49",
  "https://www.amazon.in/Certified-REFURBISHED-Mi-Redmi-Black/dp/B07D7F583H/ref=sr_1_51?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-51",
  "https://www.amazon.in/Renewed-Redmi-Note-Ruby-64GB/dp/B07WHS74FD/ref=sr_1_52?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-52",
  "https://www.amazon.in/Redmi-Black-3GB-32GB-Storage/dp/B01NAKU5HE/ref=sr_1_54?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-54",
  "https://www.amazon.in/Renewed-Redmi-Note-Sapphire-Blue/dp/B07V9D1FR8/ref=sr_1_56?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-56",
  "https://www.amazon.in/Xiaomi-Redmi-13-84-Display-Battery/dp/B07JMZPWW2/ref=sr_1_57?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-57",
  "https://www.amazon.in/Mi-4-Redmi-Gold-32GB/dp/B01MU2AWLB/ref=sr_1_58?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-58",
  "https://www.amazon.in/Certified-REFURBISHED-Redmi-Note-Pro/dp/B07H8HP1CQ/ref=sr_1_61?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-61",
  "https://www.amazon.in/Certified-REFURBISHED-Mi-Redmi-Y1/dp/B07C415VR2/ref=sr_1_68?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-68",
  "https://www.amazon.in/Redmi-Y2-Gold-32GB-Storage/dp/B077PWB22Y/ref=sr_1_70?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146255&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-70",
  "https://www.amazon.in/Mi-Redmi-4-Gold-64GB/dp/B01NAKU37U/ref=sr_1_75?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146318&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-75",
  "https://www.amazon.in/Redmi-Note-64GB-Rose-Gold/dp/B07CNWM857/ref=sr_1_77?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146318&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-77",
  "https://www.amazon.in/Renewed-Redmi-MZB6386IN-Gold-Storage/dp/B07JP4GLG6/ref=sr_1_79?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146318&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-79",
  "https://www.amazon.in/Redmi-Y1-Lite-Grey-16GB/dp/B0756RCTKL/ref=sr_1_82?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146318&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-82",
  "https://www.amazon.in/Mi-Redmi-Note-Black-64GB/dp/B07CZS8W5Y/ref=sr_1_85?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146318&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-85",
  "https://www.amazon.in/Mi-Redmi-Note-Pro-Storage/dp/B07F3HJKDB/ref=sr_1_87?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146318&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-87",
  "https://www.amazon.in/Mi-Redmi-Note-Gold-RAM/dp/B01N3BHBY1/ref=sr_1_96?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146318&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-96",
  "https://www.amazon.in/Mi-Redmi-Note-Gold-RAM/dp/B01N3BHBY1/ref=sr_1_99?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146374&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-99",
  "https://www.amazon.in/Redmi-Note-Pro-64GB-Storage/dp/B07K6Q5YTC/ref=sr_1_100?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146374&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-100",
  "https://www.amazon.in/Redmi-Note-4-Gold-64GB/dp/B077Q42FWN/ref=sr_1_101?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146374&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-101",
  "https://www.amazon.in/Mi-Redmi-Y2-Gold-32GB/dp/B07G57CJ6T/ref=sr_1_108?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146374&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-108",
  "https://www.amazon.in/Mi-REDMI-NOTE-BLACK-32GB/dp/B07653P9M1/ref=sr_1_116?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569146374&refinements=p_89%3AMi&rnid=3837712031&s=electronics&sr=1-116"
  
)

# Create a Data frame ---


product_data_Mi <- data.frame(ASIN = character(0),Title = character(0), Price = character(0),Feature = character(0),Description = character(0),
                              Rating = character(0), Size = character(0), Color = character(0),Description_Table = character(0),
                              stringsAsFactors = F)


for (x in url_list)
{  

#Specifying the url for desired website to be ---- 
scrappedurl <- x

#Reading the html content from ----
Amazonwebpage <- read_html(scrappedurl)




#scrape title of the product> ----
title_html <- html_nodes(Amazonwebpage, 'h1#title')
title <- html_text(title_html)
title <- str_trim(str_replace_all(title, "[\r\n]" , ""))
rm(title_html)
if(length(title)==0)
{
  title <- "-"
}

# scrape the price of the product
price_html <- html_nodes(Amazonwebpage, 'span#priceblock_ourprice') 
price <- html_text(price_html)
# remove spaces and new line
price <- str_replace_all(price,"[\r\n]" , "")
rm(price_html)
if(length(price)==0)
{
  price <- "-"
}

# scrape product description ----
desc_html <- html_nodes(Amazonwebpage, 'div#productDescription')
desc <- html_text(desc_html)

# replace new lines and spaces
desc <- str_replace_all(desc, "[\r\n\t]" , "")
desc <- str_trim(desc)
rm(desc_html)
if(length(desc)==0)
{
  desc <- "-"
}


# Scrape Product Features ----
temp1 <-  html_nodes(Amazonwebpage,'div#feature-bullets')
temp1 <- html_text(temp1)

# replace new lines and spaces
temp1 <- str_replace_all(temp1, "[\r\n\t]" , "")
temp1 <- str_trim(temp1)

if(length(temp1)==0)
{
  temp1 <- "-"
}

# scrape product rating ----
rate_html <- html_nodes(Amazonwebpage, 'span#acrPopover')
rate <- html_text(rate_html)
# remove spaces and new line
rate <- str_trim(str_replace_all(rate,"[\r\n]" , ""))
rm(rate_html)

if(length(rate)==0)
{
  rate <- "-"
}


# scrape size of the product ----
size_html <- html_nodes(Amazonwebpage, 'div#variation_size_name')
size_html <- html_nodes(size_html, 'span.selection')
size <- html_text(size_html)
rm(size_html)

if(length(size)==0)
{
  size <- "-"
}


# extract color of product
color_html <- html_nodes(Amazonwebpage, 'div#variation_color_name')
color_html <- html_nodes(color_html, 'span.selection')
color <- html_text(color_html)
rm(color_html)

if(length(color)==0)
{
  color <- "-"
}


# scrape product description table ----
desc_table_html <- html_nodes(Amazonwebpage, 'div.content.pdClearfix')
desc_table_html <- html_text(desc_table_html)
desc_table_html <- str_replace_all(desc_table_html, "[\r\n\t]" , "")
desc_table_html <- desc_table_html[1]

if(length(desc_table_html)==0)
{
  desc_table_html <- "-"
}


# Scrape ASIN Number ----
asin <- html_nodes(Amazonwebpage, 'div.pdTab')
asin <- html_text(asin)
asin <- str_replace_all(asin, "[\r\n\t]" , "")
asin <- str_trim(str_replace_all(asin, "[\r\n]" , ""))
asin <-  strtrim(asin[2],width = 10)

if(length(asin)==0)
{
  asin <- "-"
}



#Combining all the lists to form a data frame

x1 <- data.frame(ASIN = asin, Title = title, Price = price,Feature = temp1,Description = desc, 
                 Rating = rate, Size = size, Color = color,Description_Table = desc_table_html,
                 stringsAsFactors = F)

  


product_data_Mi <- rbind(product_data_Mi,x1)
rm(x1)

}


# Scraping Samsung Data ----

url_list <- c(
  
  "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=pa_sp_atf_electronics_sr_pg1_1?ie=UTF8&adId=A09527561STLU004A63O7&url=%2FSamsung-Galaxy-Ocean-Blue-32GB%2Fdp%2FB07HGH8JWQ%2Fref%3Dsr_1_1_sspa%3Fascsubtag%3D_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_%26ext_vrnc%3Dhi%26gclid%3DEAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE%26keywords%3Dmobiles%26qid%3D1569149345%26refinements%3Dp_89%253ASamsung%26rnid%3D3837712031%26s%3Delectronics%26sr%3D1-1-spons%26psc%3D1&qualifier=1569149345&id=6685969201000300&widgetName=sp_atf",
  "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=pa_sp_atf_electronics_sr_pg1_2?ie=UTF8&adId=A05919141QNJQPRN50EUM&url=%2FSamsung-Galaxy-M30-Gradation-Blue%2Fdp%2FB07HGMLBZ1%2Fref%3Dsr_1_2_sspa%3Fascsubtag%3D_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_%26ext_vrnc%3Dhi%26gclid%3DEAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE%26keywords%3Dmobiles%26qid%3D1569149345%26refinements%3Dp_89%253ASamsung%26rnid%3D3837712031%26s%3Delectronics%26sr%3D1-2-spons%26psc%3D1&qualifier=1569149345&id=6685969201000300&widgetName=sp_atf",
  "https://www.amazon.in/Samsung-Galaxy-Ocean-Blue-32GB/dp/B07HGH8JWQ/ref=sr_1_3?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-3",
  "https://www.amazon.in/Samsung-Galaxy-Charcoal-Black-64GB/dp/B07HGJFSC9/ref=sr_1_4?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-4",
  "https://www.amazon.in/Samsung-Galaxy-Charcoal-Black-32GB/dp/B07HGKHV8Y/ref=sr_1_5?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-5",
  "https://www.amazon.in/Samsung-Galaxy-M30-Gradation-Blue/dp/B07HGJJ58K/ref=sr_1_6?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-6",
  "https://www.amazon.in/Test-Exclusive-646/dp/B07HGJKDRR/ref=sr_1_7?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-7",
  "https://www.amazon.in/Samsung-Galaxy-M30-Gradation-Black/dp/B07HGH3G77/ref=sr_1_8?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-8",
  "https://www.amazon.in/Samsung-Galaxy-Ocean-Blue-64GB/dp/B07HGH3G6H/ref=sr_1_9?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-9",
  "https://www.amazon.in/Samsung-Galaxy-M30-Gradation-Blue/dp/B07HGMLBZ1/ref=sr_1_10?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-10",
  "https://www.amazon.in/Samsung-Galaxy-M30-Gradation-Black/dp/B07HGJJ57K/ref=sr_1_11?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-11",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07S6BW625/ref=sr_1_12?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-12",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXBMYCW/ref=sr_1_13?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&smid=A14CZOWI0VEHLG&sr=1-13",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07SCPB574/ref=sr_1_14?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-14",
  "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=pa_sp_mtf_electronics_sr_pg1_1?ie=UTF8&adId=A0833206386NL8BNH3TK8&url=%2FSamsung-Galaxy-Ocean-Blue-64GB%2Fdp%2FB07HGH3G6H%2Fref%3Dsr_1_15_sspa%3Fascsubtag%3D_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_%26ext_vrnc%3Dhi%26gclid%3DEAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE%26keywords%3Dmobiles%26qid%3D1569149345%26refinements%3Dp_89%253ASamsung%26rnid%3D3837712031%26s%3Delectronics%26sr%3D1-15-spons%26psc%3D1&qualifier=1569149345&id=6685969201000300&widgetName=sp_mtf",
  "https://www.amazon.in/Samsung-Galaxy-2018-Storage-Offers/dp/B07C7B89CV/ref=sr_1_16?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-16",
  "https://www.amazon.in/Samsung-Galaxy-Wireless-Earphone-Flexible/dp/B07Y2V5S66/ref=sr_1_17?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-17",
  "https://www.amazon.in/Samsung-Galaxy-Wireless-Earphone-Flexible/dp/B07Y2V8SS3/ref=sr_1_18?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-18",
  "https://www.amazon.in/Test-Exclusive-1037-with-Offer/dp/B07KXBMYDH/ref=sr_1_23?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-23",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07S7DYDPC/ref=sr_1_25?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-25",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KWX9GNH/ref=sr_1_27?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149345&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-27",
  "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=pa_sp_atf_next_electronics_sr_pg2_1?ie=UTF8&adId=A09526002B4ZEVNP56EHO&url=%2FSamsung-Galaxy-Charcoal-Black-32GB%2Fdp%2FB07HGKHV8Y%2Fref%3Dsr_1_25_sspa%3Fascsubtag%3D_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_%26ext_vrnc%3Dhi%26gclid%3DEAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE%26keywords%3Dmobiles%26qid%3D1569149460%26refinements%3Dp_89%253ASamsung%26rnid%3D3837712031%26s%3Delectronics%26sr%3D1-25-spons%26psc%3D1&qualifier=1569149460&id=7972216872568254&widgetName=sp_atf_next",
  "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=pa_sp_atf_next_electronics_sr_pg2_2?ie=UTF8&adId=A05917582M5W0QT01GS10&url=%2FSamsung-Galaxy-M30-Gradation-Black%2Fdp%2FB07HGJJ57K%2Fref%3Dsr_1_26_sspa%3Fascsubtag%3D_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_%26ext_vrnc%3Dhi%26gclid%3DEAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE%26keywords%3Dmobiles%26qid%3D1569149460%26refinements%3Dp_89%253ASamsung%26rnid%3D3837712031%26s%3Delectronics%26sr%3D1-26-spons%26psc%3D1&qualifier=1569149460&id=7972216872568254&widgetName=sp_atf_next",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXC3VHW/ref=sr_1_27?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&smid=A14CZOWI0VEHLG&sr=1-27",
  "https://www.amazon.in/Test-Exclusive-1039-with-Offer/dp/B07KWXH8FV/ref=sr_1_28?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-28",
  "https://www.amazon.in/Samsung-Guru-Music-2-Gold/dp/B07D4T3SC7/ref=sr_1_29?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-29",
  "https://www.amazon.in/Samsung-Galaxy-Max-Gold-RAM/dp/B07V4N5TV9/ref=sr_1_30?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-30",
  "https://www.amazon.in/Samsung-On7-Gold-16GB-Storage/dp/B01DDP7D6W/ref=sr_1_31?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-31",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXCK8SL/ref=sr_1_33?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-33",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PTLD8L3/ref=sr_1_34?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-34",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PSHDTFN/ref=sr_1_35?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-35",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PTKPD2J/ref=sr_1_36?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-36",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PTKPD2J/ref=sr_1_36?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-36",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PTKSK9G/ref=sr_1_37?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-37",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PRBMP7F/ref=sr_1_38?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-38",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PQ7HSCS/ref=sr_1_40?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-40",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PTKTDF6/ref=sr_1_41?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-41",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXC7WRG/ref=sr_1_43?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&smid=A14CZOWI0VEHLG&sr=1-43",
  "https://www.amazon.in/Samsung-Galaxy-Additional-Exchange-Offers/dp/B07KXC1QGW/ref=sr_1_44?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-44",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXBMFCN/ref=sr_1_45?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&smid=A14CZOWI0VEHLG&sr=1-45",
  "https://www.amazon.in/Samsung-Guru-Music-SM-B310E-Black/dp/B00KWDKL4K/ref=sr_1_46?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-46",
  "https://www.amazon.in/Samsung-Guru-Music-SM-B310E-Blue/dp/B00OFRKT1Y/ref=sr_1_47?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-47",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PSHNKP6/ref=sr_1_49?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-49",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PTLFJGL/ref=sr_1_50?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149460&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-50",
  "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=pa_sp_btf_electronics_sr_pg2_1?ie=UTF8&adId=A08330502TOPANVG6TTL6&url=%2FSamsung-Galaxy-Charcoal-Black-64GB%2Fdp%2FB07HGJFSC9%2Fref%3Dsr_1_51_sspa%3Fascsubtag%3D_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_%26ext_vrnc%3Dhi%26gclid%3DEAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE%26keywords%3Dmobiles%26qid%3D1569149460%26refinements%3Dp_89%253ASamsung%26rnid%3D3837712031%26s%3Delectronics%26sr%3D1-51-spons%26psc%3D1&qualifier=1569149460&id=7972216872568254&widgetName=sp_btf",
  "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=pa_sp_atf_next_electronics_sr_pg3_1?ie=UTF8&adId=A0592070K10H52VELERB&url=%2FSamsung-Galaxy-M30-Gradation-Black%2Fdp%2FB07HGH3G77%2Fref%3Dsr_1_49_sspa%3Fascsubtag%3D_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_%26ext_vrnc%3Dhi%26gclid%3DEAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE%26keywords%3Dmobiles%26qid%3D1569149574%26refinements%3Dp_89%253ASamsung%26rnid%3D3837712031%26s%3Delectronics%26sr%3D1-49-spons%26psc%3D1&qualifier=1569149574&id=7829984899190162&widgetName=sp_atf_next",
  "https://www.amazon.in/Samsung-Guru-Plus-SM-B110E-Black/dp/B00ZWSB32O/ref=sr_1_50?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-50",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KWX9GNJ/ref=sr_1_51?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&smid=A14CZOWI0VEHLG&sr=1-51",
  "https://www.amazon.in/Samsung-Galaxy-Core-Storage-Offers/dp/B07GWKKT27/ref=sr_1_52?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-52",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PSHQ8LY/ref=sr_1_53?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-53",
  "https://www.amazon.in/Samsung-Metro-313-SM-B313E-Grey/dp/B071V7YBDN/ref=sr_1_54?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-54",
  "https://www.amazon.in/Samsung-Metro-313-SM-B313E-Grey/dp/B071V7YBDN/ref=sr_1_54?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-54",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXBVLRJ/ref=sr_1_55?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-55",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-SM-J700F/dp/B01L6VFJ3O/ref=sr_1_57?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-57",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Samsung-Galaxy-Memory/dp/B07GPQDLMS/ref=sr_1_56?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-56",
  "https://www.amazon.in/Samsung-Metro-313-SM-B313E-Black/dp/B015GZH4TS/ref=sr_1_59?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-59",
  "https://www.amazon.in/Test-Exclusive-1041-with-Offer/dp/B07KXBXQYQ/ref=sr_1_60?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-60",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KX1L519/ref=sr_1_61?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&smid=A14CZOWI0VEHLG&sr=1-61",
  "https://www.amazon.in/Samsung-Galaxy-J4-Blue-Offer/dp/B07DG9384L/ref=sr_1_62?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-62",
  "https://www.amazon.in/Samsung-Galaxy-J4-Gold-Offer/dp/B07DGDNNZB/ref=sr_1_63?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-63",
  "https://www.amazon.in/Samsung-Guru-1200-GT-E1200-White/dp/B008IEGRYS/ref=sr_1_64?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-64",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07HG3YKGW/ref=sr_1_65?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-65",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PQ7CRBH/ref=sr_1_66?almBrandId=ctnow&ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&fpw=alm&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-66",
  "https://www.amazon.in/Samsung-Guru-Music-SM-B310E-White/dp/B00L5JVGFI/ref=sr_1_67?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-67",
  "https://www.amazon.in/Samsung-Guru-1200-Gold/dp/B07D4RXZ5J/ref=sr_1_68?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-68",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07K2FV9FK/ref=sr_1_70?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-70",
  "https://www.amazon.in/Samsung-Guru-Plus-SM-B110E-White/dp/B013UTLMNG/ref=sr_1_72?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149574&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-72",
  "https://www.amazon.in/gp/slredirect/picassoRedirect.html/ref=pa_sp_atf_next_electronics_sr_pg4_1?ie=UTF8&adId=A059163426RP7LM9WAYE2&url=%2FSamsung-Galaxy-M30-Gradation-Blue%2Fdp%2FB07HGJJ58K%2Fref%3Dsr_1_73_sspa%3Fascsubtag%3D_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_%26ext_vrnc%3Dhi%26gclid%3DEAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE%26keywords%3Dmobiles%26qid%3D1569149679%26refinements%3Dp_89%253ASamsung%26rnid%3D3837712031%26s%3Delectronics%26sr%3D1-73-spons%26psc%3D1&qualifier=1569149679&id=962690057752065&widgetName=sp_atf_next",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Charcoal-Black/dp/B07R13DS28/ref=sr_1_74?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-74",
  "https://www.amazon.in/Samsung-Galaxy-J6-Storage-Offers/dp/B07F88WT6B/ref=sr_1_75?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-75",
  "https://www.amazon.in/Samsung-Galaxy-A6-Plus-Storage/dp/B07D3HRF4K/ref=sr_1_76?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-76",
  "https://www.amazon.in/Samsung-Galaxy-Star-White-Storage/dp/B071LHJWF1/ref=sr_1_77?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-77",
  "https://www.amazon.in/Samsung-Galaxy-Core-Black-Offers/dp/B07GVXKVYN/ref=sr_1_78?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-78",
  "https://www.amazon.in/Samsung-Metro-313-SM-B313E-Gold/dp/B071H9NHD5/ref=sr_1_79?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-79",
  "https://www.amazon.in/Samsung-Galaxy-Pro-Gold-16GB/dp/B06XSK1D95/ref=sr_1_80?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-80",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07S9G661K/ref=sr_1_81?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-81",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PP2JD3V/ref=sr_1_82?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-82",
  "https://www.amazon.in/Test-Exclusive-1040-with-Offer/dp/B07KX1KWDR/ref=sr_1_83?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-83",
  "https://www.amazon.in/Samsung-Galaxy-J4-Black-Offer/dp/B07DG4V11B/ref=sr_1_84?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-84",
  "https://www.amazon.in/Samsung-Galaxy-Star-Black-Storage/dp/B0728C6FJ9/ref=sr_1_85?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-85",
  "https://www.amazon.in/Samsung-Galaxy-J6-Storage-Offers/dp/B07FBQT1S5/ref=sr_1_86?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-86",
  "https://www.amazon.in/Samsung-Galaxy-J6-Storage-Offers/dp/B07FBQT1S5/ref=sr_1_86?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-86",
  "https://www.amazon.in/Test-Exclusive-1042-with-Offer/dp/B07KX1S622/ref=sr_1_87?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-87",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-Note/dp/B079FWT6VB/ref=sr_1_88?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-88",
  "https://www.amazon.in/Samsung-Galaxy-Core-Gold-Offers/dp/B07GVT9L5W/ref=sr_1_91?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-91",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Samsung-Galaxy-Storage/dp/B07J2N2XX4/ref=sr_1_93?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-93",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Charcoal-Black/dp/B07R39G35F/ref=sr_1_94?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-94",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-ON7/dp/B06ZYYN59L/ref=sr_1_95?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-95",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-G610/dp/B075RFR8FR/ref=sr_1_97?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149679&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-97",
  "https://www.amazon.in/Samsung-Galaxy-Core-Gold-Offers/dp/B07GVT9L5W/ref=sr_1_98?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-98",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-2017-Gold/dp/B07RYT25SM/ref=sr_1_99?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-99",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Samsung-Galaxy-Storage/dp/B07J2N2XX4/ref=sr_1_100?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-100",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Charcoal-Black/dp/B07R39G35F/ref=sr_1_101?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-101",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-ON7/dp/B06ZYYN59L/ref=sr_1_102?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-102",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXC7WQZ/ref=sr_1_104?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-104",
  "https://www.amazon.in/Test-Exclusive-1038-with-Offer/dp/B07KXC7QSP/ref=sr_1_105?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-105",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07K2HZWB3/ref=sr_1_106?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-106",
  "https://www.amazon.in/Samsung-Galaxy-Black-Storage-Offers/dp/B07C7B8F6V/ref=sr_1_107?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-107",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07K5224KH/ref=sr_1_108?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-108",
  "https://www.amazon.in/Samsung-Metro-350-Gold/dp/B075P69D86/ref=sr_1_110?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-110",
  "https://www.amazon.in/Samsung-Galaxy-J8-Storage-Offers/dp/B07FH4PDHJ/ref=sr_1_112?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-112",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Without-Offer/dp/B07XVNKC4S/ref=sr_1_113?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-113",
  "https://www.amazon.in/Samsung-J120-Black/dp/B01N2YZMD7/ref=sr_1_116?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-116",
  "https://www.amazon.in/Samsung-Galaxy-J8-Storage-Offers/dp/B07DZZKBBL/ref=sr_1_117?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-117",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07K2G74CN/ref=sr_1_118?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-118",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXCH2FP/ref=sr_1_119?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-119",
  "https://www.amazon.in/Samsung-Galaxy-Gold-Storage-Offers/dp/B0756Z2XKH/ref=sr_1_120?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149816&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-120",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-G600F/dp/B071XPV7PZ/ref=sr_1_121?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-121",
  "https://www.amazon.in/Samsung-Galaxy-J6-Storage-Offers/dp/B07F6SH9TM/ref=sr_1_122?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-122",
  "https://www.amazon.in/Samsung-Lemonade-Storage-Additional-Exchange/dp/B07K578NPF/ref=sr_1_123?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-123",
  "https://www.amazon.in/Samsung-Galaxy-Prime-Black-Offers/dp/B0773SD3JR/ref=sr_1_124?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-124",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-A5/dp/B01BVAN68A/ref=sr_1_125?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-125",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Midnight-Storage/dp/B07WG2CFYX/ref=sr_1_126?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-126",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Gold-16GB/dp/B07MP37VK2/ref=sr_1_127?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-127",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Next-Gold/dp/B078HSQFQQ/ref=sr_1_128?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-128",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXCK8S6/ref=sr_1_129?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-129",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07K2GWKJR/ref=sr_1_130?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-130",
  "https://www.amazon.in/Samsung-Galaxy-Plus-Storage-Offers/dp/B07HG2NFG8/ref=sr_1_131?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-131",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PQ7DK2N/ref=sr_1_132?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-132",
  "https://www.amazon.in/Samsung-Galaxy-A6-Plus-Storage/dp/B07D3KMSMY/ref=sr_1_133?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-133",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07PRBL6QD/ref=sr_1_135?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-135",
  "https://www.amazon.in/Renewed-Samsung-Storage-Additional-Exchange/dp/B07V2BHXGN/ref=sr_1_137?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-137",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07K2H2V2L/ref=sr_1_139?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-139",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-SM-G610FZKOINS/dp/B07BQB9JSY/ref=sr_1_141?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-141",
  "https://www.amazon.in/Samsung-J120-Gold/dp/B01N2YWOTC/ref=sr_1_142?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-142",
  "https://www.amazon.in/Renewed-Samsung-Storage-Additional-Exchange/dp/B07XP9RH67/ref=sr_1_144?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-144",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-G900FGold-Copper/dp/B01EHULDXQ/ref=sr_1_143?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569149916&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-143",
  "https://www.amazon.in/Samsung-Lemonade-Storage-Additional-Exchange/dp/B07K4V11Y8/ref=sr_1_147?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-147",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-Note/dp/B079G1PGMP/ref=sr_1_148?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-148",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Samsung-Galaxy-Storage/dp/B07J338XSH/ref=sr_1_149?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-149",
  "https://www.amazon.in/Samsung-Galaxy-Black-64GB-Storage/dp/B07QDC8G6L/ref=sr_1_150?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-150",
  "https://www.amazon.in/Samsung-Ceramic-Storage-Additional-Exchange/dp/B07KXCXRLM/ref=sr_1_151?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-151",
  "https://www.amazon.in/Samsung-Galaxy-J4-Gold-Offer/dp/B07DG73QFS/ref=sr_1_152?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-152",
  "https://www.amazon.in/Samsung-Galaxy-Plus-Storage-Offers/dp/B07HG6DQ18/ref=sr_1_154?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-154",
  "https://www.amazon.in/Samsung-Galaxy-Black-16GB-Offers/dp/B0773SX5X9/ref=sr_1_155?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-155",
  "https://www.amazon.in/Samsung-Galaxy-A6-Plus-Storage/dp/B07D3L7STV/ref=sr_1_156?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-156",
  "https://www.amazon.in/Samsung-Galaxy-C9-Pro-Black/dp/B01N7VRPZM/ref=sr_1_158?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-158",
  "https://www.amazon.in/Samsung-Galaxy-2016-SM-J710F-Black/dp/B01J14O9K2/ref=sr_1_159?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-159",
  "https://www.amazon.in/Samsung-Galaxy-J8-Storage-Offers/dp/B07F1232ZL/ref=sr_1_160?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-160",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-SM-J700F/dp/B01HG9CL8G/ref=sr_1_161?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-161",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXC7QS4/ref=sr_1_162?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-162",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXC7QRS/ref=sr_1_163?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-163",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Samsung-Galaxy-Blue/dp/B07J2MT7VT/ref=sr_1_164?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-164",
  "https://www.amazon.in/Samsung-Galaxy-Prime-Gold-32GB/dp/B071VTHKQ6/ref=sr_1_165?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-165",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-J730G/dp/B078G8G7XD/ref=sr_1_166?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-166",
  "https://www.amazon.in/Samsung-Galaxy-J6-Storage-Offers/dp/B07F6ZK6NL/ref=sr_1_167?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150031&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-167",
  "https://www.amazon.in/Samsung-Galaxy-J6-Storage-Offers/dp/B07DB85QZ3/ref=sr_1_169?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-169",
  "https://www.amazon.in/Samsung-Navy-Blue-Storage-Offers/dp/B078WRWJ6P/ref=sr_1_170?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-170",
  "https://www.amazon.in/Samsung-Galaxy-Midnight-Storage-Offers/dp/B071HWTHBF/ref=sr_1_175?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-175",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Storage-Without/dp/B07T31D79H/ref=sr_1_178?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-178",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Samsung-Galaxy-A6/dp/B07J35X5PP/ref=sr_1_179?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-179",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07K4VNZ81/ref=sr_1_181?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-181",
  "https://www.amazon.in/Samsung-Galaxy-Pro-Black-64GB/dp/B0744Q5VFV/ref=sr_1_182?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-182",
  "https://www.amazon.in/Samsung-Galaxy-Plus-Storage-Offers/dp/B07HGDGGSH/ref=sr_1_184?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-184",
  "https://www.amazon.in/Renewed-Samsung-Storage-Additional-Exchange/dp/B07SZFYSK8/ref=sr_1_185?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-185",
  "https://www.amazon.in/Samsung-Galaxy-J6-Storage-Offers/dp/B07FC24CLM/ref=sr_1_186?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-186",
  "https://www.amazon.in/Samsung-Midnight-Storage-Additional-Exchange/dp/B07JMTYMN1/ref=sr_1_187?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-187",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Storage-Without/dp/B07T1DTCDL/ref=sr_1_191?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150115&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-191",
  "https://www.amazon.in/Samsung-Galaxy-A7-SM-A710FZDFINS-Gold/dp/B01CMBQCAQ/ref=sr_1_193?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-193",
  "https://www.amazon.in/Samsung-Galaxy-Black-Storage-Offers/dp/B07HG6DQ17/ref=sr_1_194?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-194",
  "https://www.amazon.in/REFURBISHED-Samsung-Galaxy-A8-4G/dp/B01BVANG9O/ref=sr_1_195?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-195",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Storage-Offers/dp/B07JJLN72C/ref=sr_1_196?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-196",
  "https://www.amazon.in/Samsung-Galaxy-Note-Ocean-Blue/dp/B07HBF3M1K/ref=sr_1_197?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-197",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Storage-Without/dp/B07RZKKV36/ref=sr_1_199?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-199",
  "https://www.amazon.in/Samsung-Galaxy-Pro-Gold-64GB/dp/B0744NGTC3/ref=sr_1_201?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-201",
  "https://www.amazon.in/Certified-REFURBISHED-Samsung-Galaxy-J5/dp/B0744RKP2G/ref=sr_1_202?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-202",
  "https://www.amazon.in/Samsung-Galaxy-Navy-Blue-64GB/dp/B01LXMHNMQ/ref=sr_1_203?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-203",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07KXBVLRW/ref=sr_1_204?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-204",
  "https://www.amazon.in/Samsung-Galaxy-Black-128GB-Storage/dp/B07QDC8G3H/ref=sr_1_205?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-205",
  "https://www.amazon.in/Samsung-Galaxy-Purple-Storage-Offers/dp/B07CSH8NHK/ref=sr_1_206?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-206",
  "https://www.amazon.in/Samsung-Galaxy-J4-Blue-Offer/dp/B07DGDMQ4Z/ref=sr_1_207?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-207",
  "https://www.amazon.in/Samsung-Galaxy-Note-Midnight-Storage/dp/B07G8BNVDB/ref=sr_1_208?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-208",
  "https://www.amazon.in/Samsung-Galaxy-Note-Metallic-Storage/dp/B07G7WVMXD/ref=sr_1_209?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-209",
  "https://www.amazon.in/Samsung-Gold-64GB-Memory-Offers/dp/B078WSG3N9/ref=sr_1_212?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-212",
  "https://www.amazon.in/Samsung-Galaxy-J4-Black-Offer/dp/B07DG93GGX/ref=sr_1_214?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-214",
  "https://www.amazon.in/Samsung-Galaxy-SM-G970-Canary-Yellow/dp/B07P57DS41/ref=sr_1_216?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150177&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-216",
  "https://www.amazon.in/Samsung-Galaxy-Gold-32GB-Offers/dp/B078LTKL9Q/ref=sr_1_218?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-218",
  "https://www.amazon.in/Samsung-Galaxy-J7-Prime-Gold/dp/B07BZ129Z1/ref=sr_1_222?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-222",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Storage-Offer/dp/B07RXYNX6H/ref=sr_1_224?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-224",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-without-offers/dp/B07SD485TD/ref=sr_1_225?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-225",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Storage-Offer/dp/B07Q5Y7CRY/ref=sr_1_226?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-226",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-A6-Without/dp/B07R5V5TFD/ref=sr_1_227?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-227",
  "https://www.amazon.in/Samsung-Galaxy-Coral-Storage-Offers/dp/B07C9Y8TSW/ref=sr_1_229?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-229",
  "https://www.amazon.in/Samsung-Galaxy-SM-G960FZBDINS-Without-Offers/dp/B07HC3JRXC/ref=sr_1_231?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-231",
  "https://www.amazon.in/Samsung-Z300H-Tizen-Z3/dp/B0189IBE5Y/ref=sr_1_232?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-232",
  "https://www.amazon.in/Samsung-Galaxy-J7-Duo-Storage/dp/B07C7YD6L6/ref=sr_1_233?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-233",
  "https://www.amazon.in/Samsung-Galaxy-Storage-Additional-Exchange/dp/B07K4V9GSN/ref=sr_1_234?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-234",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Samsung-Galaxy-Offer/dp/B07J33LZ8L/ref=sr_1_236?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-236",
  "https://www.amazon.in/Samsung-Galaxy-Note-Midnight-Black/dp/B07HBFQD9M/ref=sr_1_238?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-238",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Samsung-Galaxy-Orchid/dp/B07GFJN95R/ref=sr_1_239?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150381&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-239",
  "https://www.amazon.in/Samsung-Galaxy-Grand-Prime-SM-G530H/dp/B00O30T5VI/ref=sr_1_258?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150484&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-258",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Storage-Without/dp/B07R6DTPK2/ref=sr_1_259?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150484&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-259",
  "https://www.amazon.in/Samsung-Galaxy-Prime-Black-32GB/dp/B071Z8PGC7/ref=sr_1_262?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150484&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-262",
  "https://www.amazon.in/Samsung-Galaxy-Edge-Pearl-White/dp/B00UTGZ6GI/ref=sr_1_265?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-265",
  "https://www.amazon.in/Samsung-Galaxy-Edge-SM-G935FZDUINS-Platinum/dp/B01D1CXCC6/ref=sr_1_268?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-268",
  "https://www.amazon.in/Samsung-Galaxy-C9-Pro-Gold/dp/B01NCZJMMY/ref=sr_1_269?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-269",
  "https://www.amazon.in/Renewed-Samsung-Storage-Additional-Exchange/dp/B07XBR9RZS/ref=sr_1_272?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-272",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-White-Storage/dp/B07VCH2PKZ/ref=sr_1_273?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-273",
  "https://www.amazon.in/Renewed-Samsung-Galaxy-Midnight-Black/dp/B07SVZDDXK/ref=sr_1_274?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-274",
  "https://www.amazon.in/Renewed-Samsung-Storage-Additional-Exchange/dp/B07WSGY1NH/ref=sr_1_277?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-277",
  "https://www.amazon.in/Samsung-SM-G965FGBDINS-Polaris-Additional-Exchange/dp/B07KWWQKKH/ref=sr_1_278?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-278",
  "https://www.amazon.in/Samsung-Galaxy-Clear-Protective-Cover/dp/B06XJ47F5M/ref=sr_1_288?ascsubtag=_k_EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE_k_&ext_vrnc=hi&gclid=EAIaIQobChMIutiuxYrk5AIVwgorCh3EeQW-EAAYASAAEgIjbPD_BwE&keywords=mobiles&qid=1569150620&refinements=p_89%3ASamsung&rnid=3837712031&s=electronics&sr=1-288"	

  
)

# Create a Data frame ---


product_data_Samsung <- data.frame(ASIN = character(0),Title = character(0), Price = character(0),Feature = character(0),Description = character(0),
                                   Rating = character(0), Size = character(0), Color = character(0),Description_Table = character(0),
                                   stringsAsFactors = F)



for (x in url_list)
{  
  
  #Specifying the url for desired website to be ---- 
  scrappedurl <- x
  
  #Reading the html content from ----
  Amazonwebpage <- read_html(scrappedurl)
  
  
  #scrape title of the product> ----
  title_html <- html_nodes(Amazonwebpage, 'h1#title')
  title <- html_text(title_html)
  title <- str_trim(str_replace_all(title, "[\r\n]" , ""))
  rm(title_html)
  if(length(title)==0)
  {
    title <- "-"
  }
  
  # scrape the price of the product
  price_html <- html_nodes(Amazonwebpage, 'span#priceblock_ourprice') 
  price <- html_text(price_html)
  # remove spaces and new line
  price <- str_replace_all(price,"[\r\n]" , "")
  rm(price_html)
  if(length(price)==0)
  {
    price <- "-"
  }
  
  # scrape product description ----
  desc_html <- html_nodes(Amazonwebpage, 'div#productDescription')
  desc <- html_text(desc_html)
  
  # replace new lines and spaces
  desc <- str_replace_all(desc, "[\r\n\t]" , "")
  desc <- str_trim(desc)
  rm(desc_html)
  if(length(desc)==0)
  {
    desc <- "-"
  }
  
  
  # Scrape Product Features ----
  temp1 <-  html_nodes(Amazonwebpage,'div#feature-bullets')
  temp1 <- html_text(temp1)
  
  # replace new lines and spaces
  temp1 <- str_replace_all(temp1, "[\r\n\t]" , "")
  temp1 <- str_trim(temp1)
  
  if(length(temp1)==0)
  {
    temp1 <- "-"
  }
  
  # scrape product rating ----
  rate_html <- html_nodes(Amazonwebpage, 'span#acrPopover')
  rate <- html_text(rate_html)
  # remove spaces and new line
  rate <- str_trim(str_replace_all(rate,"[\r\n]" , ""))
  rm(rate_html)
  
  if(length(rate)==0)
  {
    rate <- "-"
  }
  
  
  # scrape size of the product ----
  size_html <- html_nodes(Amazonwebpage, 'div#variation_size_name')
  size_html <- html_nodes(size_html, 'span.selection')
  size <- html_text(size_html)
  rm(size_html)
  
  if(length(size)==0)
  {
    size <- "-"
  }
  
  
  # extract color of product
  color_html <- html_nodes(Amazonwebpage, 'div#variation_color_name')
  color_html <- html_nodes(color_html, 'span.selection')
  color <- html_text(color_html)
  rm(color_html)
  
  if(length(color)==0)
  {
    color <- "-"
  }
  
  
  # scrape product description table ----
  desc_table_html <- html_nodes(Amazonwebpage, 'div.content.pdClearfix')
  desc_table_html <- html_text(desc_table_html)
  desc_table_html <- str_replace_all(desc_table_html, "[\r\n\t]" , "")
  desc_table_html <- desc_table_html[1]
  
  if(length(desc_table_html)==0)
  {
    desc_table_html <- "-"
  }
  
  # Scrape ASIN Number ----
  asin <- html_nodes(Amazonwebpage, 'div.pdTab')
  asin <- html_text(asin)
  asin <- str_replace_all(asin, "[\r\n\t]" , "")
  asin <- str_trim(str_replace_all(asin, "[\r\n]" , ""))
  asin <-  strtrim(asin[2],width = 10)
  
  if(length(asin)==0)
  {
    asin <- "-"
  }
  
  
  
  #Combining all the lists to form a data frame
  
  x1 <- data.frame(ASIN = asin, Title = title, Price = price,Feature = temp1,Description = desc, 
                   Rating = rate, Size = size, Color = color,Description_Table = desc_table_html, 
                   stringsAsFactors = F)
  
  
  
  product_data_Samsung <- rbind(product_data_Samsung,x1)
  rm(x1)
  
}




# Apple Data ----



url_list <- c(
  
  "https://www.amazon.in/Apple-iPhone-XR-64GB-White/dp/B07JGXM9WN/ref=sr_1_1?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-1",
  "https://www.amazon.in/Apple-iPhone-XR-64GB-Black/dp/B07JWV47JW/ref=sr_1_2?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-2",
  "https://www.amazon.in/Apple-iPhone-6S-Space-Storage/dp/B01LX3A7CC/ref=sr_1_3?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-3",
  "https://www.amazon.in/Apple-iPhone-6S-Space-Storage/dp/B01LX3A7CC/ref=sr_1_3?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-3",
  "https://www.amazon.in/Apple-iPhone-XR-64GB-RED/dp/B07JWVNKRL/ref=sr_1_4?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-4",
  "https://www.amazon.in/Apple-iPhone-Space-Grey-Storage/dp/B072LPF91D/ref=sr_1_5?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-5",
  "https://www.amazon.in/Apple-iPhone-6S-Gold-32GB/dp/B01M0CJNVL/ref=sr_1_6?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-6",
  "https://www.amazon.in/Apple-iPhone-XR-128GB-White/dp/B07JGXBK1W/ref=sr_1_7?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-7",
  "https://www.amazon.in/Apple-iPhone-Xs-64GB-Gold/dp/B07J316BT2/ref=sr_1_8?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-8",
  "https://www.amazon.in/Apple-iPhone-11-Pro-256GB/dp/B07XVLH742/ref=sr_1_9?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-9",
  "https://www.amazon.in/Apple-iPhone-Pro-Max-64GB/dp/B07XVL4L3X/ref=sr_1_10?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-10",
  "https://www.amazon.in/Apple-iPhone-Xs-256GB-Gold/dp/B07J318ZL8/ref=sr_1_11?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-11",
  "https://www.amazon.in/Apple-iPhone-6S-Silver-32GB/dp/B01LZDA8MU/ref=sr_1_12?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-12",
  "https://www.amazon.in/Apple-iPhone-Silver-64GB-Storage/dp/B0711T2L8K/ref=sr_1_13?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-13",
  "https://www.amazon.in/Apple-iPhone-Xs-512GB-Silver/dp/B07J3193GB/ref=sr_1_14?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-14",
  "https://www.amazon.in/Apple-iPhone-Xs-256GB-Space/dp/B07JVBP9B9/ref=sr_1_15?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-15",
  "https://www.amazon.in/Apple-iPhone-Xs-Max-64GB/dp/B07J3CJM4N/ref=sr_1_16?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-16",
  "https://www.amazon.in/Apple-iPhone-Plus-Rose-Gold/dp/B01LY9UQLK/ref=sr_1_17?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-17",
  "https://www.amazon.in/Apple-iPhone-7-Gold-128GB/dp/B01LWNBFFA/ref=sr_1_18?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-18",
  "https://www.amazon.in/Apple-iPhone-Xs-512GB-Gold/dp/B07J2Z9WHZ/ref=sr_1_19?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-19",
  "https://www.amazon.in/Apple-iPhone-Xs-256GB-Silver/dp/B07J3F1M5F/ref=sr_1_20?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-20",
  "https://www.amazon.in/Apple-iPhone-Xs-512GB-Space/dp/B07J3CJH8S/ref=sr_1_21?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-21",
  "https://www.amazon.in/Apple-iPhone-7-Silver-128GB/dp/B01M0JS3LM/ref=sr_1_22?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-22",
  "https://www.amazon.in/Apple-iPhone-Plus-Silver-64GB/dp/B071HWTHBJ/ref=sr_1_23?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-23",
  "https://www.amazon.in/Apple-iPhone-Plus-Rose-128GB/dp/B01LXMHIOY/ref=sr_1_24?qid=1569163146&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-24",
  "https://www.amazon.in/Apple-iPhone-Plus-Silver-256GB/dp/B071P37651/ref=sr_1_25?qid=1569163381&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-25",
  "https://www.amazon.in/Apple-iPhone-Rose-Gold-128GB/dp/B01LZ8YCVJ/ref=sr_1_26?qid=1569163381&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-26",
  "https://www.amazon.in/Apple-iPhone-Plus-Gold-128GB/dp/B01LZW9ATO/ref=sr_1_27?qid=1569163381&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-27",
  "https://www.amazon.in/Apple-iPhone-Plus-Black-Storage/dp/B01LXASAI9/ref=sr_1_28?qid=1569163381&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3AApple&s=electronics&sr=1-28"

)

# Create a Data frame ---


product_data_Apple <- data.frame(ASIN = character(0),Title = character(0), Price = character(0),Feature = character(0),Description = character(0),
                                 Rating = character(0), Size = character(0), Color = character(0),Description_Table = character(0),
                                 stringsAsFactors = F)





for (x in url_list)
{  
  
  #Specifying the url for desired website to be ---- 
  scrappedurl <- x
  
  #Reading the html content from ----
  Amazonwebpage <- read_html(scrappedurl)
  
  
  #scrape title of the product> ----
  title_html <- html_nodes(Amazonwebpage, 'h1#title')
  title <- html_text(title_html)
  title <- str_trim(str_replace_all(title, "[\r\n]" , ""))
  rm(title_html)
  if(length(title)==0)
  {
    title <- "-"
  }
  
  # scrape the price of the product
  price_html <- html_nodes(Amazonwebpage, 'span#priceblock_ourprice') 
  price <- html_text(price_html)
  # remove spaces and new line
  price <- str_replace_all(price,"[\r\n]" , "")
  rm(price_html)
  if(length(price)==0)
  {
    price <- "-"
  }
  
  # scrape product description ----
  desc_html <- html_nodes(Amazonwebpage, 'div#productDescription')
  desc <- html_text(desc_html)
  
  # replace new lines and spaces
  desc <- str_replace_all(desc, "[\r\n\t]" , "")
  desc <- str_trim(desc)
  rm(desc_html)
  if(length(desc)==0)
  {
    desc <- "-"
  }
  
  
  # Scrape Product Features ----
  temp1 <-  html_nodes(Amazonwebpage,'div#feature-bullets')
  temp1 <- html_text(temp1)
  
  # replace new lines and spaces
  temp1 <- str_replace_all(temp1, "[\r\n\t]" , "")
  temp1 <- str_trim(temp1)
  
  if(length(temp1)==0)
  {
    temp1 <- "-"
  }
  
  # scrape product rating ----
  rate_html <- html_nodes(Amazonwebpage, 'span#acrPopover')
  rate <- html_text(rate_html)
  # remove spaces and new line
  rate <- str_trim(str_replace_all(rate,"[\r\n]" , ""))
  rm(rate_html)
  
  if(length(rate)==0)
  {
    rate <- "-"
  }
  
  
  # scrape size of the product ----
  size_html <- html_nodes(Amazonwebpage, 'div#variation_size_name')
  size_html <- html_nodes(size_html, 'span.selection')
  size <- html_text(size_html)
  rm(size_html)
  
  if(length(size)==0)
  {
    size <- "-"
  }
  
  
  # extract color of product
  color_html <- html_nodes(Amazonwebpage, 'div#variation_color_name')
  color_html <- html_nodes(color_html, 'span.selection')
  color <- html_text(color_html)
  rm(color_html)
  
  if(length(color)==0)
  {
    color <- "-"
  }
  
  # scrape product description table ----
  desc_table_html <- html_nodes(Amazonwebpage, 'div.content.pdClearfix')
  desc_table_html <- html_text(desc_table_html)
  desc_table_html <- str_replace_all(desc_table_html, "[\r\n\t]" , "")
  desc_table_html <- desc_table_html[1]
  
  if(length(desc_table_html)==0)
  {
    desc_table_html <- "-"
  }
  
  # Scrape ASIN Number ----
  asin <- html_nodes(Amazonwebpage, 'div.pdTab')
  asin <- html_text(asin)
  asin <- str_replace_all(asin, "[\r\n\t]" , "")
  asin <- str_trim(str_replace_all(asin, "[\r\n]" , ""))
  asin <-  strtrim(asin[2],width = 10)
  
  if(length(asin)==0)
  {
    asin <- "-"
  }
  
  
  
  #Combining all the lists to form a data frame
  
  x1 <- data.frame(ASIN = asin,Title = title, Price = price,Feature = temp1,Description = desc, 
                   Rating = rate, Size = size, Color = color,Description_Table = desc_table_html,
                   stringsAsFactors = F)
  
  
  
  product_data_Apple <- rbind(product_data_Apple,x1)
  rm(x1)
  
}




# FOr Nokia Data ----


url_list <- c(
  
  "https://www.amazon.in/Nokia-6-1-Plus-Black-Storage/dp/B07T4VRYS8/ref=sr_1_1?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-1",
  "https://www.amazon.in/Nokia-6-1-Plus-Blue-Storage/dp/B07RJB997T/ref=sr_1_2?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-2",
  "https://www.amazon.in/Nokia-6-1-Plus-White-Storage/dp/B07TDHMDR3/ref=sr_1_3?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-3",
  "https://www.amazon.in/Nokia-3-2-Black-16GB-Storage/dp/B07SK91DZ8/ref=sr_1_4?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-4",
  "https://www.amazon.in/Nokia-3-2-Steel-32GB-Storage/dp/B07SK91QK7/ref=sr_1_5?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-5",
  "https://www.amazon.in/Nokia-4-2-Black-32GB-Storage/dp/B07RY2NR8F/ref=sr_1_6?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-6",
  "https://www.amazon.in/Nokia-5-1-Blue-32-GB/dp/B07GRFPYNJ/ref=sr_1_7?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-7",
  "https://www.amazon.in/Nokia-3-2-Black-32GB-Storage/dp/B07SG4TXQR/ref=sr_1_9?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-9",
  "https://www.amazon.in/Nokia-Storage-SanDisk-SDDDC2-064G-G46-Drives/dp/B07XPPMF2X/ref=sr_1_8?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-8",
  "https://www.amazon.in/Nokia-Storage-SanDisk-SDDDC2-064G-G46-Drives/dp/B07XJP3V46/ref=sr_1_10?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-10",
  "https://www.amazon.in/Nokia-6-1-Blue-Gold-32GB-Storage/dp/B07DDMXV9W/ref=sr_1_11?qid=1569163743&refinements=p_6%3AA14CZOWI0VEHLG%7CA1P3OPO356Q9ZB%7CA2HIN95H5BP4BL%2Cp_89%3ANokia&rnid=3837712031&s=electronics&sr=1-11",
  "https://www.amazon.in/gp/product/B072LNVPMN/ref=s9_acsd_al_bw_c_x_1_w?pf_rd_m=A1K21FY43GMZF8&pf_rd_s=merchandised-search-3&pf_rd_r=J1JV4VTR9KMWKTHSPDZP&pf_rd_t=101&pf_rd_p=9642c18d-7794-4294-89a1-b1e74a9ba12c&pf_rd_i=14306014031",
  "https://www.amazon.in/gp/product/B071Z97ZV5/ref=s9_acsd_al_bw_c_x_2_w?pf_rd_m=A1K21FY43GMZF8&pf_rd_s=merchandised-search-3&pf_rd_r=J1JV4VTR9KMWKTHSPDZP&pf_rd_t=101&pf_rd_p=9642c18d-7794-4294-89a1-b1e74a9ba12c&pf_rd_i=14306014031",
  "https://www.amazon.in/gp/product/B0714DP3BK/ref=s9_acsd_al_bw_c_x_3_w?pf_rd_m=A1K21FY43GMZF8&pf_rd_s=merchandised-search-3&pf_rd_r=J1JV4VTR9KMWKTHSPDZP&pf_rd_t=101&pf_rd_p=9642c18d-7794-4294-89a1-b1e74a9ba12c&pf_rd_i=14306014031",
  "https://www.amazon.in/gp/product/B0714DP3BJ/ref=s9_acsd_al_bw_c_x_4_w?pf_rd_m=A1K21FY43GMZF8&pf_rd_s=merchandised-search-3&pf_rd_r=J1JV4VTR9KMWKTHSPDZP&pf_rd_t=101&pf_rd_p=9642c18d-7794-4294-89a1-b1e74a9ba12c&pf_rd_i=14306014031",
  "https://www.amazon.in/gp/product/B072LNNSQQ/ref=s9_acsd_al_bw_c_x_5_w?pf_rd_m=A1K21FY43GMZF8&pf_rd_s=merchandised-search-3&pf_rd_r=J1JV4VTR9KMWKTHSPDZP&pf_rd_t=101&pf_rd_p=9642c18d-7794-4294-89a1-b1e74a9ba12c&pf_rd_i=14306014031",
  "https://www.amazon.in/Nokia-105-Black/dp/B0745BNFYV/ref=sr_1_4?keywords=Nokia&qid=1569164112&s=electronics&sr=1-4",
  "https://www.amazon.in/Nokia-106-Grey-Dual-SIM/dp/B07M92J7RC/ref=sr_1_5?keywords=Nokia&qid=1569164112&s=electronics&sr=1-5",
  "https://www.amazon.in/Nokia-105-White/dp/B0745GF6G1/ref=sr_1_6?keywords=Nokia&qid=1569164112&s=electronics&sr=1-6",
  "https://www.amazon.in/Nokia-MT000735-3310-Dark-Blue/dp/B071HTGC1R/ref=sr_1_8?keywords=Nokia&qid=1569164112&s=electronics&sr=1-8",
  "https://www.amazon.in/Nokia-6-1-Plus-White-Storage/dp/B07TDHMDR3/ref=sr_1_9?keywords=Nokia&qid=1569164112&s=electronics&sr=1-9",
  "https://www.amazon.in/Test-Exclusive-521/dp/B077Q42J32/ref=sr_1_10?keywords=Nokia&qid=1569164112&s=electronics&sr=1-10",
  "https://www.amazon.in/Nokia-105-Blue/dp/B0746HF973/ref=sr_1_11?keywords=Nokia&qid=1569164112&s=electronics&sr=1-11",
  "https://www.amazon.in/Nokia-Warm-Red-1GB-Storage/dp/B07BTLL4TR/ref=sr_1_12?keywords=Nokia&qid=1569164112&s=electronics&sr=1-12",
  "https://www.amazon.in/Nokia-150-Dual-SIM-Black/dp/B06XQYCG4B/ref=sr_1_13?keywords=Nokia&qid=1569164112&s=electronics&sr=1-13",
  "https://www.amazon.in/Nokia-2-2-2-16-Black/dp/B07ST1SG9F/ref=sr_1_14?keywords=Nokia&qid=1569164112&s=electronics&sr=1-14",
  "https://www.amazon.in/Nokia-2-1-Blue-Copper/dp/B07GKYHN3H/ref=sr_1_18?keywords=Nokia&qid=1569164112&s=electronics&sr=1-18",
  "https://www.amazon.in/Nokia-7-1_BL-Blue-64GB-Storage/dp/B07L8DZP8P/ref=sr_1_19?keywords=Nokia&qid=1569164112&s=electronics&sr=1-19",
  "https://www.amazon.in/NOKIA-105-TA-1174-DS-Blue/dp/B07WX2R5R8/ref=sr_1_20?keywords=Nokia&qid=1569164112&s=electronics&sr=1-20",
  "https://www.amazon.in/NOKIA-105-TA-1174-DS-Black/dp/B07WXW8V4X/ref=sr_1_21?keywords=Nokia&qid=1569164112&s=electronics&sr=1-21",
  "https://www.amazon.in/Nokia-Dark-Blue-1GB-Storage/dp/B07BSCSBMP/ref=sr_1_23?keywords=Nokia&qid=1569164112&s=electronics&sr=1-23",
  "https://www.amazon.in/Nokia-8110-Black/dp/B07KWLRR32/ref=sr_1_24?keywords=Nokia&qid=1569164112&s=electronics&sr=1-24",
  "https://www.amazon.in/Nokia-150-Dual-SIM-White/dp/B06XQHBLD9/ref=sr_1_25?keywords=Nokia&qid=1569164112&s=electronics&sr=1-25",
  "https://www.amazon.in/Nokia-3-1-Plus-Baltic-Storage/dp/B07JMHBMD1/ref=sr_1_26?keywords=Nokia&qid=1569164112&s=electronics&sr=1-26",
  "https://www.amazon.in/Nokia-3310-Warm-Red/dp/B071LM2K7Z/ref=sr_1_28?keywords=Nokia&qid=1569164112&s=electronics&sr=1-28",
  "https://www.amazon.in/Nokia-3310-Grey/dp/B00OEEIZKA/ref=sr_1_29?keywords=Nokia&qid=1569164241&s=electronics&sr=1-29",
  "https://www.amazon.in/Nokia-216-Grey/dp/B01MG69BWT/ref=sr_1_30?keywords=Nokia&qid=1569164241&s=electronics&sr=1-30",
  "https://www.amazon.in/Nokia-5-1-Black-32-GB/dp/B07GRJZ7HC/ref=sr_1_32?keywords=Nokia&qid=1569164241&s=electronics&sr=1-32",
  "https://www.amazon.in/Nokia-3-2-Steel-32GB-Storage/dp/B07SK91QK7/ref=sr_1_33?keywords=Nokia&qid=1569164241&s=electronics&sr=1-33",
  "https://www.amazon.in/NOKIA-105-TA-1174-DS-Pink/dp/B07WSTY64S/ref=sr_1_34?keywords=Nokia&qid=1569164241&s=electronics&sr=1-34",
  "https://www.amazon.in/Nokia-3310-Yellow/dp/B07171KTB7/ref=sr_1_35?keywords=Nokia&qid=1569164241&s=electronics&sr=1-35",
  "https://www.amazon.in/Nokia-105-Dual-SIM-Black/dp/B0746JXMWV/ref=sr_1_36?keywords=Nokia&qid=1569164241&s=electronics&sr=1-36",
  "https://www.amazon.in/Nokia-2-1-Blue-Silver/dp/B07HD43HJL/ref=sr_1_37?keywords=Nokia&qid=1569164241&s=electronics&sr=1-37",
  "https://www.amazon.in/Nokia-16ARGB01A03-8110-4G-Black/dp/B07CNXF98X/ref=sr_1_38?keywords=Nokia&qid=1569164241&s=electronics&sr=1-38",
  "https://www.amazon.in/Nokia-2-2-2-16-Steel/dp/B07T2FL5KF/ref=sr_1_39?keywords=Nokia&qid=1569164241&s=electronics&sr=1-39",
  "https://www.amazon.in/Nokia-3-2-Black-16GB-Storage/dp/B07SK91DZ8/ref=sr_1_40?keywords=Nokia&qid=1569164241&s=electronics&sr=1-40",
  "https://www.amazon.in/Nokia-5-1-Plus-Black-RAM/dp/B07LD652V8/ref=sr_1_41?keywords=Nokia&qid=1569164241&s=electronics&sr=1-41",
  "https://www.amazon.in/Nokia-2-2-Steel-3-32/dp/B07T3HBZB2/ref=sr_1_42?keywords=Nokia&qid=1569164241&s=electronics&sr=1-42",
  "https://www.amazon.in/Nokia-3-2-Black-32GB-Storage/dp/B07SG4TXQR/ref=sr_1_43?keywords=Nokia&qid=1569164241&s=electronics&sr=1-43",
  "https://www.amazon.in/Nokia-6-1-Plus-Black-64Gb/dp/B07M7PJNYJ/ref=sr_1_45?keywords=Nokia&qid=1569164241&s=electronics&sr=1-45",
  "https://www.amazon.in/Nokia-Plus-White-32GB-Storage/dp/B07M6G8PPS/ref=sr_1_46?keywords=Nokia&qid=1569164241&s=electronics&sr=1-46",
  "https://www.amazon.in/Nokia-2-2-Black-3-32/dp/B07SXBHY3H/ref=sr_1_48?keywords=Nokia&qid=1569164241&s=electronics&sr=1-48",
  "https://www.amazon.in/Nokia-3-White-Silver/dp/B073VNGBT6/ref=sr_1_50?keywords=Nokia&qid=1569164241&s=electronics&sr=1-50",
  "https://www.amazon.in/Nokia-5-1-Plus-Blue-RAM/dp/B07NT19R1V/ref=sr_1_52?keywords=Nokia&qid=1569164356&s=electronics&sr=1-52",
  "https://www.amazon.in/Nokia-3-1-Black-32GB/dp/B07GRJVZVS/ref=sr_1_53?keywords=Nokia&qid=1569164356&s=electronics&sr=1-53",
  "https://www.amazon.in/Test-Exclusive-520/dp/B077Q19RDV/ref=sr_1_61?keywords=Nokia&qid=1569164356&s=electronics&sr=1-61",
  "https://www.amazon.in/Nokia-Plus-Charcoal-32GB-Storage/dp/B07QV9X5K6/ref=sr_1_66?keywords=Nokia&qid=1569164356&s=electronics&sr=1-66",
  "https://www.amazon.in/Nokia-Original-BH-501-Wireless-Earphones/dp/B074PZSVZK/ref=sr_1_75?keywords=Nokia&qid=1569164420&s=electronics&sr=1-75",
  "https://www.amazon.in/NOKIA-Nokia-1100-Mobile-Phone/dp/B07F67FPD8/ref=sr_1_79?keywords=Nokia&qid=1569164420&s=electronics&sr=1-79",
  "https://www.amazon.in/Nokia-4-2-Black-32GB-Storage/dp/B07RY2NR8F/ref=sr_1_88?keywords=Nokia&qid=1569164420&s=electronics&sr=1-88",
  "https://www.amazon.in/Nokia-4-2-Black-32GB-Storage/dp/B07RY2NR8F/ref=sr_1_88?keywords=Nokia&qid=1569164420&s=electronics&sr=1-88",
  "https://www.amazon.in/CERTIFIED-REFURBISHED-Nokia-216-Black/dp/B07F6DKRNL/ref=sr_1_90?keywords=Nokia&qid=1569164420&s=electronics&sr=1-90",
  "https://www.amazon.in/Nokia-5-1-Plus-RAM-Black/dp/B07NTQ59SL/ref=sr_1_95?keywords=Nokia&qid=1569164420&s=electronics&sr=1-95",
  "https://www.amazon.in/Nokia-105-Dual-SIM-Blue/dp/B0745G3NB6/ref=sr_1_98?keywords=Nokia&qid=1569164420&s=electronics&sr=1-98",
  "https://www.amazon.in/Nokia-3-1-White-32GB/dp/B07GRGYTY7/ref=sr_1_114?keywords=Nokia&qid=1569164480&s=electronics&sr=1-114",
  "https://www.amazon.in/Renewed-Nokia-2-1-Blue-Silver/dp/B07KCLWQK3/ref=sr_1_116?keywords=Nokia&qid=1569164480&s=electronics&sr=1-116",
  "https://www.amazon.in/Nokia-5-1-Blue-32-GB/dp/B07GRFPYNJ/ref=sr_1_117?keywords=Nokia&qid=1569164480&s=electronics&sr=1-117",
  "https://www.amazon.in/Nokia-3-Matte-Black/dp/B072NCDTK9/ref=sr_1_119?keywords=Nokia&qid=1569164480&s=electronics&sr=1-119"
  
  
  
)

# Create a Data frame ---


product_data_Nokia <- data.frame(ASIN = character(0),Title = character(0), Price = character(0),Feature = character(0),Description = character(0),
                                 Rating = character(0), Size = character(0), Color = character(0),Description_Table = character(0),
                                 stringsAsFactors = F)





for (x in url_list)
{  
  
  #Specifying the url for desired website to be ---- 
  scrappedurl <- x
  
  #Reading the html content from ----
  Amazonwebpage <- read_html(scrappedurl)
  
  
  #scrape title of the product> ----
  title_html <- html_nodes(Amazonwebpage, 'h1#title')
  title <- html_text(title_html)
  title <- str_trim(str_replace_all(title, "[\r\n]" , ""))
  rm(title_html)
  if(length(title)==0)
  {
    title <- "-"
  }
  
  # scrape the price of the product
  price_html <- html_nodes(Amazonwebpage, 'span#priceblock_ourprice') 
  price <- html_text(price_html)
  # remove spaces and new line
  price <- str_replace_all(price,"[\r\n]" , "")
  rm(price_html)
  if(length(price)==0)
  {
    price <- "-"
  }
  
  # scrape product description ----
  desc_html <- html_nodes(Amazonwebpage, 'div#productDescription')
  desc <- html_text(desc_html)
  
  # replace new lines and spaces
  desc <- str_replace_all(desc, "[\r\n\t]" , "")
  desc <- str_trim(desc)
  rm(desc_html)
  if(length(desc)==0)
  {
    desc <- "-"
  }
  
  
  # Scrape Product Features ----
  temp1 <-  html_nodes(Amazonwebpage,'div#feature-bullets')
  temp1 <- html_text(temp1)
  
  # replace new lines and spaces
  temp1 <- str_replace_all(temp1, "[\r\n\t]" , "")
  temp1 <- str_trim(temp1)
  
  if(length(temp1)==0)
  {
    temp1 <- "-"
  }
  
  # scrape product rating ----
  rate_html <- html_nodes(Amazonwebpage, 'span#acrPopover')
  rate <- html_text(rate_html)
  # remove spaces and new line
  rate <- str_trim(str_replace_all(rate,"[\r\n]" , ""))
  rm(rate_html)
  
  if(length(rate)==0)
  {
    rate <- "-"
  }
  
  
  # scrape size of the product ----
  size_html <- html_nodes(Amazonwebpage, 'div#variation_size_name')
  size_html <- html_nodes(size_html, 'span.selection')
  size <- html_text(size_html)
  rm(size_html)
  
  if(length(size)==0)
  {
    size <- "-"
  }
  
  
  # extract color of product
  color_html <- html_nodes(Amazonwebpage, 'div#variation_color_name')
  color_html <- html_nodes(color_html, 'span.selection')
  color <- html_text(color_html)
  rm(color_html)
  
  if(length(color)==0)
  {
    color <- "-"
  }
  
  
  # scrape product description table ----
  desc_table_html <- html_nodes(Amazonwebpage, 'div.content.pdClearfix')
  desc_table_html <- html_text(desc_table_html)
  desc_table_html <- str_replace_all(desc_table_html, "[\r\n\t]" , "")
  desc_table_html <- desc_table_html[1]
  
  if(length(desc_table_html)==0)
  {
    desc_table_html <- "-"
  }
  
  # Scrape ASIN Number ----
  asin <- html_nodes(Amazonwebpage, 'div.pdTab')
  asin <- html_text(asin)
  asin <- str_replace_all(asin, "[\r\n\t]" , "")
  asin <- str_trim(str_replace_all(asin, "[\r\n]" , ""))
  asin <-  strtrim(asin[2],width = 10)
  
  if(length(asin)==0)
  {
    asin <- "-"
  }
  
  #Combining all the lists to form a data frame
  
  x1 <- data.frame(ASIN = asin, Title = title, Price = price,Feature = temp1,Description = desc, 
                   Rating = rate, Size = size, Color = color,Description_Table = desc_table_html,
                   stringsAsFactors = F)
  
  
  
  product_data_Nokia <- rbind(product_data_Nokia,x1)
  rm(x1)
  
}


Complete_Data <-  rbind(product_data_Mi,product_data_Nokia,product_data_Samsung,product_data_Apple)

write.csv(Complete_Data,"Complete_Data.csv",row.names = F)

