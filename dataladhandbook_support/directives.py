# -*- coding: utf-8 -*-

from docutils import nodes
from docutils.parsers.rst.directives.admonitions import BaseAdmonition


class gitusernote(nodes.Admonition, nodes.Element):
    """Custom "gitusernote" admonition."""


def visit_gitusernote_html(self, node):
    # it is a simple div with a dedicated CSS class assigned
    self.body.append(
        self.starttag(
            node, 'div', CLASS=('admonition ' + 'gitusernote')))
    node.insert(0, nodes.title(
        'first',
        'Note for Git users'))


def depart_gitusernote_html(self, node):
    self.depart_admonition(node)


def visit_gitusernote_latex(self, node):
    self.body.append('\n\n\\sphinxstrong{Note for Git users:}\n\n')


def depart_gitusernote_latex(self, node):
    self.body.append("\n\n")


class GitUserNote(BaseAdmonition):
    """
    An admonition mentioning things to look at as reference.
    """
    node_class = gitusernote


class FindOutMore(BaseAdmonition):
    """findoutmore RST directive

    The idea here is to use an admonition to parse the RST,
    but actually fully replace it afterwards with a custom
    node structure. This is done to be able to replace a
    rather verbose custom markup that was used before in the
    book. Eventually, it may be replaced (in here) with
    something completely different -- without having to change
    content and markup in the book sources.
    """
    node_class = nodes.admonition
    # empty is no allowed
    has_content = True
    # needs at least a one word title
    required_arguments = 1

    def run(self):
        # this uses the admonition code for RST parsion
        docnodes = super(FindOutMore, self).run()
        # but we throw away the title, because we want to mark
        # it up as a 'header' further down
        del docnodes[0][0]
        # now put the entire admonition structure into a container
        # that we assign the necessary class to make it 'toggle-able'
        # in HTML
        # outer container
        toggle = nodes.container(
            'toogle',
            # header line with 'Find out more' prefix
            nodes.container(
                'label',
                nodes.paragraph(
                    'title', '',
                    nodes.strong('strong', 'Find out more: '),
                    # place actual admonition title we removed
                    # above
                    nodes.Text(self.arguments[0]),
                ),
                # add (CSS) class
                classes=['header'],
            ),
            # place the rest of the admonition structure after the header,
            # but still inside the container
            *docnodes[0].children,
            # properly identify as 'findoutmore' to enable easy custom
            # styling, and also tag with 'toggle'. The later is actually
            # not 100% necessary, as 'findoutmore' could get that
            # functional assigned in CSS instead (maybe streamline later)
            classes=['toggle', 'findoutmore'],
        )
        return [toggle]


def setup(app):
    app.add_node(
        gitusernote,
        html=(visit_gitusernote_html, depart_gitusernote_html),
        latex=(visit_gitusernote_latex, depart_gitusernote_latex),
    )
    app.add_directive('gitusernote', GitUserNote)
    app.add_directive('findoutmore', FindOutMore)

# vim: set expandtab shiftwidth=4 softtabstop=4 :
