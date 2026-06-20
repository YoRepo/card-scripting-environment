--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 云魔物-高层云  (ID: 79703905)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fairy
-- Level 4
-- ATK 1300 | DEF 0
-- Setcode: 24
--
-- Effect Text:
-- 这张卡不会被战斗破坏。这张卡表侧守备表示在场上存在的场合，这张卡破坏。这张卡的召唤成功时，给这张卡放置场上存在的名字带有「云魔物」的怪兽数量的雾指示物。可以把场上存在的雾指示物取除3个，对方手卡随机丢
-- 弃1张。
--[[ __CARD_HEADER_END__ ]]

--雲魔物－アルトス
function c79703905.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c79703905.sdcon)
	c:RegisterEffect(e2)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(79703905,0))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetOperation(c79703905.addc)
	c:RegisterEffect(e3)
	--handes
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(79703905,1))
	e4:SetCategory(CATEGORY_HANDES)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c79703905.hdcost)
	e4:SetTarget(c79703905.hdtg)
	e4:SetOperation(c79703905.hdop)
	c:RegisterEffect(e4)
end
function c79703905.sdcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE)
end
function c79703905.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x18)
end
function c79703905.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		local ct=Duel.GetMatchingGroupCount(c79703905.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		e:GetHandler():AddCounter(0x1019,ct)
	end
end
function c79703905.hdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,1,0x1019,3,REASON_COST) end
	Duel.RemoveCounter(tp,1,1,0x1019,3,REASON_COST)
end
function c79703905.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c79703905.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
end
