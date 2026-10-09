pragma Singleton
import Quickshell
import QtQuick

// Generado por themes/generate.py — NO editar a mano.
Scope {
    function base(fam, dark): var {
if (fam === "abyss-blue") {
    if (dark)
        return { bg: "#021024", side: "#010913", thumb: "#052659", text: "#C1E8FF", main: "#7DA0CA", muted: "#5E84AD", blue: "#7DA0CA", green: "#5483B3", yellow: "#C1E8FF", red: "#4A7BA8", violet: "#9ABEDD" };
    return { bg: "#C1E8FF", side: "#A9CCE8", thumb: "#A9CCE8", text: "#021024", main: "#052659", muted: "#4E6E96", blue: "#16406E", green: "#2F5D8A", yellow: "#5B7FA6", red: "#0B2F57", violet: "#3E6E9E" };
}
if (fam === "forest-green") {
    if (dark)
        return { bg: "#051F20", side: "#020E0F", thumb: "#0B2B26", text: "#DAF1DE", main: "#BEB69B", muted: "#7BA493", blue: "#9DC4B0", green: "#BEB69B", yellow: "#DAF1DE", red: "#5E8A7A", violet: "#8AB5A3" };
    return { bg: "#DAF1DE", side: "#C2DCC7", thumb: "#C2DCC7", text: "#051F20", main: "#0B2B26", muted: "#4E7367", blue: "#163832", green: "#235347", yellow: "#4A7A62", red: "#0B2B26", violet: "#386153" };
}
if (fam === "violet-haze") {
    if (dark)
        return { bg: "#49225B", side: "#2A1237", thumb: "#6E3482", text: "#F5EBFA", main: "#E7DBEF", muted: "#B48AC9", blue: "#A56ABD", green: "#C49BD8", yellow: "#F5EBFA", red: "#8A4FA3", violet: "#D0B3E3" };
    return { bg: "#F5EBFA", side: "#E7DBEF", thumb: "#E7DBEF", text: "#2A1237", main: "#49225B", muted: "#7E5A94", blue: "#49225B", green: "#6E3482", yellow: "#8A68A8", red: "#331640", violet: "#7A4E94" };
}
if (fam === "holst-red") {
    if (dark)
        return { bg: "#4B0F1E", side: "#24060E", thumb: "#6D1D32", text: "#F7D6DC", main: "#E07A94", muted: "#C06A80", blue: "#E07A94", green: "#CC5671", yellow: "#F7D6DC", red: "#B23C59", violet: "#D98AA0" };
    return { bg: "#F7D6DC", side: "#EAC0C7", thumb: "#EAC0C7", text: "#2E0812", main: "#4B0F1E", muted: "#8A5560", blue: "#4B0F1E", green: "#6D1D32", yellow: "#8E4A5A", red: "#2E0812", violet: "#8E2B44" };
}
if (fam === "holst-amber") {
    if (dark)
        return { bg: "#2A2206", side: "#1A1504", thumb: "#5A4A0D", text: "#FFF3D8", main: "#F3D789", muted: "#D0A94E", blue: "#F3D789", green: "#E8B84A", yellow: "#FFF3D8", red: "#CC961F", violet: "#DDBB6A" };
    return { bg: "#FFF3D8", side: "#F0DC9F", thumb: "#F0DC9F", text: "#2A2206", main: "#5A4A0D", muted: "#8A6E22", blue: "#5A4A0D", green: "#7A5E12", yellow: "#8A6E22", red: "#2A2206", violet: "#A67917" };
}
if (fam === "mono") {
    if (dark)
        return { bg: "#06151E", side: "#02090D", thumb: "#2A3438", text: "#FFFFFF", main: "#D6D6D6", muted: "#898A8C", blue: "#D6D6D6", green: "#9AA0A2", yellow: "#FFFFFF", red: "#7E8587", violet: "#B8BDC0" };
    return { bg: "#FFFFFF", side: "#D6D6D6", thumb: "#D6D6D6", text: "#06151E", main: "#2A3438", muted: "#6E7375", blue: "#06151E", green: "#2E383C", yellow: "#545A5B", red: "#1A2A33", violet: "#3E4A50" };
}
if (fam === "sakura") {
    if (dark)
        return { bg: "#240B0E", side: "#150608", thumb: "#4A222B", text: "#FFDADD", main: "#FAA3AF", muted: "#B07A86", blue: "#C9CCEC", green: "#FAA3AF", yellow: "#FFDADD", red: "#E07A94", violet: "#C48A99" };
    return { bg: "#FFDADD", side: "#EFC2C8", thumb: "#EFC2C8", text: "#240B0E", main: "#5A2E38", muted: "#8A6470", blue: "#4A5A9E", green: "#7F4D5E", yellow: "#A86A78", red: "#5A1A26", violet: "#8A4E62" };
}
    // Fallback: primera familia en dark (families valida antes).
    return { bg: "#021024", side: "#010913", thumb: "#052659", text: "#C1E8FF", main: "#7DA0CA", muted: "#5E84AD", blue: "#7DA0CA", green: "#5483B3", yellow: "#C1E8FF", red: "#4A7BA8", violet: "#9ABEDD" };
    }
}
