/**
 *	基础动画面板 
 */
package blade3d.editor.effect
{
	import flash.events.Event;
	
	import org.aswing.ASColor;
	import org.aswing.BorderLayout;
	import org.aswing.JLabel;
	import org.aswing.JList;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.LayoutManager;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import org.aswing.border.LineBorder;
	import org.aswing.colorchooser.VerticalLayout;
	
	public class BlEffectAnimationPanel extends JPanel
	{
		private var _objectXML : XML;
		
		private var _leftPanel : JPanel;
		private var _rightPanel : JPanel;
		private var _actionList : JList;
		
		// 面板
		private var _pathPanel : BlEffectAnimationPathPanel;
		private var _rotPanel : BlEffectAnimationRotPanel;
		private var _scalePanel : BlEffectAnimationScalePanel;
		
		// 选择动画
		private var rotAniList : JList;
		
		
		public function BlEffectAnimationPanel()
		{
			super(new SoftBoxLayout(SoftBoxLayout.X_AXIS));
			initUI();
		}
		
		public function set srcData(objectXML:XML):void
		{
			_objectXML = objectXML;
			updateUIByData();
		}
		
		private function initUI():void
		{
			_leftPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			_leftPanel.setPreferredHeight(500);
			_leftPanel.setBorder(new LineBorder(null, ASColor.RED, 1));
			
			_rightPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			_rightPanel.setBorder(new LineBorder(null, ASColor.BLUE, 1));
			
			append(_leftPanel, BorderLayout.WEST);
			append(_rightPanel, BorderLayout.CENTER);
			
			// left
			var arr:Array = new Array;
			arr.push("位移动画");
			arr.push("旋转动画");
			arr.push("缩放动画");
			var actionListMod : VectorListModel = new VectorListModel(arr);
			_actionList = new JList(actionListMod);
			_actionList.setPreferredWidth(150);
			_actionList.addSelectionListener(onAnimationSelected);
			_leftPanel.append(_actionList);
			
			// 位移动画
			_pathPanel = new BlEffectAnimationPathPanel;
			// 旋转动画
			_rotPanel = new BlEffectAnimationRotPanel;
			// 缩放动画
			_scalePanel = new BlEffectAnimationScalePanel;
			
		}
		
		private function onAnimationSelected(evt:Event):void
		{
			_rightPanel.removeAll();
			
			var actionName:String = _actionList.getSelectedValue();
			if(!actionName) return;
			
			switch(actionName)
			{
				case "位移动画":
				{
					_rightPanel.append(_pathPanel);
					break;
				}
				case "旋转动画":
				{
					_rightPanel.append(_rotPanel);
					break;
				}
				case "缩放动画":
				{
					_rightPanel.append(_scalePanel);
					break;
				}
			}
		}
		
		private function updateUIByData():void
		{
			var path_xml : XML = _objectXML.path[0];
			if(!path_xml)
			{
				path_xml = <path/>;
				_objectXML.appendChild(path_xml);
			}
			var rotate_xml : XML = _objectXML.rotate[0];
			if(!rotate_xml)
			{
				rotate_xml = <rotate/>;
				_objectXML.appendChild(rotate_xml);
			}
			var scale_xml : XML = _objectXML.scale[0];
			if(!scale_xml)
			{
				scale_xml = <scale/>;
				_objectXML.appendChild(scale_xml);
			}
			
			_pathPanel.srcData = path_xml;
			_rotPanel.srcData = rotate_xml;
			_scalePanel.srcData = scale_xml;
		}
	}
}