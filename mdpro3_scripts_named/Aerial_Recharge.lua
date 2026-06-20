--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 空中补给  (ID: 70875955)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡的控制者在每次双方的结束阶段把自己场上1只衍生物或者「幻兽机」怪兽解放。或者都不解放让这张卡送去墓地。
-- ①：1回合1次，可以发动。在自己场上把1只「幻兽机衍生物」（机械族·风·3星·攻/守0）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--空中補給
function c70875955.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(70875955,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1)
	e2:SetTarget(c70875955.sptg)
	e2:SetOperation(c70875955.spop)
	c:RegisterEffect(e2)
	--cost
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(70875955,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetOperation(c70875955.mtop)
	c:RegisterEffect(e3)
end
function c70875955.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,TYPES_TOKEN_MONSTER,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c70875955.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,TYPES_TOKEN_MONSTER,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,70875956)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c70875955.rfilter(c)
	return c:IsType(TYPE_TOKEN) or c:IsSetCard(0x101b)
end
function c70875955.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckReleaseGroupEx(tp,c70875955.rfilter,1,REASON_MAINTENANCE,false,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(70875955,2)) then
		local g=Duel.SelectReleaseGroupEx(tp,c70875955.rfilter,1,1,REASON_MAINTENANCE,false,nil)
		Duel.Release(g,REASON_MAINTENANCE)
	else
		Duel.SendtoGrave(e:GetHandler(),REASON_RULE)
	end
end
