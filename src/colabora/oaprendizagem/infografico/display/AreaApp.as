package colabora.oaprendizagem.infografico.display 
{
	import art.ciclope.data.PersistentData;
	import art.ciclope.io.FileBrowser;
	import colabora.display.AreaImagens;
	import colabora.display.EscolhaProjeto;
	import colabora.display.TelaAjuda;
	import colabora.display.TelaMensagem;
	import colabora.oaprendizagem.dados.ObjetoAprendizagem;
	import colabora.oaprendizagem.infografico.dados.Imagem;
	import colabora.oaprendizagem.infografico.dados.Pagina;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.net.navigateToURL;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class AreaApp extends Sprite
	{
		/**
		 * Largura da tela de design do app.
		 */
		public static const AREAWIDTH:int = 1280;
		
		/**
		 * Altura da tela de design do app.
		 */
		public static const AREAHEIGHT:int = 720;
		
		/**
		 * Cor do fundo da tela do app.
		 */
		public static const CORBG:int = 0xFFFFFF;
		
		/**
		 * Cor do fundo das barras de botões.
		 */
		public static const CORBARRAS:int = 0xFFFFFF;
		
		/**
		 * Tamanho dos botões.
		 */
		public static const TAMBT:int = 64;
		
		/**
		 * Referência para a imagem atual.
		 */
		public var imagem:Imagem;
		
		// VARIÁVEIS PRIVADAS
		
		private var _bg:Shape;
		
		private var _principal:Sprite;
		private var _barraInferior:BarraInferior;
		private var _barraLateral:BarraLateral;
		
		private var _propriedades:Sprite;
		private var _barraLateralProp:BarraLateralProp;
		private var _barraInferiorProp:BarraInferiorProp;
		
		private var _incluiImagem:JanelaIncluiImagem;
		private var _telaBiblioteca:TelaBiblioteca;
		private var _telaMinhasImagens:TelaMinhasImagens;
		private var _telaTexto:TelaTexto;
		private var _telaMensagem:TelaMensagem;
		private var _telaLink:TelaLink;
		private var _telaInfo:TelaInfo;
		private var _telaEscolha:EscolhaProjeto;
		private var _telaAjuda:TelaAjuda;
		
		private var _save:PersistentData;
		private var _ultimaAc:String;
		private var _navegaProjeto:File;
		private var _navegaMobile:FileBrowser;
		private var _apresentando:Boolean = false;
		
		
		public function AreaApp() 
		{
			// preparando fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(AreaApp.CORBG);
			this._bg.graphics.drawRect(0, 0, AreaApp.AREAWIDTH, AreaApp.AREAHEIGHT);
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// tela principal
			this._principal = new Sprite();
			this.addChild(this._principal);
			this._barraLateral = new BarraLateral();
			this._principal.addChild(this._barraLateral);
			this._barraInferior = new BarraInferior();
			this._barraInferior.y = AreaApp.AREAHEIGHT - this._barraInferior.height;
			this._principal.addChild(this._barraInferior);
			
			// ações da tela principal
			this._barraLateral.acMais = this.acMais;
			this._barraLateral.acPagina = this.acPagina;
			this._barraInferior.acAjuda = this.acAjuda;
			this._barraInferior.acTelaCheia = this.acTelaCheia;
			this._barraInferior.acExportar = this.acExportar;
			this._barraInferior.acInfo = this.acInfo;
			this._barraInferior.acNovo = this.acNovo;
			this._barraInferior.acSalvar = this.acSalvar;
			this._barraInferior.acAbrir = this.acAbrirPrjeto;
			this._barraInferior.acCompartilhar = this.acCompartilhar;
			this._barraInferior.acArquivos = this.acExportarProjeto;
			this._barraInferior.acReceber = this.acReceber;
			this._barraInferior.acApresentar = this.acApresentar;
			
			// tela de propriedades
			this._propriedades = new Sprite();
			this._barraLateralProp = new BarraLateralProp();
			this._propriedades.addChild(this._barraLateralProp);
			this._barraInferiorProp = new BarraInferiorProp();
			this._barraInferiorProp.y = AreaApp.AREAHEIGHT - this._barraInferiorProp.height;
			this._propriedades.addChild(this._barraInferiorProp);
			
			// ações da tela de propriedades
			this._barraLateralProp.acOk = this.acPropOk;
			this._barraLateralProp.acApaga = this.acPropApaga;
			this._barraLateralProp.acLink = this.acPropLink;
			this._barraLateralProp.acReset = this.acReset;
			this._barraLateralProp.acTexto = this.acTexto;
			this._barraInferiorProp.acTamanho = this.acTamanho;
			this._barraInferiorProp.acRotacao = this.acRotacao;
			this._barraInferiorProp.acVermelho = this.acVermelho;
			this._barraInferiorProp.acVerde = this.acVerde;
			this._barraInferiorProp.acAzul = this.acAzul;
			this._barraInferiorProp.acOrdem = this.acOrdem;
			
			// inclusão de imagens
			this._incluiImagem = new JanelaIncluiImagem();
			this._incluiImagem.addEventListener('biblioteca', onIncluiBiblioteca);
			this._incluiImagem.addEventListener('minhasimagens', onIncluiMinhasImagens);
			this._incluiImagem.addEventListener('texto', onIncluiTexto);
			
			// biblioteca de imagens
			this._telaBiblioteca = new TelaBiblioteca();
			this._telaBiblioteca.addEventListener(Event.CANCEL, onBibliotecaCancel);
			this._telaBiblioteca.addEventListener(Event.SELECT, onBibliotecaSelect);
			
			// minhas imagens
			this._telaMinhasImagens = new TelaMinhasImagens();
			this._telaMinhasImagens.addEventListener(Event.CANCEL, onMinhasImagensCancel);
			this._telaMinhasImagens.addEventListener(Event.SELECT, onMinhasImagensSelect);
			
			// texto
			this._telaTexto = new TelaTexto();
			this._telaTexto.addEventListener(Event.CANCEL, onTextoCancel);
			this._telaTexto.addEventListener(Event.SELECT, onTextoSelect);
			
			// tela de mensagens
			this._telaMensagem = new TelaMensagem(AreaApp.AREAWIDTH,
													AreaApp.AREAHEIGHT,
													Main.graficos.getSPGR('BTOk'),
													Main.graficos.getSPGR('BTCancel'),
													0xFFFFFF, 
													0xf08435);
			this._telaMensagem.addEventListener(Event.COMPLETE, onMensagemOK);
			this._telaMensagem.addEventListener(Event.CANCEL, onMensagemCancel);
			
			// tela de links
			this._telaLink = new TelaLink();
			this._telaLink.addEventListener(Event.CANCEL, onLinkCancel);
			this._telaLink.addEventListener(Event.SELECT, onLinkSelect);
			
			// informações sobre o projeto
			this._telaInfo = new TelaInfo(AreaApp.AREAWIDTH, AreaApp.AREAHEIGHT);
			this._telaInfo.addEventListener(Event.COMPLETE, onInfoComplete);
			
			// tela de escolha de projetos
			this._telaEscolha = new EscolhaProjeto('Escolha o projeto',
													Main.graficos.getSPGR('BTOk'),
													Main.graficos.getSPGR('BTCancel'),
													Main.graficos.getSPGR('BTAbrir'),
													Main.graficos.getSPGR('BTLixeira'),
													File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/projetos/' ),
													0xfbe0cc);
			this._telaEscolha.addEventListener(Event.COMPLETE, onEscolhaOK);
			this._telaEscolha.addEventListener(Event.CANCEL, onEscolhaCancel);
			this._telaEscolha.addEventListener(Event.OPEN, onEscolhaOpen);
			this._telaEscolha.addEventListener(Event.CLEAR, onEscolhaClear);
			
			// tela de ajuda
			var ajuda:Vector.<Bitmap> = new Vector.<Bitmap>();
			ajuda.push(Main.graficos.getGR('AJUDA00'));
			ajuda.push(Main.graficos.getGR('AJUDA01'));
			ajuda.push(Main.graficos.getGR('AJUDA02'));
			ajuda.push(Main.graficos.getGR('AJUDA03'));
			ajuda.push(Main.graficos.getGR('AJUDA04'));
			ajuda.push(Main.graficos.getGR('AJUDA05'));
			ajuda.push(Main.graficos.getGR('AJUDA06'));
			ajuda.push(Main.graficos.getGR('AJUDA07'));
			ajuda.push(Main.graficos.getGR('AJUDA08'));
			ajuda.push(Main.graficos.getGR('AJUDA09'));
			ajuda.push(Main.graficos.getGR('AJUDA10'));
			ajuda.push(Main.graficos.getGR('AJUDA11'));
			ajuda.push(Main.graficos.getGR('AJUDA12'));
			ajuda.push(Main.graficos.getGR('AJUDA13'));
			ajuda.push(Main.graficos.getGR('AJUDA14'));
			ajuda.push(Main.graficos.getGR('AJUDA15'));
			ajuda.push(Main.graficos.getGR('AJUDA16'));
			ajuda.push(Main.graficos.getGR('AJUDA17'));
			ajuda.push(Main.graficos.getGR('AJUDA18'));
			ajuda.push(Main.graficos.getGR('AJUDA19'));
			ajuda.push(Main.graficos.getGR('AJUDA20'));
			ajuda.push(Main.graficos.getGR('AJUDA21'));
			ajuda.push(Main.graficos.getGR('AJUDA22'));
			ajuda.push(Main.graficos.getGR('AJUDA23'));
			
			this._telaAjuda = new TelaAjuda(ajuda, Main.graficos.getSPGR('BTDireita'), Main.graficos.getSPGR('BTEsquerda'), Main.graficos.getSPGR('BTFechar'));
			this._telaAjuda.adicionaBotao(Main.graficos.getSPGR('BTHelp1'), 0);
			this._telaAjuda.adicionaBotao(Main.graficos.getSPGR('BTHelp2'), 17);
			this._telaAjuda.adicionaBotao(Main.graficos.getSPGR('BTHelp3'), 22);
			
			// tela de compartilhamento
			ObjetoAprendizagem.compartilhamento.addEventListener(Event.CLOSE, onCompartilhamentoClose);
			ObjetoAprendizagem.compartilhamento.addEventListener(Event.COMPLETE, onCompartilhamentoComplete);
			
			// navegação para importar projeto
			this._navegaProjeto = File.documentsDirectory;
			this._navegaProjeto.addEventListener(Event.SELECT, onNavegadorPSelect);
			this._navegaProjeto.addEventListener(Event.CANCEL, onNavegadorPFim);
			this._navegaProjeto.addEventListener(IOErrorEvent.IO_ERROR, onNavegadorPFim);
			
			// navegação de importação em aparelhos móveis
			this._navegaMobile = new FileBrowser(Main.graficos.getSPGR('BTOk'), Main.graficos.getSPGR('BTCancel'), 0xfbe0cc);
			this._navegaMobile.addEventListener(Event.COMPLETE, onNavegadorMobSelect);
			this._navegaMobile.addEventListener(Event.CANCEL, onNavegadorMobFim);
			
			// importação de projetos
			Main.projeto.addEventListener(Event.CANCEL, onImportCancel);
			Main.projeto.addEventListener(Event.COMPLETE, onImportComplete);
			
			// preparando área de conteúdo
			Main.conteudo = new AreaImagens(1920, 1080, 0x333333);
			Main.conteudo.fitOnArea(new Rectangle((1.75 * AreaApp.TAMBT), (0.25 * AreaApp.TAMBT), (AreaApp.AREAWIDTH - (2 * AreaApp.TAMBT)), (AreaApp.AREAHEIGHT - (2 * AreaApp.TAMBT))));
			this.addChild(Main.conteudo);
			
			// verificando a adição de imagens
			Main.projeto.addEventListener(Event.ADDED, onImComplete);
			
			// dados persistentes
			this._save = new PersistentData(ObjetoAprendizagem.codigo);
			if (this._save.isSet('ultimo')) {
				if (Main.projeto.carregaProjeto(this._save.getValue('ultimo'))) {
					Main.projeto.paginaAtual = 0;
					this.mostraDisplay();
				}
			}
			
			// criar primeira página?
			if (Main.projeto.paginas.length == 0) Main.projeto.adicionaPagina();
			
			// atualiza número da página
			this._barraLateral.atualiza();
			
		}
		
		// FUNÇÕES PÚBLICAS
		
		/**
		 * Posiciona a área do app na tela.
		 */
		public function posiciona():void
		{
			if (this.stage) {
				// definindo o novo tamanho
				var newWidth:Number = this.stage.stageWidth;
				var newHeight:Number = AreaApp.AREAHEIGHT * (newWidth / AreaApp.AREAWIDTH);
				if (newHeight > this.stage.stageHeight) {
					newHeight = this.stage.stageHeight;
					newWidth = AreaApp.AREAWIDTH * (newHeight / AreaApp.AREAHEIGHT);
				}
				this.scaleX = this.scaleY = newWidth / AreaApp.AREAWIDTH;
				// posicionando
				this.x = (this.stage.stageWidth - newWidth) / 2;
				this.y = (this.stage.stageHeight - newHeight) / 2;
			}
		}
		
		/**
		 * Salva projeto atual e guarda referência para abrir novamente no futuro.
		 */
		public function salvar():void
		{
			Main.projeto.salvar();
			this._save.setValue('ultimo', Main.projeto.id);
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * Incluindo imagem a partir da biblioteca.
		 */
		private function onIncluiBiblioteca(evt:Event):void
		{
			this.removeChild(this._principal);
			this.stage.addChild(this._telaBiblioteca);
		}
		
		/**
		 * Incluindo imagem própria.
		 */
		private function onIncluiMinhasImagens(evt:Event):void
		{
			this.salvar();
			this.removeChild(this._principal);
			this._telaMinhasImagens.pasta = Main.projeto.pasta.resolvePath('imagens');
			this.stage.addChild(this._telaMinhasImagens);
		}
		
		/**
		 * Incluindo texto.
		 */
		private function onIncluiTexto(evt:Event):void
		{
			this._ultimaAc = 'inclui texto';
			this.removeChild(this._principal);
			this.addChild(this._telaTexto);
		}
		
		/**
		 * Inclusão a partir da biblioteca cancelada.
		 */
		private function onBibliotecaCancel(evt:Event):void
		{
			this.addChild(this._principal);
		}
		
		/**
		 * Inclusão a partir da biblioteca confirmada.
		 */
		private function onBibliotecaSelect(evt:Event):void
		{
			Main.projeto.adicionaImagem(this._telaBiblioteca.selecionado.arquivo, 'bb');
			this.addChild(this._principal);
		}
		
		/**
		 * Inclusão a partir de minhas imagens cancelada.
		 */
		private function onMinhasImagensCancel(evt:Event):void
		{
			this.addChild(this._principal);
		}
		
		/**
		 * Inclusão a partir de minhas imagens confirmada.
		 */
		private function onMinhasImagensSelect(evt:Event):void
		{
			Main.projeto.adicionaImagem(this._telaMinhasImagens.selecionado.arquivo, 'im');
			this.addChild(this._principal);
		}
		
		/**
		 * Inclusão a partir de texto ou edição cancelada.
		 */
		private function onTextoCancel(evt:Event):void
		{
			if (this._ultimaAc == 'edita texto') {
				this.addChild(this._propriedades);
			} else {
				this.addChild(this._principal);
			}
		}
		
		/**
		 * Inclusão a partir de texto ou edição confirmada.
		 */
		private function onTextoSelect(evt:Event):void
		{
			if (this._ultimaAc == 'edita texto') {
				if (this.imagem != null) {
					this.imagem.defineTexto(this._telaTexto.selecionado.texto, this._telaTexto.selecionado.fonte);
				}
				this.addChild(this._propriedades);
				this._barraLateralProp.mostrarTexto();
			} else {
				Main.projeto.adicionaImagem(this._telaTexto.selecionado.texto, 'tx', this._telaTexto.selecionado.fonte);
				this.addChild(this._principal);
			}
		}
		
		/**
		 * Adição de link cancelada.
		 */
		private function onLinkCancel(evt:Event):void
		{
			this.addChild(this._propriedades);
		}
		
		/**
		 * Link incluído em uma imagem.
		 */
		private function onLinkSelect(evt:Event):void
		{
			if (this.imagem != null) {
				this.imagem.defineLink(this._telaLink.selecionado);
			}
			this.addChild(this._propriedades);
		}
		
		/**
		 * A tela de informações foi fechada.
		 */
		private function onInfoComplete(evt:Event):void
		{
			this.addChild(this._principal);
		}
		
		/**
		 * Uma imagem acaba de ser carregada na página atual.
		 */
		private function onImComplete(evt:Event):void
		{
			if (Main.projeto.refImagem != null) {
				if (Main.projeto.refImagem.stage == null) {
					Main.conteudo.addChild(Main.projeto.refImagem);
					Main.projeto.refImagem.addEventListener(MouseEvent.CLICK, cliqueImagem);
				}
				this.ajustaOrdem();
			}
		}
		
		/**
		 * Clique em uma imagem.
		 */
		private function cliqueImagem(evt:MouseEvent):void
		{
			// referência da imagem
			this.imagem = evt.target as Imagem;
			// modo de apresentação?
			if (this._apresentando) {
				if (this.imagem.link != '') {
					var num:Number = Number(this.imagem.link);
					if (isNaN(num)) {
						// abrir o navegador
						if (Main.desktop) {
							if (this.stage.displayState != StageDisplayState.NORMAL) this.stage.displayState = StageDisplayState.NORMAL;
						}
						this.salvar();
						navigateToURL(new URLRequest(this.imagem.link));
					} else {
						// mudar de página
						var pg:int = int(Math.round(num)) - 1;
						if (pg >= 0) {
							if (Main.projeto.selecionaPagina(pg)) {
								this.removeImApresentacao();
								this.mostraDisplay();
								this.preparaImApresentacao();
							}
						}
					}
				}
			} else {
				// somente aceitar o clique quando a tela principal estiver visível
				if (this._principal.stage != null) {
					if (this.imagem != null) {
						// desabilitando outras imagens
						for (var i:int = 0; i < Main.projeto.pagina.imagens.length; i++) {
							if (this.imagem != Main.projeto.pagina.imagens[i]) {
								Main.projeto.pagina.imagens[i].alpha = 0.5;
								Main.projeto.pagina.imagens[i].mouseEnabled = false;
							}
						}
						// habilitando drag na imagem
						this.imagem.addEventListener(MouseEvent.MOUSE_DOWN, onImMouseDown);
						this.stage.addEventListener(MouseEvent.MOUSE_UP, onImMouseUp);
						// abrindo tela de propriedades
						this.removeChild(this._principal);
						this.addChild(this._propriedades);
						// edição de texto?
						if (this.imagem.tipo == 'tx') this._barraLateralProp.mostrarTexto();
					}
				}
			}
		}
		
		/**
		 * Iniciando drag da imagem.
		 */
		private function onImMouseDown(evt:MouseEvent):void
		{
			this.imagem.startDrag();
		}
		
		/**
		 * Finalizando drag da imagem.
		 */
		private function onImMouseUp(evt:MouseEvent):void
		{
			this.imagem.stopDrag();
		}
		
		/**
		 * O botão cancelar foi escolhido na tela de mensagens.
		 */
		private function onMensagemCancel(evt:Event):void
		{
			this.removeChild(this._telaMensagem);
			switch (this._ultimaAc) {
				case 'apagar imagem':
					this.addChild(this._propriedades);
					break;
				default:
					this.addChild(this._principal);
					break;
			}
		}
		
		/**
		 * O notão OK da tela de mensagem foi clicado.
		 */
		private function onMensagemOK(evt:Event):void
		{
			var acOK:Boolean = false;
			var i:int;
			var encontrado:int;
			this.removeChild(this._telaMensagem);
			switch (this._ultimaAc) {
				case 'apagar imagem':
					if (this.imagem != null) {
						// removendo a imagem da tela
						Main.conteudo.container.removeChild(this.imagem);
						// retirando listeners
						this.imagem.stopDrag();
						this.imagem.removeEventListener(MouseEvent.MOUSE_DOWN, onImMouseDown);
						this.stage.removeEventListener(MouseEvent.MOUSE_UP, onImMouseUp);
						this.imagem.removeEventListener(MouseEvent.CLICK, cliqueImagem);
						// retirando a imagem da lista do projeto
						encontrado = -1;
						for (i = 0; i < Main.projeto.pagina.imagens.length; i++) {
							if (Main.projeto.pagina.imagens[i] == this.imagem) encontrado = i;
						}
						if (encontrado >= 0) Main.projeto.pagina.imagens.splice(encontrado, 1);
						this.imagem.dispose();
						this.imagem = null;
						// restaurando ações das outras imagens
						for (i = 0; i < Main.projeto.pagina.imagens.length; i++) {
							Main.projeto.pagina.imagens[i].alpha = 1;
							Main.projeto.pagina.imagens[i].mouseEnabled = true;
						}
						// voltando para a tela principal
						this.addChild(this._principal);
					}
					break;
				case 'adiciona pagina':
					Main.projeto.adicionaPagina();
					if (Main.projeto.selecionaPagina(Main.projeto.paginas[Main.projeto.paginas.length - 1].numero)) {
						this.mostraDisplay();
					}
					this.addChild(this._principal);
					this._barraLateral.atualiza();
					break;
				case 'remove pagina':
					Main.projeto.removePaginaAtual();
					this.mostraDisplay();
					this.addChild(this._principal);
					this._barraLateral.atualiza();
					break;
				case 'exportar imagem':
					var stream:FileStream = new FileStream();
					var regExp:RegExp=/[:|\/|.|&|$|#|*|+|=|<|>|\\|@|%]/g;
					var nomeImagem:String = Main.projeto.titulo.replace(regExp, '');;
					if (nomeImagem == '') nomeImagem = Main.projeto.id;
					nomeImagem = nomeImagem + ' - pg' + (Main.projeto.pagina.numero + 1) + '.png'
					stream.open(File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/imagens/' + nomeImagem), FileMode.WRITE);
					stream.writeBytes(Main.conteudo.getPicture('png'));
					stream.close();
					this._telaMensagem.defineMensagem('<b>Imagem gravada!</b><br />&nbsp;<br />A tela atual do seu infográfico foi gravada como uma imagem na pasta <b>' + File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/imagens/').nativePath + '</b> do seu aparelho com o nome <b>' + nomeImagem + '</b>.');
					this._ultimaAc = 'imagem exportada';
					this.addChild(this._telaMensagem);
					break;
				case 'novo projeto':
					Main.projeto.clear();
					Main.projeto.paginaAtual = 0;
					this.limpaDisplay();
					this._barraLateral.atualiza();
					this.addChild(this._principal);
					break;
				case 'salvar projeto':
					this.salvar();
					this.addChild(this._principal);
					break;
				case 'apaga projeto':
					if (this._telaEscolha.escolhido != null) {
						if (this._telaEscolha.escolhido.id != null) {
							if (String(this._telaEscolha.escolhido.id) == Main.projeto.id) {
								// o projeto a apagar é o atual
								Main.projeto.clear();
								this.limpaDisplay();
							}
							// removendo pasta do projeto
							Main.projeto.apagaProjeto(String(this._telaEscolha.escolhido.id));
						}
					}
					this.addChild(this._principal);
					break;
				case 'compartilhar projeto':
					var exportado:String = Main.projeto.exportar();
					if (exportado != '') {
						// ação ok
						acOK = true;
					}
					if (!acOK) {
						// avisar sobre problema ao exportar projeto
						this._ultimaAc = 'erro compartilhando projeto';
						this._telaMensagem.defineMensagem('<b>Ops, alguma coisa deu errado...</b><br />&nbsp;<br />Não consegui exportar o seu infográfico para compartilhamento. Quer tentar de novo?');
						this.addChild(this._telaMensagem);
					} else {
						// iniciar compartilhamento
						if (ObjetoAprendizagem.compartilhamento.iniciaURL(File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/exportados/' + exportado))) {
							this.stage.addChild(ObjetoAprendizagem.compartilhamento);
						} else {
							// avisar sobre erro de compartilhamento
							this._ultimaAc = 'erro compartilhando projeto';
							this._telaMensagem.defineMensagem('<b>Desculpe...</b><br />&nbsp;<br />Não consegui exportar o seu infográfico para compartilhamento. Vamos tentar mais uma vez?');
							this.addChild(this._telaMensagem);
						}
					}
					break;
				default:
					this.addChild(this._principal);
					break;
			}
		}
		
		/**
		 * Um projeto foi escolhido na tela de listagem.
		 */
		private function onEscolhaOK(evt:Event):void
		{
			var acOK:Boolean = false;
			switch (this._ultimaAc) {
				case 'abrir projeto':
					if (this._telaEscolha.escolhido != null) {
						if (this._telaEscolha.escolhido.id != null) {
							// salvar projeto atual?
							if (!Main.projeto.limpo) this.salvar();
							// carregar o projeto selecionado
							if (Main.projeto.carregaProjeto(this._telaEscolha.escolhido.id)) {
								Main.projeto.paginaAtual = 0;
								this.mostraDisplay();
								this._barraLateral.atualiza();
								acOK = true;
							} else {
								acOK = false;
							}
						}
					}
					if (!acOK) {
						// avisar sobre problema ao abrir projeto
						this.stage.removeChild(this._telaEscolha);
						this._telaMensagem.defineMensagem('<b>Oh, não!</b><br />&nbsp;<br />Não consegui abrir o infográfico que você escolheu. Que tal tentar mais uma vez?');
						this.addChild(this._telaMensagem);
					} else {
						// mostrar projeto aberto
						this.stage.removeChild(this._telaEscolha);
						this.addChild(this._principal);
					}
					break;
				case 'exportar projeto':
					if (this._telaEscolha.escolhido != null) {
						if (this._telaEscolha.escolhido.id != null) {
							// recuperando nome de arquivo
							var exportado:String = Main.projeto.exportarID(this._telaEscolha.escolhido.id as String);
							if (exportado != '') {
								// ação ok
								acOK = true;
							}
						}
					}
					if (!acOK) {
						// avisar sobre problema ao exportar projeto
						this.stage.removeChild(this._telaEscolha);
						this._telaMensagem.defineMensagem('<b>Desculpe...</b><br />&nbsp;<br />Não consegui exportar seu infográfico. Vamos tentar de novo?');
						this.addChild(this._telaMensagem);
					} else {
						// avisar sobre o projeto exportado
						this.stage.removeChild(this._telaEscolha);
						this._telaMensagem.defineMensagem('<b>Prontinho ;-)</b><br />&nbsp;<br />Seu infográfico foi exportado. Ele está gravado com o nome <br />&nbsp;<br /><b>' + exportado + '</b><br />&nbsp;<br />na pasta <br />&nbsp;<br /><b>' + File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/exportados').nativePath + '</b><br />&nbsp;<br />de seu aparelho.');
						this.addChild(this._telaMensagem);
					}
					break;
				default:
					this.stage.removeChild(this._telaEscolha);
					this.addChild(this._principal);
					break;
			}
			
		}
		
		/**
		 * Um projeto foi escolhido para apagar tela de listagem.
		 */
		private function onEscolhaClear(evt:Event):void
		{
			// existe informação sobre o projeto a remover?
			if (this._telaEscolha.escolhido != null) {
				if (this._telaEscolha.escolhido.id != null) {
					if (this._telaEscolha.escolhido.titulo == '') this._telaEscolha.escolhido.titulo = 'sem nome';
					this._telaMensagem.defineMensagem('<b>Quer mesmo apagar?</b><br />&nbsp;<br />Quer mesmo apagar o infográfico <b>' + this._telaEscolha.escolhido.titulo + '</b>? Se fizer isso, não vou conseguir recuperá-lo se você mudar de ideia.', true);
					this._ultimaAc = 'apaga projeto';
					this.stage.removeChild(this._telaEscolha);
					this.addChild(this._telaMensagem);
				}
			}
		}
		
		/**
		 * O botão cancelar foi escolhido na tela de listagem de projetos.
		 */
		private function onEscolhaCancel(evt:Event):void
		{
			this.stage.removeChild(this._telaEscolha);
			this.addChild(this._principal);
		}
		
		/**
		 * O botão abrir foi escolhido na tela de listagem de projetos.
		 */
		private function onEscolhaOpen(evt:Event):void
		{
			if (Main.desktop) {
				this._telaEscolha.mostrarMensagem('Localizando e importanto um arquivo de projeto.');
				this._navegaProjeto.browseForOpen('Projetos de Infográfico', [new FileFilter('arquivos de projeto', '*.ifg')]);
			} else {
				this._telaEscolha.parent.removeChild(this._telaEscolha);
				this._navegaMobile.listar('ifg', 'Escolha um projeto para importar');
				this.stage.addChild(this._navegaMobile);
			}
		}
		
		/**
		 * A tela de compartilhamento foi fechada.
		 */
		private function onCompartilhamentoClose(evt:Event):void
		{
			this.addChild(this._principal);
		}
		
		/**
		 * Foi recebido um arquivo de projeto.
		 */
		private function onCompartilhamentoComplete(evt:Event):void
		{
			this._ultimaAc = 'projeto recebido';
			if (!Main.projeto.importar(ObjetoAprendizagem.compartilhamento.download)) {
				this._telaMensagem.defineMensagem('<b>Oh, não!</b><br />&nbsp;<br />Não consegui impotar o infográfico que você escolheu. Quer tentar novamente?');
				this.stage.removeChild(ObjetoAprendizagem.compartilhamento);
				this.addChild(this._telaMensagem);
			}
		}
		
		/**
		 * Navegação por arquivo terminada sem nenhuma escolha.
		 */
		private function onNavegadorPFim(evt:Event):void
		{
			// refazendo a listagem
			this._telaEscolha.listar('Defina o projeto a exportar ou escolha um arquivo para importar');
		}
		
		/**
		 * Recebendo um arquivo de projeto selecionado.
		 */
		private function onNavegadorPSelect(evt:Event):void
		{
			// importando
			if (Main.projeto.importar(this._navegaProjeto)) {
				// aguardar importação
				this.stage.removeChild(this._telaEscolha);
			} else {
				// somentar listar novamente
				this._telaEscolha.listar('Erro ao importar o projeto: defina o projeto a exportar ou escolha um arquivo para importar');
			}
		}
		
		/**
		 * Navegação por arquivo móvel terminada sem nenhuma escolha.
		 */
		private function onNavegadorMobFim(evt:Event):void
		{
			// refazendo a listagem
			this._navegaMobile.parent.removeChild(this._navegaMobile);
			this._telaEscolha.listar('Defina o projeto a exportar ou escolha um arquivo para importar');
			this.stage.addChild(this._telaEscolha);
		}
		
		/**
		 * Recebendo um arquivo móvel de projeto selecionado.
		 */
		private function onNavegadorMobSelect(evt:Event):void
		{
			// importando
			this._navegaMobile.parent.removeChild(this._navegaMobile);
			var arq:File = new File(this._navegaMobile.escolhido.arquivo);
			if (Main.projeto.importar(arq)) {
				// aguardar importação
			} else {
				// somente listar novamente
				this._telaEscolha.listar('Erro ao importar o projeto: defina o projeto a exportar ou escolha um arquivo para importar');
				this.stage.addChild(this._telaEscolha);
			}
		}
		
		/**
		 * Sucesso na importação de um projeto.
		 */
		private function onImportComplete(evt:Event):void
		{
			this._ultimaAc = 'projeto recebido';
			this._telaMensagem.defineMensagem('<b>Chegou!</b><br />&nbsp;<br />O projeto de infográfico foi recebido! Use o botão "abrir projeto" para conferir.');
			try { this.stage.removeChild(ObjetoAprendizagem.compartilhamento); } catch (e:Error) { }
			try { this.removeChild(this._principal); } catch (e:Error) { }
			this.addChild(this._telaMensagem);
		}
		
		/**
		 * Erro na importação de um projeto.
		 */
		private function onImportCancel(evt:Event):void
		{
			this._ultimaAc = 'projeto recebido';
			this._telaMensagem.defineMensagem('<b>Ops, alguma coisa deu errado...</b><br />&nbsp;<br />Não consegui importar o arquivo que recebi. Quer tentar mais uma vez?');
			try { this.stage.removeChild(ObjetoAprendizagem.compartilhamento); } catch (e:Error) { }
			try { this.removeChild(this._principal); } catch (e:Error) { }
			this.addChild(this._telaMensagem);
		}
		
		/**
		 * Ajusta o valor de ordem da lista de imagens.
		 */
		private function ajustaOrdem():void
		{
			if (Main.conteudo.container.numChildren > 0) {
				var atual:int = 0;
				for (var i:int = 0; i < Main.conteudo.container.numChildren; i++) {
					var img:Imagem = Main.conteudo.container.getChildAt(i) as Imagem;
					img.ajustaOrdem(i);
				}
			}
		}
		
		/**
		 * Limpa o display atual.
		 */
		private function limpaDisplay():void
		{
			this.imagem = null;
			while (Main.conteudo.container.numChildren > 0) {
				var img:Imagem = Main.conteudo.container.getChildAt(0) as Imagem;
				if (img != null) {
					img.stopDrag();
					if (img.hasEventListener(MouseEvent.MOUSE_DOWN)) img.removeEventListener(MouseEvent.MOUSE_DOWN, onImMouseDown);
					if (this.stage.hasEventListener(MouseEvent.MOUSE_UP)) try { this.stage.removeEventListener(MouseEvent.MOUSE_UP, onImMouseUp); } catch (e:Error) { }
					if (img.hasEventListener(MouseEvent.CLICK)) img.removeEventListener(MouseEvent.CLICK, cliqueImagem);
					Main.conteudo.container.removeChild(img);
				}
			}
		}
		
		/**
		 * Mostra as imagens da página atual.
		 */
		private function mostraDisplay():void
		{
			if (Main.projeto.pagina != null) {
				// retirando imagens anteriores
				this.limpaDisplay();
				// organizando o vetor de imagens
				Main.projeto.pagina.imagens.sort(this.vetorImSort);
				// acrescentando imagens
				for (var i:int = 0; i < Main.projeto.pagina.imagens.length; i++) {
					Main.conteudo.addChild(Main.projeto.pagina.imagens[i]);
					Main.projeto.pagina.imagens[i].addEventListener(MouseEvent.CLICK, cliqueImagem);
				}
			}
		}
		
		/**
		 * Ordenação de elementos do vetor de imagens pela ordem.
		 * @param	a	primeira imagem
		 * @param	b	segunda imagem
		 * @return	-1 se a vem antes de b, 1 se b vem antes de a, 0 se ambos estão na mesma ordem
		 */
		private function vetorImSort(a:Imagem, b:Imagem):int
		{
			if (a.ordem < b.ordem) {
				return ( -1);
			} else if (a.ordem > b.ordem) {
				return (1);
			} else {
				return (0);
			}
		}
		
		/**
		 * Clique no botão de adicionar imagem.
		 */
		private function acMais():void
		{
			this.addChild(this._incluiImagem);
		}
		
		/**
		 * Clique no botão de adicionar ou remover página.
		 */
		private function acPagina(acao:String):void
		{
			switch (acao) {
				case '+': // adiciona página
					this._telaMensagem.defineMensagem('<b>Nova página</b><br />&nbsp;<br />Quer adicionar uma página ao seu infográfico?', true);
					this._ultimaAc = 'adiciona pagina';
					this.removeChild(this._principal);
					this.addChild(this._telaMensagem);
					break;
				case '-': // remove página
					this._telaMensagem.defineMensagem('<b>Apagar página</b><br />&nbsp;<br />Você quer mesmo apagar a página atual de seu infográfico?', true);
					this._ultimaAc = 'remove pagina';
					this.removeChild(this._principal);
					this.addChild(this._telaMensagem);
					break;
				case '<': // página anterior
					if (Main.projeto.pagina.numero > 0) {
						if (this._apresentando) this.removeImApresentacao();
						Main.projeto.selecionaPagina(Main.projeto.pagina.numero - 1);
						this.mostraDisplay();
						if (this._apresentando) this.preparaImApresentacao();
						this._barraLateral.atualiza();
					}
					break;
				case '>': // próxima página
					if (Main.projeto.pagina.numero < Main.projeto.paginas.length) {
						if (this._apresentando) this.removeImApresentacao();
						Main.projeto.selecionaPagina(Main.projeto.pagina.numero + 1);
						this.mostraDisplay();
						if (this._apresentando) this.preparaImApresentacao();
						this._barraLateral.atualiza();
					}
					break;
			}
		}
		
		/**
		 * Clique no botão de ajuda.
		 */
		private function acAjuda():void
		{
			this.stage.addChild(this._telaAjuda);
		}
		
		/**
		 * Clique no botão tela cheia.
		 */
		private function acTelaCheia():void
		{
			if (this.stage.displayState == StageDisplayState.NORMAL) {
				this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				this.posiciona();
			} else {
				this.stage.displayState = StageDisplayState.NORMAL;
				this.posiciona();
			}
		}
		
		/**
		 * Clique no botão exportar imagem.
		 */
		private function acExportar():void
		{
			this._ultimaAc = 'exportar imagem';
			this._telaMensagem.defineMensagem('<b>Exportar imagem</b><br />&nbsp;<br />Você quer salvar a página atual do seu infográfico como uma imagem?', true);
			this.removeChild(this._principal);
			this.addChild(this._telaMensagem);
		}
		
		/**
		 * Clique no botão informações do projeto.
		 */
		private function acInfo():void
		{
			this.removeChild(this._principal);
			this.addChild(this._telaInfo);
		}
		
		/**
		 * O botão "novo projeto" foi clicado.
		 */
		private function acNovo():void
		{
			this._ultimaAc = 'novo projeto';
			this._telaMensagem.defineMensagem('<b>Um novo infográfico?</b><br />&nbsp;<br />Você quer mesmo criar um infográfico novo? Qualquer alteração não salva no seu projeto atual vai ser perdida.', true);
			this.addChild(this._telaMensagem);
			this.removeChild(this._principal);
		}
		
		/**
		 * O botão "salvar" foi clicado.
		 */
		private function acSalvar():void
		{
			if (Main.projeto.titulo == '') {
				this._ultimaAc = 'aviso falta titulo';
				this._telaMensagem.defineMensagem('<b>Um probleminha...</b><br />&nbsp;<br />Seu infográfico ainda não tem um título e não posso gravá-lo. Para dar um nome, toque no botão de informações.');
				this.addChild(this._telaMensagem);
				this.removeChild(this._principal);
			} else {
				this._ultimaAc = 'salvar projeto';
				this._telaMensagem.defineMensagem('<b>Quase lá!</b><br />&nbsp;<br />Você quer mesmo salvar seu infográfico com o nome <b>' + Main.projeto.titulo + '</b>?', true);
				this.addChild(this._telaMensagem);
				this.removeChild(this._principal);
			}
		}
		
		/**
		 * O botão "abrir projeto" foi clicado.
		 */
		private function acAbrirPrjeto():void
		{
			if (this._telaEscolha.listar('Escolha um projeto para abrir ou apagar')) {
				this._ultimaAc = 'abrir projeto';
				this.removeChild(this._principal);
				this.stage.addChild(this._telaEscolha);
				this._telaEscolha.mostrarLixeira();
			}
		}
		
		/**
		 * O botão "compartilhar" foi clicado.
		 */
		private function acCompartilhar():void
		{
			if (Main.projeto.titulo == '') {
				this._ultimaAc = 'aviso falta titulo';
				this._telaMensagem.defineMensagem('<b>Oh, não!</b><br />&nbsp;<br />Seu infográfico ainda não tem um nome e não posso fazer o compartilhamento. Para dar um nome, toque no botão de informações.');
				this.addChild(this._telaMensagem);
				this.removeChild(this._principal);
			} else {
				this._ultimaAc = 'compartilhar projeto';
				this._telaMensagem.defineMensagem('<b>Compartilhando...</b><br />&nbsp;<br />Você quer mesmo compartilhar seu infográfico com o nome <b>' + Main.projeto.titulo + '</b>?', true);
				this.addChild(this._telaMensagem);
				this.removeChild(this._principal);
			}
		}
		
		/**
		 * O botão "exportar projeto" foi clicado.
		 */
		private function acExportarProjeto():void
		{
			if (this._telaEscolha.listar('Defina o projeto a exportar ou escolha um arquivo para importar')) {
				this._ultimaAc = 'exportar projeto';
				this.removeChild(this._principal);
				this.stage.addChild(this._telaEscolha);
				this._telaEscolha.mostrarAbrir();
			}
		}
		
		/**
		 * O botão "receber projeto" foi clicado.
		 */
		private function acReceber():void {
			this._ultimaAc = 'receber projeto';
			this.removeChild(this._principal);
			ObjetoAprendizagem.compartilhamento.iniciaLeitura();
			this.stage.addChild(ObjetoAprendizagem.compartilhamento);
		}
		
		/**
		 * O botão "apresentar" foi clicado.
		 */
		private function acApresentar():void
		{
			// mostrando o conteúdo em toda a tela
			this.removeChild(this._principal);
			Main.conteudo.fitOnArea(new Rectangle(0, 0, AreaApp.AREAWIDTH, AreaApp.AREAHEIGHT));
			this._apresentando = true;
			// recebendo interação do teclado
			this.stage.focus = this.stage;
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			// em aparelhos móveis
			if (!Main.desktop) {
				Multitouch.inputMode = MultitouchInputMode.GESTURE;
				this.stage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			}
			// referência visual dos links
			this.preparaImApresentacao();
		}
		
		/**
		 * Clique no botão ok da tela de propriedades.
		 */
		private function acPropOk():void
		{
			// desabilitando drag e reset
			this.imagem.removeEventListener(MouseEvent.MOUSE_DOWN, onImMouseDown);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, onImMouseUp);
			this.imagem.stopDrag();
			// restaurando ações das outras imagens
			for (var i:int = 0; i < Main.projeto.pagina.imagens.length; i++) {
				Main.projeto.pagina.imagens[i].alpha = 1;
				Main.projeto.pagina.imagens[i].mouseEnabled = true;
			}
			// mostrando a tela principal
			this.removeChild(this._propriedades);
			this.addChild(this._principal);
		}
		
		/**
		 * Clique no botão apaga da tela de propriedades.
		 */
		private function acPropApaga():void
		{
			if (this.imagem != null) {
				this._ultimaAc = 'apagar imagem';
				this.removeChild(this._propriedades);
				this._telaMensagem.defineMensagem('<b>Tem certeza?</b><br />&nbsp;<br />Você quer mesmo apagar esta imagem?', true);
				this.addChild(this._telaMensagem);
			}
		}
		
		/**
		 * Clique no botão link da tela de propriedades.
		 */
		private function acPropLink():void
		{
			if (this.imagem != null) {
				this.removeChild(this._propriedades);
				this._telaLink.mostraLink(this.imagem.link);
				this.addChild(this._telaLink);
			}
		}
		
		/**
		 * Clique no botão reset da tela de propriedades.
		 */
		private function acReset():void
		{
			if (this.imagem != null) {
				this.imagem.reset();
			}
		}
		
		/**
		 * Clique no botão texto da tela de propriedades.
		 */
		private function acTexto():void
		{
			if (this.imagem != null) {
				this._ultimaAc = 'edita texto';
				this.removeChild(this._propriedades);
				this.addChild(this._telaTexto);
				this._telaTexto.defineTexto(this.imagem.texto, this.imagem.fonte);
			}
		}
		
		/**
		 * Clique no botão tamanho da tela de propriedades.
		 */
		private function acTamanho(para:String):void
		{
			if (para == '-') {
				if (this.imagem.scaleX >= 0.30) this.imagem.scaleX -= 0.15;
			} else {
				if (this.imagem.scaleX < 10) this.imagem.scaleX += 0.15;
			}
			this.imagem.scaleY = this.imagem.scaleX;
		}
		
		/**
		 * Clique no botão rotação da tela de propriedades.
		 */
		private function acRotacao(para:String):void
		{
			if (para == '-') {
				this.imagem.rotation -= 10;
			} else {
				this.imagem.rotation += 10;
			}
		}
		
		/**
		 * Clique no botão vermelho da tela de propriedades.
		 */
		private function acVermelho(para:String):void
		{
			if (para == '+') {
				this.imagem.adicionaVermelho();
			} else {
				this.imagem.retiraVermelho();
			}
		}
		
		/**
		 * Clique no botão verde da tela de propriedades.
		 */
		private function acVerde(para:String):void
		{
			if (para == '+') {
				this.imagem.adicionaVerde();
			} else {
				this.imagem.retiraVerde();
			}
		}
		
		/**
		 * Clique no botão azul da tela de propriedades.
		 */
		private function acAzul(para:String):void
		{
			if (para == '+') {
				this.imagem.adicionaAzul();
			} else {
				this.imagem.retiraAzul();
			}
		}
		
		/**
		 * Clique no botão ordem da tela de propriedades.
		 */
		private function acOrdem(para:String):void
		{
			if (para == '+') {
				if (this.imagem.ordem < (Main.conteudo.container.numChildren - 1)) {
					Main.conteudo.container.swapChildrenAt(this.imagem.ordem, (this.imagem.ordem + 1));
					this.ajustaOrdem();
				}
			} else {
				if (this.imagem.ordem > 0) {
					Main.conteudo.container.swapChildrenAt(this.imagem.ordem, (this.imagem.ordem - 1));
					this.ajustaOrdem();
				}
			}
		}
		
		/**
		 * Recebendo interação do teclado.
		 */
		private function onKeyDown(evt:KeyboardEvent):void
		{
			switch (evt.keyCode) {
				case Keyboard.RIGHT:
				case Keyboard.UP:
					// próxima página
					this.acPagina('>');
					break;
				case Keyboard.LEFT:
				case Keyboard.DOWN:
					// página anterior
					this.acPagina('<');
					break;
				case Keyboard.BACK: // tecla voltar do android
					// sair do modo de apresentação
					evt.preventDefault();
					evt.stopImmediatePropagation();
					this.sairApresentacao();
					break;
				default:
					// sair do modo de apresentação
					this.sairApresentacao();
					break;
			}
		}
		
		/**
		 * Gesto swipe durante a apresentação.
		 */
		private function onSwipe(evt:TransformGestureEvent):void
		{
			if (evt.offsetX < 0) {
				// próxima página
				this.acPagina('>');
			} else if (evt.offsetX > 0) {
				// página anterior
				this.acPagina('<');
			}
		}
		
		/**
		 * Prepara as imagens atuais para referências visuais durante a apresentação.
		 */
		private function preparaImApresentacao():void
		{
			for (var i:int = 0; i < Main.conteudo.container.numChildren; i++) {
				var img:Imagem = Main.conteudo.container.getChildAt(i) as Imagem;
				if (img != null) {
					if (img.link != '') {
						img.buttonMode = true;
						img.useHandCursor = true;
					} else {
						img.buttonMode = false;
						img.useHandCursor = false;
					}
					img.addEventListener(MouseEvent.MOUSE_OVER, onImMouseOver);
					img.addEventListener(MouseEvent.MOUSE_OUT, onImMouseOut);
				}
			}
		}
		
		/**
		 * Remove referências visuais de apresentação das imagens atuais.
		 */
		private function removeImApresentacao():void
		{
			for (var i:int = 0; i < Main.conteudo.container.numChildren; i++) {
				var img:Imagem = Main.conteudo.container.getChildAt(i) as Imagem;
				if (img != null) {
					img.buttonMode = false;
					img.useHandCursor = false;
					img.removeEventListener(MouseEvent.MOUSE_OVER, onImMouseOver);
					img.removeEventListener(MouseEvent.MOUSE_OUT, onImMouseOut);
					img.filters = new Array();
				}
			}
		}
		
		/**
		 * Mostrar destaque na imagem sob o mouse.
		 */
		private function onImMouseOver(evt:MouseEvent):void
		{
			this.onImMouseOut(null);
			var img:Imagem = evt.target as Imagem;
			if (img != null) {
				if (img.link != '') {
					img.filters = new Array(new GlowFilter(0xFFFFFF, 0.6));
				}
			}
		}
		
		/**
		 * Retirar destaque das imagens.
		 */
		private function onImMouseOut(evt:MouseEvent):void
		{
			for (var i:int = 0; i < Main.conteudo.container.numChildren; i++) {
				Main.conteudo.container.getChildAt(i).filters = new Array();
			}
		}
		
		/**
		 * Fecha o modo de apresentação.
		 */
		private function sairApresentacao():void
		{
			this._apresentando = false;
			this.removeImApresentacao();
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			if (!Main.desktop) {
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				this.stage.removeEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			}
			this.addChild(this._principal);
			Main.conteudo.fitOnArea(new Rectangle((1.75 * AreaApp.TAMBT), (0.25 * AreaApp.TAMBT), (AreaApp.AREAWIDTH - (2 * AreaApp.TAMBT)), (AreaApp.AREAHEIGHT - (2 * AreaApp.TAMBT))));
		}
		
	}

}