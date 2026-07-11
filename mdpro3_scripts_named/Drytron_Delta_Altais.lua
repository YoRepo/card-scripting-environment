--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Drytron Delta Altais  (ID: 22420202)
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
-- Summon this card from your hand or GY in Defense Position, then you can reveal 1 Ritual Monster or 1
-- Ritual Spell in your hand, and if you do, draw 1 card.
-- You cannot Special Summon monsters, except monsters that cannot be Normal Summoned/Set, the turn you
-- activate this effect.
-- You can only use this effect of "Drytron Delta Altais" once per turn.
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－ルタδ
function c22420202.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c22420202.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddDrytronSpSummonEffect(c,c22420202.extraop)
	e2:SetDescription(aux.Stringid(22420202,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	e2:SetCountLimit(1,22420202)
end
function c22420202.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x154)
end
function c22420202.drfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER+TYPE_SPELL) and not c:IsPublic()
end
function c22420202.extraop(e,tp)
	local g=Duel.GetMatchingGroup(c22420202.drfilter,tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 and Duel.IsPlayerCanDraw(tp,1)
		and Duel.SelectYesNo(tp,aux.Stringid(22420202,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
