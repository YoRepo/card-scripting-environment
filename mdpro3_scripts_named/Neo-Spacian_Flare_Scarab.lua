--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Neo-Spacian Flare Scarab  (ID: 89621922)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Insect
-- Level: 3
-- ATK 500 | DEF 500
-- Setcode: 0x1f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 400 ATK for each Spell/Trap your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--N・フレア・スカラベ
function c89621922.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89621922,0))
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c89621922.val)
	c:RegisterEffect(e1)
end
function c89621922.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),0,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)*400
end
