--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 核成试验台  (ID: 176392)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 1800 | DEF 1800
-- Setcode: 29
--
-- Effect Text:
-- 场上表侧表示存在的名字带有「核成」的怪兽在结束阶段时被破坏的场合，可以作为代替把这张卡破坏。此外，场上表侧表示存在的名字带有「核成」的怪兽在结束阶段时被破坏时，可以在自己场上把1只「核成衍生物」（岩石
-- 族·地·4星·攻/守1800）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--コアキメイル・テストベッド
function c176392.initial_effect(c)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c176392.descon)
	e1:SetTarget(c176392.destg)
	e1:SetValue(c176392.repval)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(176392,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c176392.spcon)
	e2:SetTarget(c176392.sptg)
	e2:SetOperation(c176392.spop)
	c:RegisterEffect(e2)
end
function c176392.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END
end
function c176392.rfilter(c)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x1d) and not c:IsReason(REASON_REPLACE)
end
function c176392.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c176392.rfilter,1,c)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Destroy(c,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end
function c176392.repval(e,c)
	return c:IsFaceup() and c:IsSetCard(0x1d) and c~=e:GetHandler()
end
function c176392.spfilter(c)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousSetCard(0x1d)
end
function c176392.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END and eg:IsExists(c176392.spfilter,1,nil)
end
function c176392.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,176393,0x1d,TYPES_TOKEN_MONSTER,1800,1800,4,RACE_ROCK,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c176392.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,176393,0x1d,TYPES_TOKEN_MONSTER,1800,1800,4,RACE_ROCK,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,176393)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
