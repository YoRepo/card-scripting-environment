--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Drytron Zeta Aldhibah  (ID: 96026108)
-- Type: Monster / Effect / Special Summon
-- Attribute: LIGHT
-- Race: Machine
-- Level: 1
-- ATK 2000 | DEF 0
-- Setcode: 0x154
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned/Set.
-- Must be Special Summoned with the effect of a "Drytron" card.
-- You can Tribute 1 other "Drytron" monster, or 1 Ritual Monster, from your hand or field; Special
-- Summon this card from your hand or GY in Defense Position, then you can add 1 Ritual Spell from your
-- Deck to your hand.
-- You cannot Special Summon monsters, except monsters that cannot be Normal Summoned/Set, the turn you
-- activate this effect.
-- You can only use this effect of "Drytron Zeta Aldhibah" once per turn.
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－アルζ
function c96026108.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c96026108.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddDrytronSpSummonEffect(c,c96026108.extraop)
	e2:SetDescription(aux.Stringid(96026108,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH)
	e2:SetCountLimit(1,96026108)
end
function c96026108.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x154)
end
function c96026108.thfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c96026108.extraop(e,tp)
	local g=Duel.GetMatchingGroup(c96026108.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(96026108,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
