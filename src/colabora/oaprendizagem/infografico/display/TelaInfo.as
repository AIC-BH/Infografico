package colabora.oaprendizagem.infografico.display 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class TelaInfo extends Sprite
	{
		// VARIÁVEIS PRIVADAS
		
		private var _bg:Shape;
		private var _bgid:Bitmap;
		private var _bgnome:Bitmap;
		private var _bgsobre:Bitmap;
		private var _btok:Sprite;
		private var _sobreid:Bitmap;
		
		private var _id:TextField;
		private var _nome:TextField;
		private var _sobre:TextField;
		
		public function TelaInfo(w:Number, h:Number) 
		{
			// fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(AreaApp.CORBG);
			this._bg.graphics.drawRect(0, 0, w, h);
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// fundos
			this._bgid = Main.graficos.getGR('AreaTextoId');
			this.addChild(this._bgid);
			this._bgnome = Main.graficos.getGR('AreaTextoNome');
			this.addChild(this._bgnome);
			this._bgsobre = Main.graficos.getGR('AreaTextoSobre');
			this.addChild(this._bgsobre);
			
			// botão ok
			this._btok = Main.graficos.getSPGR('BTOk');
			this._btok.addEventListener(MouseEvent.CLICK, onOk);
			this.addChild(this._btok);
			
			// posicionando
			var intervalo:Number = (h - (this._bgid.height + this._bgnome.height + this._bgsobre.height)) / 4;
			this._bgid.x = 32;
			this._bgid.y = intervalo;
			this._bgnome.x = this._bgid.x;
			this._bgnome.y = this._bgid.y + this._bgid.height + intervalo;
			this._bgsobre.x = this._bgid.x;
			this._bgsobre.y = this._bgnome.y + this._bgnome.height + intervalo;
			this._btok.x = w - 32 - this._btok.width;
			this._btok.y = this._bgsobre.y + this._bgsobre.height - this._btok.height;
			
			// sobre id
			this._sobreid = Main.graficos.getGR('SobreID');
			this._sobreid.x = this._bgid.x + this._bgid.width + 32;
			this._sobreid.y = this._bgid.y;
			this.addChild(this._sobreid);
			
			// inputs
			var formato:TextFormat = new TextFormat('_sans', 40, 0);
			this._id = new TextField();
			this._id.defaultTextFormat = formato;
			this._id.multiline = false;
			this._id.wordWrap = false;
			this._id.type = TextFieldType.INPUT;
			this._id.needsSoftKeyboard = true;
			this.addChild(this._id);
			this._nome = new TextField();
			this._nome.defaultTextFormat = formato;
			this._nome.multiline = false;
			this._nome.wordWrap = false;
			this._nome.type = TextFieldType.INPUT;
			this._nome.needsSoftKeyboard = true;
			this.addChild(this._nome);
			this._sobre = new TextField();
			this._sobre.defaultTextFormat = formato;
			this._sobre.multiline = false;
			this._sobre.wordWrap = false;
			this._sobre.type = TextFieldType.INPUT;
			this._sobre.needsSoftKeyboard = true;
			this.addChild(this._sobre);
			
			// posicionando inputs
			this._id.x = this._bgid.x + 140;
			this._id.y = this._bgid.y + 35;
			this._id.width = 740;
			this._id.height = 80;
			this._nome.x = this._bgnome.x + 140;
			this._nome.y = this._bgnome.y + 35;
			this._nome.width = 740;
			this._nome.height = 80;
			this._sobre.x = this._bgsobre.x + 140;
			this._sobre.y = this._bgsobre.y + 35;
			this._sobre.width = 740;
			this._sobre.height = 80;
			
			// verificando a tela
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * A tela ficou disponível.
		 */
		private function onStage(evt:Event):void
		{
			// recuperando textos
			this._id.text = Main.projeto.id;
			this._nome.text = Main.projeto.titulo;
			this._sobre.text = Main.projeto.tags;
		}
		
		/**
		 * Clique no botão ok.
		 */
		private function onOk(evt:MouseEvent):void
		{
			// recuperando textos alterados
			if (this._nome.text != '') Main.projeto.titulo = this._nome.text;
			Main.projeto.tags = this._sobre.text;
			if (this._id.text != '') {
				if (this._id.text != Main.projeto.titulo) {
					var regExp:RegExp =/[:|\/|.|&|$|#|*|+|=|<|>|\\|@|%]/g;
					Main.projeto.defineID(this._id.text..replace(regExp, ''));
				}
			}
			
			// fechando tela de informações
			parent.removeChild(this);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}

}