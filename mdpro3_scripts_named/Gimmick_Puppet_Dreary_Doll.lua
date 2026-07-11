--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Gimmick Puppet Dreary Doll  (ID: 92418590)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 8
-- ATK 0 | DEF 0
-- Setcode: 0x1083
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your GY: You can banish 1 other "Gimmick Puppet" monster from your GY; Special
-- Summon this card.
-- You can only use this effect of "Gimmick Puppet Dreary Doll" once per turn.
-- Cannot be used as material for an Xyz Summon, except for the Xyz Summon of a "Gimmick Puppet"
-- monster.
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－ネクロ・ドール
function c92418590.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92418590,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,92418590)
	e1:SetCost(c92418590.cost)
	e1:SetTarget(c92418590.target)
	e1:SetOperation(c92418590.operation)
	c:RegisterEffect(e1)
	--xyz limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetValue(c92418590.xyzlimit)
	c:RegisterEffect(e2)
end
function c92418590.cfilter(c)
	return c:IsSetCard(0x1083) and c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end
function c92418590.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92418590.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c92418590.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c92418590.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c92418590.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c92418590.xyzlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x1083)
end
