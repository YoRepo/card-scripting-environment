--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Drytron Gamma Eltanin  (ID: 60037599)
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
-- Summon this card from your hand or GY in Defense Position, then you can Special Summon 1 "Drytron"
-- monster with 2000 ATK from your GY, except "Drytron Gamma Eltanin".
-- You cannot Special Summon monsters, except monsters that cannot be Normal Summoned/Set, the turn you
-- activate this effect.
-- You can only use this effect of "Drytron Gamma Eltanin" once per turn.
--[[ __CARD_HEADER_END__ ]]

--竜輝巧－エルγ
function c60037599.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c60037599.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=aux.AddDrytronSpSummonEffect(c,c60037599.extraop)
	e2:SetDescription(aux.Stringid(60037599,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e2:SetCountLimit(1,60037599)
end
function c60037599.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x154)
end
function c60037599.rbfilter(c,e,tp)
	return c:IsSetCard(0x154) and c:IsAttack(2000) and not c:IsCode(60037599) and c:IsCanBeSpecialSummoned(e,0,tp,false,aux.DrytronSpSummonType(c))
end
function c60037599.extraop(e,tp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c60037599.rbfilter),tp,LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(60037599,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		local sc=sg:GetFirst()
		if Duel.SpecialSummon(sg,0,tp,tp,false,aux.DrytronSpSummonType(sc),POS_FACEUP)~=0 and aux.DrytronSpSummonType(sc) then
			sc:CompleteProcedure()
		end
	end
end
