--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Mecha Phantom Beast Kalgriffin  (ID: 41329458)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level: 7
-- ATK 1000 | DEF 2500
-- Setcode: 0x101b
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute 2 "Mecha Phantom Beast" monsters; Special Summon this card from your hand.
-- You can only use this effect of "Mecha Phantom Beast Kalgriffin" once per turn.
-- While you control a Token, this card cannot be destroyed by battle or card effects.
-- Once per turn: You can discard 1 "Mecha Phantom Beast" monster; Special Summon 1 "Mecha Phantom
-- Beast Token" (Machine-Type/WIND/Level 3/ATK 0/DEF 0).
--[[ __CARD_HEADER_END__ ]]

--幻獣機グリーフィン
function c41329458.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41329458,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,41329458)
	e1:SetCost(c41329458.spcost)
	e1:SetTarget(c41329458.sptg)
	e1:SetOperation(c41329458.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(aux.tkfcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--token
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(41329458,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c41329458.spcost2)
	e4:SetTarget(c41329458.sptg2)
	e4:SetOperation(c41329458.spop2)
	c:RegisterEffect(e4)
end
function c41329458.rfilter(c,tp)
	return c:IsSetCard(0x101b) and (c:IsControler(tp) or c:IsFaceup())
end
function c41329458.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetReleaseGroup(tp):Filter(c41329458.rfilter,nil,tp)
	if chk==0 then return rg:CheckSubGroup(aux.mzctcheckrel,2,2,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=rg:SelectSubGroup(tp,aux.mzctcheckrel,false,2,2,tp)
	aux.UseExtraReleaseCount(g,tp)
	Duel.Release(g,REASON_COST)
end
function c41329458.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c41329458.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c41329458.cfilter(c)
	return c:IsSetCard(0x101b) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c41329458.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41329458.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c41329458.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c41329458.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,TYPES_TOKEN_MONSTER,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c41329458.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,TYPES_TOKEN_MONSTER,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,41329459)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
