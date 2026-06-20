--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 高速疾行机人 马赫羽子板  (ID: 21516908)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Machine
-- Level 5
-- ATK 2000 | DEF 1000
-- Setcode: 8214
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：把这张卡解放才能发动。场上的全部表侧表示怪兽的等级直到回合结束时上升1星。这个效果在对方回合也能发动。
-- ②：这张卡在墓地存在，自己场上有「疾行机人」调整存在的场合才能发动。这张卡特殊召唤。这个效果的发动后，直到回合结束时自己不是风属性怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--HSRマッハゴー・イータ
function c21516908.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--level up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21516908,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c21516908.lvcost)
	e1:SetTarget(c21516908.lvtg)
	e1:SetOperation(c21516908.lvop)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21516908,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,21516908)
	e2:SetCondition(c21516908.spcon)
	e2:SetTarget(c21516908.sptg)
	e2:SetOperation(c21516908.spop)
	c:RegisterEffect(e2)
end
function c21516908.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c21516908.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c21516908.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21516908.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
end
function c21516908.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21516908.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c21516908.hsfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2016) and c:IsType(TYPE_TUNER)
end
function c21516908.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c21516908.hsfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c21516908.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c21516908.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsAttribute(ATTRIBUTE_WIND)
end
function c21516908.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c21516908.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
