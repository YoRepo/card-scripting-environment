--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Submareed Tour Ride  (ID: 87116749)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Dinosaur
-- Level: 6
-- ATK 2200 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- The first Normal Monster you control that would be destroyed by battle or card effect each turn, is
-- not destroyed.
-- If you control a Normal Monster: You can Special Summon this card from your hand.
-- You can only use this effect of "Submareed Tour Ride" once per turn.
--[[ __CARD_HEADER_END__ ]]

--游覧艇サブマリード
function c87116749.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,87116749)
	e1:SetCondition(c87116749.spcon)
	e1:SetTarget(c87116749.sptg)
	e1:SetOperation(c87116749.spop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c87116749.indtg)
	e2:SetCountLimit(1)
	e2:SetValue(c87116749.indct)
	c:RegisterEffect(e2)
end
function c87116749.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL)
end
function c87116749.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c87116749.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c87116749.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c87116749.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c87116749.indtg(e,c)
	return c:IsType(TYPE_NORMAL) and c:IsFaceup()
end
function c87116749.indct(e,re,r,rp)
	local tp=e:GetHandlerPlayer()
	local a,d=Duel.GetBattleMonster(tp)
	return bit.band(r,REASON_BATTLE)~=0 and d and d:IsType(TYPE_EFFECT)
end
