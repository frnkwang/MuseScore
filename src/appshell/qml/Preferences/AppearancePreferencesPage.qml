/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-CLA-applies
 *
 * MuseScore
 * Music Composition & Notation
 *
 * Copyright (C) 2021 MuseScore BVBA and others
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
import QtQuick 2.15

import MuseScore.UiComponents 1.0
import MuseScore.Preferences 1.0

import "internal"

PreferencesPage {
    id: root

    contentHeight: content.height

    AppearancePreferencesModel {
        id: appearanceModel
    }

    Component.onCompleted: {
        appearanceModel.init()
    }

    Column {
        id: content

        width: parent.width
        height: childrenRect.height

        spacing: 24

        readonly property int firstColumnWidth: 212

        StyledTextLabel {
            text: highContrastEnable.checked ? qsTrc("appshell", "High Contrast Themes") : qsTrc("appshell", "Themes")
            font: ui.theme.bodyBoldFont
        }

        CheckBox {
            id: highContrastEnable
            width: 200

            text: "Enable High-Contrast"
            onClicked: {
                checked = !checked
            }
        }

        Loader {
            sourceComponent: highContrastEnable.checked ? highContrastThemesModel : generalThemesModel
        }

        Component {
            id: generalThemesModel

            Column {
                spacing: 24

                ThemesSection {
                    width: content.width

                    themes: appearanceModel.generalThemes
                    currentThemeCode: appearanceModel.currentThemeCode

                    onThemeChangeRequested: {
                        appearanceModel.currentThemeCode = newThemeCode
                    }
                }

                AccentColorsSection {
                    width: content.width

                    colors: appearanceModel.accentColors
                    currentColorIndex: appearanceModel.currentAccentColorIndex
                    firstColumnWidth: content.firstColumnWidth

                    onAccentColorChangeRequested: {
                        appearanceModel.currentAccentColorIndex = newColorIndex
                    }
                }
            }
        }

        Component {
            id: highContrastThemesModel

            Column {
                spacing: 24

                ThemesSection {
                    width: content.width

                    themes: appearanceModel.highContrastThemes
                    currentThemeCode: appearanceModel.currentThemeCode

                    onThemeChangeRequested: {
                        appearanceModel.currentThemeCode = newThemeCode
                    }
                }

                SeparatorLine {}

                UiColorsSection {
                    width: content.width
                    firstColumnWidth: content.firstColumnWidth

                    onColorChangeRequested: {
                        appearanceModel.setNewColor(newColor, propertyName)
                    }
                }
            }
        }

        SeparatorLine {}

        UiFontSection {
            allFonts: appearanceModel.allFonts()
            currentFontIndex: appearanceModel.currentFontIndex
            bodyTextSize: appearanceModel.bodyTextSize
            firstColumnWidth: parent.firstColumnWidth

            onFontChangeRequested: {
                appearanceModel.currentFontIndex = newFontIndex
            }

            onBodyTextSizeChangeRequested: {
                appearanceModel.bodyTextSize = newBodyTextSize
            }
        }

        SeparatorLine {}

        ColorAndWallpaperSection {
            width: parent.width

            title: qsTrc("appshell", "Background")
            wallpaperDialogTitle: qsTrc("appshell", "Choose background wallpaper")
            useColor: appearanceModel.backgroundUseColor
            color: appearanceModel.backgroundColor
            wallpaperPath: appearanceModel.backgroundWallpaperPath
            wallpapersDir: appearanceModel.wallpapersDir()
            wallpaperFilter: appearanceModel.wallpaperPathFilter()
            firstColumnWidth: parent.firstColumnWidth

            onUseColorChangeRequested: {
                appearanceModel.backgroundUseColor = newValue
            }

            onColorChangeRequested: {
                appearanceModel.backgroundColor = newColor
            }

            onWallpaperPathChangeRequested: {
                appearanceModel.backgroundWallpaperPath = newWallpaperPath
            }
        }

        SeparatorLine {}

        ColorAndWallpaperSection {
            width: parent.width

            title: qsTrc("appshell", "Paper")
            wallpaperDialogTitle: qsTrc("appshell", "Choose Notepaper")
            useColor: appearanceModel.foregroundUseColor
            color: appearanceModel.foregroundColor
            wallpaperPath: appearanceModel.foregroundWallpaperPath
            wallpapersDir: appearanceModel.wallpapersDir()
            wallpaperFilter: appearanceModel.wallpaperPathFilter()
            firstColumnWidth: parent.firstColumnWidth

            onUseColorChangeRequested: {
                appearanceModel.foregroundUseColor = newValue
            }

            onColorChangeRequested: {
                appearanceModel.foregroundColor = newColor
            }

            onWallpaperPathChangeRequested: {
                appearanceModel.foregroundWallpaperPath = newWallpaperPath
            }
        }

        FlatButton {
            text: qsTrc("appshell", "Reset Theme to Default")

            onClicked: {
                appearanceModel.resetThemeToDefault()
            }

        }
    }
}
