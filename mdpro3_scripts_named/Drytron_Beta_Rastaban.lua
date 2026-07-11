--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Drytron Beta Rastaban  (ID: 33543890)
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
-- Summon this card from your hand or GY in Defense Position, then you can return 1 of your banished
-- "Drytron" monsters to the GY.
-- You cannot Special Summon monsters, except monsters that cannot be Normal Summoned/Set, the turn you
-- activate this effect.
-- You can only use this effect of "Drytron Beta Rastaban" once per turn.
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－ラスβ
function c33543890.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c33543890.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddDrytronSpSummonEffect(c,c33543890.extraop)
	e2:SetDescription(aux.Stringid(33543890,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e2:SetCountLimit(1,33543890)
end
function c33543890.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x154)
end
function c33543890.tgfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x154) and c:IsType(TYPE_MONSTER)
end
function c33543890.extraop(e,tp)
	local g=Duel.GetMatchingGroup(c33543890.tgfilter,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(33543890,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)
	end
end
