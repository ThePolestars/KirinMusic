import QtQuick 2.0
import QtQml.Models 2.15
import QtQuick.Controls 2.15
import Clipboard 1.0
import QtGraphicalEffects 1.0


Item {
    property alias lyricText:lyricText
    property alias lyricListView:lyricListView
    property alias lyricListModel:lyricListModel
    property alias lyricDelegate:lyricDelegate
    property alias clipBoard: clipBoard


    Text {
        id: lyricText
        text: qsTr("当前无歌词")
        font.pointSize: 20
        visible: false
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        width: 300
    }
    ListView{
        id:lyricListView
        model: lyricListModel
        delegate: lyricDelegate
        anchors.fill: parent
        visible: false
        spacing: 30
        currentIndex: -1
        //固定currentItem的位置
        highlightRangeMode:ListView.ApplyRange
        preferredHighlightBegin:height/3+30
        preferredHighlightEnd: height/3+60
    }
    ListModel{
        id:lyricListModel
    }
    Component{
        id:lyricDelegate
        Text {
            id: mt
            text: currentLyrics
            width: 300
            font.pixelSize: ListView.isCurrentItem ? 25 : 18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            opacity: 0.6
            color: ListView.isCurrentItem ? "red":"black"
            onColorChanged: {
                ani.running=true
            }

            PropertyAnimation{
                id:ani
                target: mr1
                property: "width"
                from: 0
                to: m2.width
                duration: dialogs.lyricDialog.timerTest.interval>0?dialogs.lyricDialog.timerTest.interval:0
                loops: 1
                running: false
            }
            Rectangle{
                id: m2
                anchors.fill: mt
                color:"#00000000"
                Rectangle{
                    id: mr1
                    height:parent.height
                    color: "red"
                    //width是从0到m2.width
                }
                Rectangle{
                    x: mr1.width //从0到m2.width
                    height:parent.height
                    width: m2.width-mr1.width
                    color: "lightgrey"
                }
            }
            ShaderEffectSource {
                id: mask
                visible: false
                anchors.fill: mt
                hideSource : true
                sourceItem: m2
            }
            Blend {
                anchors.fill: mt
                source: mt
                foregroundSource: mask
                mode: "color"
            }
        }
    }
    Clipboard{
        id: clipBoard
    }
}
