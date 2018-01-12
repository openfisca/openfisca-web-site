

<%def name="h1_content()" filter="trim">
Conditions générales d'utilisation et mentions légales
</%def>


<%inherit file="/page.mako"/>


<%def name="body_attributes()" filter="trim">
data-spy="scroll" data-target="#sommaire"
</%def>


<%def name="page_content()" filter="trim">
    <div class="col-md-9" role="main">
        <h2 id="presentation">Présentation de la plateforme openfisca.fr</h2>

        <p>
            OpenFisca est un logiciel libre de simulation du système socio-fiscal français permettant à une communauté
            de développeurs, économistes, enseignants, instituts d'études et de recherche d'enrichir et d'améliorer
            les modèles de simulations du système socio-fiscal français. Il permet de visualiser et de tester des
            modèles relatifs aux prestations et aux impôts payés par les ménages, et de simuler l'impact de réformes
            sur le budget des ménages. Il s'agit d'un outil à vocation pédagogique pour aider les citoyens à mieux
            comprendre le système socio-fiscal français.
        </p>
        <p>
            La simulation est effectuée à partir des textes juridiques applicables et des éléments saisis en ligne.
            Elle ne constitue en aucune façon une déclaration de revenus.
        </p>
        <p>
            Les montants, obtenus à partir des informations inscrites n'ont qu'une valeur indicative. Ainsi, <strong>les
             montants des impôts et des aides calculés peuvent être différents de ceux de la déclaration de
             revenus</strong>.
        </p>

        <h2 id="fonctionnement">Fonctionnement de la plateforme openfisca.fr</h2>

        <p>
            Lors de l'utilisation de la plateforme OpenFisca, vous pourrez communiquer différents types de
            renseignements. La plateforme est itérative, c'est-à-dire que plus les informations fournies sont précises
            et complètes, meilleure est la simulation. Le défaut de réponse aux questions aura pour seule conséquence de
            rendre la simulation moins précise.
        </p>

        <h3>Mode de navigation sans création de compte</h3>

        <p>Le mode de navigation sans création de compte permet de visualiser simplement et efficacement un grand nombre de prestations sociales et d'impôts payés par les ménages, et de simuler l'impact de réformes sur leurs budgets. Cette version utilise des renseignements de nature purement patrimoniale et donc, ne collecte pas de donnée à caractère personnel.</p>
        <p>Afin de permettre aux utilisateurs de revenir sur les informations saisies, de les enregistrer et d'effectuer de nouvelles simulations il est possible de créer un compte.</p>

        <h3>Mode de navigation avec création de compte</h3>

        <p>L'utilisation de ce mode de navigation est <strong>facultative</strong>. La création du compte se fait par l'enregistrement d'une adresse électronique qui est vérifiée. Une fois enregistré, l'utilisateur est amené à fournir le même type de renseignements que dans le mode de navigation sans création de compte.</p>
        <p>Hormis les calculs effectués par l'usager grâce à l'outil de simulation, les données ne font l'objet d'aucun traitement.</p>

        <h4>Droit des personnes</h4>

        <p>Les informations contenues dans le compte sont gérées directement par l'utilisateur. Il peut, à tout moment, choisir de les modifier ou de les supprimer librement.</p>
        <p>Par ailleurs, l'utilisateur peut obtenir à tout moment la délivrance d'une copie format électronique des informations de son compte depuis la plateforme.</p>

        <h4>Conservation des données</h4>

        <p>Afin de permettre une réutilisation des données d'une année sur l'autre, les données enregistrées par l'usager sont conservées pendant une durée de deux ans sous son contrôle exclusif.</p>

        <h4>Droit de retrait et de résiliation</h4>

        <p>
            À tout moment, l'utilisateur bénéficie, depuis l'interface de son compte, d'un droit d'accès, de
            rectification, de modification et de suppression de l'ensemble des données collectées.
        </p>
        <p>
            Pour résilier son compte, l'utilisateur peut aussi en faire la demande par courriel à
            <code>contact@openfisca.fr</code> ou par voie postale à :
        </p>
        <address>
            <strong>Mission Etalab</strong><br>
            <abbr title="Direction interministérielle du numérique et du système d'information et de communication de l'État">DINSIC</abbr><br>
            20 avenue de Ségu<br>
            75334 PARIS Cedex 07
        </address>

        <p>
            La plateforme openfisca.fr a été déclarée auprès de la Commission Nationale de l'Informatique et des
            Libertés sous le numéro : <code>1753457 v 0</code>.
        </p>

        <h3>Contributions à la plateforme openfisca.fr</h3>

        <p>
            Toute personne physique ou morale, publique ou privée, peut contribuer à la plateforme openfisca.fr en
            <span class="label label-danger">TODO</span>.
        </p>

        <h2 id="responsabilite">Responsabilité des acteurs</h2>

        <h3>S'agissant de l'éditeur de la plateforme</h3>

        <p>
            L'éditeur s'engage à mettre en œuvre tout ce qui est possible techniquement pour sécuriser l'accès et l'utilisation de la plateforme openfisca.fr. Elle est accessible 24 heures sur 24, 7 jours sur 7, sauf en cas de force majeure ou de survenance d'un événement hors du contrôle de l'éditeur et sous réserve d'éventuelles pannes et interventions de maintenance nécessaires au bon fonctionnement de la plateforme. L'éditeur ne garantit pas que la plateforme fonctionne de manière ininterrompue, sécurisée ou qu'elle soit exempte d'erreurs. Les interventions de maintenance pourront être effectuées sans que les utilisateurs de la plateforme n'aient été préalablement avertis. L'éditeur ne peut être tenu pour responsable d'une éventuelle rupture de ce service ou d'un problème technique empêchant un utilisateur d'accéder à la plateforme.
        </p>
        <p>
            L'éditeur se réserve la possibilité de refuser que certaines personnes aient accès au site openfisca.fr en
            cas de violation de dispositions législatives ou réglementaires en vigueur. L'éditeur doit alors justifier
            sa décision.
        </p>
        <p>
            Concernant les contenus qu'elle propose afin d'animer la plateforme, la mission Etalab assume une responsabilité éditoriale telle que définie par la loi en vigueur. La plateforme openfisca.fr héberge des contributions provenant d'utilisateurs tiers. Conformément à la loi en vigueur, l'éditeur de la plateforme bénéficie de la responsabilité d'hébergeur de ces contenus et ne saurait en être tenu pour responsable.
        </p>

        <h3>S'agissant des contributeurs à la plateforme openfisca.fr</h3>

        <p>
            La plateforme openfisca.fr promeut la documentation, la fiabilisation et l'enrichissement de données ainsi que la mise en évidence de corrélations inédites plutôt que des interprétations définitives ou partisanes. Elle offre ainsi la possibilité à tous les citoyens de publier des réutilisations de manière simple, sans contrôle a priori, grâce à l'outillage pour les visualisations de données.
        </p>
        <p>
            La communauté des membres et des contributeurs de la plateforme participe au contrôle de la qualité du contenu.
            L'éditeur de la plateforme openfisca.fr, tout comme l'éditeur de chaque page de données, se réserve le droit de modérer à tout moment un contenu qui contreviendrait aux dispositions législatives ou réglementaires en vigueur.
        </p>

        <h2 id="mentions-legales">Mentions légales</h2>

        <p>Ce site est publié par :</p>
        <address>
            <strong>Mission Etalab</strong><br>
            <abbr title="<abbr title="Direction interministérielle du numérique et du système d'information et de communication de l'État">DINSIC</abbr><br>
            20 avenue de Ségu<br>
            75334 PARIS Cedex 07
        </address>
        <p>Directeur de la publication : M. Henri VERDIER, Directeur d'Etalab, <abbr title="Direction interministérielle du numérique et du système d'information et de communication de l'État">DINSIC</abbr></p>

    <div class="col-md-3 hidden-print sidebar" id="sommaire" role="complementary">
        <ul class="nav sidenav" data-offset-top="60" data-spy="affix">
            <li><a href="#presentation">Présentation</a></li>
            <li><a href="#fonctionnement">Fonctionnement</a></li>
            <li><a href="#responsabilite">Responsabilité</a></li>
            <li><a href="#mentions-legales">Mentions légales</a></li>
        </ul>
    </div>
</%def>
